Return-Path: <linux-fsdevel+bounces-28809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E2996E6F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 02:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E4E286DFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 00:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5E16415;
	Fri,  6 Sep 2024 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ya9w8NTD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50515DDC3
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725583929; cv=none; b=CEbRb3Bm6bwxZRXET7AGuTpQjY+mi6ALSrJSOQ7mP+LlwT2xbEKO8pjUOE6KnRS73BjMK99lkFrO55T9o7GGwWUNkn+UgJrfVccFcrYvT3M+mRIieFpdgny2BKYhv59CdLj8r6VLe9n3NGtaFArvynM14WIF6vUMjSBzG6iQ2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725583929; c=relaxed/simple;
	bh=DCDuqnN5PjEMn+i8Edk4Sm30fSE/MBwJ0hVSX8qsyUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcseciLtLa2wetoktjqM1wEqRdoVPn/Ot5yMDfxXHqmZfp73XhVSxseyssqFMGKmdnBEIhtovkRiPYxF4RnkSb8yyea5VdvSrmaQznaz+4TBzNpEvTmX93K5kN+iuQTzoGXknvVNIDIOMMAXJsinQFRrFJoq3Szq+a3rB7prQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ya9w8NTD; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 00:51:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725583923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+XaaNNpdPqhc169CZVU1D74bGGJ0f2/CiovzuI43hw=;
	b=Ya9w8NTDl0WsSO2lC7Aq0bqVfYrlKpn0dN6gy7YlHt3Kf9O50QyZjw76KgXBr2nyEWrTrP
	cC+xSlz80b2ILVwp+kHgJIcTylWVpdUj2nEiRqzK1NE09RS0iPqTQ0IYHIon8oWc+mS0kl
	QTPJ8yTT6uxiXzHEktIf1uB7rqtNTyo=
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
Subject: Re: [PATCH v4 06/17] slab: pass struct kmem_cache_args to
 create_cache()
Message-ID: <ZtpSLYPwrQk3F7Hc@google.com>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-6-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-work-kmem_cache_args-v4-6-ed45d5380679@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 09:56:49AM +0200, Christian Brauner wrote:
> Pass struct kmem_cache_args to create_cache() so that we can later
> simplify further helpers.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

