Return-Path: <linux-fsdevel+bounces-37918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 072229F90BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 11:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01C21899CCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3D1C4A34;
	Fri, 20 Dec 2024 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="kugA4uCw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kCpfiUMx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526574059;
	Fri, 20 Dec 2024 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691906; cv=none; b=aOWG7+EgiKdJHmlZKJY0Jpp6/eV4DOFTS1pdgryX6+YF+ctAaxY2WAJ2jtxZ2UzSj2MfHII7pgzO8v6RNDAOJCGNAgtldlfx1xO2204vt87x8jqBtTMKmUeAw/Q9dDtgTmmAzus3hRzFW3VWpzAlx3GM2odN/PbVBLyVTbL8ecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691906; c=relaxed/simple;
	bh=/ZaVdN3TJxI3nNk9xHC7aioAzM5CbeN6pVXqEN5Jekc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjyVxqBoVYRjHnFCGy/TlUSUDQHjEfCbjjehNpyeEynGnIJPii23Vazx9+i29qbvyl7ksTwW9rVBaUk7/cEtZN/ep4yx6z4vx4kYi4coGY4rAKYh4sxCz9IWMk7m4NliuQ4QMChj+R/IVOJpPSOdPbH5YD/pjmhsFtOX5xUHBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=kugA4uCw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kCpfiUMx; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D5A4138016A;
	Fri, 20 Dec 2024 05:51:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 20 Dec 2024 05:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734691902; x=
	1734778302; bh=VdKfaZuoAsTfIEKNboZqkylXyFi+4/vjTA3crwcpBJY=; b=k
	ugA4uCwfHLeZx+CpN0si0hhNPdzZI7Xr6a3lI9t9KOaOO7GhrjR2FTVBn/aAuhzj
	4WskTKHpJtRqmRClF3e+foRE5OFA12VB9zPtxq6UhSCDqFE+sAAhtII6UGSXtG1X
	vdjpaUI4kdU4GvBXOU23sdKDtrp0lNt83tlhT8f1hdURMvtljIXmBilo03SgJhBb
	gbhkcty8sfg5eJLPicgafNxieDLC8G+vSlQwq43e54j1CzTOZLlrwgd2wJaZFtzg
	XTsOI2v3gxXNW3Ktb377rzrFksvQdu6wDPuCgpPEsGbXKL/Jtkdr7tglQnrQcIx4
	RLqTLdEnNJNx/k6U2PkJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734691902; x=1734778302; bh=VdKfaZuoAsTfIEKNboZqkylXyFi+4/vjTA3
	crwcpBJY=; b=kCpfiUMxKaEYTCkWV3ZRwgjDEXwdUcqcf1bazM//VcIAPWx8/MR
	fkgzvNc6NJbMW2bYVXGrThAPOheHmdPrcGGYGcOtq1nYiKhiBQp4hmfU4BXKhC8Q
	OSNmZpddi02rHRnGapgfr5Str/gf3Dze9lKBCZgjyMvgMV1f1ZDpZHqz7AZNvzbu
	F2f2tiNCduOqOpJfVXU2BomJRbrRw6q4V/IIeRtRSFWKoyv3yF6mb3c8dudSnaM9
	hhCSh35WegOZkDm/RcP1LJxRFEfw4AGBCPnx0nr6M7gVEOF7AOQFuBvPDu0/jwQP
	7jhXHVlLfWwZk744W3p7TJasQ1DaApQQ/GQ==
X-ME-Sender: <xms:PUxlZz-BVS7ZlDFYQ5OKsB927Ky9hD2zR2nt-iK_xzRWi6FJHhC_ng>
    <xme:PUxlZ_u9kJx4Qov71TuJPFskavpXfj_ckP3e9GmII5vgsKoLWB8u_8XLXuWTm9axM
    t0PrYr5FEohFZi4f5E>
X-ME-Received: <xmr:PUxlZxC-FHnRn1lMNr3Wcy5y5799Pn-7UF-maNNNj1j4-lYdPrG4GrI7hIKeetwnIVMcKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhmmhes
    khhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdho
    rhhgpdhrtghpthhtoheptghlmhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhl
    hiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsfhhoshhtvghrsehrvgguhh
    grthdrtghomh
X-ME-Proxy: <xmx:PUxlZ_e4OowyjYhSTNFF7KToAw2pRBCbHo6ESADkacSVNY6eRO1n2Q>
    <xmx:PUxlZ4NvJmk7VtvTBraPSa0Xf_CHV3AcI71J9jnL2ROLjtajPJ4LRg>
    <xmx:PUxlZxnJNzXJ3wWYGiw6PUpvBmkuKgoktpaganibeBG3VXyEP8KvFA>
    <xmx:PUxlZyunFks5zS8sXBM6SolwjZL3GTsryvoLTD7SrX8cPGqhGBnzpg>
    <xmx:PkxlZ5hKrz6kduWue745i4WVr5PK6_WCYhxICIarXI9pAcTNkcb5TLu8>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 05:51:38 -0500 (EST)
Date: Fri, 20 Dec 2024 12:51:34 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	bfoster@redhat.com
Subject: Re: [PATCH 01/11] mm/filemap: change filemap_create_folio() to take
 a struct kiocb
Message-ID: <vvnsjxmc37nivfsbjkujdbjc2f6iisgvzcguboz3xdw54h3rvf@ntejcb6af4ep>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213155557.105419-2-axboe@kernel.dk>

On Fri, Dec 13, 2024 at 08:55:15AM -0700, Jens Axboe wrote:
> Rather than pass in both the file and position directly from the kiocb,
> just take a struct kiocb instead. With the kiocb being passed in, skip
> passing in the address_space separately as well. While doing so, move the
> ki_flags checking into filemap_create_folio() as well. In preparation for
> actually needing the kiocb in the function.
> 
> No functional changes in this patch.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

