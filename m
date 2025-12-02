Return-Path: <linux-fsdevel+bounces-70456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02BC9BA12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 14:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C83F3A1DAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F5A315777;
	Tue,  2 Dec 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I5+OZgPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACAC2FD7A0;
	Tue,  2 Dec 2025 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682734; cv=none; b=O0OUXHqNH71vMTFzrMaT19FRTkPK3Ts7LsdjmaHeSJW0EA93/fg5FQVZtH1AzXCWWB8N/eq3F2OE6u+uSx/DJD4tnE5aUtayuH0geAeZCjY3VeJKX7XDQ0/8W+WrGC0OK14xKcL1Z/KVKB4ay0CoDnJIhjCLumBMjUPsNk1h0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682734; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSPFg7h1A87Eg9R9eWjkhzgOfQMt3ch7MwG9GnbyaOaNWcvIz721F4BupNue3xqoNJgOuevNeGTdXpz6sbIVAs4N2AvG/DgRnNR11s8GTngmo4sfQClc4/TCOT8ypu9y4ZScermdV4U8XesN8cnyDnoklN58XUnPpmb58YwUxQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I5+OZgPT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=I5+OZgPTCr6EWWZcEtpbwlV2El
	a48yrQ0hQtBeKLMLAxtJuj9P2dgaspFiB8nGH/xqPGTQdjag5x/jcjZF7QRZ56TQ/m5aBzPZUXM8H
	SFjjvjp1h5wdGlZtr3utn74jhccXlYRc5Q59fr5xM5IJjAmLgyMnqQ/CvaeNdc+iO4cG6UceuvZ18
	i7TbXw3wSZ3k1/U5OuLdMiorguLGrwKZb+6ERZs2+Yz7tZbtci4AnXpXkOJg7HmX54DHZylBv4y1c
	ONHzq9GepsNvJfqsoaRCGq4FP774IdZBZWqQtcWhSSxaAjYvARe3q5p7xFAeMmrecGcv7Sjz1yLPf
	YjpsaxQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQQai-00000005S16-1egr;
	Tue, 02 Dec 2025 13:38:52 +0000
Date: Tue, 2 Dec 2025 05:38:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] iomap: replace folio_batch allocation with stack
 allocation
Message-ID: <aS7r7CS8RpZPseHR@infradead.org>
References: <20251113135404.553339-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113135404.553339-1-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


