Return-Path: <linux-fsdevel+bounces-76544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNTSE2SJhWkWDQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:25:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E337FA9DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AB603002F41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E2B3019B0;
	Fri,  6 Feb 2026 06:25:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B792E11D2;
	Fri,  6 Feb 2026 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359131; cv=none; b=IQvzBqCPvwpbsN7vgHkRc2zNQAceLkRxTTx2XT0nxXoKQEOaMpObNUHM4H/7sdhTw3Qo0mVT+oSRB7AerJQ4SYG9PkqzoQzyEpeA0hD8hub0wfJh6osADsDKLLZhaeirccdy1QwIMSgimFuPKy0tOrPuMdZFZ7du0h9ioazhmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359131; c=relaxed/simple;
	bh=ogYQLZ7iWfEGF07dtSs2T9QN0dSN90jwWkW/AjJXN3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdIfJIPembane2oBI7at7btGGjEUyE0uGNMEPNM+0K3pnKoZhibpKiDhvTCIVXW738oNVy+jUcjHJPaITODJcgQXZANluv7dcfIh+ZsJhyCodb8CasDxH4erJ5VfXHAbq7UWzuwrlvzAJ6l34KmPKYYIIQuwVgLEbdRKIEKIV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8033468D0F; Fri,  6 Feb 2026 07:25:27 +0100 (CET)
Date: Fri, 6 Feb 2026 07:25:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Brian Foster <bfoster@redhat.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, willy@infradead.org,
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de,
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
	cem@kernel.org, wangyufei@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v3 0/6] AG aware parallel writeback for XFS
Message-ID: <20260206062527.GA25841@lst.de>
References: <CGME20260116101236epcas5p12ba3de776976f4ea6666e16a33ab6ec4@epcas5p1.samsung.com> <20260116100818.7576-1-kundan.kumar@samsung.com> <aXEvAD5Rf5QLp4Ma@bfoster> <ca048ecf-5aec-4a0d-8faf-ad9fcd310e21@samsung.com> <aXN3EtxKFXX8DEbl@bfoster> <e7413e3b-3fae-4aab-90a1-4a6695156b2e@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7413e3b-3fae-4aab-90a1-4a6695156b2e@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76544-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[redhat.com,zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E337FA9DC
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:58:25PM +0530, Kundan Kumar wrote:
> This series is intended to replace the earlier BDI-level approach for
> XFS, not to go alongside it. While BDI-level sharding is the more
> natural generic mechanism, we saw XFS regressions on some setups when
> inodes were affined to wb threads due to completion-side AG contention.
> 
> The goal here is to make concurrency an XFS policy decision by routing
> writeback using AG-aware folio tags, so we avoid inode-affinity
> hotspots and handle cases where a single inode spans multiple AGs on
> aged or fragmented filesystems.
> 
> If this approach does not hold up across workloads and devices, we can
> fall back to the generic BDI sharding model.

I fear we're deep down a rabbit hole solving the wrong problem here.
Traditionally block allocation, in XFS and in general, was about finding
the "best" location to avoid seeks.  With SSDs the seeks themselves are
kinda pointless, although large sequential write streams are still very
useful of course, as is avoiding both freespace and bmap fragmentation.
On the other hand avoiding contention from multiple writers is a good
thing.  (this is discounting the HDD case, where the industry is very
rapidly moving to zoned device, for which zoned XFS has a totally
different allocator)

With multi-threaded writeback this become important for writeback, but
even before this would be useful for direct and uncached I/O.

So I think the first thing I'd look into it to tune the allocator to
avoid that contention, by by spreading different allocation streams from
different core to different AGs, and relax the very sophisticated and
detailed placement done by the XFS allocator.

