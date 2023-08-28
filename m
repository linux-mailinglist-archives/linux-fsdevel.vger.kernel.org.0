Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368AE78A9B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjH1KOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjH1KOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:14:37 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D88D95;
        Mon, 28 Aug 2023 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1693217671; x=1724753671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x+R7rCL3CSOP8FR2dMzsl+zUfDtt3pidUGKwb7MyxkU=;
  b=ZocKF02y8aycxyMddQwguO62Qds2n1DCLYcOYALlu7hudedz2754b5KP
   tlCCU7BzOwYBgxlcFWpMTQ/S5CKx7Vwy4TeVct9hpkBxEyOzBT4lOc8Ke
   VZOePrAXA3uPWo3AwFkznWndEE7Y5YZzkF87JcqdoF7I+NPDZBbu1wiwH
   U=;
X-IronPort-AV: E=Sophos;i="6.02,207,1688428800"; 
   d="scan'208";a="604675000"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 10:14:29 +0000
Received: from EX19D008EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com (Postfix) with ESMTPS id 5F6CF8061D;
        Mon, 28 Aug 2023 10:14:22 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008EUA003.ant.amazon.com (10.252.50.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 28 Aug 2023 10:14:21 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 10:14:20 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
        id 96B5F81F; Mon, 28 Aug 2023 10:14:20 +0000 (UTC)
Date:   Mon, 28 Aug 2023 10:14:20 +0000
From:   Maximilian Heyne <mheyne@amazon.de>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>,
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
        Kees Cook <keescook@chromium.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] mm: allow a controlled amount of unfairness in the page
 lock
Message-ID: <20230828101420.GA54787@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
References: <20230823061642.76949-1-mheyne@amazon.de>
 <2023082731-crunching-second-ad89@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023082731-crunching-second-ad89@gregkh>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 27, 2023 at 10:54:03AM +0200, Greg KH wrote:
> On Wed, Aug 23, 2023 at 06:16:42AM +0000, Maximilian Heyne wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> >
> > [ upstream commit 5ef64cc8987a9211d3f3667331ba3411a94ddc79 ]
> >
> > Commit 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic") made
> > the page locking entirely fair, in that if a waiter came in while the
> > lock was held, the lock would be transferred to the lockers strictly in
> > order.
> >
> > That was intended to finally get rid of the long-reported watchdog
> > failures that involved the page lock under extreme load, where a process
> > could end up waiting essentially forever, as other page lockers stole
> > the lock from under it.
> >
> > It also improved some benchmarks, but it ended up causing huge
> > performance regressions on others, simply because fair lock behavior
> > doesn't end up giving out the lock as aggressively, causing better
> > worst-case latency, but potentially much worse average latencies and
> > throughput.
> >
> > Instead of reverting that change entirely, this introduces a controlled
> > amount of unfairness, with a sysctl knob to tune it if somebody needs
> > to.  But the default value should hopefully be good for any normal load,
> > allowing a few rounds of lock stealing, but enforcing the strict
> > ordering before the lock has been stolen too many times.
> >
> > There is also a hint from Matthieu Baerts that the fair page coloring
> > may end up exposing an ABBA deadlock that is hidden by the usual
> > optimistic lock stealing, and while the unfairness doesn't fix the
> > fundamental issue (and I'm still looking at that), it avoids it in
> > practice.
> >
> > The amount of unfairness can be modified by writing a new value to the
> > 'sysctl_page_lock_unfairness' variable (default value of 5, exposed
> > through /proc/sys/vm/page_lock_unfairness), but that is hopefully
> > something we'd use mainly for debugging rather than being necessary for
> > any deep system tuning.
> >
> > This whole issue has exposed just how critical the page lock can be, and
> > how contended it gets under certain locks.  And the main contention
> > doesn't really seem to be anything related to IO (which was the origin
> > of this lock), but for things like just verifying that the page file
> > mapping is stable while faulting in the page into a page table.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/ed8442fd-6f54-dd84-cd4a-941e8b7ee603@MichaelLarabel.com/
> > Link: https://www.phoronix.com/scan.php?page=article&item=linux-50-59&num=1
> > Link: https://lore.kernel.org/linux-fsdevel/c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net/
> > Reported-and-tested-by: Michael Larabel <Michael@michaellarabel.com>
> > Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Chris Mason <clm@fb.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > CC: <stable@vger.kernel.org> # 5.4
> > [ mheyne: fixed contextual conflict in mm/filemap.c due to missing
> >   commit c7510ab2cf5c ("mm: abstract out wake_page_match() from
> >   wake_page_function()"). Added WQ_FLAG_CUSTOM due to missing commit
> >   7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem") ]
> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > ---
> >  include/linux/mm.h   |   2 +
> >  include/linux/wait.h |   2 +
> >  kernel/sysctl.c      |   8 +++
> >  mm/filemap.c         | 160 ++++++++++++++++++++++++++++++++++---------
> >  4 files changed, 141 insertions(+), 31 deletions(-)
> 
> This was also backported here:
>         https://lore.kernel.org/r/20230821222547.483583-1-saeed.mirzamohammadi@oracle.com
> before yours.
> 
> I took that one, can you verify that it is identical to yours and works
> properly as well?

Yes it's identical and fixes the performance regression seen. Therefore,

  Tested-by: Maximilian Heyne <mheyne@amazon.de>

for the other patch.

Thanks,

Max



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



