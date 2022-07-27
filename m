Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC7B582597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 13:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiG0LeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 07:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiG0LeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:34:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E892B13CDE;
        Wed, 27 Jul 2022 04:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FF94B82022;
        Wed, 27 Jul 2022 11:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D119C433C1;
        Wed, 27 Jul 2022 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658921652;
        bh=db3UoE/JVeKIkJbNmRDPqnol/NodJCjMUZp8vPWicCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqBNMAw4d8h6D2FW8pNMl/xzkWqHEMCuV4bviEGmRGIT4dJ5u4m5B77JxMTp0zYwm
         Gtrq8OUXh6pYU0QtNfK4gEEOWKBPa3Z2XD5iR4Eknd7/yviaLd2NAFsTD+5mb8ifY6
         GeJFS4qjfrmv92fFRtlx+qu48rTzv0+RAq3cD4hFAwpIWWjx2gIrW7SrWdgEKgEw/x
         vOJL+XTk4y2VyyrZk++kqwTei9MCpBEdJOHAFhyv3AMCOSnktC5R/PV62sRb8b6uCs
         loqefTIB6JbzdZbTeEwyxRsIIUxXbjQ3C84er3lkzLctezVdAxMri2l5dlPmocv2BA
         KgIDl2URQW1mQ==
Date:   Wed, 27 Jul 2022 13:34:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongchen Yang <yoyang@redhat.com>
Subject: Re: [RFC PATCH] vfs: don't check may_create_in_sticky if the file is
 already open/created
Message-ID: <20220727113406.ewu4kzsoo643cf66@wittgenstein>
References: <20220726202333.165490-1-jlayton@kernel.org>
 <8e4d498a3e8ed80ada2d3da01e7503e082be31a3.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e4d498a3e8ed80ada2d3da01e7503e082be31a3.camel@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 26, 2022 at 04:27:56PM -0400, Jeff Layton wrote:
> On Tue, 2022-07-26 at 16:23 -0400, Jeff Layton wrote:
> > NFS server is exporting a sticky directory (mode 01777) with root
> > squashing enabled. Client has protect_regular enabled and then tries to
> > open a file as root in that directory. File is created (with ownership
> > set to nobody:nobody) but the open syscall returns an error.
> > 
> > The problem is may_create_in_sticky, which rejects the open even though
> > the file has already been created/opened. Only call may_create_in_sticky
> > if the file hasn't already been opened or created.
> > 
> > Cc: Christian Brauner <brauner@kernel.org>
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1976829
> > Reported-by: Yongchen Yang <yoyang@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/namei.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 1f28d3f463c3..7480b6dc8d27 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3495,10 +3495,15 @@ static int do_open(struct nameidata *nd,
> >  			return -EEXIST;
> >  		if (d_is_dir(nd->path.dentry))
> >  			return -EISDIR;
> > -		error = may_create_in_sticky(mnt_userns, nd,
> > -					     d_backing_inode(nd->path.dentry));
> > -		if (unlikely(error))
> > -			return error;
> > +		if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
> > +			error = may_create_in_sticky(mnt_userns, nd,
> > +						d_backing_inode(nd->path.dentry));
> > +			if (unlikely(error)) {
> > +				printk("%s: f_mode=0x%x oflag=0x%x\n",
> > +					__func__, file->f_mode, open_flag);
> > +				return error;
> > +			}
> > +		}
> >  	}
> >  	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
> >  		return -ENOTDIR;
> 
> I'm pretty sure this patch is the wrong approach, actually, since it
> doesn't fix the regular (non-atomic) open codepath. Any thoughts on what

Hey Jeff,

I haven't quite understood why that won't work for the regular open
codepaths. I'm probably missing something obvious.

> the right fix might be?

When an actual creation has taken place - and not just a lookup - then
may_create_in_sticky() assumes that the owner of the inode matches
current_fsuid(). That'd would also be problematic on fat or in fact on
any fs where the actual inode->i_{g,u}id are based on e.g. uid/gid mount
options and not on current_fsuid(), I think?

So in order to improve this we would need to work around that assumption
in some way. Either by skipping may_create_in_sticky() if the file got
created or by adapting may_create_in_sticky().

I only wonder whether skipping may_create_in_sticky() altogether might
be a bit too lax. One possibility that came to my mind might be to relax
this assumption when the file has been created and the creator has
CAP_FOWNER.

So (not compile tested or in any way) sm like:

diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..239e9f423346 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1221,7 +1221,8 @@ int may_linkat(struct user_namespace *mnt_userns, struct path *link)
  * Returns 0 if the open is allowed, -ve on error.
  */
 static int may_create_in_sticky(struct user_namespace *mnt_userns,
-                               struct nameidata *nd, struct inode *const inode)
+                               struct nameidata *nd, struct inode *const inode,
+                               bool created)
 {
        umode_t dir_mode = nd->dir_mode;
        kuid_t dir_uid = nd->dir_uid;
@@ -1230,7 +1231,9 @@ static int may_create_in_sticky(struct user_namespace *mnt_userns,
            (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
            likely(!(dir_mode & S_ISVTX)) ||
            uid_eq(i_uid_into_mnt(mnt_userns, inode), dir_uid) ||
-           uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
+           uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) ||
+           (created &&
+            capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FOWNER)))
                return 0;

        if (likely(dir_mode & 0002) ||
@@ -3496,7 +3499,8 @@ static int do_open(struct nameidata *nd,
                if (d_is_dir(nd->path.dentry))
                        return -EISDIR;
                error = may_create_in_sticky(mnt_userns, nd,
-                                            d_backing_inode(nd->path.dentry));
+                                            d_backing_inode(nd->path.dentry),
+                                            (file->f_mode & FMODE_CREATED));
                if (unlikely(error))
                        return error;
        }
