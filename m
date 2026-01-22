Return-Path: <linux-fsdevel+bounces-74978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI+oFPm9cWkmLwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 07:04:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F08EC6228F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 07:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F278429B36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 06:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A81338911;
	Thu, 22 Jan 2026 06:03:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D834405D;
	Thu, 22 Jan 2026 06:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061809; cv=none; b=i1CKrk/fYdRPgT169dzfrrMUKsFQMzfOGdgiG3QeebTQo0KdbKGqCuiySC3YfbJbap0EG/3d4nnYNObohA8ACo0JGg6M+h7Utd4JBisFWYR1pqojTIu1v3+HZqIf/xs8iLRrc6ytH6+FUavp3U2L7XtA/zI+guIX4CalxKU+15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061809; c=relaxed/simple;
	bh=+yjQYWa7iJyv4X6MBny1qgJzOqihi99a5v9S+vI4p+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZkxY6Vl9qs/8DYFY63yBW7/u3jV9aMdSfmId9MentTTLJ/EkLi9HKoSVKFcfUv7og/VzPwN6VbGuKFhjS1QUJNBCKxRcPb8DTbGMMRs8+5iCQX7pZ6xRuw8Egu48XFGFBNHIzlJQa/oHPcMI0QMsv93JSTBCLk/uIsAVa72uaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EEADB227AA8; Thu, 22 Jan 2026 07:03:19 +0100 (CET)
Date: Thu, 22 Jan 2026 07:03:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 14/15] iomap: support T10 protection information
Message-ID: <20260122060319.GC24006@lst.de>
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-15-hch@lst.de> <20260122005936.GR5945@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122005936.GR5945@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-74978-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: F08EC6228F
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 04:59:36PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 21, 2026 at 07:43:22AM +0100, Christoph Hellwig wrote:
> > Add support for generating / verifying protection information in iomap.
> > This is done by hooking into the bio submission and then using the
> > generic PI helpers.  Compared to just using the block layer auto PI
> > this extends the protection envelope and also prepares for eventually
> > passing through PI from userspace at least for direct I/O.
> > 
> > To generate or verify PI, the file system needs to set the
> > IOMAP_F_INTEGRITY flag on the iomap for the request, and ensure the
> > ioends are used for all integrity I/O.  Additionally the file system
> > should defer read I/O completions to user context so that the guard
> 
>   must ?

Well, the copy isn't actually blocking.  So a small copy might actually
work from hardirq context, but you're not going to make friends with
anyone caring about latency.  I guess that means I should upgrade this
to a "must" :)

> >  {
> >  	struct iomap_ioend *ioend = wpc->wb_ctx;
> >  
> > +	if (ioend->io_bio.bi_iter.bi_size >
> > +	    iomap_max_bio_size(&wpc->iomap) - map_len)
> > +		return false;
> >  	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
> >  		return false;
> >  	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> 
> Unrelated question: should iomap_can_add_to_ioend return false if it did
> an IOMAP_F_ANON_WRITE and the bdevs aren't the same, even if the sectors
> match?  Currently not a problem for XFS, but some day we might want to
> have a file that maps to zones on different devices.

For IOMAP_F_ANON_WRITE the bdev doesn't really matter at this level,
as it applies the actual mapping is done below.  So the bdev is really
just a placeholder here.


