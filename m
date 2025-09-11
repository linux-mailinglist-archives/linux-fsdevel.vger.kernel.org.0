Return-Path: <linux-fsdevel+bounces-60931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2D5B53004
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E52D1885AC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D905A3101B2;
	Thu, 11 Sep 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jEEZLS33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03D3126B2;
	Thu, 11 Sep 2025 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589597; cv=none; b=ftW/DLPlNuNikfHNVj5ljmuTLRUhQRclHXrqCfek0Ib1szuKwN/c3aorjegwnIe4uuib+RxpUCW9PHSS5D7Lpt9/GpMvWSX/pQp19V/KMNL9l1YY1Yzmd4VVLVVQtHQQcueTE7goYsN2uF+s47gdx8aekHi4qPQi6j5pweSkxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589597; c=relaxed/simple;
	bh=fFjzlO2qMeCZOSWPie7y08l7b+6z2Y+5h60TkzVzcdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFoNbfg0kaUR7BQ59KTiwoho2hNaFX2o44P477i8SUTifRqznQJJRnEoyZmCPmV9fw4rK6wpgelgIjd8WC53WbdTRNjNZ6xp+ppjwmzN5C2MeeBXWUPo/0/6gL3G+UUMjLiVpr9zbfmJWTzw0BBS9aEcJCW/PkxZr0CtOHlrTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jEEZLS33; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fFjzlO2qMeCZOSWPie7y08l7b+6z2Y+5h60TkzVzcdk=; b=jEEZLS33l4YnaKIiqnVSWD4/0o
	pzZEG+4cfuyf664Ky3AI5z7HXuyOGUisAuU6+ylSOqtMj9npT9oFGpM2jM4iL5Thzgay+A0F/6qvp
	zpIV2qOuWF4YxZazzfgbFZRtP+qq6vtvYom6Ai9K3Yz9vx5WTtq8+6t3nID4DbzXFOU3blBPA/L2z
	ULEnkV8hvp+lehJex9TI5oUVDzE2LbI2LhsL8moODFbisQeG3C5m9RsVinLSlT8n95ghjevH73KZK
	2mhnM6KrBpNTKbJy7X7osTJ1brdI31XWqV4Rb6+22cWXbzYxwHIIMWxLuRCfcbA9IrRIeNkJoJxDX
	Uod0mAJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfLG-00000002d6O-37O3;
	Thu, 11 Sep 2025 11:19:54 +0000
Date: Thu, 11 Sep 2025 04:19:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, djwong@kernel.org,
	hch@infradead.org, brauner@kernel.org, miklos@szeredi.hu,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 11/16] iomap: add caller-provided callbacks for read
 and readahead
Message-ID: <aMKwWqhvYYhba_Vf@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-12-joannelkoong@gmail.com>
 <aL9xb5Jw8tvIRMcQ@debian>
 <CAJnrk1YPpNs811dwWo+ts1xwFi-57OgWvSO4_8WLL_3fJgzrFw@mail.gmail.com>
 <488d246b-13c7-4e36-9510-8ae2de450647@linux.alibaba.com>
 <CAJnrk1a5af-BMPUM3HfGwKZ=zoN4bcmbViLBWMtLao1KfK2gww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1a5af-BMPUM3HfGwKZ=zoN4bcmbViLBWMtLao1KfK2gww@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Sep 10, 2025 at 01:41:25PM -0400, Joanne Koong wrote:
> In my mind, the big question is whether or not the data the
> filesystems pass in is logically shared by both iomap_begin/end and
> buffered reads/writes/dio callbacks, or whether the data needed by
> both are basically separate entities

They are separate entities.


