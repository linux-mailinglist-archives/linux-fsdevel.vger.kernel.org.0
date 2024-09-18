Return-Path: <linux-fsdevel+bounces-29623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C397B811
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 08:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58FC1C21E1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 06:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F221816BE01;
	Wed, 18 Sep 2024 06:43:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52F4405;
	Wed, 18 Sep 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726641785; cv=none; b=QoPLoIP2YznTTK41JIoj/a5GcP++szQLRwi5ZXbyOlLz1GmDGHgM0KnpDyuRw2GyZVd8J0n9tCgNwPL15dbCwjFO4x8L7iHezwLKlLPdIXYDQfWuuDPA0W78tQITUUFPe2doDdWx7Cyguem+xbkgEGqXcoicHiA9M5jeNdCmolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726641785; c=relaxed/simple;
	bh=MzVKV51d+VHpTFlhpQYHvPisBRGcKj1hHNlihG4moZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etqKXQBrPR36G91kKgAOcZbXJ7v88wUUbmX4sBPeIjNuM5XwH+EezXC4cm9vob+hs1h5+I7M91mHG6cAhk6l+i5/EUoQEIgbNSEEP8D8l9uEm9TevEKAoUR4WRJEJZYVjDMfvOdBzvw5f4Q+aPNotSAWE95bEq7AasYRXSFzuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0186F227A88; Wed, 18 Sep 2024 08:42:59 +0200 (CEST)
Date: Wed, 18 Sep 2024 08:42:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240918064258.GA32627@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com> <20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de> <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com> <20240913080659.GA30525@lst.de> <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com> <20240917062007.GA4170@lst.de> <b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> > If the device (or file system, which really needs to be in control
> > for actual files vs just block devices) does not support all 256
> > we need to reduce them to less than that.  The kernel can help with
> > that a bit if the streams have meanings (collapsing temperature levels
> > that are close), but not at all if they don't have meanings. 
> 
> Current patch (nvme) does what you mentioned above.
> Pasting the fragment that maps potentially large placement-hints to the 
> last valid placement-id.
> 
> +static inline void nvme_assign_placement_id(struct nvme_ns *ns,
> +					struct request *req,
> +					struct nvme_command *cmd)
> +{
> +	u8 h = umin(ns->head->nr_plids - 1,
> +				WRITE_PLACEMENT_HINT(req->write_hint));
> +
> +	cmd->rw.control |= cpu_to_le16(NVME_RW_DTYPE_DPLCMT);
> +	cmd->rw.dsmgmt |= cpu_to_le32(ns->head->plids[h] << 16);
> +}
> 
> But this was just an implementation choice (and not a failure avoidance 
> fallback).

And it completely fucks thing up as I said.  If I have an application
that wants to separate streams I need to know how many stream I
have available, and not fold all higher numbers into the last one
available.

