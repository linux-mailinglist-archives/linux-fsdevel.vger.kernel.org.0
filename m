Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DDB3A722C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 00:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhFNWoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 18:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhFNWoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:44:11 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82226C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 15:41:52 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id x6so16442493qvx.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Ln8aa8N4NkXgGmfhKmW+YOk+ZQP4J2F53dGDWutRYI=;
        b=BTvt9AQQnZeMgoi8kZ+rpU61FQu7oIAu4pBLZ5r/GsD6sENIQpoQzs+ndGR/K6WAKZ
         qHJImr2H1AtdDSzcc3TZtyfTdpq0bes1JARrugpd/KUJ2tWxjQ1V9vreICAV7fx2X1u6
         aRtfU7IuQhAFCv/u//PANv7OV5J2vzkmCgpOZxzIoiaSVZhraKLWOetn+z2Hih5c4hPG
         dkkrTLKYMAjTsdIy0kLLlJxrp0uro8qMDl6F6G0rt5LnyUDFv2ar8khX9bBW95y8dObH
         Wl9LkCA9kwiCVTZuNqJ3M0iSrlHQcvNu8MNjaj1IN2RUZ0usAHbZY4QY8Z/n3TO1P0QG
         vd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Ln8aa8N4NkXgGmfhKmW+YOk+ZQP4J2F53dGDWutRYI=;
        b=qOa91uCrHNDkEE2Id70am71geIPfUWgos7FLrQX3LZAZHKPShCfoCekUscr0vKdwwR
         wNSgqJVRBX6ID4sSE9l95ig+Xs0s3rNRTxPGSj7WGDPsmuR/6Ud81h7BmkiNkT6EET3p
         aRm1V0htHvcMV0ouFdG1nQYogAUz6K4q+W+x1OCZrUlYKP8zLX7E5RMPIH+RePa+J/po
         q8mGZ6n+ExvF9S966jtXSD4bcbLJFnVzXBqkLfIAirUYzsEuiPp9HbB5a3/dBIvCgXuK
         WKUGNuUBD1AmpXV91AGy65wv2d6iyu6xk7TG3NX/x+TtJRDsXpXCVVAj7Z2ZizNyXnMJ
         /NCw==
X-Gm-Message-State: AOAM532W2JFT6+clpaJ6tQIBwZglEu+0qyIIthfBDaJyGYffwfCmKIzb
        BjUXVweA+dqxMMBNyLR0ujS2ww==
X-Google-Smtp-Source: ABdhPJyWQrrXQUjJrZcR1DdcwITE7ckgVpPOl79Nc9WscxBEYiYeedtKgqsg2s8LjpIEFtocJ72oSQ==
X-Received: by 2002:ad4:5042:: with SMTP id m2mr315121qvq.29.1623710510887;
        Mon, 14 Jun 2021 15:41:50 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id g1sm1518745qkd.125.2021.06.14.15.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 15:41:50 -0700 (PDT)
Date:   Mon, 14 Jun 2021 18:41:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-ID: <YMfbLQvB+tHk9vAE@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-4-hannes@cmpxchg.org>
 <20210614145912.feb751df928f38476048ec15@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614145912.feb751df928f38476048ec15@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 02:59:12PM -0700, Andrew Morton wrote:
> On Mon, 14 Jun 2021 17:19:04 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > Historically (pre-2.5), the inode shrinker used to reclaim only empty
> > inodes and skip over those that still contained page cache. This
> > caused problems on highmem hosts: struct inode could put fill lowmem
> > zones before the cache was getting reclaimed in the highmem zones.
> > 
> > To address this, the inode shrinker started to strip page cache to
> > facilitate reclaiming lowmem. However, this comes with its own set of
> > problems: the shrinkers may drop actively used page cache just because
> > the inodes are not currently open or dirty - think working with a
> > large git tree. It further doesn't respect cgroup memory protection
> > settings and can cause priority inversions between containers.
> > 
> > Nowadays, the page cache also holds non-resident info for evicted
> > cache pages in order to detect refaults. We've come to rely heavily on
> > this data inside reclaim for protecting the cache workingset and
> > driving swap behavior. We also use it to quantify and report workload
> > health through psi. The latter in turn is used for fleet health
> > monitoring, as well as driving automated memory sizing of workloads
> > and containers, proactive reclaim and memory offloading schemes.
> > 
> > The consequences of dropping page cache prematurely is that we're
> > seeing subtle and not-so-subtle failures in all of the above-mentioned
> > scenarios, with the workload generally entering unexpected thrashing
> > states while losing the ability to reliably detect it.
> > 
> > To fix this on non-highmem systems at least, going back to rotating
> > inodes on the LRU isn't feasible. We've tried (commit a76cf1a474d7
> > ("mm: don't reclaim inodes with many attached pages")) and failed
> > (commit 69056ee6a8a3 ("Revert "mm: don't reclaim inodes with many
> > attached pages"")). The issue is mostly that shrinker pools attract
> > pressure based on their size, and when objects get skipped the
> > shrinkers remember this as deferred reclaim work. This accumulates
> > excessive pressure on the remaining inodes, and we can quickly eat
> > into heavily used ones, or dirty ones that require IO to reclaim, when
> > there potentially is plenty of cold, clean cache around still.
> > 
> > Instead, this patch keeps populated inodes off the inode LRU in the
> > first place - just like an open file or dirty state would. An
> > otherwise clean and unused inode then gets queued when the last cache
> > entry disappears. This solves the problem without reintroducing the
> > reclaim issues, and generally is a bit more scalable than having to
> > wade through potentially hundreds of thousands of busy inodes.
> > 
> > Locking is a bit tricky because the locks protecting the inode state
> > (i_lock) and the inode LRU (lru_list.lock) don't nest inside the
> > irq-safe page cache lock (i_pages.xa_lock). Page cache deletions are
> > serialized through i_lock, taken before the i_pages lock, to make sure
> > depopulated inodes are queued reliably. Additions may race with
> > deletions, but we'll check again in the shrinker. If additions race
> > with the shrinker itself, we're protected by the i_lock: if
> > find_inode() or iput() win, the shrinker will bail on the elevated
> > i_count or I_REFERENCED; if the shrinker wins and goes ahead with the
> > inode, it will set I_FREEING and inhibit further igets(), which will
> > cause the other side to create a new instance of the inode instead.
> > 
> 
> And what hitherto unexpected problems will this one cause, sigh.

Yeah, I wish we could have stuck with simple rotations, but I can see
how they can become problematic - even though we haven't been able to
reproduce the issue which led to the revert in the FB fleet.

> How exhaustively has this approach been tested?

This specific patch I've put through various inode / cache loads on my
local test rig, drgn-inspected the sb inode lists to check for leaked
inodes etc. - they've held up.

We've had the previous version (which was more complicated) running on
the entire Facebook fleet for a while. I did switch us back to simple
rotations in a recent rebase, though, because the one-liner is easier
to carry out of tree and (luckily) isn't causing problems for us.

It would be good to have a fix upstream that works for everybody,
though. The above-mentioned containerization and pressure detection
failures aren't theoretical, we can't run upstream in our fleet.

We're also trying to publish containerization software that showcases
how the different cgroup controllers play together, how automated
container sizing works etc, but many of those scenarios are broken in
the upstream kernel. A kernel patch dependency is a painful one for a
project like this. Tejun can probably provide more context on this.
