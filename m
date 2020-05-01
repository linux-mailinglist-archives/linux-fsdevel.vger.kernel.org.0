Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2D1C0EDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgEAHbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 03:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAHbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 03:31:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46829C035495
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 00:31:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so10579742wrx.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 00:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rAliNqiNu+1dGXi4Ijb6n1X5xzkWQyLVearRKu8YpyE=;
        b=nIFyGcUtpdLyvAYYS/MRLj42vjeHrDf7Yp9WzAVh7V4mFIedZx7M9y0t8FNL9xjK3i
         jCIG+1XWbQ16yz1zYQkHRherfClADA4zBSf9WX8PIgBH0hGmmzifDNvRoksTSVbUt+n5
         TNtfvZjPBvxeyU7T1oeVmpZvb4EZXgC1OkgRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rAliNqiNu+1dGXi4Ijb6n1X5xzkWQyLVearRKu8YpyE=;
        b=jWZKY1zf07RaS+pZEetdBu6usY39qvir9HvAqvwiGxy5zT1Y3mbfD7Y8AH5RcNC4iY
         d3DSHYXqec8EzP8mYHb2JT/JpOp09O7uU3n3ofOHrAdQRM8ToZtHaOFhbIyvoYpH/+yl
         S0VvM3bT+qopSpsDbvEMTjG4phWngE12IPNbUkkSRIYFa1tKALLD438WZYjxvcb0TqwW
         rvVDxQXFpo+d0VrO8eY8yG6tns4Eqebl5C8LUMBjG4mliSUd4BcMpbiDmYJnmqR6pgC9
         DdeznLlpXaYvYZwZ6Z+MbcX1SnYo69CZHVTfGTpndrkb5wh61TDuFmQAUVwxNMV+OxpH
         oGOQ==
X-Gm-Message-State: AGi0Pua4ZOE7BUJB0dBhTrcTlrbY2M8X4wAfTZ2ck89qaE/3p8L3HJG0
        7qe7YqJM5vhCsKkouaIimJWCmw==
X-Google-Smtp-Source: APiQypLex36dnTHSszriNToHwyP9qb2U8oD664JwLqWSLyOs7CdJVhKAqZYYVNBUWIgzKn6Uw6nt4g==
X-Received: by 2002:adf:e552:: with SMTP id z18mr2666258wrm.244.1588318289891;
        Fri, 01 May 2020 00:31:29 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id u30sm3250343wru.13.2020.05.01.00.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 00:31:29 -0700 (PDT)
Date:   Fri, 1 May 2020 09:31:27 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
Message-ID: <20200501073127.GB13131@miu.piliscsaba.redhat.com>
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
 <20200501041444.GJ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501041444.GJ23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 05:14:44AM +0100, Al Viro wrote:
> On Thu, Apr 09, 2020 at 11:28:59PM +0200, Miklos Szeredi wrote:
> > From: Miklos Szeredi <mszeredi@redhat.com>
> > 
> > Whiteouts, unlike real device node should not require privileges to create.
> > 
> > The general concern with device nodes is that opening them can have side
> > effects.  The kernel already avoids zero major (see
> > Documentation/admin-guide/devices.txt).  To be on the safe side the patch
> > explicitly forbids registering a char device with 0/0 number (see
> > cdev_add()).
> > 
> > This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
> > i.e. it won't have any side effect.
> 
> >  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> >  {
> > +	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
> >  	int error = may_create(dir, dentry);
> >  
> >  	if (error)
> >  		return error;
> >  
> > -	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> > +	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> > +	    !is_whiteout)
> >  		return -EPERM;
> 
> Hmm...  That exposes vfs_whiteout() to LSM; are you sure that you won't
> end up with regressions for overlayfs on sufficiently weird setups?

You're right.  OTOH, what can we do?  We can't fix the weird setups, only the
distros/admins can.

Can we just try this, and revert to calling ->mknod directly from overlayfs if
it turns out to be a problem that people can't fix easily?

I guess we could add a new ->whiteout security hook as well, but I'm not sure
it's worth it.  Cc: LMS mailing list; patch re-added for context.

Thanks,
Miklos

---
 fs/char_dev.c                 |    3 +++
 fs/namei.c                    |   17 ++++-------------
 include/linux/device_cgroup.h |    3 +++
 3 files changed, 10 insertions(+), 13 deletions(-)

--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -483,6 +483,9 @@ int cdev_add(struct cdev *p, dev_t dev,
 	p->dev = dev;
 	p->count = count;
 
+	if (WARN_ON(dev == WHITEOUT_DEV))
+		return -EBUSY;
+
 	error = kobj_map(cdev_map, dev, count, NULL,
 			 exact_match, exact_lock, p);
 	if (error)
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3505,12 +3505,14 @@ EXPORT_SYMBOL(user_path_create);
 
 int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
+	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(dir, dentry);
 
 	if (error)
 		return error;
 
-	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
+	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
+	    !is_whiteout)
 		return -EPERM;
 
 	if (!dir->i_op->mknod)
@@ -4345,9 +4347,6 @@ static int do_renameat2(int olddfd, cons
 	    (flags & RENAME_EXCHANGE))
 		return -EINVAL;
 
-	if ((flags & RENAME_WHITEOUT) && !capable(CAP_MKNOD))
-		return -EPERM;
-
 	if (flags & RENAME_EXCHANGE)
 		target_flags = 0;
 
@@ -4485,15 +4484,7 @@ SYSCALL_DEFINE2(rename, const char __use
 
 int vfs_whiteout(struct inode *dir, struct dentry *dentry)
 {
-	int error = may_create(dir, dentry);
-	if (error)
-		return error;
-
-	if (!dir->i_op->mknod)
-		return -EPERM;
-
-	return dir->i_op->mknod(dir, dentry,
-				S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+	return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 }
 EXPORT_SYMBOL(vfs_whiteout);
 
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -51,6 +51,9 @@ static inline int devcgroup_inode_mknod(
 	if (!S_ISBLK(mode) && !S_ISCHR(mode))
 		return 0;
 
+	if (S_ISCHR(mode) && dev == WHITEOUT_DEV)
+		return 0;
+
 	if (S_ISBLK(mode))
 		type = DEVCG_DEV_BLOCK;
 	else
