Return-Path: <linux-fsdevel+bounces-28814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DB196E70F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 03:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC66286A29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 01:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E99171AA;
	Fri,  6 Sep 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hg6xrx/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7C186A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584438; cv=none; b=ryhx0smf10JlZrDJse7CHKdW0hHoVfIbFtFchiHxSfsIjiI6THsDh1+k8QBYmi6T0tQmwzrRO93xiptNNIwQXp3W1IVJE1DCgs3cPxnednGWuqSQKOuy1dVen/7w+ytybyGvleVhxRv1hQVx4hK0GXM+O1rfd7n4jSfRIelQldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584438; c=relaxed/simple;
	bh=xBmSValBY5fRTAcvAz1IOMdqdolDLY6qt7+vyaYITz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3QD0xRcXZZz7PBaQtEthiajLwNIqWdjMCChVaEpJ6XYwFl7iBCHyJf9UBfCtOaAz0YZ3udCn+GXntg7OESctgROvycA0YZ7cOkxNPcyvSPzDch0YFCSF8ApQcW5YfrBU8IMtkholNzTt/AJGAukwHXtpv/E7MyLWD3tOv4Kyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hg6xrx/Y; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 01:00:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725584434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCJNkPnpE8qBBh01qgUqgPDWV/Y18hFGULXcmoLLElM=;
	b=hg6xrx/YarefXCRgixznWZPFkyFEW6snhNqlO2cM2yValbXuphqxYL/KRSaT2lLR5fT3C8
	eINPgrNbYFWDXUowSpLKNcyGNc4uNqBvP5E12Ky4/EVXVkQXq3/IjkS3vq9AKJBOMtU9L1
	ECGTlgWxBTP0OUOpdTL4ExuWknoFXlM=
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
Subject: Re: [PATCH v4 11/17] slab: port KMEM_CACHE_USERCOPY() to struct
 kmem_cache_args
Message-ID: <ZtpULHHGM3ATqi_R@google.com>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
 <20240905-work-kmem_cache_args-v4-11-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-work-kmem_cache_args-v4-11-ed45d5380679@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 09:56:54AM +0200, Christian Brauner wrote:
> Make KMEM_CACHE_USERCOPY() use struct kmem_cache_args.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>


