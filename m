Return-Path: <linux-fsdevel+bounces-40198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C4BA2040E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 06:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A111652D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 05:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD31B4248;
	Tue, 28 Jan 2025 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TgcYKBNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BEC13F43A;
	Tue, 28 Jan 2025 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738042565; cv=none; b=LDEwuNzs5Rlp5qBx4c0fhQGUyN9Q/n2OdNC3fxkVUJo1SmgSyad4hIOIsRiGRfwsdMbMflMGrfbU9sjPDzg59avsK25bsjvEMpkCTDPia6AKtO2tYhnW4tsfmgdCBqMFwDeUdsohgdz42mqkzXn2KpTELXB5i46JKqtjdUP6jAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738042565; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrVGUURdhrTt0Oc7VLuqJCY/pei9E85CS9Ok8A3WPRTb+jnGtfSHIW81aKGLhHZptxFyTfKAXKXXDSsxz710iJUsZm5v8Uz3oSuuNfkztfNBIlkSYxYQeVSruGmEpRizXWeI7eV9OVbkNmlbdSQS6hfv5UMwpZtGZxCICqeCXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TgcYKBNX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TgcYKBNXdP3/yBE3bZvwgCpqGq
	nNVbdWZv5q4asbKqpV9HovXjm+B3jmh1gnq2eTAzKSxl57fF3R6J46kTqZ4AQRu2SYxTgydNvDYPQ
	G5+bE9uSBEcf7HqvEHdgL1p+mK203KRTX/Lo2bOQtnhaN6Jf32UQ4sZmamVc+rSoDYgCgH3KsNtcv
	oxqPluyTy702LZNiHZJTmLf/Uyj+Sfsymq7BhoRmiVZzB8h7UvkHP0Bwp9hCe7/pAAb6b0e1cdLzP
	g5t7JxAWIyrRSQtcFtUbxVoA6d0KXdYkSKjvCNo892xOM3jxK+PWrfQMJr7rv+pQXzra1q4RRpcFk
	K0WuSBYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tceGa-00000004AkC-07j5;
	Tue, 28 Jan 2025 05:36:04 +0000
Date: Mon, 27 Jan 2025 21:36:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iomap: advance the iter directly on buffered
 writes
Message-ID: <Z5hsxE_94MfdXMz2@infradead.org>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122133434.535192-6-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


