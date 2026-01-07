Return-Path: <linux-fsdevel+bounces-72681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B2CFF9CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 20:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49DA7303492B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 19:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444541ACED5;
	Wed,  7 Jan 2026 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eepL2e8b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953733032C;
	Wed,  7 Jan 2026 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811857; cv=none; b=ljIwzTmwzC+h08hx3JrLGbT6Mqpf6XUavpKNxdTpnoV9Z/QCnjP6rp+0aQtUzRYfuqFjwpUPbQARtb8JYFIhATLaWYA77EgPOlX7I15a4gHVztLx1zR0fqZzCjp7EAcZEPpTIo7/+cHwTp34LDLmFwY+xjar97nrQl31Ow3/HxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811857; c=relaxed/simple;
	bh=dcntz5yo7TL16JzdRfI26eb3bdr9fVlucOOmZVw+5l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8dsjCbWKQgqnTUz8jl7q9z5F8ZqjM3CDSRAjDDMH+xBzm0gz6M+Dq7h/XImzwWKQEPFKKLQxkAQoWBT3rPuBx//2h2wc2+Nx5eoHavLvaeIA+JmoDNjqXZfBF1Lyc0XgkQj9/cVHhzzlCcluzYTeKwqY3r62wW8ai/WL+3ziZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eepL2e8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A10C4CEF1;
	Wed,  7 Jan 2026 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767811856;
	bh=dcntz5yo7TL16JzdRfI26eb3bdr9fVlucOOmZVw+5l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eepL2e8bw2rgHoVt+eomHM3ZWROeuFY38JxwVluacU6ST9E0H+v0VnE77fEv+yfhJ
	 jl8+08QKkQBEBipmIiLNhZ++Innn113kyyycBKdQoY8NB0QIebnvPu+extxnMv388j
	 yXcN+GRtBsHb3KkUk2EizWAuWjLnMTyFgUYoAhPyBbfymWXcJPQFItk59mOZvozVE1
	 +BvzPN5tGoY4rVg9jv/1PiOHyaN4f49Ub+zFxzBW2B1f6VG4WAz6VtR4DSfM82aNH1
	 O2DT+E2eR+DbSTa97hVcAi284Cf9HMc5HoOySj29UEYE/NlXR1QZDRhrqQf9zrDKWf
	 M6qriGzhJz56A==
Date: Wed, 7 Jan 2026 10:50:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/11] xfs: start creating infrastructure for health
 monitoring
Message-ID: <20260107185055.GE15551@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
 <176766637289.774337.11016648296945814848.stgit@frogsfrogsfrogs>
 <20260107091713.GB22838@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107091713.GB22838@lst.de>

On Wed, Jan 07, 2026 at 10:17:13AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 05, 2026 at 11:11:08PM -0800, Darrick J. Wong wrote:
> > +struct xfs_health_monitor {
> > +	__u64	flags;		/* flags */
> > +	__u8	format;		/* output format */
> > +	__u8	pad1[7];	/* zeroes */
> > +	__u64	pad2[2];	/* zeroes */
> > +};
> 
> Why not use a single __u8-based padding field?

Ok.

> > +struct xfs_healthmon {
> > +	/*
> > +	 * Weak reference to the xfs filesystem that is being monitored.  It
> > +	 * will be set to zero when the filesystem detaches from the monitor.
> > +	 * Do not dereference this pointer.
> > +	 */
> > +	uintptr_t			mount_cookie;
> > +
> > +	/*
> > +	 * Device number of the filesystem being monitored.  This is for
> > +	 * consistent tracing even after unmount.
> > +	 */
> > +	dev_t				dev;
> 
> It isn't really used for tracking, but just in a single print, right?

It's used for tracepoints and fdinfo.

> > + * be parsed easily by userspace.  Then we hook various parts of the filesystem
> 
> Is the hooking terminology still right?

I still think of the entry points as hooks, but I'll reword it to avoid
confusion with the actual xfs_hooks:

"When those internal events occur, the filesystem will call this health
monitor to convey them to userspace."

> > + * The healthmon abstraction has a weak reference to the host filesystem mount
> > + * so that the queueing and processing of the events do not pin the mount and
> > + * cannot slow down the main filesystem.  The healthmon object can exist past
> > + * the end of the filesystem mount.
> > + */
> > +
> > +/* sign of a detached health monitor */
> > +#define DETACHED_MOUNT_COOKIE		((uintptr_t)0)
> 
> This almost looks like a not performance optimized version of hazard
> pointers.  Not that we care much about performance here.

Yep.  AFAIK the kernel doesn't have an actual hazard pointer
implementation that we could latch onto, right?

> > +/*
> > + * Free the health monitor after an RCU grace period to eliminate possibility
> > + * of races with xfs_healthmon_get.
> > + */
> > +static inline void
> > +xfs_healthmon_free(
> > +	struct xfs_healthmon		*hm)
> > +{
> > +	kfree_rcu_mightsleep(hm);
> > +}
> 
> Is there much of a point in this wrapper vs just open coding the call to
> kfree_rcu_mightsleep in the only caller?

No, and indeed this could be compressed into _healthmon_put:

	if (refcount_dec_and_test(&hm->ref)) {
		while (hm->first_event) {
			/* free hm->first_event */
		}
		kfree(hm->buffer);
		mutex_destroy(&hm->lock);
		kfree_rcu_mightsleep(hm);
	}

which would be much easier to think about.

> > +/* Is this health monitor active? */
> > +static inline bool
> > +xfs_healthmon_activated(
> > +	struct xfs_healthmon	*hm)
> > +{
> > +	return hm->mount_cookie != DETACHED_MOUNT_COOKIE;
> > +}
> > +
> > +/* Is this health monitor watching the given filesystem? */
> > +static inline bool
> > +xfs_healthmon_covers_fs(
> > +	struct xfs_healthmon	*hm,
> > +	struct super_block	*sb)
> > +{
> > +	return hm->mount_cookie == (uintptr_t)sb;
> > +}
> 
> Is there much of a point in these helpers vs open coding them in the callers?
> (no caller yet in this patch of the second one anyway).  Especially as we
> need to hold a lock for them to be safe.

The only one really worth keeping is _healthmon_activated because it
gets called from various places.  And even then, it now only has three
callsites so maybe it'll just go away.

> > +
> > +/* Attach a health monitor to an xfs_mount.  Only one allowed at a time. */
> > +STATIC int
> > +xfs_healthmon_attach(
> > +	struct xfs_mount	*mp,
> > +	struct xfs_healthmon	*hm)
> > +{
> > +	int			ret = 0;
> > +
> > +	spin_lock(&xfs_healthmon_lock);
> > +	if (mp->m_healthmon == NULL) {
> > +		mp->m_healthmon = hm;
> > +		hm->mount_cookie = (uintptr_t)mp->m_super;
> > +		refcount_inc(&hm->ref);
> > +	} else {
> > +		ret = -EEXIST;
> > +	}
> > +	spin_unlock(&xfs_healthmon_lock);
> > +
> > +	return ret;
> 
> Maybe just me, but I'd do away with the ret variable and just handle the
> EEXIST case directly:
> 
> 	spin_lock(&xfs_healthmon_lock);
> 	if (mp->m_healthmon) {
> 		spin_unlock(&xfs_healthmon_lock);
> 		return -EEXIST;
> 	}
> 	refcount_inc(&hm->ref);
> 	mp->m_healthmon = hm;
> 	hm->mount_cookie = (uintptr_t)mp->m_super;
> 	spin_unlock(&xfs_healthmon_lock);
> 	return 0;
> 
> > +/* Detach a xfs mount from a specific healthmon instance. */
> > +STATIC void
> > +xfs_healthmon_detach(
> > +	struct xfs_healthmon	*hm)
> > +{
> > +	spin_lock(&xfs_healthmon_lock);
> > +	if (xfs_healthmon_activated(hm)) {
> > +		struct xfs_mount	*mp =
> > +			XFS_M((struct super_block *)hm->mount_cookie);
> > +
> > +		mp->m_healthmon = NULL;
> > +		hm->mount_cookie = DETACHED_MOUNT_COOKIE;
> > +	} else {
> > +		hm = NULL;
> > +	}
> > +	spin_unlock(&xfs_healthmon_lock);
> > +
> > +	if (hm)
> > +		xfs_healthmon_put(hm);
> > +}
> 
> Kinda similar here:
> 
> 	struct xfs_mount	*mp;
> 
> 	spin_lock(&xfs_healthmon_lock);
> 	if (hm->mount_cookie == DETACHED_MOUNT_COOKIE) {
> 		spin_unlock(&xfs_healthmon_lock);
> 		return;
> 	}
> 
> 	XFS_M((struct super_block *)hm->mount_cookie)->m_healthmon = NULL;
> 	hm->mount_cookie = DETACHED_MOUNT_COOKIE;
> 	spin_unlock(&xfs_healthmon_lock);
> 
> 	xfs_healthmon_put(hm);

Will change.  And get rid of some of the mount cookie helpers.

Thanks for reading!

--D

