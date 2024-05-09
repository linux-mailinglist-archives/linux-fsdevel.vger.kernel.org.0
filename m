Return-Path: <linux-fsdevel+bounces-19194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2748C11C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287B81C209F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764C15E7E4;
	Thu,  9 May 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cs39PB44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCC12FF9B;
	Thu,  9 May 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267630; cv=none; b=JDwckm/5u1aa/KGewjaAcHkEH/TogeMFMPMmIsZO/M1zSur1hWKcQ1owKKqEzSwhaY9Zu3mkq8rBaHo0vQas/vxN1bRXbzOYc7LvD2/pbRdVVVikSqF6nWjWZlKJUxObDyzhoRztPJ9JQTmJUbBBCL/IiFEu5vR16D0dA6t6ngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267630; c=relaxed/simple;
	bh=cnMzO2A+Ga6QE4ek+2uIiCB3gaEWsNraR5DEyjN8xHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp9IHWxGZwk4iU7Nx/00TtHDmmJcsxyVsZktftDdG7U5odcvvWK7+ZtkR9E/a93lkc9qj6wmm2ZywtlsNX2ChW5R67ubzkZvFKcO9s+zY3M5xa+skevZ7TUe4qiqFy1tvCNE4B10XIMzX09J9YES72hmxC9+BbUIZmYmrgG425w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cs39PB44; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2z0wT8gt7dkldW9YUB+LxHRPNABG7fCbmV5XzFY7UhE=; b=cs39PB44VIazzjmJTVgeh67P+S
	2T1nrRDAxOdv3tuwEyVb836vQfuk0wiRYk4UPW2P+vrhN1ba6YvZiWNpGTS4/BPBaQEWv+h1kguwh
	Bw5O/zVhcUdmt0VOwjfyP3RDgEs9xVCYGeNsoFDMhZCXM4AhUXYc7f5E9RGf7yz3RtBsdWRbF1GfJ
	vGs5RgqRFae/e7F/WHpTf1YeM15d/tdLh6D9Nul9xzS6nox9Nt68V9+2oqED2Hx/kXsw2KW5m3z5S
	5HSVD6P0KuS2imG37E4eZBX9jLdCQhau8Mxme8qxXBx5Wa1/2LkvTkRVHipNeCXYd8jarleesbRb6
	aV0y2CMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s55Su-00000001qhf-44sO;
	Thu, 09 May 2024 15:13:48 +0000
Date: Thu, 9 May 2024 08:13:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: make it possible to disable fsverity
Message-ID: <ZjzoLKev1WqnsBx-@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
 <ZjHlventem1xkuuS@infradead.org>
 <20240501225007.GM360919@frogsfrogsfrogs>
 <20240502001501.GB1853833@google.com>
 <20240508203148.GE360919@frogsfrogsfrogs>
 <ZjxZRShZLTb7SS3d@infradead.org>
 <20240509144542.GJ360919@frogsfrogsfrogs>
 <Zjzmho9jm2wisUPj@infradead.org>
 <20240509150955.GL360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509150955.GL360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 08:09:55AM -0700, Darrick J. Wong wrote:
> xfs doesn't do data block checksums.
> 
> I already have a dumb python program that basically duplicates fsverity
> style merkle trees but I was looking forward to sunsetting it... :P

Well, fsverity as-is is intended for use cases where you care about
integrity of the file.  For that disabling it really doesn't make
sense.  If we have other use cases we can probably add a variant
of fsverity that clearly deals with non-integrity checksums.
Although just disabling them if they mismatch still feels like a
somewhat odd usage model.

