Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CCB463CC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 18:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbhK3RbR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 12:31:17 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:53895 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242596AbhK3RbR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:31:17 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 24587CAF93
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 17:27:56 +0000 (GMT)
Received: (qmail 22121 invoked from network); 30 Nov 2021 17:27:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Nov 2021 17:27:55 -0000
Date:   Tue, 30 Nov 2021 17:27:54 +0000
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
Message-ID: <20211130172754.GS3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
 <20211127011246.7a8ac7b8@mail.inbox.lv>
 <20211129150117.GO3366@techsingularity.net>
 <20211201010348.31e99637@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211201010348.31e99637@mail.inbox.lv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 01, 2021 at 01:03:48AM +0900, Alexey Avramov wrote:
> I tested this [1] patch on top of 5.16-rc2. It's the same test with 10 tails.
> 
> - with noswap
> 
> Summary:
> 
> 2021-11-30 23:32:36,890: Stall times for the last 548.6s:
> 2021-11-30 23:32:36,890: -----------
> 2021-11-30 23:32:36,891: some cpu     3.7s, avg 0.7%
> 2021-11-30 23:32:36,891: -----------
> 2021-11-30 23:32:36,891: some io      187.6s, avg 34.2%
> 2021-11-30 23:32:36,891: full io      178.3s, avg 32.5%
> 2021-11-30 23:32:36,891: -----------
> 2021-11-30 23:32:36,892: some memory  392.2s, avg 71.5%
> 2021-11-30 23:32:36,892: full memory  390.7s, avg 71.2%
> 
> full psi:
> https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch5/noswap/psi
> 
> mem:
> https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-throttle/516-rc2/patch5/noswap/mem
> 

Ok, taking just noswap in isolation, this is what I saw when running
firefox + youtube vido and running tail /dev/zero 10 times in a row

2021-11-30 17:10:11,817: =================================
2021-11-30 17:10:11,817: Peak values:  avg10  avg60 avg300
2021-11-30 17:10:11,817: -----------  ------ ------ ------
2021-11-30 17:10:11,817: some cpu       1.00   0.96   0.56
2021-11-30 17:10:11,817: -----------  ------ ------ ------
2021-11-30 17:10:11,817: some io        0.24   0.06   0.04
2021-11-30 17:10:11,817: full io        0.24   0.06   0.01
2021-11-30 17:10:11,817: -----------  ------ ------ ------
2021-11-30 17:10:11,817: some memory    2.48   0.51   0.38
2021-11-30 17:10:11,817: full memory    2.48   0.51   0.37
2021-11-30 17:10:11,817: =================================
2021-11-30 17:10:11,817: Stall times for the last 53.7s:
2021-11-30 17:10:11,817: -----------
2021-11-30 17:10:11,817: some cpu     0.4s, avg 0.8%
2021-11-30 17:10:11,817: -----------
2021-11-30 17:10:11,817: some io      0.1s, avg 0.2%
2021-11-30 17:10:11,817: full io      0.1s, avg 0.2%
2021-11-30 17:10:11,817: -----------
2021-11-30 17:10:11,817: some memory  0.3s, avg 0.6%
2021-11-30 17:10:11,817: full memory  0.3s, avg 0.6%

Obviously a fairly different experience and most likely due to the
underlying storage.

Can you run the same test but after doing this

$ echo 1 > /sys/kernel/debug/tracing/events/vmscan/mm_vmscan_throttled/enable
$ cat /sys/kernel/debug/tracing/trace_pipe > trace.out

and send me the trace.out file please?

-- 
Mel Gorman
SUSE Labs
