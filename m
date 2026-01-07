Return-Path: <linux-fsdevel+bounces-72684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8744CFFB11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 20:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7137132DEF52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2AA800;
	Wed,  7 Jan 2026 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZt+HrHx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268E4A35;
	Wed,  7 Jan 2026 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812503; cv=none; b=cqxR9++KdI6i6/xl9PPQjBPGZWa02RrUIg20Xk9f0vcvTWfIk6hEGGeQ00AGZIq91FI/miIEGdA4Y9B0h/jq1thjVc/2JHAMpfI8xOZ0RE6YeMHjoeUR5RXIDDpedDZKkZZZv6RjsC3UNQnJgn6OeWYbiEYy4EJ7yPMZRH8aVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812503; c=relaxed/simple;
	bh=sDwOAC6+V6ZXqreGwzXX4jWEdA8kLtRlRj+GspvBufE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/iPiXAhCE7S6L3cGKuBTCq22/9bOxZcQBbisQ6TGfrSUdo+y1PI66m9l4fIX/MSn+cSCsUyL9orJZ2iZC3l0//RDqGfXLQuTHAjOq+0Js1oaVXFA+L/Kn9l6ZhXm9RYfP2UKOgoiuc5zvbYIBh/Vt34MaaJZok1Bh7IV2y9LfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZt+HrHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E7CC4CEF1;
	Wed,  7 Jan 2026 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767812502;
	bh=sDwOAC6+V6ZXqreGwzXX4jWEdA8kLtRlRj+GspvBufE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZt+HrHx+NIIU27/Mr1fJd0yYiPwLtsorAI1K1Bc4mlkjGEuoRN2Gx1Kguhl9YEHo
	 nt4DRW3LD01LlZDKqBsDbBu+57mgUZgWhGHfkIulX0TqnPG4XNs9tCHZwGPtTlo40r
	 JeqfELCbL2F30a9TUAzBYMTtpbMQPCl5VONiqw8yrGIwZFY9dCiZ9LdcvohFXin5qj
	 NycZMVRmYgIoZuGRRmWrChznG2kvomVIUaut/DqAnxauuymdDU3mI35+Rd84p0Ud8n
	 ULZGipvlKfzh4A07VhPFtRyEzX3NSj2+9eYdgpaRsto6ZaX1+y21HGga06qTcQ0VVg
	 Mb3qKBCBoZj4w==
Date: Wed, 7 Jan 2026 11:01:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/11] xfs: create event queuing, formatting, and
 discovery infrastructure
Message-ID: <20260107190141.GF15551@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
 <176766637311.774337.2635132516714726157.stgit@frogsfrogsfrogs>
 <20260107093245.GA24264@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107093245.GA24264@lst.de>

On Wed, Jan 07, 2026 at 10:32:45AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 05, 2026 at 11:11:24PM -0800, Darrick J. Wong wrote:
> > diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
> > index 3fdac72b478f3f..799e0687ae3263 100644
> > --- a/fs/xfs/xfs_healthmon.c
> > +++ b/fs/xfs/xfs_healthmon.c
> > @@ -45,6 +45,13 @@
> >  /* sign of a detached health monitor */
> >  #define DETACHED_MOUNT_COOKIE		((uintptr_t)0)
> >  
> > +/* Constrain the number of event objects that can build up in memory. */
> > +#define XFS_HEALTHMON_MAX_EVENTS \
> > +		(SZ_32K / sizeof(struct xfs_healthmon_event))
> 
> The double tab indent here looks a bit weird.
> 
> > +/* Free all events */
> > +STATIC void
> > +xfs_healthmon_free_events(
> > +	struct xfs_healthmon		*hm)
> > +{
> > +	struct xfs_healthmon_event	*event, *next;
> > +
> > +	event = hm->first_event;
> > +	while (event != NULL) {
> > +		trace_xfs_healthmon_drop(hm, event);
> > +		next = event->next;
> > +		kfree(event);
> > +		event = next;
> > +	}
> 
> This could be simplified a bit to:
> 
> 	struct xfs_healthmon_event	*event = hm->first_event;
> 
> 	while (event) {
> 		struct xfs_healthmon_event	*next = event->next;
> 
> 		trace_xfs_healthmon_drop(hm, event);
> 		kfree(event);
> 		event = next;
> 	}
> 
> or alternatively:
> 	
> 	struct xfs_healthmon_event	*event, *next = hm->first_event;
> 
> 	while ((event = next) != NULL) {
> 		trace_xfs_healthmon_drop(hm, event);
> 		next = event->next;
> 		kfree(event);
> 	}

Changed.

> > +	hm->first_event = hm->last_event = NULL;
> 
> Always personal preference, but I always hate decoding double assignments
> like this vs the more verbose:
> 
> 	hm->first_event = NULL;
> 	hm->last_event = NULL;
> 
> that beeing said, do we even need to zero these given that hm gets freed
> right after?

Nope.

> > +		return false;
> > +
> > +	switch (existing->type) {
> > +	case XFS_HEALTHMON_RUNNING:
> > +		/* should only ever be one of these events anyway */
> > +		return false;
> > +
> > +	case XFS_HEALTHMON_LOST:
> > +		existing->lostcount += new->lostcount;
> > +		return true;
> > +	}
> > +
> > +	return false;
> 
> I think the XFS_HEALTHMON_RUNNING check here is redundant, so you could
> just special case XFS_HEALTHMON_LOST with an if instead of the switch
> statement.

The switch statement fills out as we add more event types, and with the
way it's written now, gcc will complain if someone enlarges the enum
without adding a switch case here.  So I'd prefer to keep this the way
it is now.

> > +/* Make a stack event dynamic so we can put it on the list. */
> > +static inline struct xfs_healthmon_event *
> > +xfs_healthmon_event_dup(
> > +	const struct xfs_healthmon_event	*event)
> > +{
> > +	return kmemdup(event, sizeof(struct xfs_healthmon_event), GFP_NOFS);
> > +}
> 
> The callers of this and and xfs_healthmon_merge_events seem to share
> the same logic.  Maybe add a helper for the two calls and the
> XFS_HEALTHMON_MAX_EVENTS check, and fold at least xfs_healthmon_event_dup
> (and maybe xfs_healthmon_merge_events if it works out) into that?

_event_dup can be folded into its callers.

I'm less sure about _merge_events -- it would be pretty easy to
opencode its logic in _clear_lost_prev:

	if (hm->last_event &&
	    hm->last_event->type == XFS_HEALTHMON_LOST &&
	    hm->last_event->domain == XFS_HEALTHMON_MOUNT) {
		hm->last_event->lostcount += hm->lost_prev_event;
		trace_xfs_healthmon_merge(hm, hm->last_event);
		wake_up(&hm->wait);
		goto cleared;
	}

But the downside is that either we leave the dead XFS_HEALTHMON_LOST
case in the switch statement in _merge_events to avoid giving up the
compiler checking, or we add a default: case which then means that
authors of future extensions can miss things without noticing.

I think I'll remove _event_dup but leave the merge function.

> > +	if (file->f_flags & O_NONBLOCK) {
> > +		if (!xfs_healthmon_has_eventdata(hm))
> > +			return -EAGAIN;
> > +	} else {
> > +		ret = wait_event_interruptible(hm->wait,
> > +				xfs_healthmon_has_eventdata(hm));
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	inode_lock(inode);
> 
> should this be a trylock + -EAGAIN for O_NONBLOCK?

Oops yes.

--D

