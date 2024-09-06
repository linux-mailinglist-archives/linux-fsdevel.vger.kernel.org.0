Return-Path: <linux-fsdevel+bounces-28813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFC196E70A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 02:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BDF281DBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 00:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A54171AA;
	Fri,  6 Sep 2024 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SK1HOq5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A7186A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584322; cv=none; b=fvjrgsDMqfuxdWTpHKuMqHyvgthx1qz0sJgE8ZxZQXOa4sY4y46W6yTZZN10hobJ1qUUEARS9Ycz+1TmvmsS31/Xy9KVPcQ1OFZ5S5nEEahMN1eOCidzlnflGMNTyq0FIHB4j8VGJ4l/Vn4Opfcr5JIOWad/SgafNKwmSqvSH4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584322; c=relaxed/simple;
	bh=RHsVs5LvM9MKyy1CMVvIg4EkPWplBMF/INnwtNjyIl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA5rcfRTUM2bV2e23SMji87EiJXHa1BvbgTTRSf5DOpQI2FnWj2Xwx0RIIFhgzQZzYwjCxwBgxPWgcPs2DiA4QrVJoxrQpAJDHtJG2JboYjGvu1+uEDsG1tAL9Q8e20b4JLBZcP6T/jYZ7p0lB6YPu6Dk2YOVogu8om5ORZAbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SK1HOq5C; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 00:58:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725584319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C3b4knYjBVLgkXkDknQoo4+xhSbWx8+d7tm+Hv0EORo=;
	b=SK1HOq5Cap0jyf/OyR6NB5pyeaazzPBqq2Yc3ffWbg7eKRBSKMeDF4NLgvO7cEmCZO5sVs
	d+T0UPxWtx4ZbM7KYjhbKJq56ucgHIpPVepEndmPGJdAHp5pMi996CwKEpfkHXv1CXp7wI
	irMk1ZaWWSfpwfSHhqa3PSLpTq64n54=
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
Subject: Re: [PATCH v4 10/17] slab: port KMEM_CACHE() to struct
 kmem_cache_args
Message-ID: <ZtpTubnvT3YUD1R9@google.com>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-10-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-work-kmem_cache_args-v4-10-ed45d5380679@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 09:56:53AM +0200, Christian Brauner wrote:
> Make KMEM_CACHE() use struct kmem_cache_args.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

