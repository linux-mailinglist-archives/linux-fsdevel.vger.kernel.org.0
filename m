Return-Path: <linux-fsdevel+bounces-72601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0444CFCE40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 10:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 064BC30A50CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A5E2F6904;
	Wed,  7 Jan 2026 09:32:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D72DC792;
	Wed,  7 Jan 2026 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778370; cv=none; b=eIdhnpSXzMxvTGqx3BwZ2LZpcZRRZ6Kl4k/nqAJP2dAyk0XcfPSpzhNle73F8xLXnoIznS1KaDJ/7q38bu+50Mn6GsWDTtfE1+KD2RYQ1VyVQbZN3DPkgmfqnFZ0h4inIjDciEVKoZ04yfAeJ+d6LFL/8ijO85CPKxlSphIHWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778370; c=relaxed/simple;
	bh=mRGjStRLI6jqhj51EiUGBQoiVhSKN5yqSu2iXE5dCOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGk50TvdgBn/bEwxM6WZ2J9u9U9+mvpvwpBwDXRtjVevm8ztsY0u6hX2rpQmp/woR5idoI07C8TA9t+HC3plwnGYyDlFVAqwsM8Mifreflt+1e9iAKBTxrDsIGScwJFbvZ8srM6YbXfMjxWcP/cAbSM4rlM6qmmCpbWqJRs55zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 77818227A87; Wed,  7 Jan 2026 10:32:45 +0100 (CET)
Date: Wed, 7 Jan 2026 10:32:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/11] xfs: create event queuing, formatting, and
 discovery infrastructure
Message-ID: <20260107093245.GA24264@lst.de>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs> <176766637311.774337.2635132516714726157.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176766637311.774337.2635132516714726157.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 05, 2026 at 11:11:24PM -0800, Darrick J. Wong wrote:
> diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
> index 3fdac72b478f3f..799e0687ae3263 100644
> --- a/fs/xfs/xfs_healthmon.c
> +++ b/fs/xfs/xfs_healthmon.c
> @@ -45,6 +45,13 @@
>  /* sign of a detached health monitor */
>  #define DETACHED_MOUNT_COOKIE		((uintptr_t)0)
>  
> +/* Constrain the number of event objects that can build up in memory. */
> +#define XFS_HEALTHMON_MAX_EVENTS \
> +		(SZ_32K / sizeof(struct xfs_healthmon_event))

The double tab indent here looks a bit weird.

> +/* Free all events */
> +STATIC void
> +xfs_healthmon_free_events(
> +	struct xfs_healthmon		*hm)
> +{
> +	struct xfs_healthmon_event	*event, *next;
> +
> +	event = hm->first_event;
> +	while (event != NULL) {
> +		trace_xfs_healthmon_drop(hm, event);
> +		next = event->next;
> +		kfree(event);
> +		event = next;
> +	}

This could be simplified a bit to:

	struct xfs_healthmon_event	*event = hm->first_event;

	while (event) {
		struct xfs_healthmon_event	*next = event->next;

		trace_xfs_healthmon_drop(hm, event);
		kfree(event);
		event = next;
	}

or alternatively:
	
	struct xfs_healthmon_event	*event, *next = hm->first_event;

	while ((event = next) != NULL) {
		trace_xfs_healthmon_drop(hm, event);
		next = event->next;
		kfree(event);
	}

> +	hm->first_event = hm->last_event = NULL;

Always personal preference, but I always hate decoding double assignments
like this vs the more verbose:

	hm->first_event = NULL;
	hm->last_event = NULL;

that beeing said, do we even need to zero these given that hm gets freed
right after?

> +		return false;
> +
> +	switch (existing->type) {
> +	case XFS_HEALTHMON_RUNNING:
> +		/* should only ever be one of these events anyway */
> +		return false;
> +
> +	case XFS_HEALTHMON_LOST:
> +		existing->lostcount += new->lostcount;
> +		return true;
> +	}
> +
> +	return false;

I think the XFS_HEALTHMON_RUNNING check here is redundant, so you could
just special case XFS_HEALTHMON_LOST with an if instead of the switch
statement.

> +/* Make a stack event dynamic so we can put it on the list. */
> +static inline struct xfs_healthmon_event *
> +xfs_healthmon_event_dup(
> +	const struct xfs_healthmon_event	*event)
> +{
> +	return kmemdup(event, sizeof(struct xfs_healthmon_event), GFP_NOFS);
> +}

The callers of this and and xfs_healthmon_merge_events seem to share
the same logic.  Maybe add a helper for the two calls and the
XFS_HEALTHMON_MAX_EVENTS check, and fold at least xfs_healthmon_event_dup
(and maybe xfs_healthmon_merge_events if it works out) into that?

> +	if (file->f_flags & O_NONBLOCK) {
> +		if (!xfs_healthmon_has_eventdata(hm))
> +			return -EAGAIN;
> +	} else {
> +		ret = wait_event_interruptible(hm->wait,
> +				xfs_healthmon_has_eventdata(hm));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	inode_lock(inode);

should this be a trylock + -EAGAIN for O_NONBLOCK?


