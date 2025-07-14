Return-Path: <linux-fsdevel+bounces-54849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75113B03FC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EFE1A660E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0AB253358;
	Mon, 14 Jul 2025 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IEBh86Bz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F024BBEE;
	Mon, 14 Jul 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499252; cv=none; b=WV3sgYSHVe7mxwD9++w3Aj12L5ZvtybD4deCyt/oVGF59K13BpDoFj3Z7Dgbt/+//y6x/I2S+aeNxRSCu37ls/ug9RbJUHQTCMV2yktOp4pQ4GkFjBjk54qxv+YPkr/L0fcjmB0PWg7t1DqV2cYVtLv2v2kWSLYifjqTXit7+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499252; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg9fgxEQmGDaGeiT7Oa3ZuuZyNaKiGjCkHsvVHlLZl+MUB1Yotx6dXJMtcT3IWTU70R6Ggb728G33jFSVN43h9ksy1sNv/0Sg8W/jV114sSG/TBVLqv/q79QXqLOJV7jrBdvIOQwshv2vPlRagqs/mJtVWdWGbx12Pg1fio8g+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IEBh86Bz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=IEBh86Bz6zUOHFT8ThY7xWgYx+
	0Kvo05wKZvh/eIUy80Z4L4zzJrVcE+dlFnuovQUb+4nG1oHksLkOAQWsDJqvb7EgHjbvzb0F5fBJU
	0p3PUOvIksgPmfImKb38Qrz3ysmjcosPpUroY8ji4lFot9v9YhZqOQiLnhqeXr3jmTh7Zq2IGBUUo
	rsSWVS0RVppAE/LXz6UElSr6IBxTUqf6G7mO60O3kRXFi9bmJdF1tVydaMzluXwwTjr7Mq27IQRqt
	LTTxOOF+VtuZtXO8B1fum2JzK9G+kqu022kLQ9iZlG9hfoSQBvNJzPmwta8umbE99zr6EIxnifKGM
	hRxCSsug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJ6w-00000002Ggu-296J;
	Mon, 14 Jul 2025 13:20:50 +0000
Date: Mon, 14 Jul 2025 06:20:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org
Subject: Re: [PATCH v2 3/7] iomap: optional zero range dirty folio processing
Message-ID: <aHUEMiB93OnG36Wb@infradead.org>
References: <20250714132059.288129-1-bfoster@redhat.com>
 <20250714132059.288129-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714132059.288129-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


