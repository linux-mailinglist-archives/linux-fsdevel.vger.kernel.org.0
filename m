Return-Path: <linux-fsdevel+bounces-43900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AE5A5F6F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 14:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A8619C17EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D6267F46;
	Thu, 13 Mar 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZ/pjeEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD437603F;
	Thu, 13 Mar 2025 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874049; cv=none; b=ptioNyC4VSYxUIy6UoLGoqIw8UC0k3Yx+y4bbKTDRCOGqkmM4mseRzMoD48mHzBcEWVV9kfpya7th7EMnfZRbzk4WJBNrK4EzuNiSY7QeV+CoVb4Hkfg19tCKCWcxvMExpLstjYHVjLi2FyDpGwVfWX8/yMDAudKtP/aQiEAa/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874049; c=relaxed/simple;
	bh=v+2fmTN6TZLW6xWVe2v3KEl06Nx4Y29MoHlb7YVFZmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZfkT79CLX8lQFCTvJK8jON+TSZ5QyBJ7ru7Zi7nslM5aR+/FXM6EATnwcE4tT+JRZ5yfDo5MQhwvXR6UlBYxHknMS2Di99G2eKAKSdwuu+xyZtntt/wo2uRQ3td0kxs64jikAK4eAbf7a3osU7bBYBUzFkX72rgkPaIVo6Oa5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TZ/pjeEc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jlEn5FEw96qYHJXfLUT6UZ62UFkbZhzk/i6BsYhdANg=; b=TZ/pjeEcZu1WWgQyJDdB6Fc8dY
	Mfv8WUXd6e5fx2W7ell8dXu0wcAMAjpZz0pgMdaTU9Hvdq5QuXvW7m6jbxIXHWQeoQoRIqFydFG9w
	+D6rARwGHBPoS8KevU2hcfg7861TU2CWWuRZX8oWLMKGQLoK256baHaCY4vMNsti/Y6aE/cFIb24A
	+q+S0rz4oG8ODud4/Yp1d2hoJpNLfNQVOORFRJd5dB7+RdxuVYFR/4O7V/NiVgz9S3Q/mVkoVGWCl
	k7AzK74OVi9Ob9TElnCBaaj6cNT2oeP984LfdRRV+OitKEM5VzcHDUn1WOQamNym30Sy5fFDU0Vi+
	nNP0v/Ig==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsj0Z-0000000GnY7-2s0h;
	Thu, 13 Mar 2025 13:53:59 +0000
Date: Thu, 13 Mar 2025 13:53:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/7] iomap: add bioset in iomap_read_folio_ops for
 filesystems to use own bioset
Message-ID: <Z9Ljd-AwJGnk7f2D@casper.infradead.org>
References: <20250203094322.1809766-1-hch@lst.de>
 <20250203094322.1809766-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203094322.1809766-4-hch@lst.de>

On Mon, Feb 03, 2025 at 10:43:07AM +0100, Christoph Hellwig wrote:
> Allocate the bio from the bioset provided in iomap_read_folio_ops.
> If no bioset is provided, fs_bio_set is used which is the standard
> bioset for filesystems.

It feels weird to have an 'ops' that contains a bioset rather than a
function pointer.  Is there a better name we could be using?  ctx seems
wrong because it's not a per-op struct.

> +++ b/include/linux/iomap.h
> @@ -311,6 +311,12 @@ struct iomap_read_folio_ops {
>  	 */
>  	void (*submit_io)(struct inode *inode, struct bio *bio,
>  			  loff_t file_offset);
> +
> +	/*
> +	 * Optional, allows filesystem to specify own bio_set, so new bio's
> +	 * can be allocated from the provided bio_set.
> +	 */
> +	struct bio_set *bio_set;
>  };

