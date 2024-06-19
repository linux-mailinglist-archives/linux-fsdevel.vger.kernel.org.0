Return-Path: <linux-fsdevel+bounces-21910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 782AF90E2F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 07:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7FEB22609
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 05:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491F36F2E8;
	Wed, 19 Jun 2024 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="peNqlYvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036051E495;
	Wed, 19 Jun 2024 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776681; cv=none; b=nfMBkXZmmjLfB7QsB5q5rz1yJEYTP45NQ45vrzalE1Muhe1awN/Inj/spE6rUM93wBi7OWvPoKv0aHcEjeGO2y809BJOKJqMBceUr6LmZY8N5T1ixrIA/7KFkiOc66L/mRAY981CIRdslB/f/URSoC6zkxel2FoF9wopm4frxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776681; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+HWEfClh6YxGr5UGTWbkfiqJZFMV6vt8UulYubpi8Ez/bMHxWyjWOGGKl3DI/GbLGlsI5B5SkIvCbj+7gc0iTGgctF04VrTK5nLcQkQw5kizPQbpbEo0nNy9oeA3clgKmRBVA9gOJ4yoYlCtEZVYfvT+mJFVc4qVUfWwWsH5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=peNqlYvs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=peNqlYvsod+RwO80lB6JUboU7T
	su99ktY00wFMRuB6X7k7tvmfU1+XG3RkI231ycmw/2l1POJKQTai5Ms01D/vPsP77752u+i4asN1/
	5gukYXrGtrhwF6+++pDQQDwhtgBT9PY+2Qo9fmCy4SwYrbz5UsI+L8jrKypLmeYmKVk1y/+LSHoSR
	igjSS13KV7Ez9xirgL2ZspRQM/u9aj0+Ng8VmN20pSXV2b2eFUB3zjW4aavhJ4o9hWNstaN0IkvKk
	o/oXS+Io5vO9+o2DxNVto6akAxUwcc11nl4v0ZHAXjVzJdCaMdodXKnyBCTMAU1KQDr6eu8vkTAtB
	ziu+r1nw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJoKT-0000000Ha1V-0N6Z;
	Wed, 19 Jun 2024 05:57:57 +0000
Date: Tue, 18 Jun 2024 22:57:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH -next v6 2/2] iomap: don't increase i_size in
 iomap_write_end()
Message-ID: <ZnJzZYPpVxEQ642k@infradead.org>
References: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
 <20240618142112.1315279-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618142112.1315279-3-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


