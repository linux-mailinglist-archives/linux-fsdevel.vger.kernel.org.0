Return-Path: <linux-fsdevel+bounces-60896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8349B52A89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A833A908F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8272BE02B;
	Thu, 11 Sep 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1AjlyyD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF521CC4B;
	Thu, 11 Sep 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577129; cv=none; b=t0zCo3C5u2uNgHI/q1YaQCWQSoKfaTVhgowGqHMbhusihLsU4PZ/MTA2ujDtWYMbCOMkIm3vkRzXf4g51DGzzo77ex056IQBjy13i4VbGjJD5iG3CHFwAKbKJa3zSP3JGLrF8sRTqilXHGhGh+2X4EZvNk5gyvezBy9r2uVrj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577129; c=relaxed/simple;
	bh=zCa/Trshx6t//cjDi+8MplzJbi0R8aSBzBBF4hlrJaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqRGPEMMvYtcEST3KCvT1SFpVR4TKpEmBc6NRzIxMbjKdDjXRBny8uuJ0CXdxGB7arVo19AMnueuDTSYWZVEy9CDJNkiVT5BP8D5Au65dXTyozmotc0NAvDSccEuiGlTCeA3EnUzm6M7Vygj+bWJSmmkROUVSA3/NLEyEB3VwZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1AjlyyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F95DC4CEF1;
	Thu, 11 Sep 2025 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757577128;
	bh=zCa/Trshx6t//cjDi+8MplzJbi0R8aSBzBBF4hlrJaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1AjlyyDYEn9GxWz2+UfShAjuVTVlMdY7BvFsdN/00ftJKHXadGlP1U0K16/N0l/d
	 z/g18n4+AHhrm9ThUIFJjTovOyc7zU8l1+ehGq8MFzQBSAXjHzFWfpydpU2loJCKC7
	 OruzJApGWUEdY/eehGGpa/sxpoF9tbT69+v1M9R1VFi4B5nbdPBPS3Nqbr6zOggqOv
	 eD/nN7cQ+tJe/qnSpKEhJNf8J8keyAc6blrhW/elyTI3MQx/QwexR1TzakugRMZVCf
	 jNEm99gJksMTsfEbG6bjnGZAggwyRKGRYexdRVXUtJRAi+U7YrSw/F+1rJRjYdPn3I
	 9Abpbkkxf9MDQ==
Date: Thu, 11 Sep 2025 09:52:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 29/32] nsfs: add missing id retrieval support
Message-ID: <20250911-korallen-aufgibt-faafc9df8f9a@brauner>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-29-4dd56e7359d8@kernel.org>
 <2025-09-10-yawning-gross-samba-lox-6iVSwq@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025-09-10-yawning-gross-samba-lox-6iVSwq@cyphar.com>

On Thu, Sep 11, 2025 at 02:49:49AM +1000, Aleksa Sarai wrote:
> On 2025-09-10, Christian Brauner <brauner@kernel.org> wrote:
> > The mount namespace has supported id retrieval for a while already.
> > Add support for the other types as well.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/nsfs.c                 | 74 +++++++++++++++++++++++++++++++++++++++--------
> >  include/uapi/linux/nsfs.h | 12 ++++++--
> >  2 files changed, 72 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/nsfs.c b/fs/nsfs.c
> > index 3c6fcf652633..527480e67fd1 100644
> > --- a/fs/nsfs.c
> > +++ b/fs/nsfs.c
> > @@ -173,6 +173,13 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
> >  	case NS_GET_NSTYPE:
> >  	case NS_GET_OWNER_UID:
> >  	case NS_GET_MNTNS_ID:
> > +	case NS_GET_NETNS_ID:
> > +	case NS_GET_CGROUPNS_ID:
> > +	case NS_GET_IPCNS_ID:
> > +	case NS_GET_UTSNS_ID:
> > +	case NS_GET_PIDNS_ID:
> > +	case NS_GET_TIMENS_ID:
> > +	case NS_GET_USERNS_ID:
> >  	case NS_GET_PID_FROM_PIDNS:
> >  	case NS_GET_TGID_FROM_PIDNS:
> >  	case NS_GET_PID_IN_PIDNS:
> > @@ -226,18 +233,6 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
> >  		argp = (uid_t __user *) arg;
> >  		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
> >  		return put_user(uid, argp);
> > -	case NS_GET_MNTNS_ID: {
> > -		__u64 __user *idp;
> > -		__u64 id;
> > -
> > -		if (ns->ops->type != CLONE_NEWNS)
> > -			return -EINVAL;
> > -
> > -		mnt_ns = container_of(ns, struct mnt_namespace, ns);
> > -		idp = (__u64 __user *)arg;
> > -		id = mnt_ns->ns.ns_id;
> > -		return put_user(id, idp);
> > -	}
> >  	case NS_GET_PID_FROM_PIDNS:
> >  		fallthrough;
> >  	case NS_GET_TGID_FROM_PIDNS:
> > @@ -283,6 +278,61 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
> >  			ret = -ESRCH;
> >  		return ret;
> >  	}
> > +	case NS_GET_MNTNS_ID:
> > +		fallthrough;
> > +	case NS_GET_NETNS_ID:
> > +		fallthrough;
> > +	case NS_GET_CGROUPNS_ID:
> > +		fallthrough;
> > +	case NS_GET_IPCNS_ID:
> > +		fallthrough;
> > +	case NS_GET_UTSNS_ID:
> > +		fallthrough;
> > +	case NS_GET_PIDNS_ID:
> > +		fallthrough;
> > +	case NS_GET_TIMENS_ID:
> > +		fallthrough;
> > +	case NS_GET_USERNS_ID: {
> > +		__u64 __user *idp;
> > +		__u64 id;
> > +		int expected_type;
> > +
> > +		switch (ioctl) {
> > +		case NS_GET_MNTNS_ID:
> > +			expected_type = CLONE_NEWNS;
> > +			break;
> > +		case NS_GET_NETNS_ID:
> > +			expected_type = CLONE_NEWNET;
> > +			break;
> > +		case NS_GET_CGROUPNS_ID:
> > +			expected_type = CLONE_NEWCGROUP;
> > +			break;
> > +		case NS_GET_IPCNS_ID:
> > +			expected_type = CLONE_NEWIPC;
> > +			break;
> > +		case NS_GET_UTSNS_ID:
> > +			expected_type = CLONE_NEWUTS;
> > +			break;
> > +		case NS_GET_PIDNS_ID:
> > +			expected_type = CLONE_NEWPID;
> > +			break;
> > +		case NS_GET_TIMENS_ID:
> > +			expected_type = CLONE_NEWTIME;
> > +			break;
> > +		case NS_GET_USERNS_ID:
> > +			expected_type = CLONE_NEWUSER;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (ns->ops->type != expected_type)
> > +			return -EINVAL;
> 
> While I get that having this be per-ns-type lets programs avoid being
> tricked into thinking that one namespace ID is actually another
> namespace, it feels a bit ugly to have to add a new ioctl for every new
> namespace.
> 
> If we added a way to get the CLONE_* flag for a namespace (NS_GET_TYPE)

That exists afaict: NS_GET_NSTYPE.

> we could have just NS_GET_ID. Of course, we would have to trust
> userspace to do the right thing...

So NS_GET_ID can just return the id and be done with it. If userspace
wants to know what type it is they can issue a separate ioctl. But since
the id space is shared all ids of all namespaces can be compared with
each other reliably. So really for comparision you wouldn't need to
care. IOW, yes.

> 
> > +
> > +		idp = (__u64 __user *)arg;
> > +		id = ns->ns_id;
> > +		return put_user(id, idp);
> > +	}
> >  	}
> >  
> >  	/* extensible ioctls */
> > diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> > index 97d8d80d139f..f7c21840cc09 100644
> > --- a/include/uapi/linux/nsfs.h
> > +++ b/include/uapi/linux/nsfs.h
> > @@ -16,8 +16,6 @@
> >  #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
> >  /* Get owner UID (in the caller's user namespace) for a user namespace */
> >  #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> > -/* Get the id for a mount namespace */
> > -#define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, __u64)
> >  /* Translate pid from target pid namespace into the caller's pid namespace. */
> >  #define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
> >  /* Return thread-group leader id of pid in the callers pid namespace. */
> > @@ -42,6 +40,16 @@ struct mnt_ns_info {
> >  /* Get previous namespace. */
> >  #define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
> >  
> > +/* Retrieve namespace identifiers. */
> > +#define NS_GET_MNTNS_ID		_IOR(NSIO, 5,  __u64)
> > +#define NS_GET_NETNS_ID		_IOR(NSIO, 13, __u64)
> > +#define NS_GET_CGROUPNS_ID	_IOR(NSIO, 14, __u64)
> > +#define NS_GET_IPCNS_ID		_IOR(NSIO, 15, __u64)
> > +#define NS_GET_UTSNS_ID		_IOR(NSIO, 16, __u64)
> > +#define NS_GET_PIDNS_ID		_IOR(NSIO, 17, __u64)
> > +#define NS_GET_TIMENS_ID	_IOR(NSIO, 18, __u64)
> > +#define NS_GET_USERNS_ID	_IOR(NSIO, 19, __u64)
> > +
> >  enum init_ns_ino {
> >  	IPC_NS_INIT_INO		= 0xEFFFFFFFU,
> >  	UTS_NS_INIT_INO		= 0xEFFFFFFEU,
> > 
> > -- 
> > 2.47.3
> > 
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



