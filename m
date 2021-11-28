Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BBC460602
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Nov 2021 13:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357330AbhK1MD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Nov 2021 07:03:56 -0500
Received: from shark4.inbox.lv ([194.152.32.84]:32818 "EHLO shark4.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357360AbhK1MBz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Nov 2021 07:01:55 -0500
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id A3A42C008C;
        Sun, 28 Nov 2021 13:58:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638100711; bh=dEctK94YixwRqHyBW6ErQeBzCnjwBwzYFVw8iMyoARc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=LXuq/rFNl9fOWw4/p6voFwpdyc35JnqMsSXEdXMzBeWuSWtIXF7C2DPjBB0m9Yu6b
         wGYvLRie7tP9n8kZGB3WGGUYYvPoa0lPZMBxgHf+y20k0nS6ckEW+GKmBv0UPmJGyQ
         rwWW20hZ4Ojb4SzqOwzKwLQWpqRWT+ZMaqEm1aSU=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 97EA5C007C;
        Sun, 28 Nov 2021 13:58:31 +0200 (EET)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id FDZJno_ILohd; Sun, 28 Nov 2021 13:58:31 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 22D53C0078;
        Sun, 28 Nov 2021 13:58:31 +0200 (EET)
Date:   Sun, 28 Nov 2021 20:58:05 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211128205805.466bf311@mail.inbox.lv>
In-Reply-To: <252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
        <20211127011246.7a8ac7b8@mail.inbox.lv>
        <20211126165211.GL3366@techsingularity.net>
        <20211128042635.543a2d04@mail.inbox.lv>
        <252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: AJ2EQ38cmnBBsMa9LpgOlO7lx8rAJVdB2DuJsLBwtjJFz9PMtNdrcW+QBYXuHxy7cWTD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I tested this patch [1] on top of the 2nd Mel's patch [2].

Test case:
Running firefox with youtube tab (basic desktop workload) and starting
$ for i in {1..10}; do tail /dev/zero; done
-- 1. with noswap and 2. with SwapTotal > MemTotal and swappiness=0.


- With noswap

2021-11-28 20:13:18,755: Stall times for the last 296.0s:
2021-11-28 20:13:18,755: -----------
2021-11-28 20:13:18,755: some cpu     8.6s, avg 2.9%
2021-11-28 20:13:18,755: -----------
2021-11-28 20:13:18,755: some io      253.7s, avg 85.7%
2021-11-28 20:13:18,755: full io      228.9s, avg 77.3%
2021-11-28 20:13:18,755: -----------
2021-11-28 20:13:18,755: some memory  135.1s, avg 45.7%
2021-11-28 20:13:18,755: full memory  134.3s, avg 45.4%

mem:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch4/noswap/mem

psi:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch4/noswap/psi


- With swappiness=0

2021-11-28 20:29:35,229: Stall times for the last 257.9s:
2021-11-28 20:29:35,229: -----------
2021-11-28 20:29:35,229: some cpu     7.7s, avg 3.0%
2021-11-28 20:29:35,229: -----------
2021-11-28 20:29:35,229: some io      223.1s, avg 86.5%
2021-11-28 20:29:35,230: full io      196.2s, avg 76.1%
2021-11-28 20:29:35,230: -----------
2021-11-28 20:29:35,230: some memory  170.8s, avg 66.2%
2021-11-28 20:29:35,230: full memory  167.9s, avg 65.1%

mem:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch4/swappiness0/mem

psi:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch4/swappiness0/psi


There are still some freezes, although in some cases there are no significant stalls. 

13-17s average stall vs 0.4s with 5.15

[1] https://lore.kernel.org/lkml/252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de/
[2] https://lore.kernel.org/lkml/20211124143303.GH3366@techsingularity.net/
