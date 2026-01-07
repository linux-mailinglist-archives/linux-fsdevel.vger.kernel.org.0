Return-Path: <linux-fsdevel+bounces-72599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA1CFCCA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 10:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5851C3003854
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B23E2E9ED6;
	Wed,  7 Jan 2026 09:17:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE02701DC;
	Wed,  7 Jan 2026 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777439; cv=none; b=bcnQOnxE++eMXIbVAQcvuMD3zutchH4WMRrKt1uZV+jNbrQZ9u+NIr3aen9cCDxvjevUak7IIJkO/kp6KTRGKw/mV8u81TujMNLUVSl40FcsbnsDo161Ly/TlgGdo+F34vLvzLuEH2dhF7hzWN4bz35zlYFheL7RmzsThe8d5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777439; c=relaxed/simple;
	bh=4zvYr5Pm5yPWhQdzj6n1eLfcCyvZsaLxTEHQEnlmHkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIZVsLus/r4cXvYjmMA5ihBYSWHSVy5Vi86kanBId/HaiEze3aqfxbHxpPVLl3quTiLpu5fpasHstX5j6/Pv2SR2A4qYhIqjUI9oiGPf8giyN4vypuWpCs2bootq4A1Hs+nr4N8HiXGyOGMZQu93s71RZOZn1nLBpfjtxusFk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A3904227A87; Wed,  7 Jan 2026 10:17:13 +0100 (CET)
Date: Wed, 7 Jan 2026 10:17:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/11] xfs: start creating infrastructure for health
 monitoring
Message-ID: <20260107091713.GB22838@lst.de>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs> <176766637289.774337.11016648296945814848.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176766637289.774337.11016648296945814848.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 05, 2026 at 11:11:08PM -0800, Darrick J. Wong wrote:
> +struct xfs_health_monitor {
> +	__u64	flags;		/* flags */
> +	__u8	format;		/* output format */
> +	__u8	pad1[7];	/* zeroes */
> +	__u64	pad2[2];	/* zeroes */
> +};

Why not use a single __u8-based padding field?

> +struct xfs_healthmon {
> +	/*
> +	 * Weak reference to the xfs filesystem that is being monitored.  It
> +	 * will be set to zero when the filesystem detaches from the monitor.
> +	 * Do not dereference this pointer.
> +	 */
> +	uintptr_t			mount_cookie;
> +
> +	/*
> +	 * Device number of the filesystem being monitored.  This is for
> +	 * consistent tracing even after unmount.
> +	 */
> +	dev_t				dev;

It isn't really used for tracking, but just in a single print, right?

> + * be parsed easily by userspace.  Then we hook various parts of the filesystem

Is the hooking terminology still right?

> + * The healthmon abstraction has a weak reference to the host filesystem mount
> + * so that the queueing and processing of the events do not pin the mount and
> + * cannot slow down the main filesystem.  The healthmon object can exist past
> + * the end of the filesystem mount.
> + */
> +
> +/* sign of a detached health monitor */
> +#define DETACHED_MOUNT_COOKIE		((uintptr_t)0)

This almost looks like a not performance optimized version of hazard
pointers.  Not that we care much about performance here.

> +/*
> + * Free the health monitor after an RCU grace period to eliminate possibility
> + * of races with xfs_healthmon_get.
> + */
> +static inline void
> +xfs_healthmon_free(
> +	struct xfs_healthmon		*hm)
> +{
> +	kfree_rcu_mightsleep(hm);
> +}

Is there much of a point in this wrapper vs just open coding the call to
kfree_rcu_mightsleep in the only caller?

> +/* Is this health monitor active? */
> +static inline bool
> +xfs_healthmon_activated(
> +	struct xfs_healthmon	*hm)
> +{
> +	return hm->mount_cookie != DETACHED_MOUNT_COOKIE;
> +}
> +
> +/* Is this health monitor watching the given filesystem? */
> +static inline bool
> +xfs_healthmon_covers_fs(
> +	struct xfs_healthmon	*hm,
> +	struct super_block	*sb)
> +{
> +	return hm->mount_cookie == (uintptr_t)sb;
> +}

Is there much of a point in these helpers vs open coding them in the callers?
(no caller yet in this patch of the second one anyway).  Especially as we
need to hold a lock for them to be safe.

> +
> +/* Attach a health monitor to an xfs_mount.  Only one allowed at a time. */
> +STATIC int
> +xfs_healthmon_attach(
> +	struct xfs_mount	*mp,
> +	struct xfs_healthmon	*hm)
> +{
> +	int			ret = 0;
> +
> +	spin_lock(&xfs_healthmon_lock);
> +	if (mp->m_healthmon == NULL) {
> +		mp->m_healthmon = hm;
> +		hm->mount_cookie = (uintptr_t)mp->m_super;
> +		refcount_inc(&hm->ref);
> +	} else {
> +		ret = -EEXIST;
> +	}
> +	spin_unlock(&xfs_healthmon_lock);
> +
> +	return ret;

Maybe just me, but I'd do away with the ret variable and just handle the
EEXIST case directly:

	spin_lock(&xfs_healthmon_lock);
	if (mp->m_healthmon) {
		spin_unlock(&xfs_healthmon_lock);
		return -EEXIST;
	}
	refcount_inc(&hm->ref);
	mp->m_healthmon = hm;
	hm->mount_cookie = (uintptr_t)mp->m_super;
	spin_unlock(&xfs_healthmon_lock);
	return 0;

> +/* Detach a xfs mount from a specific healthmon instance. */
> +STATIC void
> +xfs_healthmon_detach(
> +	struct xfs_healthmon	*hm)
> +{
> +	spin_lock(&xfs_healthmon_lock);
> +	if (xfs_healthmon_activated(hm)) {
> +		struct xfs_mount	*mp =
> +			XFS_M((struct super_block *)hm->mount_cookie);
> +
> +		mp->m_healthmon = NULL;
> +		hm->mount_cookie = DETACHED_MOUNT_COOKIE;
> +	} else {
> +		hm = NULL;
> +	}
> +	spin_unlock(&xfs_healthmon_lock);
> +
> +	if (hm)
> +		xfs_healthmon_put(hm);
> +}

Kinda similar here:

	struct xfs_mount	*mp;

	spin_lock(&xfs_healthmon_lock);
	if (hm->mount_cookie == DETACHED_MOUNT_COOKIE) {
		spin_unlock(&xfs_healthmon_lock);
		return;
	}

	XFS_M((struct super_block *)hm->mount_cookie)->m_healthmon = NULL;
	hm->mount_cookie = DETACHED_MOUNT_COOKIE;
	spin_unlock(&xfs_healthmon_lock);

	xfs_healthmon_put(hm);


