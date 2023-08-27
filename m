Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B00E789C61
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjH0Iy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 04:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjH0IyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F229136;
        Sun, 27 Aug 2023 01:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2DD862A62;
        Sun, 27 Aug 2023 08:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96E1C433C8;
        Sun, 27 Aug 2023 08:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693126446;
        bh=DVepnvk9nZnshKBUYaBYHbcRgcSiPVV2po4HFKIFZMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYQNpGoYghPNAwhd4XaIzOnrSB7+Oo1nBfo8GYNTZS7GQIO3uReUUAbiLK6QQp4LF
         JBiD4OFeQZxPxL8C4SrszXLJK02S3fC5xbKZJX17vRpnC+Wtje1SmpzFgzuo79DKal
         1aHePaFrGqNaakzS/l/j2CupTN7BTmr7z6ojnKYQ=
Date:   Sun, 27 Aug 2023 10:54:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: allow a controlled amount of unfairness in the page
 lock
Message-ID: <2023082731-crunching-second-ad89@gregkh>
References: <20230823061642.76949-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823061642.76949-1-mheyne@amazon.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 06:16:42AM +0000, Maximilian Heyne wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> [ upstream commit 5ef64cc8987a9211d3f3667331ba3411a94ddc79 ]
> 
> Commit 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic") made
> the page locking entirely fair, in that if a waiter came in while the
> lock was held, the lock would be transferred to the lockers strictly in
> order.
> 
> That was intended to finally get rid of the long-reported watchdog
> failures that involved the page lock under extreme load, where a process
> could end up waiting essentially forever, as other page lockers stole
> the lock from under it.
> 
> It also improved some benchmarks, but it ended up causing huge
> performance regressions on others, simply because fair lock behavior
> doesn't end up giving out the lock as aggressively, causing better
> worst-case latency, but potentially much worse average latencies and
> throughput.
> 
> Instead of reverting that change entirely, this introduces a controlled
> amount of unfairness, with a sysctl knob to tune it if somebody needs
> to.  But the default value should hopefully be good for any normal load,
> allowing a few rounds of lock stealing, but enforcing the strict
> ordering before the lock has been stolen too many times.
> 
> There is also a hint from Matthieu Baerts that the fair page coloring
> may end up exposing an ABBA deadlock that is hidden by the usual
> optimistic lock stealing, and while the unfairness doesn't fix the
> fundamental issue (and I'm still looking at that), it avoids it in
> practice.
> 
> The amount of unfairness can be modified by writing a new value to the
> 'sysctl_page_lock_unfairness' variable (default value of 5, exposed
> through /proc/sys/vm/page_lock_unfairness), but that is hopefully
> something we'd use mainly for debugging rather than being necessary for
> any deep system tuning.
> 
> This whole issue has exposed just how critical the page lock can be, and
> how contended it gets under certain locks.  And the main contention
> doesn't really seem to be anything related to IO (which was the origin
> of this lock), but for things like just verifying that the page file
> mapping is stable while faulting in the page into a page table.
> 
> Link: https://lore.kernel.org/linux-fsdevel/ed8442fd-6f54-dd84-cd4a-941e8b7ee603@MichaelLarabel.com/
> Link: https://www.phoronix.com/scan.php?page=article&item=linux-50-59&num=1
> Link: https://lore.kernel.org/linux-fsdevel/c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net/
> Reported-and-tested-by: Michael Larabel <Michael@michaellarabel.com>
> Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Chris Mason <clm@fb.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> CC: <stable@vger.kernel.org> # 5.4
> [ mheyne: fixed contextual conflict in mm/filemap.c due to missing
>   commit c7510ab2cf5c ("mm: abstract out wake_page_match() from
>   wake_page_function()"). Added WQ_FLAG_CUSTOM due to missing commit
>   7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem") ]
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
>  include/linux/mm.h   |   2 +
>  include/linux/wait.h |   2 +
>  kernel/sysctl.c      |   8 +++
>  mm/filemap.c         | 160 ++++++++++++++++++++++++++++++++++---------
>  4 files changed, 141 insertions(+), 31 deletions(-)

This was also backported here:
	https://lore.kernel.org/r/20230821222547.483583-1-saeed.mirzamohammadi@oracle.com
before yours.

I took that one, can you verify that it is identical to yours and works
properly as well?

thanks,

greg k-h
