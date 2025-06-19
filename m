Return-Path: <linux-fsdevel+bounces-52201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03136AE02BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8354C189FA5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C486E224898;
	Thu, 19 Jun 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BIwxu6yy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03195221DA5;
	Thu, 19 Jun 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329219; cv=none; b=scQ8GmbLcWVpjtKI/4s1D+vLxXByK25ijcObPzsG5kQktPGGgHwNOHZeGxd9F321x024zNB/XJZOSEcPxPaG2vl2ZsEOmdh4PhKV5h5lHM6NalnKiZhNdvEi6t59v9wKidPfSxYDVRZK4yDGnEvgNq1snI5JQQczs7gmMM3kwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329219; c=relaxed/simple;
	bh=nZOJnav4OaxTkQHH6I3Z1VQrNr4yBKaUDCt16h3kwuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3cMLFDDvmbA1WMpElXSTTL9VM9shWWZ4i1wXLppA4ppoY1yDZ6iBM5etCmbXh6A2PJ5mtiS9us4fL4dhI10Qo4bxxslj+xOqi/+C3jCKyDmQNzOqh0h3n10EbYp4dgAoXwshLurOz0CB34Sk6t5b0zEap+hfc0FHqOP549IFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BIwxu6yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98E5C4CEEA;
	Thu, 19 Jun 2025 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750329216;
	bh=nZOJnav4OaxTkQHH6I3Z1VQrNr4yBKaUDCt16h3kwuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BIwxu6yyxi2aaHFm1IXGR8UqKWXZzJxilRJCimbx5oVISHRbYrctKBg5YSH6fX/ru
	 +O0+kXgLfWoMRHz2Bju9p8KVlMmktTMuGmptq3g0vdKD4q+VuZlG6pq8ciKWDsbVrR
	 3afbmQMUeP07rUrZ21fmzGBEE/Y5PGTLVx8xeBAY=
Date: Thu, 19 Jun 2025 12:33:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org,
	mattbobrowski@google.com, amir73il@gmail.com,
	daan.j.demeyer@gmail.com
Subject: Re: [PATCH bpf-next 1/4] kernfs: Add __kernfs_xattr_get for RCU
 protected access
Message-ID: <2025061917-unrushed-overtake-e4ef@gregkh>
References: <20250618233739.189106-1-song@kernel.org>
 <20250618233739.189106-2-song@kernel.org>
 <20250619-kaulquappen-absagen-27377e154bc0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-kaulquappen-absagen-27377e154bc0@brauner>

On Thu, Jun 19, 2025 at 12:01:19PM +0200, Christian Brauner wrote:
> On Wed, Jun 18, 2025 at 04:37:36PM -0700, Song Liu wrote:
> > Existing kernfs_xattr_get() locks iattr_mutex, so it cannot be used in
> > RCU critical sections. Introduce __kernfs_xattr_get(), which reads xattr
> > under RCU read lock. This can be used by BPF programs to access cgroupfs
> > xattrs.
> > 
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  fs/kernfs/inode.c      | 14 ++++++++++++++
> >  include/linux/kernfs.h |  2 ++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > index b83054da68b3..0ca231d2012c 100644
> > --- a/fs/kernfs/inode.c
> > +++ b/fs/kernfs/inode.c
> > @@ -302,6 +302,20 @@ int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
> >  	return simple_xattr_get(&attrs->xattrs, name, value, size);
> >  }
> >  
> > +int __kernfs_xattr_get(struct kernfs_node *kn, const char *name,
> > +		       void *value, size_t size)
> > +{
> > +	struct kernfs_iattrs *attrs;
> > +
> > +	WARN_ON_ONCE(!rcu_read_lock_held());
> > +
> > +	attrs = rcu_dereference(kn->iattr);
> > +	if (!attrs)
> > +		return -ENODATA;
> 
> Hm, that looks a bit silly. Which isn't your fault. I'm looking at the
> kernfs code that does the xattr allocations and I think that's the
> origin of the silliness. It uses a single global mutex for all kernfs
> users thus serializing all allocations for kernfs->iattr. That seems
> crazy but maybe I'm missing a good reason.
> 
> I'm appending a patch to remove that mutex. @Greg, @Tejun, can you take
> a look whether that makes sense to you. Then I can take that patch and
> you can build yours on top of the series and I'll pick it all up in one
> go.

Looks sane to me, thanks!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

