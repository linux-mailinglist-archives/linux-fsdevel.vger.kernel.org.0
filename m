Return-Path: <linux-fsdevel+bounces-58632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB84B3028B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47F916B61E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C912246BB6;
	Thu, 21 Aug 2025 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QES3rEDO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F9194C86;
	Thu, 21 Aug 2025 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802871; cv=none; b=irQoO38YLqPwZerTOcdNPl55yTSHm+CPXr+IVt5bjlWUg+LEenKPd2KqAThQUi+FEQt8ysKVA+2MXj2ySkJTd2zm4j6HyGxEJ4n1E7SEOCrLCM3XI6PiSpSI9EvE6HDk6pfqo56YVEY+Q/my3qRdz/yLVKtfDNGrnAqv2vfD0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802871; c=relaxed/simple;
	bh=kiYzv+ykBbvja6WLcNzMdnPOi5+QDzOSzNFg2/Lw1p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaZgFYthL/7u3ZsPgluomFJT5h26G5NOLLVZxDZRDJup0Giq6cZJGgOj71FhJ5VQaCfEcjHackQq54PWm/yQnk3Z1sFoYokOUMal2dJtPEAT42f/dvOrcqfywPh7sM4Jod7hNVcho3W3aQZr8o5hoR+yW86mc7ZFhyPjzMBy6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QES3rEDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5FEC4CEF4;
	Thu, 21 Aug 2025 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755802870;
	bh=kiYzv+ykBbvja6WLcNzMdnPOi5+QDzOSzNFg2/Lw1p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QES3rEDO+3c6yUOGupyuUJfdk9b9h8kSq4WuOBkqfPA4BaiOsmfR8Di3TEGSaB3is
	 5jZNJ9pdIJuvkIsdP1nVmGpEmLIaFF49HRMYA7/2zkSaClt2uQgjhRLXxG4x1n/41Z
	 XmBmoIYH+75mRIDahJJqXCm2LXtC9EsNlANX/hdtFtOcaCt2b73FSXPqjuCHJ3KX/U
	 +3ZDjyUAQ1Qw3Um63jwSYF01wvTuT8tT84bIkWhylMzZ332AsbB7lEG5ro6jn/8aTD
	 /G9Dn92fZhTyait9Az/66sK1pBh8vJh6gJaK+irYmREzLUOzB8Rn5ba5sVWtMANotE
	 bOSvoUkC4CJFg==
Date: Thu, 21 Aug 2025 09:01:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, axboe@kernel.dk
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
Message-ID: <aKds9ZMUTC8VztEt@slm.duckdns.org>
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com>
 <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <aKdQgIvZcVCJWMXl@slm.duckdns.org>
 <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>

Hello,

On Fri, Aug 22, 2025 at 02:00:10AM +0800, Julian Sun wrote:
...
> Do you mean logic like this?
> 
>     for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
>         wb_wait_for_completion(&memcg->cgwb_frn[i].done);
>     kfree(memcg);
> 
> But there still exist task hang issues as long as
> wb_wait_for_completion() exists.

Ah, right. I was just thinking about the workqueue being stalled. The
problem is that the wait itself is too long.

> I think the scope of impact of the current changes should be
> manageable. I have checked all the other places where wb_queue_work()
> is called, and their free_done values are all 0, and I also tested
> this patch with the reproducer in [1] with kasan and kmemleak enabled.
> The test result looks fine, so this should not have a significant
> impact.
> What do you think?

My source of reluctance is that it's a peculiar situation where flushing of
a cgroup takes that long due to hard throttling and the self-freeing
mechanism isn't the prettiest thing. Do you think you can do the same thing
through custom waitq wakeup function?

Thanks.

-- 
tejun

