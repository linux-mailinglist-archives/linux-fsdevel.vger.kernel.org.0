Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A885B6770
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 07:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiIMFku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 01:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiIMFkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:40:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6957224
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 22:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lbwSdxVGzTYlRe6j1Vszaw9FVafDeDCFnvv0z+nhV9A=; b=rIBeL1Isge1XsLM9HPrzBXMSq3
        UF+6B1pDdVJhGs51SlwEilHu1/oLWSAWPg1RGxIHGF3wXoZ0ronfGIBESw/02OOX0D9PNvJWPTrJb
        BHFqYU4/VivX3FtFrswuM6jTaPQBvRLt361anBpsRoVlcHcPynS+Coe2YJnMb7kkkv2Bag+e7Tvan
        vYYpSH5A/ck9O7WPogoHgBHxKECPIgJ+J3+0HUCPc9TEYMR7c6qOu0lXTxL9evijLQS5l6/uTzZ63
        OLeKRsdwNRFaAc9nNhWX3NP43/Ez+O+lba6k+GlIX4DAjuHx7dBXcmhQ6+cytgKwSGQdSP+Jh18gz
        xrfInqIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oXyf3-00FkWA-16;
        Tue, 13 Sep 2022 05:40:41 +0000
Date:   Tue, 13 Sep 2022 06:40:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
Message-ID: <YyAX2adCGec95qXn@ZenIV>
References: <20220221082002.508392-1-mszeredi@redhat.com>
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>
 <YyATCgxi9Ovi8mYv@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyATCgxi9Ovi8mYv@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 06:20:10AM +0100, Al Viro wrote:

> > Alternately, lock the "from" directory as well as the "to" directory.
> > That would mean using lock_rename() and generally copying the structure
> > of do_renameat2() into do_linkat()
> 
> Ever done cp -al?  Cross-directory renames are relatively rare; cross-directory
> links can be fairly heavy on some payloads, and you'll get ->s_vfs_rename_mutex
> held a _lot_.
> 
> > I wonder if you could get a similar race trying to create a file in
> > (empty directory) /tmp/foo while /tmp/bar was being renamed over it.
> 
> 	Neil, no offense, but... if you have plans regarding changes in
> directory locking, you might consider reading through the file called
> Documentation/filesystems/directory-locking.rst
> 
> 	Occasionally documentation is where one could expect to find it...

... and that "..." above should've been ";-)" - it was not intended as
a dig, especially since locking in that area has subtle and badly
underdocumented parts (in particular, anything related to fh_to_dentry(),
rules regarding the stability of ->d_name and ->d_parent, mount vs. dentry
invalidation and too many other things), but the basic stuff like that
is actually covered.

FWIW, the answer to your question is that the victim of overwriting
rename is held locked by caller of ->rename(); combined with the lock
held on directory by anyone who modifies it that prevents the race
you are asking about.

See
        if (!is_dir || (flags & RENAME_EXCHANGE))
                lock_two_nondirectories(source, target);
        else if (target)
                inode_lock(target);
in vfs_rename().
