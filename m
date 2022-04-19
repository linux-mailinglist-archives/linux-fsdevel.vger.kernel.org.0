Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A355066C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349902AbiDSITs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 04:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349904AbiDSITb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:19:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79820344C2;
        Tue, 19 Apr 2022 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nxk6ARS1KhpZKavk3fbvq/OGlMyKz6/I9rTuwfuzZ9w=; b=BQoHDCeKF0vIXfC8DfzcWomYI5
        LmiebAdA+mNAXukoCW0SNDlIfg6PTxKc998E2MCFIf31qPBDw2d+0fTnwICrgsky48UNQMfauxydp
        Hhw2+Y0sFUDRQ6GbpSMnHtvRp30W0L61g88PnCHp6fcXgH2LaC0XmKMvjepM+t9uMrPS6LQyXWSBa
        yXf4/mGZ7+u4DT3gCPpISQJH7Y0dJd0AsCqNRmm10WaGNi17SH6r2CyvKkJMHvpGnT5S0rVXB27RX
        CpHL+gaWpeqvNouBrcx01/s1Q0v7uAev7F0V0FrppKogq5gSY83QHZTwVYWbp7Fp0+dgfTeHvqshQ
        tIVyye+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngj29-002uqH-8O; Tue, 19 Apr 2022 08:16:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D369798618A; Tue, 19 Apr 2022 10:16:24 +0200 (CEST)
Date:   Tue, 19 Apr 2022 10:16:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
Subject: Re: [PATCH v2] fs-writeback: =?utf-8?Q?wri?=
 =?utf-8?Q?teback=5Fsb=5Finodes=EF=BC=9ARecalculat?= =?utf-8?Q?e?= 'wrote'
 according skipped pages
Message-ID: <20220419081624.GM2731@worktop.programming.kicks-ass.net>
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
 <587c1849-f81b-13d6-fb1a-f22588d8cc2d@kernel.dk>
 <CAHk-=wjmFw1EBOVAN8vffPDHKJH84zZOtwZrLpE=Tn2MD6kEgQ@mail.gmail.com>
 <df4853fb-0e10-4d50-75cd-ee9b06da5ab1@kernel.dk>
 <CAHk-=wg6s5gHCc-JngKFfOS7uZUrT9cqzNDKqUQZON6Txfa_rQ@mail.gmail.com>
 <69f80fe3-5bec-f02e-474b-e49651f5818f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69f80fe3-5bec-f02e-474b-e49651f5818f@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 18, 2022 at 06:30:16PM -0600, Jens Axboe wrote:
> On 4/18/22 6:19 PM, Linus Torvalds wrote:
> > On Mon, Apr 18, 2022 at 3:12 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> Hmm yes. But doesn't preemption imply a full barrier? As long as we
> >> assign the plug at the end, we should be fine. And just now looking that
> >> up, there's even already a comment to that effect in blk_start_plug().
> >> So barring any weirdness with that, maybe that's the solution.
> > 
> > My worry is more about the code that adds new cb_list entries to the
> > plug, racing with then some random preemption event that flushes the
> > plug.
> > 
> > preemption itself is perfectly fine wrt any per-thread data updates
> > etc, but if preemption then also *changes* the data that is updated,
> > that's not great.
> > 
> > So that worries me.
> 
> Yes, and the same is true for eg merge traversal. We'd then need to
> disable preempt for that as well...

One is only supposed to disable preemption for short and bounded things,
otherwise we'll get people complaining their latencies are going bad.
