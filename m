Return-Path: <linux-fsdevel+bounces-10626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD49A84CE6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 16:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDF61F26DA9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3958060E;
	Wed,  7 Feb 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4roDxo8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369E7FBD9;
	Wed,  7 Feb 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321125; cv=none; b=rzwMcSxkdI+S6o7jSrlyGaRsuUGKS+LIRyTghzFY5ueqVs2BWzoiDv/OdiIiYonA7dFyyWo5dvsf2kESW3B5ZGfmM/iGZh84/wZS/lU1ajEedyWdWnzlxWppNXIUW3QO20I1C5EUJnSYvvbcWF0TKiKSnC/c1BzJbHXLeEszP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321125; c=relaxed/simple;
	bh=/1x7h2DpHjWcd/k76A8g5THiTurxMbwv+SYlEW+93sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6hng+cGwy959ErJkpp6V5JzKjivlCDbLsPZ4feC9upV8jiSDOZlxwE8ClUV9Zj7zNhF14PwfG3SOHaDr/hg3vsuxuZgI5RKUDKlRN9/O3/VErZ1PpqJ8sboLE9DzqFKfRCRS7BB8MdDX8QLurUbfXGD1mPn87+HQH2sz3QxcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4roDxo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9B4C43394;
	Wed,  7 Feb 2024 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707321123;
	bh=/1x7h2DpHjWcd/k76A8g5THiTurxMbwv+SYlEW+93sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4roDxo8tVqC2GezTlb3cfXFcp6weQcwLaiGZmdf1pdhhuOhtMsuGhDXsDCMV8GbO
	 RLxAo3vtpqHJdWUBeO1ZdBUc+YJEiBqPKnzeW10gKgdzx5yAj262qNEjatFr2oewA5
	 U96gkG8+cuJWYr/hLXC31VNHfddrz7/y70HWgLAxw3ppS44aI4YAdO6JffVBmwOlG8
	 XU9HW6HuV+8zPXv4xQ3gBEg6Ps5noXk7cufMK2v4qV4yePWova47vaD8FNN7s7EdTb
	 NB9oCYbsmwivsZGgDOIpD/iQoZTqpkGenaDhqgpVnREaQgX0b1oUD9pyX7pTlppedD
	 uLYLbPbnYYeQg==
Date: Wed, 7 Feb 2024 17:51:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <ZcOnEGyr6y3jei68@kernel.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
 <Zb9pZTmyb0lPMQs8@kernel.org>
 <ZcACya-MJr_fNRSH@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcACya-MJr_fNRSH@casper.infradead.org>

On Sun, Feb 04, 2024 at 09:34:01PM +0000, Matthew Wilcox wrote:
> On Sun, Feb 04, 2024 at 11:39:33AM +0100, Mike Rapoport wrote:
> > On Mon, Jan 29, 2024 at 04:32:03AM +0000, Matthew Wilcox wrote:
> > > Our documentation of the current page flags is ... not great.  I think
> > > I can improve it for the page cache side of things; I understand the
> > > meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
> > > mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
> > > has_hwpoisoned, hugetlb and large_remappable.
> > > 
> > > Where I'm a lot more shaky is the meaning of the more "real MM" flags,
> > > like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
> > > unevictable, young, idle, swapcache, isolated, and reported.
> > > 
> > > Perhaps we could have an MM session where we try to explain slowly and
> > > carefully to each other what all these flags actually mean, talk about
> > > what combinations of them make sense, how we might eliminate some of
> > > them to make more space in the flags word, and what all this looks like
> > > in a memdesc world.
> > > 
> > > And maybe we can get some documentation written about it!  Not trying
> > > to nerd snipe Jon into attending this session, but if he did ...
> > 
> > I suspect Jon will be there anyway, but not sure he'd be willing to do the
> > writing :)
> > 
> > I was going to propose the "mm docs" session again, but this one seems more
> > useful than talking yet again about how hard it is to get MM documentation
> > done.
> 
> I'm doing my best to write documentation as I go.  I think we're a bit
> better off than we were last year.  Do we have scripts to tell us which
> public functions (ie EXPORT_SYMBOL and static inline functions in header
> files) have kernel-doc?  And could we run them against kernels from, say,
> April 2023, 2022, 2021, 2020, 2019 (and in two months against April 2024)
> and see how we're doing in terms of percentage undocumented functions?

We didn't have such script, but it was easy to compare "grep
EXPORT_SYMBOL\|static inline" with ".. c:function" in kernel-doc.
We do improve slowly, but we are still below 50% with kernel-doc for
EXPORT_SYMBOL functions and slightly above 10% for static inlines.

Although with static inlines it's quite possible that the percentage of
actual public API documentation is higher because some of the functions in
inlcude/linux/ are only used inside mm.

There are also APIs that are not EXPORT_SYMBOL, but I didn't find an easy
way to check how well there are documented.

EXPORT_SYMBOL
version     	funcs	docs	percent
v5.0        	514	177	34
v5.6        	538	208	38
v5.12       	550	209	38
v5.17       	580	228	39
v6.3        	580	235	40
v6.8-rc1    	565	238	42

static inline
version     	funcs	docs	percent
v5.0        	581	33	5
v5.6        	596	41	6
v5.12       	629	42	6
v5.17       	746	74	9
v6.3        	867	95	10
v6.8-rc1    	944	116	12

 
> There's also the problem of getting long-form documentation done.
> But I think that's a different problem from getting kernel-doc written.
> Looking at the 55 commits in the last year to Documentation/mm, we seems
> to be doing a pretty good job of keeping the documentation we have up
> to date.  Just not a great job of adding new documentation.

I agree that long-form documentation is a different problem from getting
kernel-doc written and we are not doing a great job in writing new
documentation.

-- 
Sincerely yours,
Mike.

