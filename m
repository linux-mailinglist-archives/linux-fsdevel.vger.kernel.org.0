Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DECA6EC920
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 11:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDXJi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDXJiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:38:24 -0400
Received: from outbound-smtp41.blacknight.com (outbound-smtp41.blacknight.com [46.22.139.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8FB10FB
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 02:38:21 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 123A21D35
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 10:38:20 +0100 (IST)
Received: (qmail 14803 invoked from network); 24 Apr 2023 09:38:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Apr 2023 09:38:19 -0000
Date:   Mon, 24 Apr 2023 10:38:17 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 3/4] migrate_pages: Don't wait forever locking pages
 in MIGRATE_SYNC_LIGHT
Message-ID: <20230424093817.am3qpsba35yrhmow@techsingularity.net>
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.3.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230421151135.v2.3.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:12:47PM -0700, Douglas Anderson wrote:
> The MIGRATE_SYNC_LIGHT mode is intended to block for things that will
> finish quickly but not for things that will take a long time. Exactly
> how long is too long is not well defined, but waits of tens of
> milliseconds is likely non-ideal.
> 
> Waiting on the folio lock in isolate_movable_page() is something that
> usually is pretty quick, but is not officially bounded. Nothing stops
> another process from holding a folio lock while doing an expensive
> operation. Having an unbounded wait like this is not within the design
> goals of MIGRATE_SYNC_LIGHT.
> 
> When putting a Chromebook under memory pressure (opening over 90 tabs
> on a 4GB machine) it was fairly easy to see delays waiting for the
> lock of > 100 ms. While the laptop wasn't amazingly usable in this
> state, it was still limping along and this state isn't something
> artificial. Sometimes we simply end up with a lot of memory pressure.
> 
> Putting the same Chromebook under memory pressure while it was running
> Android apps (though not stressing them) showed a much worse result
> (NOTE: this was on a older kernel but the codepaths here are
> similar). Android apps on ChromeOS currently run from a 128K-block,
> zlib-compressed, loopback-mounted squashfs disk. If we get a page
> fault from something backed by the squashfs filesystem we could end up
> holding a folio lock while reading enough from disk to decompress 128K
> (and then decompressing it using the somewhat slow zlib algorithms).
> That reading goes through the ext4 subsystem (because it's a loopback
> mount) before eventually ending up in the block subsystem. This extra
> jaunt adds extra overhead. Without much work I could see cases where
> we ended up blocked on a folio lock for over a second. With more
> more extreme memory pressure I could see up to 25 seconds.
> 
> Let's bound the amount of time we can wait for the folio lock. The
> SYNC_LIGHT migration mode can already handle failure for things that
> are slow, so adding this timeout in is fairly straightforward.
> 
> With this timeout, it can be seen that kcompactd can move on to more
> productive tasks if it's taking a long time to acquire a lock.
> 
> NOTE: The reason I stated digging into this isn't because some
> benchmark had gone awry, but because we've received in-the-field crash
> reports where we have a hung task waiting on the page lock (which is
> the equivalent code path on old kernels). While the root cause of
> those crashes is likely unrelated and won't be fixed by this patch,
> analyzing those crash reports did point out this unbounded wait and it
> seemed like something good to fix.
> 
> ALSO NOTE: the timeout mechanism used here uses "jiffies" and we also
> will retry up to 7 times. That doesn't give us much accuracy in
> specifying the timeout. On 1000 Hz machines we'll end up timing out in
> 7-14 ms. On 100 Hz machines we'll end up in 70-140 ms. Given that we
> don't have a strong definition of how long "too long" is, this is
> probably OK.
> 
> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Keep unbounded delay in "SYNC", delay with a timeout in "SYNC_LIGHT"
> 
>  mm/migrate.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index db3f154446af..60982df71a93 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -58,6 +58,23 @@
>  
>  #include "internal.h"
>  
> +/* Returns the schedule timeout for a non-async mode */
> +static long timeout_for_mode(enum migrate_mode mode)
> +{
> +	/*
> +	 * We'll always return 1 jiffy as the timeout. Since all places using
> +	 * this timeout are in a retry loop this means that the maximum time
> +	 * we might block is actually NR_MAX_MIGRATE_SYNC_RETRY jiffies.
> +	 * If a jiffy is 1 ms that's 7 ms, though with the accuracy of the
> +	 * timeouts it often ends up more like 14 ms; if a jiffy is 10 ms
> +	 * that's 70-140 ms.
> +	 */
> +	if (mode == MIGRATE_SYNC_LIGHT)
> +		return 1;
> +

Use switch and WARN_ON_ONCE if MIGRATE_ASYNC with a fallthrough to
MIGRATE_SYNC_LIGHT?

> +	return MAX_SCHEDULE_TIMEOUT;
> +}
> +

Even though HZ is defined at compile time, it is underdesirable to use
a constant timeout unrelated to HZ because it's normal case is variable
depending on CONFIG_HZ.  Please use a value like DIV_ROUND_UP(HZ/250) or
DIV_ROUND_UP(HZ/1000) for a 4ms or 1ms timeout respectively. Even though
it's still potentially variable, it would make any hypothetical transition
to [milli|micro|nano]seconds easier in the future as the intent would be
known. While there are no plans for change as such, working in jiffies is
occasionally problematic in kernel/sched/. At OSPM this year, the notion
of dynamic HZ was brought up (it would be hard) and a preliminary step
would be converting all uses of HZ to normal time.

-- 
Mel Gorman
SUSE Labs
