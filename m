Return-Path: <linux-fsdevel+bounces-65669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BDC0C33F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0F618986C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECB92E5402;
	Mon, 27 Oct 2025 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JQmC7JC2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E932571DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551677; cv=none; b=P+cFNBJOycNarOVQDSAeMWkTitHbIXA+r1Al2YpfBm7jNnLVgUfD8dUvBcWxjsOHup6AHHkv4b2tRMXFkllY+nHZbZ1NqswZ89qOZ9Ly2dgi1uxEuGF94F87Kwv9NgMW15DQnYqberntny1RT5z8mhQm9O35mIwtzSAxEMVH8FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551677; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnKz3UlUQSIdr7D0yRACxqNbC0XjRjlM6Uc9nmxnj/mK3RP33f0a25j9kr1yKng1eR1pPHotiJhgJJh2va+ir5GU1FxGgM+C1ZtkIFHAP6rRgVe2BIPjr6ykR2XOMKXFomoHfJ+RwbZ3wYQ540NWBRO8n17M0fNr+ynJouGBiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JQmC7JC2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=JQmC7JC2nrLrLlej+pwwwX2uho
	YR0mtKa6bt3FNi1AOvrDRZrjs0uaimsfPPoIuZdAQQZunF4RO5MJTiSf9MVPt/Gc8DlrMcuw1MvYs
	L1A0MkQ80ghCPFDcK/xteQzzw7p4F+ywjpnpbLcP63A6J84P21ccXApdze+GIIocE0amkSbBxYasA
	WNBcNgPpBRV52DmW6Mlk192knucxRVmOZ2LNeQRoclGes6zOozyx+3j/8JuVgDEpdaZxDlbStWgpb
	P1ci20f3gdgOuRVNlM3VhSphmXb21vIVYAmC5JbQZOJf77STvgHXhP64dRlHetvbXssGLqrtsxH8r
	ObPuIaaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDI3n-0000000DJ9x-3sOK;
	Mon, 27 Oct 2025 07:54:35 +0000
Date: Mon, 27 Oct 2025 00:54:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 03/10] buffer: Use folio_next_pos()
Message-ID: <aP8lO01ZOyz6RmgJ@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024170822.1427218-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


