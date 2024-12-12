Return-Path: <linux-fsdevel+bounces-37125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684399EDE9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 05:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E572165CAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 04:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A516F84F;
	Thu, 12 Dec 2024 04:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A0XU1H+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6B195;
	Thu, 12 Dec 2024 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978944; cv=none; b=LEjbKR09HPirqNymPuJaA3naZh2iKvZzrdYx3RmjWxhL8GKmaIG0PrRHq6CTmfMdicSI2aoY6J/wlTbH9QOIOR5cyFPLgfa7e8hykfedBZswswbrs70Y8xjG2GeZ3j/TrrZv09id3i3sh6Pc65tUALxbtle5XLcJGLzXntKxFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978944; c=relaxed/simple;
	bh=/mGFOstPW/8O12NZTAry1P1DtwGW00o6ENEllI05cB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+CyaoVP6gQwIkqoEGcrPkwkXnDFa0ucdj0dHJWMqWflJqyZErUK6G/cCNY9ripBzdF63raykgGI8a8zng0tNoy6q0Olrbyg9snp4IiU42md0ceRpYBGwq15BA0bYNctJQ3qf+TsGpuJvsoRCTpNaUFexXY7qcfcTPXGVL5OXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A0XU1H+j; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UDfUCvGJZUh5a5QRBeL0Xq8pTitiUzpBZKT6xPZM7Qs=; b=A0XU1H+jpSMbY0mLRmY3PfHalf
	Au1ZiEEr5gGIKCN4sDxJLj6u+8norkRUWPJ4acUvudSW9qfQ5PxJdXHDo5P60NXOZEof+9tskgARD
	2IafdwxtFh+4meLv0AiZCsjT5DiY4i3deelB8rkaK5lUcEocPaASsnFD++j5aA85hsiXybGsKwxin
	bFNyWIkKB+U8WT63DkXNbMcJN564nXvVhDkXLN9KtRNf9yVDT3rF3dzZujTFpDpiu/YPefb5zhP8d
	o9PK0k+Hvt07oBlO20pWWIy9EAC0evp2bqtYdB3v4p3B0GmzDC/Iwj+Obsx4Kgm+EzOQMxmyVcIXJ
	/YowukzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLb8G-0000000Gv0w-1FAl;
	Thu, 12 Dec 2024 04:49:00 +0000
Date: Wed, 11 Dec 2024 20:49:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	caiqingfu <baicaiaichibaicai@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <Z1prPME6G1OeEO4I@infradead.org>
References: <20241212035826.GH2091455@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212035826.GH2091455@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 12, 2024 at 12:58:26PM +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> We've got two reports [1] [2] (could be the same person) which
> suggest that ext4 may change page content while the page is under
> write().  The particular problem here the case when ext4 is on
> the zram device.  zram compresses every page written to it, so if
> the page content can be modified concurrently with zram's compression
> then we can't really use zram with ext4.

This smells like ext4 doesn't respect BDI_CAP_STABLE_WRITES somewhere.


