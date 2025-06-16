Return-Path: <linux-fsdevel+bounces-51707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD5ADA7A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 07:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680FD7A6281
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 05:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70751D5AC6;
	Mon, 16 Jun 2025 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b/nuvRU2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08E14A8E;
	Mon, 16 Jun 2025 05:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750051533; cv=none; b=SsVe8kzeIPSELCOWhWeEp32DiA5r1Hoas3PaOeaTV6mPYyk1uvdTJjSQfKxLUfOsvLTeKWBdf4XRIrvOdFvhYiyeWoil31FDZ+2kx4tfQenbaESOQD7q4npDXKXf/r3MLUbkQnhq+XYF6GrqWS6O9YSqIMXnaf/kScKklvMC/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750051533; c=relaxed/simple;
	bh=dU9R8MC6xbPrHNM/OSqF0vDUwVpni+pZRmmj2opuiWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE9MZJpHk3XUJ4whbKUTT76I42DKmKuI9N472ON8b4mQiDGfXZY8VAIP8mZl46JUjtCSG7JW89Y3r5eOWdWSk381/rw0ppoQFaS/AT0sRn9b0eeuUp1ce5jGCZcmSEGXD9tIu+VVVSLOkgDI+QqoJL71lVdSEp+2Vt4GumKT51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b/nuvRU2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0ilKtUDLU3xGxduLonN3eGibnQvh68iPK6xSKyYUOoU=; b=b/nuvRU2/IoozMkhu3mIHfAyEl
	RKkQiEF+lhJUc10muHa6qXv1EXRebIM1fQTmhK2lF+fL0DqGhiHbG4ZWjR5LIgs9CFo8Z3Y2ZV1kY
	j/70R4chy02UprCaSQIywOcRQF1wRLUZKZsIERdMGYzlFNFhpaHyFO+2cigQZViw4farcxUf6TbYB
	UABDK7RtyPFSpYwhJesGSSkdH17qkYOL8VWFgqJ3baziBIGFJ3vfi1CeVThA9FDkTm2kE0stGx7kH
	ei0r1f5w7M9vLrL8bhmfvoCd9UFQTdw0WpoBSeeI+Q+VPjNp9p02KiaKHDf8EHdNKmmbHC63UWqS4
	NnPSoXnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR2LU-00000003QVL-1zRf;
	Mon, 16 Jun 2025 05:25:24 +0000
Date: Sun, 15 Jun 2025 22:25:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: wangtao <tao.wangtao@honor.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Message-ID: <aE-qxK6rbvfoeBr6@infradead.org>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org>
 <5d36abace6bf492aadd847f0fabc38be@honor.com>
 <a766fbf4-6cda-43a5-a1c7-61a3838f93f9@amd.com>
 <aEZkjA1L-dP_Qt3U@infradead.org>
 <761986ec0f404856b6f21c3feca67012@honor.com>
 <aEg0aYQJ9h_tyum9@infradead.org>
 <34c2dbc06d074ffbb8f920418636bafc@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34c2dbc06d074ffbb8f920418636bafc@honor.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 13, 2025 at 09:33:55AM +0000, wangtao wrote:
> 
> > 
> > On Mon, Jun 09, 2025 at 09:32:20AM +0000, wangtao wrote:
> > > Are you suggesting adding an ITER_DMABUF type to iov_iter,
> > 
> > Yes.
> 
> May I clarify: Do all disk operations require data to pass through
> memory (reading into memory or writing from memory)? In the block layer,
> the bio structure uses bio_iov_iter_get_pages to convert iter_type
> objects into memory-backed bio_vec representations.
> However, some dmabufs are not memory-based, making page-to-bio_vec
> conversion impossible. This suggests adding a callback function in
> dma_buf_ops to handle dmabuf- to-bio_vec conversion.

bios do support PCI P2P tranfers.  This could be fairly easily extended
to other peer to peer transfers if we manage to come up with a coherent
model for them.  No need for a callback.

