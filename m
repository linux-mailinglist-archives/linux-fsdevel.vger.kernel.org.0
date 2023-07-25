Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B681C761D5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjGYP1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGYP1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:27:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90668E2;
        Tue, 25 Jul 2023 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FWv8YUOLDpc9XWpy42XZkr/o/V+IgMX0b+gKuTdbiQw=; b=B71INnRD3fJ67zcj/KlULhsLsr
        JKhVWS0RbQwwHsaf29JeM5y1H5uLxqnrd0ZD8geKFJfRzeq9YupOKsw2VgDe997O9slDnrZQaOACq
        yxi7N75Gi1mWxylYinAqJ4Mo1bN6COCOzQynpSA8H7If9YmM7/TXZgVwSSKtsmZDPO6tIw6YbtM7a
        2qhntEHm+2yPxp1Q0iite7DpMrKhIJ9U4EpotaPaxO2xOLnO00gaenS3LxX/1kv/r4OZfU/PkHosy
        uA063/A20TsAvT7r3IAb5Tu4lwRishzfojqHcxUzlwZfEzuVO3dF+99+Nmxz4LwoWSmnB0lTPSz3E
        NF8c+sEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOJw6-005aym-Jp; Tue, 25 Jul 2023 15:26:54 +0000
Date:   Tue, 25 Jul 2023 16:26:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/2] softirq: fix integer overflow in function show_stat()
Message-ID: <ZL/pvjMMtlxvBSCm@casper.infradead.org>
References: <20230724132224.916-1-thunder.leizhen@huaweicloud.com>
 <20230724132224.916-2-thunder.leizhen@huaweicloud.com>
 <ZL6BwiHhvQneJZYH@casper.infradead.org>
 <6e38e31f-4413-1aff-8973-5c3d660bedea@huaweicloud.com>
 <3b1ba209-58c8-b2b6-115a-6c43cba80098@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b1ba209-58c8-b2b6-115a-6c43cba80098@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 05:09:05PM +0800, Leizhen (ThunderTown) wrote:
> On 2023/7/25 10:00, Leizhen (ThunderTown) wrote:
> > On 2023/7/24 21:50, Matthew Wilcox wrote:
> >> On Mon, Jul 24, 2023 at 09:22:23PM +0800, thunder.leizhen@huaweicloud.com wrote:
> >>> From: Zhen Lei <thunder.leizhen@huawei.com>
> >>>
> >>> The statistics function of softirq is supported by commit aa0ce5bbc2db
> >>> ("softirq: introduce statistics for softirq") in 2009. At that time,
> >>> 64-bit processors should not have many cores and would not face
> >>> significant count overflow problems. Now it's common for a processor to
> >>> have hundreds of cores. Assume that there are 100 cores and 10
> >>> TIMER_SOFTIRQ are generated per second, then the 32-bit sum will be
> >>> overflowed after 50 days.
> >>
> >> 50 days is long enough to take a snapshot.  You should always be using
> >> difference between, not absolute values, and understand that they can
> >> wrap.  We only tend to change the size of a counter when it can wrap
> >> sufficiently quickly that we might miss a wrap (eg tens of seconds).
> 
> Sometimes it can take a long time to view it again. For example, it is
> possible to run a complete business test for hours or even days, and
> then calculate the average.

I've been part of teams which have done such multi-hour tests.  That
isn't how monitoring was performed.  Instead snapshots were taken every
minute or even more frequently, because we wanted to know how these
counters were fluctuating during the test -- were there time periods
when the number of sortirqs spiked, or was it constant during the test?

> > Yes, I think patch 2/2 can be dropped. I reduced the number of soft
> > interrupts generated in one second, and actually 100+ or 1000 is normal.
> > But I think patch 1/2 is necessary. The sum of the output scattered values
> > does not match the output sum. To solve this problem, we only need to
> > adjust the type of a local variable.
> 
> However, it is important to consider that when the local variable is changed
> to u64, the output string becomes longer. It is not clear if the user-mode
> program parses it only by u32.

There's no need for the numbers to add up.  They won't anyway, because
summing them is racy , so they'll always be a little off.
