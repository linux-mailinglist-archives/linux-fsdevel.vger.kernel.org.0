Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953B53A71AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 23:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhFNWBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 18:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhFNWBQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:01:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 812B0611AB;
        Mon, 14 Jun 2021 21:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623707952;
        bh=pWkuBglv4mJnySzxhM7bwezoUP6TooTYCM8jj9C/mMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YwSajIk1y4sYoZY1UBFqXv0/yZ/AiCakTI2i2mjtLiUBMYJ3Nx370PZ08rJnPm7iL
         rnjeiU+qqZujCFrnI8IKr47zRkSzzon0gjd3rA8tzgplkkxe+ox7gjb4HPbKJPjzD4
         7p/WfcR9LrREx8ocKOPJeaO+YA9ngbBjiKFSCgYs=
Date:   Mon, 14 Jun 2021 14:59:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-Id: <20210614145912.feb751df928f38476048ec15@linux-foundation.org>
In-Reply-To: <20210614211904.14420-4-hannes@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
        <20210614211904.14420-4-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 14 Jun 2021 17:19:04 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Historically (pre-2.5), the inode shrinker used to reclaim only empty
> inodes and skip over those that still contained page cache. This
> caused problems on highmem hosts: struct inode could put fill lowmem
> zones before the cache was getting reclaimed in the highmem zones.
> 
> To address this, the inode shrinker started to strip page cache to
> facilitate reclaiming lowmem. However, this comes with its own set of
> problems: the shrinkers may drop actively used page cache just because
> the inodes are not currently open or dirty - think working with a
> large git tree. It further doesn't respect cgroup memory protection
> settings and can cause priority inversions between containers.
> 
> Nowadays, the page cache also holds non-resident info for evicted
> cache pages in order to detect refaults. We've come to rely heavily on
> this data inside reclaim for protecting the cache workingset and
> driving swap behavior. We also use it to quantify and report workload
> health through psi. The latter in turn is used for fleet health
> monitoring, as well as driving automated memory sizing of workloads
> and containers, proactive reclaim and memory offloading schemes.
> 
> The consequences of dropping page cache prematurely is that we're
> seeing subtle and not-so-subtle failures in all of the above-mentioned
> scenarios, with the workload generally entering unexpected thrashing
> states while losing the ability to reliably detect it.
> 
> To fix this on non-highmem systems at least, going back to rotating
> inodes on the LRU isn't feasible. We've tried (commit a76cf1a474d7
> ("mm: don't reclaim inodes with many attached pages")) and failed
> (commit 69056ee6a8a3 ("Revert "mm: don't reclaim inodes with many
> attached pages"")). The issue is mostly that shrinker pools attract
> pressure based on their size, and when objects get skipped the
> shrinkers remember this as deferred reclaim work. This accumulates
> excessive pressure on the remaining inodes, and we can quickly eat
> into heavily used ones, or dirty ones that require IO to reclaim, when
> there potentially is plenty of cold, clean cache around still.
> 
> Instead, this patch keeps populated inodes off the inode LRU in the
> first place - just like an open file or dirty state would. An
> otherwise clean and unused inode then gets queued when the last cache
> entry disappears. This solves the problem without reintroducing the
> reclaim issues, and generally is a bit more scalable than having to
> wade through potentially hundreds of thousands of busy inodes.
> 
> Locking is a bit tricky because the locks protecting the inode state
> (i_lock) and the inode LRU (lru_list.lock) don't nest inside the
> irq-safe page cache lock (i_pages.xa_lock). Page cache deletions are
> serialized through i_lock, taken before the i_pages lock, to make sure
> depopulated inodes are queued reliably. Additions may race with
> deletions, but we'll check again in the shrinker. If additions race
> with the shrinker itself, we're protected by the i_lock: if
> find_inode() or iput() win, the shrinker will bail on the elevated
> i_count or I_REFERENCED; if the shrinker wins and goes ahead with the
> inode, it will set I_FREEING and inhibit further igets(), which will
> cause the other side to create a new instance of the inode instead.
> 

And what hitherto unexpected problems will this one cause, sigh.

How exhaustively has this approach been tested?
