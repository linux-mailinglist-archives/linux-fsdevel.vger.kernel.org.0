Return-Path: <linux-fsdevel+bounces-51221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F78AD49BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 05:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BAB17BAB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 03:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20520766E;
	Wed, 11 Jun 2025 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VMEpyNS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9613212A;
	Wed, 11 Jun 2025 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613985; cv=none; b=FvjbxulZmktmNuZDwbfm1Icn3YlaBY8tuwpUNjFIHg+5wAYa5/trP3AtuSOVp9Dmpef73P1k6X6fohfY22yDijMJ1f3VXcthR91VpXLjFZ16LGTz21cjs4LxmWYASfZdSTWozsxZ6P9O7xoSwddUQmtG/rDBxLyb0xVzqFMUU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613985; c=relaxed/simple;
	bh=x482A21mUGaRDJZLmRuBV6YR46jauSMxp6TwTJk7A1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+9lcPHw6tzXP8zFNhOxqDS+7llQXSVcwuMkqHAqXbuZzEbwv8rvTEKvCbRvZmOsi/BUaKFGKJcusrOIBrkaRGMnTTH499AFTTkGxM2IuUWJ4KYkskons202bLuQWLSUysv7gu1XdsGxFwxfdV83BeazkRPVkTvFBTaKZe4JdJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VMEpyNS4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=axgow8YkojsJju5NzZ4BiJzaKv1RbU4ONmSqO03BkZk=; b=VMEpyNS4E5oUAxE6soKfdLbaZe
	pDBmCFazOexCyUPIoOPWVXj3YLXbS5uP+jbLXozx4e+TzDWUupdj3y6eSbnjRdWiBmoSOdwS0mjiC
	fRm4JQvPtbHD7CQ+in5PO4BZIHxWaAuPsGuokC98EqAJzkyJ9/YWfTzqOJQqayWM5zKAX34+D1OKr
	u+azhwdWNF6MRw07Iq0taKpZsIcB7ZmJN34LZb5YIFv9eAWpFfHuZh/99t8ATPaQicMgynXakGtej
	VYetJi1UpaHdGpYHOufgStMeTZvVmJiaiJSBVFWbjf17B4OU+zR5eZ2+3aCVbCbeRAxAguhvWSDGj
	cYlRX9aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCWK-00000008mMT-1b2X;
	Wed, 11 Jun 2025 03:53:00 +0000
Date: Tue, 10 Jun 2025 20:53:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v3 2/2] fs: add ioctl to query metadata and
 protection info capabilities
Message-ID: <aEj9nNEz7veOL7wL@infradead.org>
References: <20250610132254.6152-1-anuj20.g@samsung.com>
 <CGME20250610132317epcas5p442ce20c039224fb691ab0ba03fcb21e7@epcas5p4.samsung.com>
 <20250610132254.6152-3-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610132254.6152-3-anuj20.g@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 06:52:54PM +0530, Anuj Gupta wrote:
> +int blk_get_meta_cap(struct block_device *bdev,
> +		     struct logical_block_metadata_cap __user *argp)
> +{
> +	struct blk_integrity *bi = blk_get_integrity(bdev->bd_disk);
> +	struct logical_block_metadata_cap meta_cap = {};
> +
> +	if (!bi)
> +		goto out;

So is returning an all zeroed structure really the expected interface?
It feels kinda unusual, but if we want to go with that for extensibility
it should probably frow a comment and some language in the man page to
explain what fields to check for support.

> +	if (bi->csum_type == BLK_INTEGRITY_CSUM_NONE) {
> +		/* treat entire tuple as opaque block tag */
> +		meta_cap.lbmd_opaque_size = bi->tuple_size;
> +		goto out;

Purely cosmetic, but the mix of this and the later switch looks a
bit odd.  Instead I'd..

> +	}
> +	meta_cap.lbmd_pi_size = bi->pi_size;
> +	meta_cap.lbmd_pi_offset = bi->pi_offset;
> +	meta_cap.lbmd_opaque_size = bi->tuple_size - bi->pi_size;
> +	if (meta_cap.lbmd_opaque_size && !bi->pi_offset)
> +		meta_cap.lbmd_opaque_offset = bi->pi_size;
> +
> +	meta_cap.lbmd_guard_tag_type = bi->csum_type;

... keep this in the common branch.  All the assignment should do
the right thing even for the non-PI metadata case even if they
do a little extra work.

> +	meta_cap.lbmd_app_tag_size = 2;

And then just guard this with:

	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE)
		meta_cap.lbmd_app_tag_size = 2;

> +
> +/*
> + * struct logical_block_metadata_cap - Logical block metadata
> + * @lbmd_flags:			Bitmask of logical block metadata capability flags
> + * @lbmd_interval:		The amount of data described by each unit of logical block metadata
> + * @lbmd_size:			Size in bytes of the logical block metadata associated with each interval
> + * @lbmd_opaque_size:		Size in bytes of the opaque block tag associated with each interval
> + * @lbmd_opaque_offset:		Offset in bytes of the opaque block tag within the logical block metadata
> + * @lbmd_pi_size:		Size in bytes of the T10 PI tuple associated with each interval
> + * @lbmd_pi_offset:		Offset in bytes of T10 PI tuple within the logical block metadata
> + * @lbmd_pi_guard_tag_type:	T10 PI guard tag type
> + * @lbmd_pi_app_tag_size:	Size in bytes of the T10 PI application tag
> + * @lbmd_pi_ref_tag_size:	Size in bytes of the T10 PI reference tag
> + * @lbmd_pi_storage_tag_size:	Size in bytes of the T10 PI storage tag
> + * @lbmd_rsvd:			Reserved for future use

I find this style of comment really hard to read due to the long
lines vs just comments next to the fields.  But it's become
fashionable lately, so..


