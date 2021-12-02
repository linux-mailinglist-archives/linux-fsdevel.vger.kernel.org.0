Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAA346635B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 13:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346715AbhLBMTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 07:19:23 -0500
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:35705 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346668AbhLBMTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:19:20 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id 4D2E41C3A04
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 12:15:56 +0000 (GMT)
Received: (qmail 32528 invoked from network); 2 Dec 2021 12:15:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Dec 2021 12:15:55 -0000
Date:   Thu, 2 Dec 2021 12:15:54 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alexey Avramov <hakavlad@inbox.lv>
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
Message-ID: <20211202121554.GY3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
 <20211127011246.7a8ac7b8@mail.inbox.lv>
 <20211129150117.GO3366@techsingularity.net>
 <20211201010348.31e99637@mail.inbox.lv>
 <20211130172754.GS3366@techsingularity.net>
 <20211201033836.4382a474@mail.inbox.lv>
 <20211201140005.GU3366@techsingularity.net>
 <20211202204229.5ed83f31@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211202204229.5ed83f31@mail.inbox.lv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 08:42:29PM +0900, Alexey Avramov wrote:
> I tested this [1] patch on top of 5.16-rc2, the same tests.
> 

Thanks for all the tests you've done for this, it's much appreciated.

> - with noswap:
> 
> 2021-12-02 19:41:19,279: Stall times for the last 146.5s:
> 2021-12-02 19:41:19,279: -----------
> 2021-12-02 19:41:19,279: some cpu     1.1s, avg 0.8%
> 2021-12-02 19:41:19,279: -----------
> 2021-12-02 19:41:19,279: some io      116.2s, avg 79.3%
> 2021-12-02 19:41:19,280: full io      109.6s, avg 74.8%
> 2021-12-02 19:41:19,280: -----------
> 2021-12-02 19:41:19,280: some memory  3.9s, avg 2.6%
> 2021-12-02 19:41:19,280: full memory  3.8s, avg 2.6%
> 
> Excellent!
> 
> psi log:
> https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch6/noswap/psi
> 
> mem log:
> https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch6/noswap/mem
> 
> - with swappiness=0
> 
> 2021-12-02 19:46:04,860: Stall times for the last 144.5s:
> 2021-12-02 19:46:04,860: -----------
> 2021-12-02 19:46:04,860: some cpu     1.1s, avg 0.8%
> 2021-12-02 19:46:04,860: -----------
> 2021-12-02 19:46:04,860: some io      106.9s, avg 74.0%
> 2021-12-02 19:46:04,861: full io      101.3s, avg 70.1%
> 2021-12-02 19:46:04,861: -----------
> 2021-12-02 19:46:04,861: some memory  99.6s, avg 68.9%
> 2021-12-02 19:46:04,861: full memory  95.6s, avg 66.2%
> 
> PSI mem pressure was high, but there were no long stalls.
> 

Great, so can I assume you're ok with this version? If yes, can I add
the following?

Tested-by: Alexey Avramov <hakavlad@inbox.lv>

-- 
Mel Gorman
SUSE Labs
