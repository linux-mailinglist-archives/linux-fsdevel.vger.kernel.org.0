Return-Path: <linux-fsdevel+bounces-28815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AF296E714
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 03:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CAF1F2436E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 01:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81A51401C;
	Fri,  6 Sep 2024 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z6Lzvqnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC87E9
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584727; cv=none; b=V43lU1+jmEDNEk1kasWzpu+6WNnVaXPU6GZhhz+tJOCrRzCvvFw1hN/4ogI6qY0pzFtR84/Y6s6DQRl1gCHL3+OPyBYhLHd0eI6RIlhhlywuETMaYNVp7BBTD9H900C07Y2d22C8FfejPVCb3PRjXOeqkA/hSjMB0yTHKbBxB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584727; c=relaxed/simple;
	bh=FRAz00Tj5wzItfEVk1DK1jayotRRx/AU0ggRuolcd+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRkTllfpZDfl+bz/8q5IX6qUcWhOXrSjQv81zY+vG/WejkHEztWu/eNGs9LD66zpwVTcOs9Ah0dlzr1q1STdRUQSOptXtdlo9daNPLiesQeNfUjurnE2Yroy2w/wRyW4PyPdzWx40keYLhVlzLrn2Htn5GA4RiicbIopdwCRq0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z6Lzvqnh; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 01:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725584723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZfl4jNLYBumPhfVdwIVw+fClZAE2xAgEb6OUEp57zE=;
	b=Z6LzvqnhHdMv4bA53nRXA1ASjOv1XVtS86OxuQoX8iqw4uZ/zwH6PdIMSUKiT1/Xtr87/E
	A5FxE68Qg04KU2F+etoKVxPPhcmgFpmeza/+lYDReXEkPSBcgoGrEkyIVXQzxsQtLx+wkD
	+uHdFK44TTaOuJjq87ryNK7nRAb3kLY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 12/17] slab: create kmem_cache_create() compatibility
 layer
Message-ID: <ZtpVTRnc1rwlZS-I@google.com>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-12-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-work-kmem_cache_args-v4-12-ed45d5380679@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 09:56:55AM +0200, Christian Brauner wrote:
> Use _Generic() to create a compatibility layer that type switches on the
> third argument to either call __kmem_cache_create() or
> __kmem_cache_create_args(). If NULL is passed for the struct
> kmem_cache_args argument use default args making porting for callers
> that don't care about additional arguments easy.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

