Return-Path: <linux-fsdevel+bounces-60933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FF4B5305B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C943565F6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B443191BF;
	Thu, 11 Sep 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="03hldyOf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34FC3126D8;
	Thu, 11 Sep 2025 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589985; cv=none; b=i288IZ8MSnv5+f9pz8MzavnxPj6CkCLVIpjLuEM9eiUY8H9TOnWBd/niF7Qx2VMCJmXPa2VXTJFvacKu0yPv/sRLN/Y2LmXbDOclFqBg/fpHy7PhodIlcAmxg7cgC922nj5iKxmYPV1RZkrHUWcNR0EUankMKVQwgjK+xDiJ+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589985; c=relaxed/simple;
	bh=kyoHfJv60MgSqNk04GS7WfHja/+6HA97+PJVBuaOH2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnplrY6bWnxPtkFwn9ZGhu4QYSMztUrst0CenEDTOCFv5Y2d/1apjkKEH2RIXN1Pl1ORMIeOyFSiwno5zMcNFdfOHVQtW50uQyVYvpn2wNedRPN9QCbfly4W1wl8leQSk++lXDzQGlv5QWpOmQ+w2CpXnoQZhNfPRDG8Lkzwlqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=03hldyOf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R3I2U2ZPXeYWsTjQsRQwT9QFt6JCj85R8freTEb2xdk=; b=03hldyOfqwTX5tGVw+UNG4O55I
	eLU1dvx3u+B7LazpSakaQOHnVCbneaxPSovOJiiJ9czUkntDb2xmzJnjsR+tTURxNoiVbP8EtpHCN
	2RKeAMH/18w0vX7nw72z22pNFltM1GvOuY9t+vKGOwIyZPZ3MJpI8tiMmodyd3GpMkNp6IxZeWXa3
	Lhd98Hj/8VNp0TSELcPV5OB035zjeLCQDBLYunaQDB/hgKNbxmef2Z4UhQwrxJRg3qgdfZEU0vxDb
	UScB/2fO1f0I4v1wO9i3lQgnf+/dzPdYB+5Zf8o3yTVKNfvHu+Ryy9SSzK5Pd5Q91t13MVvnbchUq
	Rg6Aq4UQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfRT-00000002fOG-1wmq;
	Thu, 11 Sep 2025 11:26:19 +0000
Date: Thu, 11 Sep 2025 04:26:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 11/16] iomap: add caller-provided callbacks for read
 and readahead
Message-ID: <aMKx23I3oh5fN-F8@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-12-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-12-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 08, 2025 at 11:51:17AM -0700, Joanne Koong wrote:
> +  - ``read_folio_range``: Called to read in the range (read can be done
> +    synchronously or asynchronously). This must be provided by the caller.

As far as I can tell, the interface is always based on an asynchronous
operation, but doesn't preclude completing it right away.  So the above
is a little misleading.

> +	struct iomap_read_folio_ctx ctx = {
> +		.ops = &iomap_read_bios_ops,
> +		.cur_folio = folio,
> +	};
>
> +	return iomap_read_folio(&blkdev_iomap_ops, &ctx);

> +	struct iomap_read_folio_ctx ctx = {
> +		.ops = &iomap_read_bios_ops,
> +		.rac = rac,
> +	};
> +
> +	iomap_readahead(&blkdev_iomap_ops, &ctx);

Can you add iomap_bio_read_folio and iomap_bio_readahead inline helpers
to reduce this boilerplate code duplicated in various file systems?

> -static void iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
> +static int iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
>  {
>  	struct bio *bio = ctx->private;
>  
>  	if (bio)
>  		submit_bio(bio);
> +
> +	return 0;

Submission interfaces that can return errors both synchronously and
asynchronously are extremely error probe. I'd be much happier if this
interface could not return errors.

> +const struct iomap_read_ops iomap_read_bios_ops = {
> +	.read_folio_range = iomap_read_folio_range_bio_async,
> +	.read_submit = iomap_submit_read_bio,
> +};

Please use tabs to align struct initializers before the '='.


