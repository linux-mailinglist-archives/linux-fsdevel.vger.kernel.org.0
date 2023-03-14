Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF16B8F09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 10:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCNJzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 05:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCNJzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA675865;
        Tue, 14 Mar 2023 02:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C38A616CA;
        Tue, 14 Mar 2023 09:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7487C433D2;
        Tue, 14 Mar 2023 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678787744;
        bh=Ml5eEB7wiPfEgRtV2rIkKaAoqJoRbyT21kgehns7Z48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7m6L0kpZwkFxG1VN7QQ9eaT7lyq2OfAbj1bbpaO9NX6P+lOkstYFr9obbJzU/XDi
         DziwewMWij7zSQAnSuzJBNCAAVL4HdeuUsFXWz28Cs4fNFJ+jq411+r7jWyG4cIjvW
         IsGpEvhfkder/jEMC2SnohzBWR4Ot/OEIoCiOZIMmhJI38L6dJ9pUjuK2neonmL2qp
         Ti9WbXh6RCmFe6znlXqAWZ5gC2hZ9ssAORRwM4pvkHEA8o/wxfntxhpgGCFR3O+gBF
         DjQgPeZfXzncN+WhIKsUstfhHkVfDnuQhcdQFFzwEssZe9WIc78kVfCPmy+nGFVif1
         CFVvB8ZZNvP+w==
Date:   Tue, 14 Mar 2023 10:55:39 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>,
        security@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: Patch for a overwriting/corruption of the file system
Message-ID: <20230314095539.zf7uy27cjflqp6kp@wittgenstein>
References: <CADZg-m0Z+dOGfG=ddJxqPvgFwG0+OLAyP157SNzj6R6J2p7L-g@mail.gmail.com>
 <ZA734rBwf4ib2u9n@kroah.com>
 <CADZg-m04XELrO-v-uYZ4PyYHXVPX35dgWbCHBpZvwepS4XV9Ew@mail.gmail.com>
 <CADZg-m2k_L8-byX0WKYw5Cj1JPPhxk3HCBexpqPtZvcLRNY8Ug@mail.gmail.com>
 <ZA77qAuaTVCEwqHc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZA77qAuaTVCEwqHc@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:32:08AM +0100, Greg KH wrote:
> On Mon, Mar 13, 2023 at 03:54:55PM +0530, Kirtikumar Anandrao Ramchandani wrote:
> > Seems like again it got rejected. I am sending it in the body if it works:
> > 
> > >From 839cae91705e044b49397590f2d85a5dd289f0c5 Mon Sep 17 00:00:00 2001
> > From: KirtiRamchandani <kirtar15502@gmail.com>
> > Date: Mon, 13 Mar 2023 15:05:08 +0530
> > Subject: [PATCH] Fix bug in affs_rename() function. The `affs_rename()`
> >  function in the AFFS filesystem has a bug that can cause the `retval`
> >  variable to be overwritten before it is used. Specifically, the function
> >  assigns `retval` a value in two separate code blocks, but then only checks
> >  its value in one of those blocks. This commit fixes the bug by ensuring
> > that
> >  `retval` is properly checked in both code blocks.
> > 
> > Signed-off-by: KirtiRamchandani <kirtar15502@gmail.com>
> > ---
> >  namei.c | 4++++--
> >  1 file changed, 4 insertions(+), 2 deletion(-)
> > 
> > diff --git a/fs/affs/namei.c b/fs/affs/namei.c
> > index d1084e5..a54c700 100644
> > --- a/fs/affs/namei.c
> > +++ b/fs/affs/namei.c
> > @@ -488,7 +488,8 @@ affs_xrename(struct inode *old_dir, struct dentry
> > *old_dentry,
> >         affs_lock_dir(new_dir);
> >         retval = affs_insert_hash(new_dir, bh_old);
> >         affs_unlock_dir(new_dir);
> > -
> > +       if (retval)
> > +               goto done;
> 
> The patch is corrupted and can not be applied.

Yeah, that patch is pretty borked. This should probably be sm like:

From f3a7758bb53cc776820656c6ac66b13fb8ed9022 Mon Sep 17 00:00:00 2001
From: KirtiRamchandani <kirtar15502@gmail.com>
Date: Tue, 14 Mar 2023 10:49:38 +0100
Subject: [PATCH] affs: handle errors in affs_xrename()

Fix a bug in the affs_xrename() function. The affs_xrename() function in
the AFFS filesystem has a bug that can cause the retval variable to be
overwritten before it is used. Specifically, the function assigns retval
a value in two separate code blocks, but then only checks its value in
one of those blocks. This commit fixes the bug by ensuring that retval
is properly checked in both code blocks.

Signed-off-by: KirtiRamchandani <kirtar15502@gmail.com>
---
 fs/affs/namei.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index d12ccfd2a83d..98525d69391d 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -488,6 +488,8 @@ affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	affs_lock_dir(new_dir);
 	retval = affs_insert_hash(new_dir, bh_old);
 	affs_unlock_dir(new_dir);
+	if (retval)
+		goto done;
 
 	/* Insert new into the old directory with the old name. */
 	affs_copy_name(AFFS_TAIL(sb, bh_new)->name, old_dentry);
@@ -495,6 +497,8 @@ affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	affs_lock_dir(old_dir);
 	retval = affs_insert_hash(old_dir, bh_new);
 	affs_unlock_dir(old_dir);
+	if (retval)
+		goto done;
 done:
 	mark_buffer_dirty_inode(bh_old, new_dir);
 	mark_buffer_dirty_inode(bh_new, old_dir);
-- 
2.34.1

