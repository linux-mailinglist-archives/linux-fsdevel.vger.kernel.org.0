Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C972C6B9C4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 17:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCNQ5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 12:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCNQ5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:57:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966DAA029A;
        Tue, 14 Mar 2023 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c77n210BuZyDU9jbLz5rd5p68G+E/873BqA5rCXORkE=; b=ozZu5fg2WMl49RaNPqzA5mLPWq
        0622WNynNPkzXWEBn/1vZvVFPvBXtfJlXq3jxId/fs8jFrx1l+AUban4MncW+f+UDNlcZEBs/lMXG
        nhIpw8GY2BeFkJJYSPKCpwp3P1QhW9jLMih4/aYbPmSe/XvHCJwr0BRI9rWQ81qDiY1/4XHM8MQHd
        qxVZkTd8dEy1qUyCErKCZqskEPIZAfPbgzdbNH+Q7BzFGdy/dULE333Tc27LZ7T/ydLe0ohOSCUuB
        53r3PWO9pjCXZ+Fc/cGdCp858DHJG5he5dTQiVbawwqe8TN3lw7vtaRaSM649K6zrP2rKlNPaJvnc
        hfvqf52w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pc7xU-00Ga3O-0a;
        Tue, 14 Mar 2023 16:57:08 +0000
Date:   Tue, 14 Mar 2023 16:57:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>,
        security@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: Patch for a overwriting/corruption of the file system
Message-ID: <20230314165708.GY3390869@ZenIV>
References: <CADZg-m0Z+dOGfG=ddJxqPvgFwG0+OLAyP157SNzj6R6J2p7L-g@mail.gmail.com>
 <ZA734rBwf4ib2u9n@kroah.com>
 <CADZg-m04XELrO-v-uYZ4PyYHXVPX35dgWbCHBpZvwepS4XV9Ew@mail.gmail.com>
 <CADZg-m2k_L8-byX0WKYw5Cj1JPPhxk3HCBexpqPtZvcLRNY8Ug@mail.gmail.com>
 <ZA77qAuaTVCEwqHc@kroah.com>
 <20230314095539.zf7uy27cjflqp6kp@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314095539.zf7uy27cjflqp6kp@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:55:39AM +0100, Christian Brauner wrote:
> On Mon, Mar 13, 2023 at 11:32:08AM +0100, Greg KH wrote:
> > On Mon, Mar 13, 2023 at 03:54:55PM +0530, Kirtikumar Anandrao Ramchandani wrote:
> > > Seems like again it got rejected. I am sending it in the body if it works:
> > > 
> > > >From 839cae91705e044b49397590f2d85a5dd289f0c5 Mon Sep 17 00:00:00 2001
> > > From: KirtiRamchandani <kirtar15502@gmail.com>
> > > Date: Mon, 13 Mar 2023 15:05:08 +0530
> > > Subject: [PATCH] Fix bug in affs_rename() function. The `affs_rename()`
> > >  function in the AFFS filesystem has a bug that can cause the `retval`
> > >  variable to be overwritten before it is used. Specifically, the function
> > >  assigns `retval` a value in two separate code blocks, but then only checks
> > >  its value in one of those blocks. This commit fixes the bug by ensuring
> > > that
> > >  `retval` is properly checked in both code blocks.
> > > 
> > > Signed-off-by: KirtiRamchandani <kirtar15502@gmail.com>
> > > ---
> > >  namei.c | 4++++--
> > >  1 file changed, 4 insertions(+), 2 deletion(-)
> > > 
> > > diff --git a/fs/affs/namei.c b/fs/affs/namei.c
> > > index d1084e5..a54c700 100644
> > > --- a/fs/affs/namei.c
> > > +++ b/fs/affs/namei.c
> > > @@ -488,7 +488,8 @@ affs_xrename(struct inode *old_dir, struct dentry
> > > *old_dentry,
> > >         affs_lock_dir(new_dir);
> > >         retval = affs_insert_hash(new_dir, bh_old);
> > >         affs_unlock_dir(new_dir);
> > > -
> > > +       if (retval)
> > > +               goto done;
> > 
> > The patch is corrupted and can not be applied.
> 
> Yeah, that patch is pretty borked. This should probably be sm like:
> 
> >From f3a7758bb53cc776820656c6ac66b13fb8ed9022 Mon Sep 17 00:00:00 2001
> From: KirtiRamchandani <kirtar15502@gmail.com>
> Date: Tue, 14 Mar 2023 10:49:38 +0100
> Subject: [PATCH] affs: handle errors in affs_xrename()
> 
> Fix a bug in the affs_xrename() function. The affs_xrename() function in
> the AFFS filesystem has a bug that can cause the retval variable to be
> overwritten before it is used. Specifically, the function assigns retval
> a value in two separate code blocks, but then only checks its value in
> one of those blocks. This commit fixes the bug by ensuring that retval
> is properly checked in both code blocks.

"Properly checked" as in...?

> Signed-off-by: KirtiRamchandani <kirtar15502@gmail.com>
> ---
>  fs/affs/namei.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/affs/namei.c b/fs/affs/namei.c
> index d12ccfd2a83d..98525d69391d 100644
> --- a/fs/affs/namei.c
> +++ b/fs/affs/namei.c
> @@ -488,6 +488,8 @@ affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
>  	affs_lock_dir(new_dir);
>  	retval = affs_insert_hash(new_dir, bh_old);
>  	affs_unlock_dir(new_dir);
> +	if (retval)
> +		goto done;

OK, so you've got an IO error and insertion has failed.  Both entries had already
been removed from their directories.  Sure, we must report an error, but why is
leaking *both* entries the right thing to do?

>  	/* Insert new into the old directory with the old name. */
>  	affs_copy_name(AFFS_TAIL(sb, bh_new)->name, old_dentry);
> @@ -495,6 +497,8 @@ affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
>  	affs_lock_dir(old_dir);
>  	retval = affs_insert_hash(old_dir, bh_new);
>  	affs_unlock_dir(old_dir);
> +	if (retval)
> +		goto done;
>  done:

Really?  How could that possibly make any sense?  I mean, look for the target of
that goto...

The bug here (AFFS awful layout aside) is that error from the first insert_hash
is always lost.  And it needs to be reported.  But this is no way to fix that.
