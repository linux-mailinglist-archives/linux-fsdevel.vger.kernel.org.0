Return-Path: <linux-fsdevel+bounces-51752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22517ADB0AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312273A3211
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336BA292B32;
	Mon, 16 Jun 2025 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K5hDDFLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD326D4D5;
	Mon, 16 Jun 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078462; cv=none; b=qw8rucnMKKuS4fyWw1sXM4hJc6JpMh1FaS4kYikeUvJDONZ3w2OlVcnT+VGatzTTWpRoFaj52g6pbP7OflqidyvGkSkdFhR9cTMi20UehTj+irduAqlvVtkxKC5969R0+qQGvAvsXQI35n05sBBGbKOV4vfNQFWhnUg6+L7yikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078462; c=relaxed/simple;
	bh=kjPjpxHa1Fq/Eycvl2HWCHtERbvYiGxn1GXNW1g9l9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qffrwuw4+xVzu4Tkk9tVhFOMucn3gekLBjJD+RF+vX6qY8wNdTt02rfDeL9va6E4c095XVoc0BivewNnNPOD3gDYMEzLanLX40WVu335Cod3aubXMo3JYvcwOfXxQJcjSwgY1emCoGdZDcSGe+EMcfAzlZa1zBLEc6mPjJmkJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K5hDDFLQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GYyKEloZlQo4PaY3EigEV9mvepWh8VNAk7Jd35AvKwg=; b=K5hDDFLQsYsdr/6Cwv4N3+0Uyl
	x6zHJr8AGytMUoF0L1GY465Q+4Fu9s1/fwIm/IiJlnSWsf7vz+FXpa3mR9qwzsdHoC8UNV3ZYZec6
	bwlTrNCLrrO/rlXCjZwz7l1huijvQV5gwqWa+KK+Qj4e5Rxj033wUVjvL0tC5i1G6PWIYDwDopshM
	oBfiuD526dqbCF+MSHPyxMKgZAVkCkKH77U7PDtUKPa3qFfOlkwqvedq5zg4VN6ACR4wHv90TVm1o
	bwPuFqTpGsUY3ijhBH9auKrrlrPG2ht8pEQ/6IaHUuyDi6TNhn94+kusK1w6usGAFy1wOVdy7QzVc
	+6SgrKyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9Lw-00000004RRj-3ufv;
	Mon, 16 Jun 2025 12:54:20 +0000
Date: Mon, 16 Jun 2025 05:54:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, djwong@kernel.org,
	anuj1072538@gmail.com, miklos@szeredi.hu, brauner@kernel.org,
	linux-xfs@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 10/16] iomap: replace ->map_blocks() with generic
 ->writeback_folio() for writeback
Message-ID: <aFAT_M0mpR8IQBgE@infradead.org>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-11-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613214642.2903225-11-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 13, 2025 at 02:46:35PM -0700, Joanne Koong wrote:
> As part of the larger effort to have iomap buffered io code support
> generic io, replace map_blocks() with writeback_folio() and move the
> bio writeback code into a helper function, iomap_bio_writeback_folio(),
> that callers using bios can directly invoke.

Hmm, what I had in mind with my suggestion was to only have a single
callback, where the guts of the current code are just called by the
block based file systems.

I ended up implementing this this morning to see if it's feasible,
and it works fine so far.  Let me send out what I've got.


