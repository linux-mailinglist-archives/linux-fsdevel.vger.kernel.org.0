Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB2671800
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 10:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjARJmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 04:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjARJj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:39:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2A16334;
        Wed, 18 Jan 2023 00:56:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DF8B3E98B;
        Wed, 18 Jan 2023 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674032198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tgBJPKX6OrvfX7vt7VeuwRYdAa1JYzlRkPsncNLXpXI=;
        b=BmBHBQR+zuTDcSZg7eP3ujTQmmYoHkhFL7UHQnOfaLn4X+8t6GJCTB2lHWId0KdMifpI2B
        7vV8O4S7uzbYuMML8bte/sATQ7YPyN9lA0xGyolZk4BxPQZPanpexstsnYSPsf5RhFCUhV
        YWrEtQba5mUUXVSSL86STuKIwx1R3V0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674032198;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tgBJPKX6OrvfX7vt7VeuwRYdAa1JYzlRkPsncNLXpXI=;
        b=atRN1VcwzH95sn4fF0V2e0yJNbP4744YGS7ZBjufI9NJH7+jLIRm1F3G4QUTx17qhiGXr4
        VDKCovOTvCse/FBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E2DE138FE;
        Wed, 18 Jan 2023 08:56:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KIklD0a0x2NBJwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 18 Jan 2023 08:56:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9C505A06B2; Wed, 18 Jan 2023 09:56:37 +0100 (CET)
Date:   Wed, 18 Jan 2023 09:56:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <20230118085637.56u4tbocimzhrjly@quack3>
References: <20230117123735.un7wbamlbdihninm@quack3>
 <20230117214457.GG360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117214457.GG360264@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed 18-01-23 08:44:57, Dave Chinner wrote:
> On Tue, Jan 17, 2023 at 01:37:35PM +0100, Jan Kara wrote:
> > I've some across an interesting issue that was spotted by syzbot [1]. The
> > report is against UDF but AFAICS the problem exists for ext4 as well and
> > possibly other filesystems. The problem is the following: When we are
> > renaming directory 'dir' say rename("foo/dir", "bar/") we lock 'foo' and
> > 'bar' but 'dir' is unlocked because the locking done by vfs_rename() is
> > 
> >         if (!is_dir || (flags & RENAME_EXCHANGE))
> >                 lock_two_nondirectories(source, target);
> >         else if (target)
> >                 inode_lock(target);
> > 
> > However some filesystems (e.g. UDF but ext4 as well, I suspect XFS may be
> > hurt by this as well because it converts among multiple dir formats) need
> > to update parent pointer in 'dir' and nothing protects this update against
> > a race with someone else modifying 'dir'. Now this is mostly harmless
> > because the parent pointer (".." directory entry) is at the beginning of
> > the directory and stable however if for example the directory is converted
> > from packed "in-inode" format to "expanded" format as a result of
> > concurrent operation on 'dir', the filesystem gets corrupted (or crashes as
> > in case of UDF).
> 
> No, xfs_rename() does not have this problem - we pass four inodes to
> the function - the source directory, source inode, destination
> directory and destination inode.
> 
> In the above case, "dir/" is passed to XFs as the source inode - the
> src_dir is "foo/", the target dir is "bar/" and the target inode is
> null. src_dir != target_dir, so we set the "new_parent" flag. the
> srouce inode is a directory, so we set the src_is_directory flag,
> too.
> 
> We lock all three inodes that are passed. We do various things, then
> run:
> 
>         if (new_parent && src_is_directory) {
>                 /*
>                  * Rewrite the ".." entry to point to the new
>                  * directory.
>                  */
>                 error = xfs_dir_replace(tp, src_ip, &xfs_name_dotdot,
>                                         target_dp->i_ino, spaceres);
>                 ASSERT(error != -EEXIST);
>                 if (error)
>                         goto out_trans_cancel;
>         }
> 
> which replaces the ".." entry in source inode atomically whilst it
> is locked.  Any directory format changes that occur during the
> rename are done while the ILOCK is held, so they appear atomic to
> outside observers that are trying to parse the directory structure
> (e.g. readdir).

Thanks for explanation! I've missed the ILOCK locking in xfs_rename() when
I was glancing over the function...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
