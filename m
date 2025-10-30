Return-Path: <linux-fsdevel+bounces-66480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C5C20748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32C5D34DFEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD5C242D78;
	Thu, 30 Oct 2025 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OU42mios"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27973126BF1;
	Thu, 30 Oct 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833120; cv=none; b=Aw3MyWTrbdoqmSlY81u0vtgRekKXGNEGjNOhI1d6dxAd/nCQeZ1iWoIi8scERezVBSMRd8SnXYZl7hk46+L2e/UkSS8FtXtPuQBv/pEKcAqHEYNEMLaO5QXjsTxCT8tTfUXJxhI+eMk9DiH/jhbvTORNRJOtI/sLvBnhL3ACHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833120; c=relaxed/simple;
	bh=FIKu4iYEpNCcQJAJFxEAKcyoNhn57WXUvUK9Lqt+ERU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmZ213yzDCgKJpLu8x3RgRZnQZYUTv9PkN93SXlu+sybxdhR383rRjRmXMzO2e1xZKHOou2He3GfkGD7d4qqWYfs14cUzlcugWM1whI89n+VJCs4CuZeMtY3gcFFIDILydJo6GsdrMx9PIlB9fYdBdMZqEEfsQVgoMbA00Buu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OU42mios; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xFP5v3fUOlDAEzHhimBhc19pvPkZDICA/lfyXRtuCO8=; b=OU42miosZZnsNGA8GWX4rxDD5v
	NbliiDx+SjRjbIF9jFGckM3MdP80CQtGSDK/nbkvMlbdk1UygMYUDjPgN0c3vvX0NOyP5CKxGp8AZ
	A0DJkJWWLkbUlw/iPQNrDXvp28dgzimT0B/sxr0cBPO6KMupjjlnCC3hxe9S9lUyGvfnixBrqjeAC
	wT0vgTXn2TPw1TpM6hxsYrRnggBilsHevdZqkWTFmJhpkv49kyH6eyrb1h6QAe2DZ4/V8W1eTyrm9
	TrXUxnBsjtbfa8pB8oZssfa0DYQyEYtx2WM8A6WPnUYKejXmj9paTw59DZGiAsEmGg/W8PAHKEk9q
	Asgroq/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vETGn-00000004H02-1Xin;
	Thu, 30 Oct 2025 14:04:54 +0000
Date: Thu, 30 Oct 2025 07:04:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com,
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com,
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, willy@infradead.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com, hannes@cmpxchg.org,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	minchan@kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
Message-ID: <aQNwhQcN8Su_Il6c@infradead.org>
References: <20251026203611.1608903-1-surenb@google.com>
 <aP8XMZ_DfJEvrNxL@infradead.org>
 <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com>
 <aQHdG_4yk0-o0iEY@infradead.org>
 <CAJuCfpFPDPaQdHW3fy46fsNczyqje0W8BemHSfroeawB1-SRpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFPDPaQdHW3fy46fsNczyqje0W8BemHSfroeawB1-SRpQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 29, 2025 at 07:57:34AM -0700, Suren Baghdasaryan wrote:
> On Wed, Oct 29, 2025 at 2:23 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Oct 27, 2025 at 12:51:17PM -0700, Suren Baghdasaryan wrote:
> > > I'm guessing you missed my reply to your comment in the previous
> > > submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=eukTuS2X8f=nBGiiuE0Nwhg@mail.gmail.com/
> > > Please check it out and follow up here or on the original thread.
> >
> > I didn't feel to comment on it.  Please don't just build abstractions
> > on top of abstractions for no reason.  If you later have to introduce
> > them add them when they are actually needed.
> 
> Ok, if it makes it easier to review the code, I'll do it. So, I can:
> 1. merge cleancache code (patch 1) with the GCMA code (patch 7). This
> way all the logic will be together.
> 2. . LRU additiona (patch 2) and readahead support (patch 3) can stay
> as incremental additions to GCMA, sysfs interface (patch 4) and
> cleancache documentation (

Sounds good.


