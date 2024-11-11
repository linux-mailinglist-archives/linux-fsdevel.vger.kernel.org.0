Return-Path: <linux-fsdevel+bounces-34187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF2B9C382E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 07:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6532810FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865C14AD2B;
	Mon, 11 Nov 2024 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gQii+L/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0601EA80
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305198; cv=none; b=nO06E57pPGyYsM1Z6UruMiqAqgPi5I6TtkDkfSjYeemVTdeEeKXCUsPMhzkWbljukc4i6a/fZYQNba9Cjdv63lvByflQg0NvCwAuwBOjO+TjDquhJZspz5qDhsVRwg/NJVoUjoWzWIjX91qVKIG+8CgzotZKm5u+TTjk0ZiEx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305198; c=relaxed/simple;
	bh=J8ZpJ7IEUIssWYiGn4JUZV8YSFiAwMHHgkpgEGYWdV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyz1bHX524TVaAD1bScP6rD2XZmrM4ET0MIQIVHEtuFuc0QjR+9slLJUS5UH++Lj4xduwI+WqvhI1GCYb6nZgkK+MXxoyujcLw2QKR2E6TdvMvNm3xL6yDEU/o0HUFzhHkCBMztS9Y6K2HRx6b6KBSvytqjslRPczuiW4CnbHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gQii+L/P; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J8ZpJ7IEUIssWYiGn4JUZV8YSFiAwMHHgkpgEGYWdV8=; b=gQii+L/PN3xyHrOwziBYHQ36ce
	u35/4gF/t814xKLn1Pat46Ta0iI/AqpbDVHtnn6Em9URZX8jaDCENcpZg4Cg1WLW8GL0vyw43QL1m
	KdNBUtsWgIXL7Lal0NP32O5b6ZbR7Gj1VaJJ6wgXgRYWMOknLRqp8pIfnkseknWNAL5l6PUnJ2F2v
	yTvZuUfPZ+pZZ2yu9v5aiule77cxAT8ak/5YGaHBYsyHeOUDyAI3CzCU41VtdyGvMyHRat2jE4FF8
	Av2fP/YD/sdzuCSjQdwc1zMYkO/ZZ5L38zI26l5QUejkE7U6D/bfUjr9GYfC7WF1DLWuDWWXTzouj
	tR8scQng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tANZM-0000000GS2w-2d7F;
	Mon, 11 Nov 2024 06:06:36 +0000
Date: Sun, 10 Nov 2024 22:06:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iomap: warn on zero range of a post-eof folio
Message-ID: <ZzGe7B4JsOLMYrpP@infradead.org>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108124246.198489-5-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>


