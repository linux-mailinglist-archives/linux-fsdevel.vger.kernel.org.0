Return-Path: <linux-fsdevel+bounces-51168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C977AD3984
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 15:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AB616B098
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD312820AA;
	Tue, 10 Jun 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Chl/Ylha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF88246BC0;
	Tue, 10 Jun 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562636; cv=none; b=VyQwid3PNnw7Xdsp6sowHNcw3/ZbslRX+SA62T4wL9Kj9bONqEvzD/iJxiRIV74q6EqKim6qH3JeZIydWAjvAdddHRNb3VeX8sU9Qxzag2+vuFqmfu5VIuqF3AgMbeMwq/FkKDmEwoNTx0cn6LOeevbjq2HfU1Ec0tdlONJ3M+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562636; c=relaxed/simple;
	bh=FXI2MAeHUinlbQb7gSHVXNf8DUYi8tYUEMJCn9PAC5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t12WoE/b87LS63k6nI/9ccjPfljQ2+hbynYnbTHE6O7aqd8mqINHQ02FFM5TLNzDE+r4dxy4CCRpbsT1tywddQVsv0xUSqEecPYUc3fevdVeZ2fYSyI3Xl/3aFvFxu5QS2NAfTKsJvWDflZ9Jf21+XbHm1rLxLq18Te/HV8O4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Chl/Ylha; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1NzR2rxPnpJMPP1YD7GZH2AVOTPhR96TImD7BWPOQN8=; b=Chl/YlhauFGOETLTvPnRnWBjfy
	opTuncHILIemQPoRR7xSy319pBTxdofO0pGDv6D+Z/u0Nvp5k9X1CFLysi57iB8hf1EwyZE8JtVKb
	qg2JLB0m1lye2E0nK2XnmciBR+kXGD0YalsfOrzvgwKrdrjuoIwYZ6x7SmRmeJ86S7lve2d5YL26Z
	ifNFah2Z6Azx4cfPkthqawLP44c8oSJugAVCgkX8HHVhlvtAtNPrTZMb1+c2OA9EEWE/ZGBmSncza
	GqrystEeMZHiuD/pdlwvBhq4XCRj+bXeudUZP8ZhrYZisNgT95QfAqx82riWKQMfAXy6sPama9g4a
	UDyzxdgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOzA5-00000006zyQ-1iAC;
	Tue, 10 Jun 2025 13:37:09 +0000
Date: Tue, 10 Jun 2025 06:37:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: wangtao <tao.wangtao@honor.com>, Christoph Hellwig <hch@infradead.org>,
	"sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
	"Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
	"jstultz@google.com" <jstultz@google.com>,
	"tjmercier@google.com" <tjmercier@google.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"wangbintian(BintianWang)" <bintian.wang@honor.com>,
	yipengxiang <yipengxiang@honor.com>,
	liulu 00013167 <liulu.liu@honor.com>,
	hanfeng 00012985 <feng.han@honor.com>
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Message-ID: <aEg1BZj-HzbgWKsx@infradead.org>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org>
 <5d36abace6bf492aadd847f0fabc38be@honor.com>
 <a766fbf4-6cda-43a5-a1c7-61a3838f93f9@amd.com>
 <aEZkjA1L-dP_Qt3U@infradead.org>
 <761986ec0f404856b6f21c3feca67012@honor.com>
 <d86a677b-e8a7-4611-9494-06907c661f05@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d86a677b-e8a7-4611-9494-06907c661f05@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 12:52:18PM +0200, Christian König wrote:
> >> dma_addr_t/len array now that the new DMA API supporting that has been
> >> merged.  Is there any chance the dma-buf maintainers could start to kick this
> >> off?  I'm of course happy to assist.
> 
> Work on that is already underway for some time.
> 
> Most GPU drivers already do sg_table -> DMA array conversion, I need
> to push on the remaining to clean up.

Do you have a pointer?

> >> Yes, that's really puzzling and should be addressed first.
> > With high CPU performance (e.g., 3GHz), GUP (get_user_pages) overhead
> > is relatively low (observed in 3GHz tests).
> 
> Even on a low end CPU walking the page tables and grabbing references
> shouldn't be that much of an overhead.

Yes.

> 
> There must be some reason why you see so much CPU overhead. E.g.
> compound pages are broken up or similar which should not happen in
> the first place.

pin_user_pages outputs an array of PAGE_SIZE (modulo offset and shorter
last length) array strut pages unfortunately.  The block direct I/O
code has grown code to reassemble folios from them fairly recently
which did speed up some workloads.

Is this test using the block device or iomap direct I/O code?  What
kernel version is it run on?


