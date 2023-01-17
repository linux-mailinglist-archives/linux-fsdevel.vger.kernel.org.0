Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5429266E438
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 17:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjAQQ6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 11:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjAQQ6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:58:00 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996939BA3;
        Tue, 17 Jan 2023 08:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VFgrKKVDGlnjswcyDcS33CkLpy5eaqJX1Jr0XAotnhM=; b=HaeMD/ccoYcTFtebP4vLcZuH+N
        1PT/gnYIywzUVrTYt4cocfc0srMQoa3RaxHgzKmDXLk+WfMr/253ydnKgRVwgVB+9PHUJXhpzPUfB
        GrJhFJ6qm4fFHHP8im0tRC1NIFGojSYQTNOrTNIEDrPIVK+j0N38QZX0qN8fKMPuWOeV3rrjOa1QC
        86fVaT2Z4Om0f03eTiiRtGZSC0pRIqKRjoga2/SSD/RCDT8H+cbeSVjfZ5e1Ks9NK4a1TeNTu6A4S
        cCbV4DV56TzaVVKP8z+/S68D3aMy7u5RwUa2CDrDGzYvlax92Jncw+HlgnSo84fbKlgBsteU2alnF
        u0goMv6A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pHpHX-002OEN-2m;
        Tue, 17 Jan 2023 16:57:56 +0000
Date:   Tue, 17 Jan 2023 16:57:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <Y8bTk1CsH9AaAnLt@ZenIV>
References: <20230117123735.un7wbamlbdihninm@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117123735.un7wbamlbdihninm@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 01:37:35PM +0100, Jan Kara wrote:
> Hello!
> 
> I've some across an interesting issue that was spotted by syzbot [1]. The
> report is against UDF but AFAICS the problem exists for ext4 as well and
> possibly other filesystems. The problem is the following: When we are
> renaming directory 'dir' say rename("foo/dir", "bar/") we lock 'foo' and
> 'bar' but 'dir' is unlocked because the locking done by vfs_rename() is
> 
>         if (!is_dir || (flags & RENAME_EXCHANGE))
>                 lock_two_nondirectories(source, target);
>         else if (target)
>                 inode_lock(target);
> 
> However some filesystems (e.g. UDF but ext4 as well, I suspect XFS may be
> hurt by this as well because it converts among multiple dir formats) need
> to update parent pointer in 'dir' and nothing protects this update against
> a race with someone else modifying 'dir'. Now this is mostly harmless
> because the parent pointer (".." directory entry) is at the beginning of
> the directory and stable however if for example the directory is converted
> from packed "in-inode" format to "expanded" format as a result of
> concurrent operation on 'dir', the filesystem gets corrupted (or crashes as
> in case of UDF).
> 
> So we'd need to lock 'source' if it is a directory. Ideally this would
> happen in VFS as otherwise I bet a lot of filesystems will get this wrong
> so could vfs_rename() lock 'source' if it is a dir as well? Essentially
> this would amount to calling lock_two_nondirectories(source, target)
> unconditionally but that would become a serious misnomer ;). Al, any
> thought?

FWIW, I suspect that majority of filesystems that do implement rename
do not have that problem.  Moreover, on cross-directory rename we already
have
	* tree topology stabilized
	* source guaranteed not to be an ancestor of target or either of
the parents
so the method instance should be free to lock the source if it needs to
do so.

Not sure, I'll need to grep around and take a look at the instances...

