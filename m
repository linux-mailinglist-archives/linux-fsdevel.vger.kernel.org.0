Return-Path: <linux-fsdevel+bounces-24500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1330993FC8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7E32836BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913415F404;
	Mon, 29 Jul 2024 17:43:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB47603A
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275030; cv=none; b=C593XYCyfzUkvWy5cgJVGgASyB9oLHA5lmvMV5yljcsQhf7JGUkjCUWtRplrtpNIhofrLhWWYQ9/UmIlLrAzhs3XyQWjuoJp3IoTEGYgpoIyK3MXJ75WaKTJjeH8bEUQP5CVPVSr64iDr0Z0KkpE9kBGEtL0UTtcHw9KlmWSpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275030; c=relaxed/simple;
	bh=BchamHXHKDJRbJVNM3Q2yqLongoZPh+frDUH1NY2jjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCaR/JfwNetzdeZKFIJxcW+GmXhVLBuX9/daAm5Yzuw/OOpM5PSIifgiOQ0aD4ulNMu4Hkn4CSnFuPGvBkotHMK6hte+p198JJL43Qx4i3ks+fe2cgZI3pGaVcMaRVtrHzfXuSkDsGbYgkwGWKFwWOBaNPb2nrRLya+LHEybaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6C4CC68B05; Mon, 29 Jul 2024 19:43:44 +0200 (CEST)
Date: Mon, 29 Jul 2024 19:43:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trondmy@hammerspace.com>,
	libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <20240729174344.GA31982@lst.de>
References: <20240729160951.GA30183@lst.de> <91e405eb-0f55-4ffc-a01d-660e2e5d0b84@cs.ucla.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91e405eb-0f55-4ffc-a01d-660e2e5d0b84@cs.ucla.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Paul,

thanks for the answer.  I don't have a current glibc assignment, so me
directly sending a patch is probably not productive.

I don't really know which file systems benefit from doing a zeroing
operations - after all this requires writing the data twice which usually
actually is a bad idea unless offset by extremely suboptimal allocation
behavior for small allocations, which got fixed in most file systems
people actually use.  So candidates where it actually would be useful
might be things like hfsplus.  But these are often used on cheap
consumer media, where the double write will actually meaningfully cause
additional write and erase cycle harming the device lifetime and long
term performance.

Note that the kernel has a few implementations of fallocate that are
basically a slightly more optimized implementation of this pattern
(fat, gfs2) so some maintainers through it useful at least for
some workloads and use cases.



