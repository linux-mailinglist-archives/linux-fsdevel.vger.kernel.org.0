Return-Path: <linux-fsdevel+bounces-61430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA16B58196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F741AA81A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7523FC66;
	Mon, 15 Sep 2025 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hPilNql7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA122A4EE;
	Mon, 15 Sep 2025 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952354; cv=none; b=qY5IZP0Pfj9YA8CkqFAbYjKj8meHs6h7A0thWRIaPHcWJk6L/JTaEfweV2y4tj9iR1e/20T0eo1ErhSKxo+F6p3ujJlw4ZxHEfVVUr+3WKs2YWEqwyu6guz1yEmLgLZvagcVKAtuTnCA7PblFbcTcpoGFq4pVgt2PYxlCxMbqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952354; c=relaxed/simple;
	bh=lp5o+OtvyP7RyOuio/+1UKRQHuPTE6Vn/E49AJ+zUjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF4MLnsct/wsWxJSA1NVFKAJlhvxjcvo9iSAkLcoC6HOdfWxusSbp18myQ1Ec/IWp63zelUsPF8LB7aq9NNT0kzvA8y06RxvDtm/SAT0DHbNLdaf6NKQ7sbwi+3D6XTfz9X/PoNgBshFOrHyRFdS00o3GbuWGs2f5xIg4E8SRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hPilNql7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jlL1Cb+6MbYk1+h/WWLBuvRphciTXyLJKToQ9qNYACs=; b=hPilNql7Z+bwv0+tcn+S3Z8K7y
	vMPcpAm9tPZc57twzHBhmvJkgVuJZqYQqxQpQ4Da94KFDCQitH6JA2DYJ0Wb0Hu+EwRkOP1Kc9niB
	WlSP9+rrQqCZl6bVh1ug7UjXvfO26Tcw4iRkzDp6gAOy0/QYdtiQpAyZ6GZ55yxrpYYCyK/AD5Qri
	0iFbEBtmm/MnzKN8cZ+NUkYuqD2UcQbTwuDqXu622buEB3Dk0pjykWx08coOGzPFQ6rHE1+1eYfJ1
	+VNUIiNPhLrg1b2HwEhMPaV1XpK/htmySUBFzzjwuWrcNT+vQHdw2R/taVhL3/qm7C+48Q0+wl6EY
	dUA+Gbqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBiC-000000053IM-1diC;
	Mon, 15 Sep 2025 16:05:52 +0000
Date: Mon, 15 Sep 2025 09:05:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	miklos@szeredi.hu, djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 12/16] iomap: add bias for async read requests
Message-ID: <aMg5YJRZMefvUKy8@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-13-joannelkoong@gmail.com>
 <aMKzG3NUGsQijvEg@infradead.org>
 <CAJnrk1Z2JwUKKoaqExh2gPDxtjRbzSPxzHi3YdBWXKvygGuGFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1Z2JwUKKoaqExh2gPDxtjRbzSPxzHi3YdBWXKvygGuGFA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 12, 2025 at 01:30:35PM -0400, Joanne Koong wrote:
> I think you're right, this is probably clearer without trying to share
> the function.
> 
> I think maybe we can make this even simpler. Right now we mark the
> bitmap uptodate every time a range is read in but I think instead we
> can just do one bitmap uptodate operation for the entire folio when
> the read has completely finished.  If we do this, then we can make
> "ifs->read_bytes_pending" back to an atomic_t since we don't save one
> atomic operation from doing it through a spinlock anymore (eg what
> commit f45b494e2a "iomap: protect read_bytes_pending with the
> state_lock" optimized). And then this bias thing can just become:

That's a really good idea, and also gets us closer to the write side.


