Return-Path: <linux-fsdevel+bounces-58959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFFB337E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CC43B0076
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 07:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8137A2980A8;
	Mon, 25 Aug 2025 07:35:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C37293C42;
	Mon, 25 Aug 2025 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107354; cv=none; b=hbxHE+ZoSxHAl4S/N8YNlAYvjUUuF58Ir7c354vlN6GvPaxxcaNXPvlOgLV1w398tFgQ3YuFAQ0K99rvjUGgRE1FbEVM4Hp75VU7TF/ZSQstNBDfGk4HFSjljrMXDz3l9YgQCIa28sxU7xaw2+r/IDrSHI3fsl7Vyp9TUmw7++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107354; c=relaxed/simple;
	bh=SrlkANA7wsELpKXgPYjzLkrK2UslojFBxnBy9jodUYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYvCjUW2s8FklBnkWu7TWoRbTZ9V/80NJWDSULumHi2OGcM3EozARa6c3F3kBXpQ7awUoQBVQ4s5wKDQKDaeUtP4HqXN6PNbSpT1WQiQwhPM3RJUlAEG/5LHJPPfK0IotYvmHXxenrFWGbJfrv8ItMEO+/+RDMASkcTh5biPLWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E911368AA6; Mon, 25 Aug 2025 09:35:39 +0200 (CEST)
Date: Mon, 25 Aug 2025 09:35:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/8] block: check for valid bio while splitting
Message-ID: <20250825073539.GA20853@lst.de>
References: <20250819164922.640964-1-kbusch@meta.com> <20250819164922.640964-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819164922.640964-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 19, 2025 at 09:49:15AM -0700, Keith Busch wrote:
>  		/*
>  		 * If the queue doesn't support SG gaps and adding this
>  		 * offset would create a gap, disallow it.
> @@ -339,8 +343,16 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  	 * Individual bvecs might not be logical block aligned. Round down the
>  	 * split size so that each bio is properly block size aligned, even if
>  	 * we do not use the full hardware limits.
> +	 *
> +	 * Misuse may submit a bio that can't be split into a valid io. There
> +	 * may either be too many discontiguous vectors for the max segments
> +	 * limit, or contain virtual boundary gaps without having a valid block
> +	 * sized split. Catch that condition by checking for a zero byte
> +	 * result.
>  	 */
>  	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
> +	if (!bytes)

If this is just misuse it could be a WARN_ON_ONCE.  But I think we
can also trigger this when validating passthrough commands that need
to be built to hardware limits.  So maybe don't speak about misuse
here?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


