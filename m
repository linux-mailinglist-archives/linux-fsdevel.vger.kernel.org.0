Return-Path: <linux-fsdevel+bounces-32811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6C99AEDE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065171F24C89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B31FC7CA;
	Thu, 24 Oct 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UuKber85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016521F80CC
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790643; cv=none; b=fGcHfDjBvnM/ZINHZk/5oRr/D6Y82AeEoTfTsGKnQOQM6yd72UYxg2JaO/OJGd4noxqEYvNLY/G27nHjjNZEoRXbj6jf0AFfCxyQnxP/ejSTKsIZ+Yh/MSxsZlJ0WZuhKD87y4zIUQqHq22G1mD7Y7TU4L275G8bmeMVH28LDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790643; c=relaxed/simple;
	bh=yazdF8DdqiUPcOFQKwHytvczCwtC7cFyM0Z8v2bzmH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8++Lu07453EIfeTtCwPGgByopkO6WHcDFbeZX76g7tIJ/SBhT0y35G+w281TV8tX8ICSt9rJdLiYgCfPsjITEHOxZYS8T9duijn9SZoxXPZRsQRB7CcK5cq4W/6Xq6LzZsa7yzpC2xESsAW79E+dznpmlZNY1aLmOf+u45vtBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UuKber85; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 10:23:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729790637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h74CK0tiJYaE5TPqN+PPqGm7CGDGWVsPWLsQQbpuBDU=;
	b=UuKber85VwkZSQ0uYPSblgX0oKvL+orCwOdqfT1aRfWqgUsDFo3tklI+QJNJQ/vFfCHKQd
	+ze9dP5ollYhnfKhRW8PwsStYGU8u9doQsOdbpoXT2+9oujfxZAIg+fZza76g3egQE5GkP
	bDTQCy3b/bn/jX4m8oRvMGrYQwi8S7I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
Message-ID: <kr6fjny7aqni4habduj2uqfznusozkku3xeq62bjscb5ovwxog@ccgl3kxufmma>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev>
 <ZxoQhEPXmSkM7sH_@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxoQhEPXmSkM7sH_@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 11:16:52AM GMT, Michal Hocko wrote:
> On Wed 23-10-24 23:57:12, Shakeel Butt wrote:
> > The memcg v1's charge move feature has been deprecated. There is no need
> > to have any locking or protection against the moving charge. Let's
> > proceed to remove all the locking code related to charge moving.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> > -/**
> > - * folio_memcg_lock - Bind a folio to its memcg.
> > - * @folio: The folio.
> > - *
> > - * This function prevents unlocked LRU folios from being moved to
> > - * another cgroup.
> > - *
> > - * It ensures lifetime of the bound memcg.  The caller is responsible
> > - * for the lifetime of the folio.
> > - */
> > -void folio_memcg_lock(struct folio *folio)
> > -{
> > -	struct mem_cgroup *memcg;
> > -	unsigned long flags;
> > -
> > -	/*
> > -	 * The RCU lock is held throughout the transaction.  The fast
> > -	 * path can get away without acquiring the memcg->move_lock
> > -	 * because page moving starts with an RCU grace period.
> > -         */
> > -	rcu_read_lock();
> 
> Is it safe to remove the implicit RCU?

Good question. I think it will be safe to keep the RCU in this patch and
in the followup examine each place and decide to remove RCU or not.

Thanks for the review.

