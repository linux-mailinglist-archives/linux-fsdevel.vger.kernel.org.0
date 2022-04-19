Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673815066C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 10:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349846AbiDSIUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 04:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbiDSIUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:20:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82B5FCF;
        Tue, 19 Apr 2022 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rRxmedwUzsUPi3oM81wvEiIXlzZjV8rSZCFbGT4aQEw=; b=KG4yrVW6YDkJYUvbVknV9ibkO9
        8IsGMxingUi69r/wkNBP/v8NPQrdmmbtsKg4+dfmG8X1ofDkC3SOPn7N6LUZVbG05T/7vo23+vSV1
        dq8xOolvvEe5DILX7bM8CajlS9jgctC16ydTR6r8CyO98x6Xlt7JCiRkTmke+tFDfB9d7l9zMHU6g
        eFAp6ygTES8KkkKUMrwfF7H+iKZPeeUkZt4G/7poq08HIV8NkjXembkGrBbzATFy2nrvt0V0y6/QN
        AvZmIq2Z2duZ6Cba1mMTp73XYeSPe72lDmDc7WeQCTRENCDcVXoaKRgqmqXMwE9FHEQwsp0Hetca9
        7Rm5dlog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngj3d-006lEh-DR; Tue, 19 Apr 2022 08:17:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B47D398618A; Tue, 19 Apr 2022 10:17:55 +0200 (CEST)
Date:   Tue, 19 Apr 2022 10:17:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
Subject: Re: [PATCH v2] fs-writeback: =?utf-8?Q?wri?=
 =?utf-8?Q?teback=5Fsb=5Finodes=EF=BC=9ARecalculat?= =?utf-8?Q?e?= 'wrote'
 according skipped pages
Message-ID: <20220419081755.GN2731@worktop.programming.kicks-ass.net>
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 18, 2022 at 12:43:43PM -0700, Linus Torvalds wrote:
> Which all brings us back to how we have that hacky thing in
> writeback_sb_inodes() that does
> 
>         if (need_resched()) {
>                 /*
>                  * We're trying to balance between building up a nice
>                  * long list of IOs to improve our merge rate, and
>                  * getting those IOs out quickly for anyone throttling
>                  * in balance_dirty_pages().  cond_resched() doesn't
>                  * unplug, so get our IOs out the door before we
>                  * give up the CPU.
>                  */
>                 blk_flush_plug(current->plug, false);
>                 cond_resched();
>         }

Yeah, that's horribly broken for PREEMPT=y.
