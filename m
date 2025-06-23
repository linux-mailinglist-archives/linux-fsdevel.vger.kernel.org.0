Return-Path: <linux-fsdevel+bounces-52475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB1DAE34CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 07:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A859B1891933
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 05:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B61CCEE0;
	Mon, 23 Jun 2025 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WhzzCamn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B17262C;
	Mon, 23 Jun 2025 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750656779; cv=none; b=R5YlsOYPEvyOgttmazFIWm/dCsiT/hppcUSff7d2sDW6SOlxGIs4ihEOtvBKKB60YagyDrcg3ufIf+VBIYbTX0GQyWiNcVx7L/vDZMBoDHcwsn1Dhov5lyYV3Oi+MhJVoERBdoqtn5bLX7wT1hHJZ4yceMWYPx0eAZqKbbCBjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750656779; c=relaxed/simple;
	bh=wn6hU4uBLVXiKUn0aPPSrorYe7DaQl25K3Tr55cujBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFAwoybQUO013gGUxSC0+sji+BO/QeesNNbJb/7k31rBHvxW3YVByughmj+FxD7k/dxqf6h8ooEnzCBPAOIhQMaCfPGNSC0vaUFYrE4g/0bwS62HOCFCUKCu3+POPMURah0ASvlq2kFyK2CDND+cXjwTBjb4WUulKqLKxjmVmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WhzzCamn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ipEsyYyk71k2C4j1LNOEHkyKYSiaoyutZyoqccIJItY=; b=WhzzCamnfQVlzTExnovnOi1iaK
	igUte6PEQMjPQxzd/6ESeKng+Fy6g3VOkYFYHJ6pG6nqLEy1U800RqWaZTwDPAJK/wBNS9Bq46KDA
	LsDyjAPQ1/RjW5HrZde+pMp2sjTwah3eN+D+RnPz4M4dyArXZVoiGwGCaz0/uiji8dKRhYfP+kxSf
	z9YrB9gBkl7m9/f2y7fjCRYOjzD8WTseQHzHwoLDSytNbux5fAgeWotvLVVR/OY1shLD9Iv9lpM18
	+ddDN4Tpu0NbUel24ydM0308x4Jd1AQjJrwwiwiXk7bBWFTUlRLzng66b4dNEc9Pa3omG6CkWe/DX
	02NRoogg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZnb-00000001cyp-0xeg;
	Mon, 23 Jun 2025 05:32:55 +0000
Date: Sun, 22 Jun 2025 22:32:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v4 4/4] fs: add ioctl to query metadata and
 protection info capabilities
Message-ID: <aFjnBxZ8dAehH0Xr@infradead.org>
References: <20250618055153.48823-1-anuj20.g@samsung.com>
 <CGME20250618055220epcas5p3e806eb6636542bb344c1a08cb9d9fd0f@epcas5p3.samsung.com>
 <20250618055153.48823-5-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618055153.48823-5-anuj20.g@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 18, 2025 at 11:21:53AM +0530, Anuj Gupta wrote:
> +/*
> + * struct logical_block_metadata_cap - Logical block metadata capability

No real need to duplicate the struct name here.

> + * If the device does not support metadata, all the fields will be zero.
> + * Applications must check lbmd_flags to determine whether metadata is supported or not.

Overly long line.

> + */
> +struct logical_block_metadata_cap {
> +	/* Bitmask of logical block metadata capability flags */
> +	__u32	lbmd_flags;
> +	/* The amount of data described by each unit of logical block metadata */

Loit sof overly long lines, please reformat these as block comments.

> +	__u16	lbmd_interval;
> +	/* Size in bytes of the logical block metadata associated with each interval */
> +	__u8	lbmd_size;
> +	/* Size in bytes of the opaque block tag associated with each interval */
> +	__u8	lbmd_opaque_size;



> +	/* Offset in bytes of the opaque block tag within the logical block metadata */
>
> +	__u8	lbmd_opaque_offset;
> +	/* Size in bytes of the T10 PI tuple associated with each interval */
> +	__u8	lbmd_pi_size;
> +	/* Offset in bytes of T10 PI tuple within the logical block metadata */
> +	__u8	lbmd_pi_offset;
> +	/* T10 PI guard tag type */
> +	__u8	lbmd_guard_tag_type;
> +	/* Size in bytes of the T10 PI application tag */
> +	__u8	lbmd_app_tag_size;
> +	/* Size in bytes of the T10 PI reference tag */
> +	__u8	lbmd_ref_tag_size;
> +	/* Size in bytes of the T10 PI storage tag */
> +	__u8	lbmd_storage_tag_size;
> +};

This leaves a byte of padding at the end, leaving to issues with
compiler alignments and potentially leaking uninitialized stack data.


