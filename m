Return-Path: <linux-fsdevel+bounces-48030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 338CAAA8EC0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B527A87EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD931BD01F;
	Mon,  5 May 2025 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bVREwlSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DBBA50;
	Mon,  5 May 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435646; cv=none; b=ZvuC4LNfsNCeH5GLMhX5cLeubLFL/8jhafCqSGFgIVaVmzb32rpGX8Y8T74pr3LHTJ8VzAdbpleSj3pj3TerQgvrbojS6CKd9bnBIwTwcCmZLRk/gYnz3X4Kx9r9IIPGPvmWKqvVB0bgMk1FlJwGNqThlM7a/VwLsMGKl2+/FJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435646; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h14lzlRA/HrM/5jL7IDzy10Q5QqtKeNDoSe4358RdW2JbtJPFB8LOioFwIhfBRUZ1z/XIli48pB84A4lLBMGEhIB9If/tEVG2nB6wZKNprB2T0s64Md2DGrdeYht1YRVuPsOY3dxaUhNVPVjorfMV1C1mcnCJdLCBfcpr4aar58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bVREwlSb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=bVREwlSbG4dzsplmMVv5Ft8kUK
	N2u3FPqwXab7vuCXfMsNG8NO140k48Oe8+rz9Q//6levG4RakJuLeFwfbhw4GcvIFpRshDtX7oL5N
	Xi38s0yiyUVQCm734dERZgtxJdcwVPMOb2495bFz1sxpvupKAmpXEVTN/PxHUSuIVX96OUzNhb0jp
	s2MokKunJoFVR3x7eRTxuU7pWQqDdtTyWxsBOaLH0hCxOdDUzt06SZiSW8mfP9soV8ZTB/qaCE66O
	feGswLIp90S56Xj56jGQw8D15qOZ7UAfDsiXyW5jQlApU++TChwG6gESZL4jlq1Dy8/+uNxbUdmIx
	XW1c+JAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrgq-00000006qup-3Vll;
	Mon, 05 May 2025 09:00:44 +0000
Date: Mon, 5 May 2025 02:00:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/6] iomap: resample iter->pos after iomap_write_begin()
 calls
Message-ID: <aBh-PKvtQDcMjFjQ@infradead.org>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190112.690800-2-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


