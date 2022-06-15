Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94A54C8A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 14:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344694AbiFOMgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 08:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiFOMgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:36:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB6530553;
        Wed, 15 Jun 2022 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5lqEWJkgj4WjPMuFW/4um7Uq+N/W4NBmyjYBaPvODgA=; b=vWlkI0pgs/XEbRElbcbobR9x5/
        xOMvayvrru8rGx8BcLb04qvMiqqgkWMhtELlE4vNY+qjLMUxNgEEtWtO/hhcWMSO1EWZEFWr8Q0cm
        3X17/GtHvRwQu5tuf61wACBzsaHS6LYnEgLUfWJnKqmT+ZvKfU5wl9HgNWHHz5exLvNRwqen5Mw0s
        V2SrBaA7jP3eptFp4KZ0GhER5exyexHNggeQ46b7nfFNmWWf6nYA+/f5Qq2nT44bguo8RTby7aAqT
        tNrnkBN90FHFkyE92627IAlUPwaStfjnQHApd1ZZY00MMAldfbrikKBIA4BocCzFLvD+VwdtQhIHY
        WRZM8qkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1SGG-0013CA-8o; Wed, 15 Jun 2022 12:36:40 +0000
Date:   Wed, 15 Jun 2022 13:36:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LKP] Re: [mm/readahead] 793917d997: fio.read_iops -18.8%
 regression
Message-ID: <YqnSWMQN58xBUEt/@casper.infradead.org>
References: <20220418144234.GD25584@xsang-OptiPlex-9020>
 <Yl2bKRcRqbcMmhji@casper.infradead.org>
 <1e8deaea-5a05-1846-d51c-b834beb9f23e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e8deaea-5a05-1846-d51c-b834beb9f23e@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 02:38:24PM +0800, Yin Fengwei wrote:
> On 4/19/2022 1:08 AM, Matthew Wilcox wrote:
> > 
> > I'm on holiday today, but adding linux-fsdevel and linux-mm so relevant
> > people know about this.
> > 
> > Don't focus on the 18% regression, focus on the 240% improvement on the
> > other benchmark ;-)
> > 
> > Seriously, someone (probably me) needs to dig into what the benchmark
> > is doing and understand whether there's a way to avoid (or decide this
> > regression isn't relevant) while keeping the performance gains elsewhere.
> With:
> commit b9ff43dd27434dbd850b908e2e0e1f6e794efd9b
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Wed Apr 27 17:01:28 2022 -0400
> 
>     mm/readahead: Fix readahead with large folios
> 
> the regression is almost gone:

That makes sense.  I did think at the time that this was probably the
cause of the problem.

> commit:
>   18788cfa236967741b83db1035ab24539e2a21bb
>   b9ff43dd27434dbd850b908e2e0e1f6e794efd9b
> 
> 18788cfa23696774 b9ff43dd27434dbd850b908e2e0
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>        4698:9       -36360%        1426:3     dmesg.timestamp:last
>        3027:9       -22105%        1037:3     kmsg.timestamp:last
>          %stddev     %change         %stddev
>              \          |                \
>       0.39 ±253%      -0.3        0.09 ±104%  fio.latency_1000us%
>       0.00 ±141%      +0.0        0.01        fio.latency_100ms%
>      56.60 ±  5%     +10.3       66.92 ±  8%  fio.latency_10ms%
>      15.65 ± 22%      -1.3       14.39 ± 17%  fio.latency_20ms%
>       1.46 ±106%      -0.5        0.95 ± 72%  fio.latency_2ms%
>      25.81 ± 25%      -9.2       16.59 ± 18%  fio.latency_4ms%
>       0.09 ± 44%      +0.9        1.04 ± 22%  fio.latency_50ms%
>       0.00 ±282%      +0.0        0.02 ±141%  fio.latency_750us%
>      13422 ±  6%      -1.4%      13233        fio.read_bw_MBps   <-----

A stddev of 6% and a decline of 1.4%?  How many tests did you run
to make sure that this is a real decline and not fluctuation of
one-quarter-of-one-standard-devisation?

