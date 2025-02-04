Return-Path: <linux-fsdevel+bounces-40765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD35EA273DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA1161D98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B92153D9;
	Tue,  4 Feb 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pz1tAwAo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5420F082;
	Tue,  4 Feb 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677142; cv=none; b=NRimx7IkMmQn7y4JspLM/91ZeDADu82/326pupAWJeU4falYihUMMNG0rvlnBt2PPx4lvlQqTuOoMbCBrEVtFsVUZKVb1YUcgI2ygtUfg77/Web0ZOl1OKpdclY1OTlLUgIM1ykgcpJrgrqgJrItl3e4AqAuC54TBzxQOGPb6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677142; c=relaxed/simple;
	bh=+u3PJ3n4vtianVg++VLIdp4pPq/B3pd5HBYoE34jXe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiTsQT9homsVuPUvQBKJ0mpbbrKZ4ZN+tRWENioFAul49BJwWifqmBD0pJ+zTIU3+7pHZSD2sLjm6vvI3KMUEPDUiTZvo82suWet9+WTM+fC5uVjW9keUTvPYklZsjd/vMkQgPYkc7Yf+rosqH00XQeYb5Menm6mhvlIdYfkULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pz1tAwAo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2+2zrRchWJ6H6lBKOLtgMf6PPiecKPnQft+8NfpjXcw=; b=pz1tAwAo5rlVsgwWwji+6qlvH7
	VWGv8KCbJt4agxxKt9R8vQjFh5JtpeTrt+KK86Rnpss589bGKxEMBWQWSO4JbXTTiN1yvVelW/a+y
	kh6uYpA76YrJ0r9YJvUOfV1ByUjbktqgpRbbT2FPsiX0a9WllDWwkLVRLwebBc/NduaBSqXivQ/fq
	lH55PCPndG9KsfOmAq8w8dXyK2Ah7MoWAZeUVnnlazTOUxbwORMG9c1z1efkYd16jaKWHW9T3mUFn
	PGIivwpN1vRrQD3sEsfUxjchiiABXiO7RosV/2FEku18JxwN041HwC89+gjBAJw/txONXqdAXQTNz
	rzr0GNbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfJLg-00000000acS-1VRR;
	Tue, 04 Feb 2025 13:52:20 +0000
Date: Tue, 4 Feb 2025 05:52:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 06/10] iomap: export iomap_iter_advance() and return
 remaining length
Message-ID: <Z6IblMMbjCONHPDj@infradead.org>
References: <20250204133044.80551-1-bfoster@redhat.com>
 <20250204133044.80551-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204133044.80551-7-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 04, 2025 at 08:30:40AM -0500, Brian Foster wrote:
> As a final step for generic iter advance, export the helper and
> update it to return the remaining length of the current iteration
> after the advance. This will usually be 0 in the iomap_iter() case,
> but will be useful for the various operations that iterate on their
> own and will be updated to advance as they progress.

Normally we use export for adding EXPORT_SYMBOL*, so the subject
confused me a bit.  The patch itself looks good, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>


