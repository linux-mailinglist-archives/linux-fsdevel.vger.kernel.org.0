Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4711D46629A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 12:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbhLBLqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 06:46:06 -0500
Received: from shark3.inbox.lv ([194.152.32.83]:59234 "EHLO shark3.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhLBLqF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:46:05 -0500
Received: from shark3.inbox.lv (localhost [127.0.0.1])
        by shark3-out.inbox.lv (Postfix) with ESMTP id D8C1928018B;
        Thu,  2 Dec 2021 13:42:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638445360; bh=+DYJizioDSO1dPTiu99sjHEIJzVctfeLaL1SpPgZ0pg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=iEhwSn2w1nhBlspKxi/JnWfZG+VnkR3eHwY6hpq6sIrUjsTH086ECsivcFzexVbMJ
         em8TjTF8f78vXrRo95dJ1ttSgUQcV5tJ95BC73SUat5T1pQvl/LWWO2h5cWCgWE4Fr
         LKlcrmGBaEN0yNC7QX03K/jA4SQKu3JE7Z8wwgqM=
Received: from localhost (localhost [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id D1D64280124;
        Thu,  2 Dec 2021 13:42:40 +0200 (EET)
Received: from shark3.inbox.lv ([127.0.0.1])
        by localhost (shark3.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 9UajyLpnH5Zd; Thu,  2 Dec 2021 13:42:40 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id 727CB28010E;
        Thu,  2 Dec 2021 13:42:40 +0200 (EET)
Date:   Thu, 2 Dec 2021 20:42:29 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211202204229.5ed83f31@mail.inbox.lv>
In-Reply-To: <20211201140005.GU3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
        <20211127011246.7a8ac7b8@mail.inbox.lv>
        <20211129150117.GO3366@techsingularity.net>
        <20211201010348.31e99637@mail.inbox.lv>
        <20211130172754.GS3366@techsingularity.net>
        <20211201033836.4382a474@mail.inbox.lv>
        <20211201140005.GU3366@techsingularity.net>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: AJ2EQ38cmnBBsMa9LpgflO6Go8rKNlcktDn7zrgu6HdfqLDFr7wGfW6UB/eRFELmMn8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I tested this [1] patch on top of 5.16-rc2, the same tests.

- with noswap:

2021-12-02 19:41:19,279: Stall times for the last 146.5s:
2021-12-02 19:41:19,279: -----------
2021-12-02 19:41:19,279: some cpu     1.1s, avg 0.8%
2021-12-02 19:41:19,279: -----------
2021-12-02 19:41:19,279: some io      116.2s, avg 79.3%
2021-12-02 19:41:19,280: full io      109.6s, avg 74.8%
2021-12-02 19:41:19,280: -----------
2021-12-02 19:41:19,280: some memory  3.9s, avg 2.6%
2021-12-02 19:41:19,280: full memory  3.8s, avg 2.6%

Excellent!

psi log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch6/noswap/psi

mem log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch6/noswap/mem

- with swappiness=0

2021-12-02 19:46:04,860: Stall times for the last 144.5s:
2021-12-02 19:46:04,860: -----------
2021-12-02 19:46:04,860: some cpu     1.1s, avg 0.8%
2021-12-02 19:46:04,860: -----------
2021-12-02 19:46:04,860: some io      106.9s, avg 74.0%
2021-12-02 19:46:04,861: full io      101.3s, avg 70.1%
2021-12-02 19:46:04,861: -----------
2021-12-02 19:46:04,861: some memory  99.6s, avg 68.9%
2021-12-02 19:46:04,861: full memory  95.6s, avg 66.2%

PSI mem pressure was high, but there were no long stalls.

psi log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch6/swappiness0/psi

mem log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch6/swappiness0/mem

[1] https://lore.kernel.org/all/20211201140005.GU3366@techsingularity.net/
