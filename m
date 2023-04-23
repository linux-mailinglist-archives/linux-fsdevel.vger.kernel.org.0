Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC86EBDD2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Apr 2023 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjDWIAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWIAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 04:00:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55440171F;
        Sun, 23 Apr 2023 01:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682236822; x=1713772822;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=O6HQx+7ATNfLn29XVUobeBHwkKkA2qEXspWQTyfx/uw=;
  b=BFEjRs646VRlWzjnX/s9TjQ2t1hH46ntY9vgq2RWA7SWz5QZm1k2qoSa
   gbQEap+0RTcCP711q4M0rER6QdvSJDNfBQ5Hh/U/RMhunux9n5GzGXVl8
   gPNBYJFpwcoRJKoJSb5MyAR5VYYevu1p+mbftSgzqnOK+qh2XrC0/9A27
   exr1YT4R5yxL8XqAh/q6IYdJFGdtzCFQEei+tpdacXe5hpAmBaqgt5amu
   MVvFW1afRQrJlpyJnpBXU9y97gKm3Wflb3PFlGgzVj15LyIgG3gwrTu8O
   +snc50zsXceLdHLpMeBF+Dn+ptyVCZpPZMbd55NHaPgACIzVahGaj/xwb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="343744154"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="343744154"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 01:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="695382675"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="695382675"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 01:00:19 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 3/4] migrate_pages: Don't wait forever locking pages
 in MIGRATE_SYNC_LIGHT
References: <20230421221249.1616168-1-dianders@chromium.org>
        <20230421151135.v2.3.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
Date:   Sun, 23 Apr 2023 15:59:14 +0800
In-Reply-To: <20230421151135.v2.3.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
        (Douglas Anderson's message of "Fri, 21 Apr 2023 15:12:47 -0700")
Message-ID: <87h6t7kp0t.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Douglas Anderson <dianders@chromium.org> writes:

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

How long is the max wait time of folio_lock_timeout()?

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

You can use HZ to work with different configuration.  It doesn't help
much if your target is 1ms.  But I think that it's possible to set it to
longer than that in the future.  So, some general definition looks
better.

Best Regards,
Huang, Ying

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
> +	return MAX_SCHEDULE_TIMEOUT;
> +}
> +
>  bool isolate_movable_page(struct page *page, isolate_mode_t mode)
>  {
>  	struct folio *folio = folio_get_nontail_page(page);
> @@ -1162,7 +1179,8 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
>  		if (current->flags & PF_MEMALLOC)
>  			goto out;
>  
> -		folio_lock(src);
> +		if (folio_lock_timeout(src, timeout_for_mode(mode)))
> +			goto out;
>  	}
>  	locked = true;
