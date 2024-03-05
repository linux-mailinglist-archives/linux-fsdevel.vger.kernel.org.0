Return-Path: <linux-fsdevel+bounces-13617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCF58720BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3652862B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0388662E;
	Tue,  5 Mar 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qvds27Sp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546F86141
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646475; cv=none; b=EvNoMG1lD3afKwNJ7MbFoI3hGsLgI7HfNzH0xINDcLJKKSpYMyAbo8n5oCxUMjQ7knxrhFvoYguljWTHa++xHYDQCXmufVUINURRhtuMJSpAQatfgg/+O9rtYJl7Hs+DnvK/aY1AuOnv2gAea2jo14nsV7ekUoLIjOGJeiuBDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646475; c=relaxed/simple;
	bh=G4REYVf3XLRtxmU4VTSzF5SQLrNKmJZc8qFUh5MbRhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM4tzYY1/u62a1MJXHwWLVot/VP6Hk1gk7m6OgW8tiJomMNFBMD1pHWwy+ZgHyTZeQ1v/tCzg2BvugwAVHGTu1S5f8LIaLm9LzR7FIj3acRH+GD0Ue4qf643F9gLJeYrhBaNYPdvduQEb8Azznvaw8HPQ+DIKgzv7fYKZqSs2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qvds27Sp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4kpLO4s8L2ervvsS2fuA9MOogE0U0TcIY/XGyl14Aao=; b=qvds27Sppo1/giajShcPFs25Vx
	GwKHI9G1nMCjc5N5I1kLU3vUi9U71L/r7tFwRheZTvblg2p7ek6gFeTJzNazo6RDF2qYqu8CmYUyx
	yDtSUrwHxKAekoKJovCQK8mGC4H0QhVblpS1xdiGZuLoufr1xO8W4Yi9lmY1Mdm1oIoF+oUXyRY4T
	mROZbN+eJWfmKL3eHVm2xZNYTiCQz0LW/2yo/m2W5HAx45Hiif5pLcI4JisFyQBD4qs0k30GZgzjk
	FF1OXIQ7RfeZJNk8GoIaZm8k1N70tnvgvyrZ0BN5tcsjYV0+SWnXMaTAg9Uq5x6Rxy+B7x4I7tJqU
	bogK04uA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhV96-0000000DsyP-2NI7;
	Tue, 05 Mar 2024 13:47:52 +0000
Date: Tue, 5 Mar 2024 05:47:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Bill O'Donnell <billodo@redhat.com>,
	Krzysztof =?utf-8?Q?B=C5=82aszkowski?= <kb@sysmikro.com.pl>
Subject: Re: [PATCH] freevxfs: Convert freevxfs to the new mount API.
Message-ID: <ZeciiH1jYeT3juD7@infradead.org>
References: <b0d1a423-4b8e-4bc1-a021-a1078aee915f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d1a423-4b8e-4bc1-a021-a1078aee915f@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static int vxfs_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops = &vxfs_context_ops;
> +
> +	return 0;

Superficial nit, but I would have skipped the empty line here.

Otherwise this looks good and thanks for doing the work!

Reviewed-by: Christoph Hellwig <hch@lst.de>

(and I'm fine with routing all freevxfs patches through Christian)

