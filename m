Return-Path: <linux-fsdevel+bounces-32791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A8B9AEC94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3F6281E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2A21F8182;
	Thu, 24 Oct 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hHUUl/Xj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716331F669F
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788647; cv=none; b=XrnOEOh2f3PyoozC4AVTjZsmnzz75GwpoVAnxEpr8X+21sn4JrtkGP3soo2if/WTASCUjCX+KPXY1PXsk344jn3ZYL+Amhq5T09xXamSfZ5vumfVUPXIRbPxgLwFUSHEiB+ppnRbt785ZPNXqYqTYUPldZrzZKE9hj507iy0pWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788647; c=relaxed/simple;
	bh=8LW97kAfbQ4wnY8UTapAk7R/Bh5KKCWkT5g5zjjJdkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoWa5J2mtQhYb1PAGmvLVrQPjwk6qugvD41KfZffpBqlVyoUmzGzrAH+xp2y8cLDNByNPZvgaoZn25cgKXHVwXSxC/9oCBxY0e98vfNRls4SmwA5NIUipKOz4ImjX8ETIkzu19r2RIwcobR7y/xAnzAO9u8rBtxNv3EvfayUKA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hHUUl/Xj; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 16:50:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729788643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OC+rwVr1wT6stj+kJdr+t6nKbOeIS1RDCiaPt4dw4F4=;
	b=hHUUl/XjWmDctddsNrqSwB46a1jyGns1+wYTXe8VW/AZGACj8p8H0ey/FKtR6iQoQJjYVa
	tj/AADrNutcaMP17XoSQ8cfDe3BPEfzMrmYzg3+laVNfQcXJYzPs0aWkwWQwprA+E63yWI
	othgLfAS7YsS6px+MTcIOPQ1xQYadGA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
Message-ID: <Zxp63b9WlI4sTwWk@google.com>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065712.1274481-4-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 23, 2024 at 11:57:12PM -0700, Shakeel Butt wrote:
> The memcg v1's charge move feature has been deprecated. There is no need
> to have any locking or protection against the moving charge. Let's
> proceed to remove all the locking code related to charge moving.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

