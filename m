Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEC6F3F2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 10:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjEBIff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 04:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjEBIfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 04:35:32 -0400
X-Greylist: delayed 377 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 01:35:29 PDT
Received: from outbound-smtp28.blacknight.com (outbound-smtp28.blacknight.com [81.17.249.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CB249C9
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 01:35:29 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp28.blacknight.com (Postfix) with ESMTPS id BA236CCCE5
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 09:29:10 +0100 (IST)
Received: (qmail 24126 invoked from network); 2 May 2023 08:29:10 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 May 2023 08:29:10 -0000
Date:   Tue, 2 May 2023 09:29:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Hillf Danton <hdanton@sina.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v3] migrate_pages: Avoid blocking for IO in
 MIGRATE_SYNC_LIGHT
Message-ID: <20230502082904.je47t3g6dnmrcbz7@techsingularity.net>
References: <20230428135414.v3.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230428135414.v3.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:54:38PM -0700, Douglas Anderson wrote:
> The MIGRATE_SYNC_LIGHT mode is intended to block for things that will
> finish quickly but not for things that will take a long time. Exactly
> how long is too long is not well defined, but waits of tens of
> milliseconds is likely non-ideal.
> 
> When putting a Chromebook under memory pressure (opening over 90 tabs
> on a 4GB machine) it was fairly easy to see delays waiting for some
> locks in the kcompactd code path of > 100 ms. While the laptop wasn't
> amazingly usable in this state, it was still limping along and this
> state isn't something artificial. Sometimes we simply end up with a
> lot of memory pressure.
> 
> Putting the same Chromebook under memory pressure while it was running
> Android apps (though not stressing them) showed a much worse result
> (NOTE: this was on a older kernel but the codepaths here are similar).
> Android apps on ChromeOS currently run from a 128K-block,
> zlib-compressed, loopback-mounted squashfs disk. If we get a page
> fault from something backed by the squashfs filesystem we could end up
> holding a folio lock while reading enough from disk to decompress 128K
> (and then decompressing it using the somewhat slow zlib algorithms).
> That reading goes through the ext4 subsystem (because it's a loopback
> mount) before eventually ending up in the block subsystem. This extra
> jaunt adds extra overhead. Without much work I could see cases where
> we ended up blocked on a folio lock for over a second. With more
> extreme memory pressure I could see up to 25 seconds.
> 
> We considered adding a timeout in the case of MIGRATE_SYNC_LIGHT for
> the two locks that were seen to be slow [1] and that generated much
> discussion. After discussion, it was decided that we should avoid
> waiting for the two locks during MIGRATE_SYNC_LIGHT if they were being
> held for IO. We'll continue with the unbounded wait for the more full
> SYNC modes.
> 
> With this change, I couldn't see any slow waits on these locks with my
> previous testcases.
> 
> NOTE: The reason I stated digging into this originally isn't because
> some benchmark had gone awry, but because we've received in-the-field
> crash reports where we have a hung task waiting on the page lock
> (which is the equivalent code path on old kernels). While the root
> cause of those crashes is likely unrelated and won't be fixed by this
> patch, analyzing those crash reports did point out these very long
> waits seemed like something good to fix. With this patch we should no
> longer hang waiting on these locks, but presumably the system will
> still be in a bad shape and hang somewhere else.
> 
> [1] https://lore.kernel.org/r/20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
