Return-Path: <linux-fsdevel+bounces-73461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D63CD1A1E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D50C307DBD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40103876CE;
	Tue, 13 Jan 2026 16:11:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21773378D8F;
	Tue, 13 Jan 2026 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320670; cv=none; b=nO2A5XUKJOfo+Cxv9ez/Cqnc6yUSqZtJnWcd9owclKX954g/nTSjH0jwXWeIBQ7D5bw3icWJstXsW0CMEHXe5XWIo4SNsyhhusODQ3OYzUZ8o4fZeiXyPrXRfMKrS0K95Jqd+wem5OoSrYQlXGWSvU+KDmTyEkw7nKkV7DO2xo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320670; c=relaxed/simple;
	bh=BU2YqPEwb1t+k6V8HbT2rN+4tqo0ou8XDGIJSQKsSVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYc6z78h3xy6wOAEXKs5d2ONaouVELXSPXEqjEURxA0mja1e13m/b2zyapamuKSfpp+JejMJbzL5SdQ4G1Vt8kOH75z5kTonm1nZoiV7GZ7Q+UfAI4tozwGfXGaXGOP2OjHYUQwAOKeF0eqRzPkYnUbbYKl7FCnMd5+6yv5Vjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 182A067373; Tue, 13 Jan 2026 17:11:06 +0100 (CET)
Date: Tue, 13 Jan 2026 17:11:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/11] xfs: convey filesystem unmount events to the
 health monitor
Message-ID: <20260113161105.GC4208@lst.de>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs> <176826412793.3493441.11061369088553154286.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176826412793.3493441.11061369088553154286.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	event = kzalloc(sizeof(struct xfs_healthmon_event), GFP_NOFS);
> +	mutex_lock(&hm->lock);
> +
> +	trace_xfs_healthmon_report_unmount(hm);
> +
> +	if (event) {
> +		/*
> +		 * Insert the unmount notification at the start of the event
> +		 * queue so that userspace knows the filesystem went away as
> +		 * soon as possible.  There's nothing actionable for userspace
> +		 * after an unmount.
> +		 */
> +		event->type = XFS_HEALTHMON_UNMOUNT;
> +		event->domain = XFS_HEALTHMON_MOUNT;
> +
> +		__xfs_healthmon_insert(hm, event);

The allocation (and locking) could move into __xfs_healthmon_insert
sharing this code with xfs_ioc_health_monitor().  That means the wake_up
would not be covered by the lock, but I can't see how that would need
it.

> +	} else {
> +		/*
> +		 * Wake up the reader directly in case we didn't have enough
> +		 * memory to queue the unmount event.  The filesystem is about
> +		 * to go away so we don't care about reporting previously lost
> +		 * events.
> +		 */
> +		wake_up(&hm->wait);
> +	}

And then even after reading this many times I'm still not understanding
it.  Yes, this wakes up the reader direct, but why is waking it up
without an even ok?  And if it is ok, why do we even bother with the
unmount even?  If OTOH the unmount event is actually important, should
we preallocate the event?  (and render my above suggestion impractical).


