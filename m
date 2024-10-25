Return-Path: <linux-fsdevel+bounces-32915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBDD9B0BDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F77A1C25D3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A8741C69;
	Fri, 25 Oct 2024 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t9x9nvfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6AD20C318
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878061; cv=none; b=ueiJ2cGchx/kxH3H4DFOH4ODDwHGKm+w2nscBBtYdUwGYxSEw9BpRHQuKT+AMRChYiEz+MYKd8AE6b4YFlN+2UAgkny2d9R78ZGx8gbvw2+rcMtdXhVWgr2+e4eSdkJxmxHm/Iog+n2FTk6no4/0c0jXMPJjbT5TbDej/baIVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878061; c=relaxed/simple;
	bh=24CjPZINRTGk7V+Gz5saXuLBscalIJDDVpgZyPi6DQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5s3i1rSM7fcfMUlFLwdoR1GM57LdykKs4Jae3xhyIY92afbV2mX5BM7ufwXkNRBYWnY8Nwwnik7BXcc0mJU7zjgFMX7rmWpYAPyS6ao9Y/8aVbbbvxBPSt/ZsO/G6omPZyY8EPp+FMI3qTOAu13Rrhs8LIdMygvJtY0o/e2Kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t9x9nvfx; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 17:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729878058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZZi0QQzXVADJVHeSO90RuV4/Uz17msU1AAdrvd9myA=;
	b=t9x9nvfxObepocqu22ZGalnaw5WyowMFOnhdtW95javKxOw2rn1LId+pNkikqCUPI6owI6
	AOCgkE3E2sK+bgLi8IQ9dCAYNERchWN723IaCv4CscWeyZIssFz5ILV+0PT19Qq/SWhK+m
	6NEJ30lUtccs+x1Lar6YtgdwuvLNksk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 4/6] memcg-v1: no need for memcg locking for writeback
 tracking
Message-ID: <ZxvYIxE3wB7FyFCW@google.com>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-5-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-5-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 06:23:01PM -0700, Shakeel Butt wrote:
> During the era of memcg charge migration, the kernel has to be make sure
> that the writeback stat updates do not race with the charge migration.
> Otherwise it might update the writeback stats of the wrong memcg. Now
> with the memcg charge migration deprecated, there is no more race for
> writeback stat updates and the previous locking can be removed.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

