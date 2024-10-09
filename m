Return-Path: <linux-fsdevel+bounces-31419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AEE9960E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 09:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E85B1C239A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C1817E472;
	Wed,  9 Oct 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hVZ9FAdQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D215C144;
	Wed,  9 Oct 2024 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459058; cv=none; b=Z8eHaY7eGvyy4dUAjo+R0ng1zopl/d9TJk7StK1VevC5kxCiMUGYo7+KwGnc6CO6LXnQw+zII1d73h94hXpm4N6eaCk2FDPgACHc97zN3XfPzM1Z8BBxeiUrJuY8M1yliInfTdhIIBmbyvSpPqHkLVXNO3oyx9BGRBp4ppHwLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459058; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFHU6WGS3XslZdyaTOSwpK8Z17B3OLi+0g+GiVccs4vqWDQZse5Uee7lMC1dO69QVvrLl+hXWnyMD2IERuBYZ3x03zAYTypghwQ55+UhLqovi5jXw3DPtQbunwKkvQUnpBks7wUeSlxrEP/BcE0vgDQ8L9V9pCi1/LGq66WYb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hVZ9FAdQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hVZ9FAdQQRkUduD36fYPkntV8C
	JGCuDWzI82F5ewjyrpq7AbIYO/WKo3qVktuNb1G765tGITWBhthkUnFLFbYaD85y3kb7igIaFd6O1
	CNl/KiAjKdWTvd5l4jsJQF+UtSkI6P6SDKgAd5TFS+Q3BZd+1jFO09HsDCGT0R98rdoEI/nHgtgXY
	aMNnNLOzMj4u6WyWvfq7pFV7dKzCH7QR2Ln4XwCtLpkE4JCGRf7pJhcMT/dWk9wa0JqT5HcMWFlaR
	c/LUKr1YINz7C9l0B5nEmxWhjnca4rQawNZO0W8GU8yJn3Bvr4fTIny/ojXaoiqCFXPA+jaNUlaJB
	AA/sg2OA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syR9p-00000008F3I-2TA3;
	Wed, 09 Oct 2024 07:30:53 +0000
Date: Wed, 9 Oct 2024 00:30:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Message-ID: <ZwYxLXumaU-CYzj8@infradead.org>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


