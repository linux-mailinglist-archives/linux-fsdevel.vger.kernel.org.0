Return-Path: <linux-fsdevel+bounces-73853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B200D21E3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 01:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C643028DAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 00:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A28D1D8E01;
	Thu, 15 Jan 2026 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="e0i1+i/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF81C5486;
	Thu, 15 Jan 2026 00:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437974; cv=none; b=scZNKvA6ET5r0h46ntcEXjxJAJGQOajL/qEAw8a7ty+tO5tw0QY2ys8s9aB/9dxwi6+X2EgFClFrKp60W9d6YaZiUNa96FPwsszuHBkof6VgQONFiIc50jIjzjZ1W9Kd8utI45lF0yDpwccpwZJXSvBtlRsCOPAti0BhGs2TDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437974; c=relaxed/simple;
	bh=W3U4m/oqLfESSPENXjy5hyjsmBe+zWiBlc3RcXGMd8g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hfBl9J3CJyPUizM0OrSwJBhT19KVghZ/8akEWF0NrtjGayzrVrP18IYOcfdwb9SWreJFp4F10u77KPNkxHigTjm1REKnD++CxMx7s3mmGZsq6pNHLcesjzWQRtFTEfyXoRo0UoE+OtPptJtgtsxfvk9PWpSrbtTLvqiDp3iIWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=e0i1+i/u; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1768437964;
	bh=W3U4m/oqLfESSPENXjy5hyjsmBe+zWiBlc3RcXGMd8g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=e0i1+i/uEUncxqqlVSxjtdOjgwzzxD//BL1vgaxa3bbLJeDye+Jw/ZF8D8QoQZDX0
	 GzvRBOnBk+STTOemYCD/Y5tbKJXDRwJJ+hEFOfd7v0UuXGWvJcwmcCyGTAWGPMB2Km
	 HX1TVWsrVBTLVE5/+B3DyWd6WlR+LcVZmjfgCaug=
Received: by gentwo.org (Postfix, from userid 1003)
	id 6DDBF402BD; Wed, 14 Jan 2026 16:46:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 6B4EA401F6;
	Wed, 14 Jan 2026 16:46:04 -0800 (PST)
Date: Wed, 14 Jan 2026 16:46:04 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Al Viro <viro@zeniv.linux.org.uk>
cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
    Harry Yoo <harry.yoo@oracle.com>, linux-fsdevel@vger.kernel.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Mateusz Guzik <mguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] kmem_cache instances with static storage
 duration
In-Reply-To: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
Message-ID: <0727b5a1-078f-0055-fc52-61b80bc5d59e@gentwo.org>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 10 Jan 2026, Al Viro wrote:

> 1) as it is, struct kmem_cache is opaque for anything outside of a few
> files in mm/*; that avoids serious headache with header dependencies,
> etc., and it's not something we want to lose.  Solution: struct
> kmem_cache_opaque, with the size and alignment identical to struct
> kmem_cache.  Calculation of size and alignment can be done via the same
> mechanism we use for asm-offsets.h and rq-offsets.h, with build-time
> check for mismatches.  With that done, we get an opaque type defined in
> linux/slab-static.h that can be used for declaring those caches.
> In linux/slab.h we add a forward declaration of kmem_cache_opaque +
> helper (to_kmem_cache()) converting a pointer to kmem_cache_opaque
> into pointer to kmem_cache.

Hmmm. A new kernel infrastructure feature: Opaque objects

Would that an deserve a separate abstraction so it is usable by other
subsystems?


