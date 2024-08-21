Return-Path: <linux-fsdevel+bounces-26446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB259594D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B481C222D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0E175D34;
	Wed, 21 Aug 2024 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pszP6qaA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DB170A30;
	Wed, 21 Aug 2024 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222360; cv=none; b=gJr4hWB7QCFbtrDGpoh+zB0Um+2uVtQ1twHftbXijzGSAVsoHHEZJ4yVBMlR1BRpKcbvwaAyh9WjZRMladvbejrpeL6g9JBRtoDaLlvayKKHWlD4X6AA2BDy0JWhe7kl24TY6d/ATqRhcwTp2rzKNJeYRhvFG/9NRJMovkG4hvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222360; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0k6dH9U6hp2H3kmCApKq3dhMdBNBmYv+paw2TdtJw325PK1jnsn2Q5Q2bhoQjIynpYjH9zZwCUVZAzQ7aSu0Nd8K/025luRBXwqsxhI171p3X9oCrDJdsVcW5hc4XnMAjYoXnEgZ4FxjbOVwOrkKyggUBPU/bubusYzc0XTeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pszP6qaA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=pszP6qaAzRBLgDguJQ9OwdSRPm
	Sg3lWuQ5LejXMq3wTJaC7OjpGBstaMJHveLi0bc3w1Kg74TVpgCcuZhll/58OeOs9gb4EFKJJTFTO
	QieP0TM8efehe/no8wtyP4VCZe24o8h5KA32ZCqQnDMSyKUH17g33LGyiOGT58rMwXSHEOytBnUIA
	fyFqELXHpoPNVh+9w3yTJ+791h2B0HsrurQ1DR4evyGqBELRGp8B3SuHXxhEeBVWmDvihOG3qs53D
	WtcbOl42CA+cJ5L9IEMps6dn7gTJBPY8PK0fdn2Ms+rjPO2O/OH6bZldsHU1Aku3nYrxcQR/a2KP7
	0nVLZWBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgf02-00000007kHx-2qlv;
	Wed, 21 Aug 2024 06:39:18 +0000
Date: Tue, 20 Aug 2024 23:39:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH fstests v2] generic/755: test that inode's ctime is
 updated on unlink
Message-ID: <ZsWLlnzcHQj1ih26@infradead.org>
References: <20240820-master-v2-1-41703dddcc32@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-master-v2-1-41703dddcc32@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


