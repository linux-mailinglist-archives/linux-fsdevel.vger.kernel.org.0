Return-Path: <linux-fsdevel+bounces-22365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B966916A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 16:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2FE1C21B2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5F169AD0;
	Tue, 25 Jun 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grkxs7UY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F4158D7C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325273; cv=none; b=eNO/7lpMPhyCQ4EVTbslASYleD3MKv2UPcaZ5Xgnec3+t3JosyjgvhUuFmA3NYHRf0Ay2mYbX5g30sJcxXMJkrH3pFWzwuBXAR/pY5LehDkv/acifah2heWJH/1xrZWfgAOi3XUJXExir60mCSHO/ZFR1FhELpn9uAS5qVB6ciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325273; c=relaxed/simple;
	bh=Ufq/5wat4DEu0bfHDex7KDp+N8ySGxBNakyWeLwjYgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mku6/3RPusgQ1w9W+uc3bkjMFa0tPNW7G22zbSk07FgKjFvudX4jIaV5Ct6k9QVQXjSiIxJRdaDp6NqxYEykgZeyV7XTVRoBPON9TdTx4SpZ4XRFkh1ig/lnk2HWWi+ecbOBURe9hvtyPFPdKd6Whf4cZ0JTgLCnj31RN5xE7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grkxs7UY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17022C32781;
	Tue, 25 Jun 2024 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719325273;
	bh=Ufq/5wat4DEu0bfHDex7KDp+N8ySGxBNakyWeLwjYgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Grkxs7UY+oPpKdL+DDKItpykLfWQysBqcqp65mExYq0/wPryvjzPqm+D63kn58HOS
	 Npq+lpmokFez9izl38jbE3bkQVsLakEP0wKFiROX+mytGe592ccGPp9MhiXJ0UkdvA
	 PssB+YQphHbu995cdEIIfKwkgLMHobJR4uHN82BxQOllr269GjdIdM1V/SR0TMp4Q2
	 26T6HZJS9CJRBzYzzKM5V1/wprkrFRzkgNMM1cz5XBwBK+pWEPEcrW0aNdJcuBEl90
	 /8oOBofBHeJUIN33kpi4QM8qxWq8WqBJk5SkPJdzHWoxsRGWnBS2rwl2hBfJk8mFTA
	 RtxyIOjlPg9pQ==
Date: Tue, 25 Jun 2024 16:21:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Subject: Re: [PATCH 7/8] fs: add an ioctl to get the mnt ns id from nsfs
Message-ID: <20240625-darunter-wieweit-9ced87b1df0b@brauner>
References: <cover.1719243756.git.josef@toxicpanda.com>
 <180449959d5a756af7306d6bda55f41b9d53e3cb.1719243756.git.josef@toxicpanda.com>
 <14330f15065f92a88c7c0364cba3e26c294293a4.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14330f15065f92a88c7c0364cba3e26c294293a4.camel@kernel.org>

On Tue, Jun 25, 2024 at 10:10:29AM GMT, Jeff Layton wrote:
> On Mon, 2024-06-24 at 11:49 -0400, Josef Bacik wrote:
> > In order to utilize the listmount() and statmount() extensions that
> > allow us to call them on different namespaces we need a way to get
> > the
> > mnt namespace id from user space.  Add an ioctl to nsfs that will
> > allow
> > us to extract the mnt namespace id in order to make these new
> > extensions
> > usable.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/nsfs.c                 | 14 ++++++++++++++
> >  include/uapi/linux/nsfs.h |  2 ++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/fs/nsfs.c b/fs/nsfs.c
> > index 07e22a15ef02..af352dadffe1 100644
> > --- a/fs/nsfs.c
> > +++ b/fs/nsfs.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/nsfs.h>
> >  #include <linux/uaccess.h>
> >  
> > +#include "mount.h"
> >  #include "internal.h"
> >  
> >  static struct vfsmount *nsfs_mnt;
> > @@ -143,6 +144,19 @@ static long ns_ioctl(struct file *filp, unsigned
> > int ioctl,
> >  		argp = (uid_t __user *) arg;
> >  		uid = from_kuid_munged(current_user_ns(), user_ns-
> > >owner);
> >  		return put_user(uid, argp);
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
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> > index a0c8552b64ee..56e8b1639b98 100644
> > --- a/include/uapi/linux/nsfs.h
> > +++ b/include/uapi/linux/nsfs.h
> > @@ -15,5 +15,7 @@
> >  #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
> >  /* Get owner UID (in the caller's user namespace) for a user
> > namespace */
> >  #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> > +/* Get the id for a mount namespace */
> > +#define NS_GET_MNTNS_ID		_IO(NSIO, 0x5)
> >  
> >  #endif /* __LINUX_NSFS_H */
> 
> Thinking about this more...
> 
> Would it also make sense to wire up a similar ioctl in pidfs? It seems
> like it might be nice to just open a pidfd for pid and then issue the
> above to get its mntns id, rather than having to grovel around in nsfs.

I had a different idea yesterday: get a mount namespace fd from a pidfd
in fact, get any namespace fd based on a pidfd. It's the equivalent to:
/proc/$pid/ns* and then you can avoid having to go via procfs at all.

Needs to be governed by ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS).

(We also need an ioctl() on the pidfd to get to the PID without procfs btw.)

