Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC26A36C0AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 10:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhD0IRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 04:17:14 -0400
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:35274 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhD0IRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:17:14 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Apr 2021 04:17:13 EDT
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id ACBDCD29CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 09:09:23 +0100 (IST)
Received: (qmail 32322 invoked from network); 27 Apr 2021 08:09:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.248])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Apr 2021 08:09:23 -0000
Date:   Tue, 27 Apr 2021 09:09:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, bhe@redhat.com,
        nigupta@nvidia.com, khalid.aziz@oracle.com,
        mateusznosek0@gmail.com, sh_def@163.com, iamjoonsoo.kim@lge.com,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        mhocko@suse.com, rientjes@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH] mm: compaction: improve /proc trigger for full node
 memory compaction
Message-ID: <20210427080921.GG4239@techsingularity.net>
References: <1619098678-8501-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1619098678-8501-1-git-send-email-charante@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:07:58PM +0530, Charan Teja Reddy wrote:
> The existing /proc/sys/vm/compact_memory interface do the full node
> compaction when user writes an arbitrary value to it and is targeted for
> the usecases like an app launcher prepares the system before the target
> application runs.

The intent behind compact_memory was a debugging interface to tell
the difference between an application failing to allocate a huge page
prematurely and the inability of compaction to find a free page.

> The downside of it is that even if there are
> sufficient higher order pages left in the system for the targeted
> application to run, full node compaction will still be triggered thus
> wasting few CPU cycles. This problem can be solved if it is known when
> the sufficient higher order pages are available in the system thus full
> node compaction can be stopped in the middle. The proactive
> compaction[1] can give these details about the availability of higher
> order pages in the system(it checks for COMPACTION_HPAGE_ORDER pages,
> which usually be order-9) thus can be used to trigger for full node
> compaction.
> 
> This patch adds a new /proc interface,
> /proc/sys/vm/proactive_compact_memory, and on write of an arbitrary
> value triggers the full node compaction but can be stopped in the middle
> if sufficient higher order(COMPACTION_HPAGE_ORDER) pages available in
> the system. The availability of pages that a user looking for can be
> given as input through /proc/sys/vm/compaction_proactiveness.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Hence, while I do not object to the patch as-such, I'm wary of the trend
towards improving explicit out-of-band compaction via proc interfaces. I
would have preferred if the focus was on reducing the cost of compaction
so that direct allocation requests succeed quickly or improving background
compaction via kcompactd when there has been recent failures.

-- 
Mel Gorman
SUSE Labs
