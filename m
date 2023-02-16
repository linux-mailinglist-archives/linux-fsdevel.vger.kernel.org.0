Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47BD6995E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 14:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBPNdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 08:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBPNdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:33:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2796B59B5A;
        Thu, 16 Feb 2023 05:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FN9D4k4in1bDBo/daLEAKvVZkKm0gfZWwwcy44PDlmE=; b=GakoIeAf57y2vs7Q0oE+KFu/ug
        8/uC6WcbsHuP/Q3aTR4oMpvuWi2DLeIPbgruviIIDBh0noFzMy7IkY3873zDUoDeEMROSopbnOsjr
        nwr0dyDjEcPe0pRwa9/puHNi0tij2hlu4afQQ5BUoUsh4mzdv02V1xGrg+0m3q+79F3zjcUwyH40r
        44H19wub8OHrc98G5hFj78kUzCI+8A7/M9ttmVqgwO+TiGAD/l49Kec8s6Ew5qbapgnShK7ufMpi9
        QtyYHt09P1LC1EDvnMT2d7GAcZe3arq4AyH4jzdH9ZH5DRUGfpp3laHL9vk6Yzby81Cp9dkq3bHew
        9zASgkqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSeNk-008Rm5-0k; Thu, 16 Feb 2023 13:33:04 +0000
Date:   Thu, 16 Feb 2023 13:33:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     wenyang.linux@foxmail.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: use wait_event_interruptible_locked_irq() helper
Message-ID: <Y+4wj6hIt3jEA4Of@casper.infradead.org>
References: <tencent_47F9893DA354D9509F06DD4C52A7EB30130A@qq.com>
 <Y+4vnHS5y5stzg9o@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+4vnHS5y5stzg9o@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 16, 2023 at 01:29:00PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 16, 2023 at 09:17:39PM +0800, wenyang.linux@foxmail.com wrote:
> > +		res = wait_event_interruptible_locked_irq(
> > +				ctx->wqh, ULLONG_MAX - ctx->count > ucnt) ?
> > +			-ERESTARTSYS : sizeof(ucnt);
> 
> You've broken the line here in a weird way.  I'd've done it as:
> 
> 		res = wait_event_interruptible_locked_irq(ctx->wqh,
> 				ULLONG_MAX - ctx->count > ucnt) ?
> 					-ERESTARTSYS : sizeof(ucnt));
> 
> ... also the patch you've sent here doesn't even compile.  Have you
> tested it?

Sorry, I misread it.  But I would have avoided use of the ?: operator
here ...

		res = wait_event_interruptible_locked_irq(ctx->wqh,
				ULLONG_MAX - ctx->count > ucnt);
		if (res == 0)
			res = sizeof(ucnt);
