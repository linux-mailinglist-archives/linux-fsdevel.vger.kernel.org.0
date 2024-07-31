Return-Path: <linux-fsdevel+bounces-24656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7EF942601
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 07:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6174EB20E43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 05:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B8C53370;
	Wed, 31 Jul 2024 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqogeD9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF919478;
	Wed, 31 Jul 2024 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722405091; cv=none; b=plKFSd+S0dUiLG6fxlPpk+Ehp1fO99B4jKIywDryu4ulheRaK9HfKmgpwAwFyF1CCwK6Oy5wGq/sRVpVdIh5gF8boPVL2ZqIle5BOv3627FIog56IPx9RGViqxLX3UWmA2neKexPxjwYhEtaLP/Lf1NMoMY6eu8pjdnAkWy9zS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722405091; c=relaxed/simple;
	bh=UEsjXMA2SABPVP0LGK1Uqnqs5RdT3iO4Qiqk/+tBM3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgOyErw7P+J6jSE8jG6ILok+Nu7CZM7PPmBF9i51MOSBCDJ+pHe1WU72EbnhUH+AxPHyHRZKd6pD8m9Xmky0s+cQ0hGMjs/3FTqn8TwkXuNvKdnMEnw5GnHw0iXcIYumRv7dq5RxS8vdekMhovqefnHys7RkmE2DJE4UuzNe580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqogeD9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A834C116B1;
	Wed, 31 Jul 2024 05:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722405090;
	bh=UEsjXMA2SABPVP0LGK1Uqnqs5RdT3iO4Qiqk/+tBM3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqogeD9eQBRtKLAq0F8jgH6CJxQdc2YCF9iMinZa+GmmooR2hDJX2f44hx6/8fiaY
	 Bg/tmUNdD9fYASGAPGu3o3PBfOpQB75aklL4Q+Rpx9o3ZKmc5RvD5HBJYAe+GapynX
	 6Or2eM97BgWWZ+1E0vvj3oQYvGRs/7gqoGHzi0BSngKz+FgEwwtneq7k/mLrNStj13
	 5IkI3k+mqzuqEzsIUn5GrYlxfos56oHKAp4yWSMgQMSXLvyPFDBIc/c4fkl27vaVBZ
	 6NIwMOBDE29QqWqqZT09TGkqjowWt5eJ06ePI3jA25Hcx4fzLt7IMsiDSEDEOt4ihK
	 YnoWK2dIHnB9g==
Date: Wed, 31 Jul 2024 07:51:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 7/8] fs: add an ioctl to get the mnt ns id from nsfs
Message-ID: <20240731-wortgefecht-biogas-72e67e7babc7@brauner>
References: <cover.1719243756.git.josef@toxicpanda.com>
 <180449959d5a756af7306d6bda55f41b9d53e3cb.1719243756.git.josef@toxicpanda.com>
 <20240730164554.GA18486@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="czhavtllv27b4av2"
Content-Disposition: inline
In-Reply-To: <20240730164554.GA18486@altlinux.org>


--czhavtllv27b4av2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Jul 30, 2024 at 07:45:54PM GMT, Dmitry V. Levin wrote:
> Hi,
> 
> On Mon, Jun 24, 2024 at 11:49:50AM -0400, Josef Bacik wrote:
> > In order to utilize the listmount() and statmount() extensions that
> > allow us to call them on different namespaces we need a way to get the
> > mnt namespace id from user space.  Add an ioctl to nsfs that will allow
> > us to extract the mnt namespace id in order to make these new extensions
> > usable.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/nsfs.c                 | 14 ++++++++++++++
> >  include/uapi/linux/nsfs.h |  2 ++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/fs/nsfs.c b/fs/nsfs.c
> > index 07e22a15ef02..af352dadffe1 100644
> > --- a/fs/nsfs.c
> > +++ b/fs/nsfs.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/nsfs.h>
> >  #include <linux/uaccess.h>
> >  
> > +#include "mount.h"
> >  #include "internal.h"
> >  
> >  static struct vfsmount *nsfs_mnt;
> > @@ -143,6 +144,19 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
> >  		argp = (uid_t __user *) arg;
> >  		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
> >  		return put_user(uid, argp);
> > +	case NS_GET_MNTNS_ID: {
> > +		struct mnt_namespace *mnt_ns;
> > +		__u64 __user *idp;
> > +		__u64 id;
> > +
> > +		if (ns->ops->type != CLONE_NEWNS)
> > +			return -EINVAL;
> > +
> > +		mnt_ns = container_of(ns, struct mnt_namespace, ns);
> > +		idp = (__u64 __user *)arg;
> > +		id = mnt_ns->seq;
> > +		return put_user(id, idp);
> > +	}
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> > index a0c8552b64ee..56e8b1639b98 100644
> > --- a/include/uapi/linux/nsfs.h
> > +++ b/include/uapi/linux/nsfs.h
> > @@ -15,5 +15,7 @@
> >  #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
> >  /* Get owner UID (in the caller's user namespace) for a user namespace */
> >  #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> > +/* Get the id for a mount namespace */
> > +#define NS_GET_MNTNS_ID		_IO(NSIO, 0x5)
> 
> As the kernel is writing an object of type __u64,
> this has to be defined to _IOR(NSIO, 0x5, __u64) instead,
> see the corresponding comments in uapi/asm-generic/ioctl.h file.

Thanks for spotting that. I've pushed a fix to vfs.fixes. See the
appended patch.

--czhavtllv27b4av2
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-nsfs-fix-ioctl-declaration.patch"

From c43a484ddff73f92739f0167c738eb6fd2df78b7 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 31 Jul 2024 07:47:27 +0200
Subject: [PATCH] nsfs: fix ioctl declaration

The kernel is writing an object of type __u64, so the ioctl has to be
defined to _IOR(NSIO, 0x5, __u64) instead of _IO(NSIO, 0x5).

Reported-by: Dmitry V. Levin <ldv@strace.io>
Link: https://lore.kernel.org/r/20240730164554.GA18486@altlinux.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/nsfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index b133211331f6..5fad3d0fcd70 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -3,6 +3,7 @@
 #define __LINUX_NSFS_H
 
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 #define NSIO	0xb7
 
@@ -16,7 +17,7 @@
 /* Get owner UID (in the caller's user namespace) for a user namespace */
 #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
 /* Get the id for a mount namespace */
-#define NS_GET_MNTNS_ID		_IO(NSIO, 0x5)
+#define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, __u64)
 /* Translate pid from target pid namespace into the caller's pid namespace. */
 #define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
 /* Return thread-group leader id of pid in the callers pid namespace. */
-- 
2.43.0


--czhavtllv27b4av2--

