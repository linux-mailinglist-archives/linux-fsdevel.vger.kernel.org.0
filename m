Return-Path: <linux-fsdevel+bounces-63345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C451CBB6211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 09:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F023B298D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 07:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFC622759C;
	Fri,  3 Oct 2025 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LSDwnsHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AC158DAC;
	Fri,  3 Oct 2025 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475089; cv=none; b=KpvL9jQ6PagPex9U5S9wUG9aA7M6qBrdeEpFRjtz5YfW/Ygxm9Wfbk5fx57kna/DOEulTraXj5YxbLhjUWKD016y7KlOwJe5zTbHE5cQqz9cf4yEkgpq9SWRSM5Fjxl6RshR+oCNI8//yxpGp1dZRbZqb5y9X3Gqgzd6cybIfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475089; c=relaxed/simple;
	bh=GZkKQIGbMfyDtdHTzYapoN8J+L30AvqjaDbotK8B1u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCyd47QSUbDI8NPjXC31tr9ERLOgtA10JQudbMEwEn+AtlWuv5dw9yfEYGtAkiD0NJclk9cl3U5Lfz4XJ+ZvR1VglS9dSVnT5XSIRJyMqCYqEl/XbuGlTCYs5LKHD5PzQsmPSf+qAdFDJsen3b3sa5r8ARkxshItd+RiHvw6Su8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LSDwnsHz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GZkKQIGbMfyDtdHTzYapoN8J+L30AvqjaDbotK8B1u8=; b=LSDwnsHzquwo2wRIxHKvIE5U/N
	o0z93nrkxCvc4152anSn0YJrvTPfC9vTvp6rcfCL83QsvAAu+lXz5nxv2YviilZ7FJ1Yiecpb6O4x
	bGMDiLLAMky7JY8ByQr0te5p78qXLGPrqtF/Z6qoGarqjcNHI0VVMaHB5h/Q9djXeEmWIxgULo09z
	hs1x4RlV4TNDRWHjhgQC3Z6fWFYs9W/E5RxWNzoV4SB3ZTvaWx0M5ANMkxZ/Pds6HG5XdYUFsBV9I
	VTxmoWaXMQHJPXhyhxIAC4GMTEe5Dd1zMMvT9gcdeD1emImv+QYbaf0KJmAkzNW6r+UgznIkoL2F3
	JKGgnRJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4ZqR-0000000Bmtc-3IT6;
	Fri, 03 Oct 2025 07:04:47 +0000
Date: Fri, 3 Oct 2025 00:04:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 3/6] loop: add lo_submit_rw_aio()
Message-ID: <aN91j8EwfdCC6rz5@infradead.org>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
 <20250928132927.3672537-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928132927.3672537-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Sep 28, 2025 at 09:29:22PM +0800, Ming Lei wrote:
> Add lo_submit_rw_aio() and refactor lo_rw_aio().

Same.


