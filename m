Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B060F50C0C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiDVUpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 16:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiDVUpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5DF202B4C;
        Fri, 22 Apr 2022 12:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 849AC61CE4;
        Fri, 22 Apr 2022 19:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B01C385A4;
        Fri, 22 Apr 2022 19:39:18 +0000 (UTC)
Date:   Fri, 22 Apr 2022 15:39:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422153916.7ebf20c3@gandalf.local.home>
In-Reply-To: <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
        <20220421234837.3629927-7-kent.overstreet@gmail.com>
        <20220422042017.GA9946@lst.de>
        <YmI5yA1LrYrTg8pB@moria.home.lan>
        <20220422052208.GA10745@lst.de>
        <YmI/v35IvxhOZpXJ@moria.home.lan>
        <20220422113736.460058cc@gandalf.local.home>
        <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Apr 2022 15:30:15 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> > This is how open source programming is suppose to work ;-)  
> 
> Is it though? :)
> 
> One of the things I've been meaning to talk more about, that
> came out of a recent Rust discussion, is that we in the kernel community could
> really do a better job with how we interact with the outside world, particularly
> with regards to the sharing of code.
> 
> The point was made to me when another long standing kernel dev was complaining
> about Facebook being a large, insular, difficult to work with organization, that
> likes to pretend it is the center of the universe and not bend to the outside
> world, while doing the exact same thing with respect to new concerns brought by
> the Rust community. The irony was illuminating :)

I do not consider Facebook an open source company. One reason I turned them
down.

> 
> The reason I bring that up is that in this case, printbuf is the more evolved,
> more widely used implementation, and you're asking me to discard it so the
> kernel can stick with its more primitive, less widely used implementation.
> 
> $ git grep -w seq_buf|wc -l
> 86
> 
> $ git grep -w printbuf|wc -l
> 366

$ git grep printbuf
drivers/media/i2c/ccs/ccs-reg-access.c:                 char printbuf[(MAX_WRITE_LEN << 1) +
drivers/media/i2c/ccs/ccs-reg-access.c:                 bin2hex(printbuf, regdata, msg.len);
drivers/media/i2c/ccs/ccs-reg-access.c:                         regs->addr + j, printbuf);

I don't see it.

And by your notion:

$ git grep trace_seq | wc -l
1680

Thus we all should be using trace_seq!

> 
> So, going to have to push back on that one :)
> 
> Printbufs aren't new code; everything in them is there because I've found it
> valuable, which is why I decided to try promoting them to the kernel proper (and
> more importantly, the idea of a standard way to pretty-print anything).
> 
> I'm happy to discuss the merits of the code more, and try to convince you why
> you'll like them :)

I'd like to know more to why seq_buf is not good for you. And just telling
me that you never seriously tried to make it work because you were afraid
of causing tracing regressions without ever asking the tracing maintainer
is not going to cut it.

-- Steve
