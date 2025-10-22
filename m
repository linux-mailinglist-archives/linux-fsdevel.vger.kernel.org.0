Return-Path: <linux-fsdevel+bounces-65047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3071BFA009
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8FE84F6C6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458932D836D;
	Wed, 22 Oct 2025 04:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bVbTobea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE57230BEC
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108592; cv=none; b=rgyx/RNnuwHrebXvATS7OSRLeR1CxIVaUsQdUvK7R/NNB5IU6jNctpcXLk0DNWvgHo+5FmxN2RE7TUQcYV/rPbVoOCn2Rpixabgm3c7JaWVJq/R8FsNXxhekR+dNLGZcS9lt8WCFkcH28kL5dr/L4jISCALPAYRlCksXP5LCXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108592; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of97uxuptQcAjJODP9ZSHVUfNTQJqWqnR7jnyiLW+qHOstEax/nLGTe6pbHJC6zc8EI8RdyGj1r2vEzGYq/k1IXFLisOkYnX1xFEPJolpfMjTDXKSN8Z0GjoLsPc/aGqviDYhwFLWa4KgO0xr3PDIRaVl2T+ObyGqen555Ml3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bVbTobea; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=bVbTobeaKUnTFNmWOCYuZi8PN4
	+G0ttOJMcSxNrOqT2ngMFC4igpIhNeEflM+96ERoc2jYc92bM+PoLbDgrz8Q40O+F11clGVv55JK1
	4A/x9LA9myskpT16dMfoA3dtZr063SPG0WWROd2fPDIBemNHAowtej15nmA2/tAZcoaI/Rd66aI/U
	bzDODzN1yji0OEd1PMqPm734t+MY2T8X8aFx2j88kb4zFEuBv4Ki8GtNbMAbATcFxlza6+qokPC8Q
	3hZftUdwws66oEes6Q0lRVuKFXCb0uM3MCaWgXsV5JjqS203pQAqjrgQvso1Ja4SxlRFDOQF5kRZ/
	B2psJvKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBQnG-00000001TeM-0A3H;
	Wed, 22 Oct 2025 04:49:50 +0000
Date: Tue, 21 Oct 2025 21:49:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 3/8] iomap: optimize pending async writeback accounting
Message-ID: <aPhibrLaTWQ2m0x8@infradead.org>
References: <20251021164353.3854086-1-joannelkoong@gmail.com>
 <20251021164353.3854086-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021164353.3854086-4-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


