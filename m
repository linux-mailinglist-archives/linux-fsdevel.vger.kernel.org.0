Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF56463AEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbhK3QHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 11:07:20 -0500
Received: from shark4.inbox.lv ([194.152.32.84]:40650 "EHLO shark4.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237958AbhK3QHU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:07:20 -0500
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id 0B852C01B9;
        Tue, 30 Nov 2021 18:04:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638288240; bh=MaBmrbP8dDC347/MJhlAP6RXqkK7vpRItGnOjqKVKMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=NHNGWgWsZJ0U++0xL+tMHjxROjFFZ/sdn4qopEIzHxDtyrUFP4nkbPUkdk0PGvmPU
         bbAtMtPxn6lE1RTAMHf7rcZHmk13R+Aw042Wb5lv5NJS6683c6bFAjfWHKYiaCpqau
         +C6ATRtiK7Z8iF+gG+/sd2Jqghb6wZPHk6t3bfd8=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id F33CCC01A8;
        Tue, 30 Nov 2021 18:03:59 +0200 (EET)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id wR-tlqMNy4Vw; Tue, 30 Nov 2021 18:03:59 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 76F78C018F;
        Tue, 30 Nov 2021 18:03:59 +0200 (EET)
Date:   Wed, 1 Dec 2021 01:03:48 +0900
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
Message-ID: <20211201010348.31e99637@mail.inbox.lv>
In-Reply-To: <20211129150117.GO3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
        <20211127011246.7a8ac7b8@mail.inbox.lv>
        <20211129150117.GO3366@techsingularity.net>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: G4mERXADmHlDpsG9Ippu5OH4tai+FgVjoUWJw7wx9RAtu7LHst18d2eTGIHzanG0EAbD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I tested this [1] patch on top of 5.16-rc2. It's the same test with 10 tails.

- with noswap

Summary:

2021-11-30 23:32:36,890: Stall times for the last 548.6s:
2021-11-30 23:32:36,890: -----------
2021-11-30 23:32:36,891: some cpu     3.7s, avg 0.7%
2021-11-30 23:32:36,891: -----------
2021-11-30 23:32:36,891: some io      187.6s, avg 34.2%
2021-11-30 23:32:36,891: full io      178.3s, avg 32.5%
2021-11-30 23:32:36,891: -----------
2021-11-30 23:32:36,892: some memory  392.2s, avg 71.5%
2021-11-30 23:32:36,892: full memory  390.7s, avg 71.2%

full psi:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch5/noswap/psi

mem:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch5/noswap/mem

- with swappiness=0

Summary:

2021-11-30 23:51:48,969: Stall times for the last 919.4s:
2021-11-30 23:51:48,969: -----------
2021-11-30 23:51:48,969: some cpu     5.5s, avg 0.6%
2021-11-30 23:51:48,970: -----------
2021-11-30 23:51:48,970: some io      240.4s, avg 26.2%
2021-11-30 23:51:48,970: full io      230.6s, avg 25.1%
2021-11-30 23:51:48,970: -----------
2021-11-30 23:51:48,970: some memory  806.1s, avg 87.7%
2021-11-30 23:51:48,971: full memory  800.5s, avg 87.1%

psi log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch5/swappiness0/psi

mem log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch5/swappiness0/mem

In some cases stalls was very short, but in many cases stalls was long. 
The result is still not good enough.


offtop
======

The same test with the patch [1] on top of 5.16-rc2 + le9 patch [2] 
with vm.clean_min_kbytes=99000.

- with noswap

Summary:

2021-11-30 23:59:32,209: Stall times for the last 73.1s:
2021-11-30 23:59:32,209: -----------
2021-11-30 23:59:32,209: some cpu     0.4s, avg 0.5%
2021-11-30 23:59:32,209: -----------
2021-11-30 23:59:32,210: some io      5.8s, avg 8.0%
2021-11-30 23:59:32,210: full io      5.3s, avg 7.3%
2021-11-30 23:59:32,210: -----------
2021-11-30 23:59:32,210: some memory  3.3s, avg 4.5%
2021-11-30 23:59:32,210: full memory  3.1s, avg 4.2%

This is just an example of what a result close to the expected 
result might be (especially note io pressure values).

full psi:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch5/noswap_le9_min99k/psi

mem:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch5/noswap_le9_min99k/mem

[1] https://lore.kernel.org/lkml/20211129150117.GO3366@techsingularity.net/
[2] https://lore.kernel.org/all/20211130201652.2218636d@mail.inbox.lv/
