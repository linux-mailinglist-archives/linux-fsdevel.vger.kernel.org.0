Return-Path: <linux-fsdevel+bounces-36038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4AA9DB1F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 04:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5F816731A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 03:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2954884A5E;
	Thu, 28 Nov 2024 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QFqkrrqv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52B2CAB;
	Thu, 28 Nov 2024 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732764835; cv=none; b=Xxhg9CGON9rEHUw2b0DsPXLLF+T5jv79kAYcahJdQzV5xf4wC6poPa8oCf5nxS5Oir3ivitSuw3Am9YF4DmonYuphjdUw7TcdUVcKwwnhMN3UgF5dqqVeC9RNvDU9oyfAPlXC/vzGkx2kwv4wwacVP+v3SyWqDG0CS/ZI80ZBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732764835; c=relaxed/simple;
	bh=dvbIFmLuqxy4v7rEGoU4I+r+KUMkEgIFQflgiBhS1aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnkwuHQNmUFXaWIfYN/MXCcr430Zy1J7ZO6qKcgcU0rMRMqDaUmJ0jhR4VfEwjwv3ciVMvbIkJQOltwsROMsOfYZNGcMR6GkKyUGfD7JMgd6Eg//ERC59xPba8avd2ANlGvErJLlGSn2m4U7p5N3yTi50NvIQptKLtuWd8QTsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QFqkrrqv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dvbIFmLuqxy4v7rEGoU4I+r+KUMkEgIFQflgiBhS1aE=; b=QFqkrrqvp/sEjh7cTW7atHCRxE
	vNm8sixG8c/y86eCL6dwNBCbnQWKioR6hDVm0bPWMNv/ipW60jU+w6oBVfg18Kvk7T3u9Cb8+BrUa
	191zwAJdijD+bvOrRv+BZuQ7EM8gdTRs2ijP0wvFA6Bgq6QFv0u5SZOfYHKpXiVCcdjzjTQZGIMQh
	muYFmXzBV9BLZU7e7sZpNTHwQb1NUF481gQ7zae+DVXTfFGiFCh16fdo5xJMyfzPhkupDvSLoiX8c
	JcDUEaeSXNCNygSj2FbW8ppM6/UCt+c3ItbwXCbVOhcb46N68//goqaGxxNxrFp36j/8FT2pFw0n3
	cUt0PYGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGVHr-0000000Ed3K-4B0A;
	Thu, 28 Nov 2024 03:33:51 +0000
Date: Wed, 27 Nov 2024 19:33:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Long Li <leo.lilong@huawei.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z0fknwDTlm55XeTg@infradead.org>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127063503.2200005-1-leo.lilong@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I agree with Darrick that the graphic comment would be nice to keep,
but otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


