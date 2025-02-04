Return-Path: <linux-fsdevel+bounces-40762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6142CA273DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2911885821
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55294212B33;
	Tue,  4 Feb 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXaEyRIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8115E8634A;
	Tue,  4 Feb 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677066; cv=none; b=XGU/uXzmf3ObTXu2/ZuQKZ6cmXdd2SbrzeeKrQhBBgYaksMpNMN2AUFn1OI1kihKuv/YxuLS9hTfX/wfKCoRG+wlWR+5fUQVAQmYeURYyAYqbudpuhQc5YFySU2Y+40Ipk6UtrSkY4Wg2vkOXtgfZOxnJLqsL8amxFuTHlS/lMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677066; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqi7KxmJNJch3svyDapRi9vIr+eBJbhwcHpa+OH1sktLpaI5qEMoUyswNrxCpOKMKQxvjzzZ4V26YF38Q2FyHgC+H8t9UxNtU2R6pQWiEjDItgodJf4BtRQq3uefnxDtruFYrlcooR2A56GYvluBihIfTGXSHCseQOgYd+nUgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GXaEyRIp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GXaEyRIpf82MJQckTIwBPdCcRj
	XfVEj+6QVxfxksdZsq+pNz41gZzGgN49yeQDIZZIJrJoPdoktl7RQwblxWflYQVYIF5WIq79X/4Hs
	By+vNjS/VBa1Qq6GgPuN+jLPrMMBn5YED6BPRwn5AL9maeiU8VCXhOm2yKprBMfKj08/jNVZWkk/3
	rjdDF0zBU7cO7Y1E6nxIErkWswAYqqPY7/Nkf4Se5QyUCOflc9v19xfb3WUFGcHTnvETydVojllm9
	VFW5XEsLb3+wF+langpwRruQ2/j1UGco4tWrur66OUXFrzdNkiXmTv/BlfzECI7RlP38pUiw/gUyU
	Pm0PgE9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfJKS-00000000aNh-2tkT;
	Tue, 04 Feb 2025 13:51:04 +0000
Date: Tue, 4 Feb 2025 05:51:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 04/10] iomap: lift error code check out of
 iomap_iter_advance()
Message-ID: <Z6IbSHUtTAfiCdRA@infradead.org>
References: <20250204133044.80551-1-bfoster@redhat.com>
 <20250204133044.80551-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204133044.80551-5-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


