Return-Path: <linux-fsdevel+bounces-28818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785D96E71D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 03:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C764E1F22CCA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 01:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0B917BA3;
	Fri,  6 Sep 2024 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y66M6t0x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3214286
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584938; cv=none; b=EfSnQdRkpiDPr4/B+obcW3uI46RR3ORJ9wbOZSPFJ0UPeBZIlprIy1VuAnp7yIeXqfgVdM5yNB2FGRCUkvk+O+ciQ5erRHbGdK+Iw9LwFaN9/qoP73/InKwvaR3X28ZrJWraTvZTRjUIkw1V1K8SeV7aAinI4EMJEbdgBQoYT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584938; c=relaxed/simple;
	bh=UWYQluc6cUD18s4fU4rR2r1PssywkaXdDefiIw13eDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FANcqi48578B/Zf74j8KDZ04wZVoga9VNXWAQKhUOOyplyqK4x2RTpVIedAIGkXryVCeIC9SQB63aoeUj2YL8yBl5PX2Il8iAae+YUJZ1IXn/6gRFDAh75R3xgKj1bSqbQPxJCMw00TFbAu2aLRdDO4c3JGm9ExrwVHKlT18g00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y66M6t0x; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 01:08:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725584935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PW6f1LNDbRBU5QsQyoEwe8fXvSobZ9LwGQ3ITLK8m8s=;
	b=Y66M6t0xcdYULGnjjfoNFAXpNmZK0+yhkH0NyxmOIIznfYRith48bp8IgBqlbtM+aPSOs+
	QDS8dOIDHhCTNx3mB/YKBTneU2wwo5EtK+XoA2iZ0tW8clw5dPVQYdFT6mAT40HAiKe1hx
	6qE6Ple7w8xcZqfyIhrbOSfc05LVYuk=
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
Subject: Re: [PATCH v4 15/17] slab: make kmem_cache_create_usercopy() static
 inline
Message-ID: <ZtpWHMWLAB8jOXdu@google.com>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-15-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-work-kmem_cache_args-v4-15-ed45d5380679@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 09:56:58AM +0200, Christian Brauner wrote:
> Make kmem_cache_create_usercopy() a static inline function.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

