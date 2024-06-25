Return-Path: <linux-fsdevel+bounces-22305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DEC91644A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2268B28E88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0B14AD38;
	Tue, 25 Jun 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B9cFtK/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7121487E9;
	Tue, 25 Jun 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309333; cv=none; b=tjaGrGIEUIIcx6yITtQaYMxNYwEGmzVcGkSiVs6a7CNFEOxsD0wP2VMzV3I9cyf5h8z/J3DQSgblc12rOKikm9n9sRYZ/Gmri+43TdI9Sgs4rucQxJfoVRFJyMkKJiRVTV2WygIgfWIEvpOK3lc9oRgzQNq61Qex/rWyUCRHCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309333; c=relaxed/simple;
	bh=Lfw4YmKeu+GKdvQ1wup3M4mqIp3GJuM8b7boODrkSdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5ikxPMofsZMpZ3i81D7y5ClFGOKr8Ieq905aTbkNIv31WZwtCRkAG+IGE+Hfj7YGP4o4FxpyoZwwiDqdhM+OwLqJ31tgYbLSBKUiV/Zjr96+hsotsvnuRkYNUHd8OvsGDYxsle8m850vtWlPGuDgNFrTaOFaWNgczdQ1SaItgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B9cFtK/d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oaG1k9bawOcdiKjyQr0Vh/BDN6Ii0esFFl+OFjSftSk=; b=B9cFtK/d05Hftmbg1NdOJ5JL3y
	UEyPT0dNpz/iEVtRqlbaYhgphGY766VqGaowYWfoZMazbiwfxANRFKrw0Ds767QxuvyAZrhGvoGoK
	MVLJEOVZ8Ost5xhwt7OqA9NVS1KsuhIYQhFi2MFuErN8dDyOZiT51n+03rcBeZXLvSCj01mUj+15U
	8/DIWBlGbTvSjdqCQ1YF6ivIqXwnfBuWvJAc9FxbkXlpbcz9Qz66Gw5uhWlfBCLgC2F0P7SffMrmN
	OEPlSoAsD9N1ts5LCJ1/hNRti9d6CStKxehbH42e2pUU9QLfEWVSveUjxWgbO/KlAt3u7Ae6Z08IX
	G4lDKf4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM2tf-00000002KV5-2rmH;
	Tue, 25 Jun 2024 09:55:31 +0000
Date: Tue, 25 Jun 2024 02:55:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chunjie Zhu <chunjie.zhu@cloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] revert "iomap: add support for dma aligned
 direct-io"
Message-ID: <ZnqUE90IEN_VeWSH@infradead.org>
References: <20240625093851.73331-1-chunjie.zhu@cloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625093851.73331-1-chunjie.zhu@cloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 25, 2024 at 09:38:51AM +0000, Chunjie Zhu wrote:
> This reverts commit bf8d08532bc19a14cfb54ae61099dccadefca446 as it
> causes applications unable to probe a consistent value for direct
> io buffer alignment, see an example,

The required alignment is available in the stx_dio_mem_align field of
struct statx (and for XFS also through the older XFS_IOC_DIOINFO ioctl).
No need to probe anything.  And if you don't want to use that just use
a conservativ block size alignment, no need to probe anything.


