Return-Path: <linux-fsdevel+bounces-40197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E8A2040C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 06:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBC2165248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 05:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532A1ACEC6;
	Tue, 28 Jan 2025 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="flQVf1Ib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D113F43A;
	Tue, 28 Jan 2025 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738042527; cv=none; b=f89RaQwW5j+qGPOU2pjWCXhO/gGdhWS+g8PhJoiHuY06XmuUXGuOJN5s6hPICeWmsjeipAaujvfkRyecb/nsuw4Ml2LjOkHYxQ7YBPiOwDGuXbUu3+hU5PsdP17DFdGWJkGb2QQ5Ed7ifwfsC/VUL08Cp7tZjpUXpsgwMgAYQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738042527; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWZOLXboRwMw3wTZIAPc+cAxUWvIJq4X+tB8sBbzONFJo31/X+JBpLPTa48Vn1M9zg03ozbsOI7XEY5zoo8T5uoU8S4lyOr8rpxTXDh2u+LucnKhq/v4n8Sv0tC+I8w1c9riPgz72OBGLSF6hsUGrz7VzLskA+hFIUUWErZtpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=flQVf1Ib; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=flQVf1Ib1SSLvbzfdqC8LW3xBq
	uraFqlZC6euHwVBS5aaz0g8a+4Bt8xYA/YuXNHajxq7agQ05FFWedbRSQw7TAIMcVfA1Lz9fo2H2K
	+ocDK2c+SbTsHIhCpbq5KIzjMQkX3CPpu+7GuJ7TjhsWOeH2njaYODI6jS6kIZS/5JTDK1yXOzGq4
	RkcuI4bC8ko0z8rTLQSz9kpdR3zNif7Pguxzz15qerBvgk4YhR2+I16B+YEs9BpA+tplBRhl19lv/
	XeF6yZUQgGnIctjExgZFB76CsEddITk8w9lh2JcDh/GTqjX4IAJl5XIa+8PFNEzkz/C7WPmnSA9AK
	+KNtRUdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tceFx-00000004AiQ-3hhB;
	Tue, 28 Jan 2025 05:35:25 +0000
Date: Mon, 27 Jan 2025 21:35:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iomap: support incremental iomap_iter advances
Message-ID: <Z5hsnXnzXlcyfeKv@infradead.org>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122133434.535192-5-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


