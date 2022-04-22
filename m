Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744E750C18B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiDVWFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiDVWFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:05:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C20541D1F3;
        Fri, 22 Apr 2022 13:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38147B83260;
        Fri, 22 Apr 2022 20:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5EFC385A4;
        Fri, 22 Apr 2022 20:47:45 +0000 (UTC)
Date:   Fri, 22 Apr 2022 16:47:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422164744.6500ca06@gandalf.local.home>
In-Reply-To: <20220422203057.iscsmurtrmwkpwnq@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
        <20220421234837.3629927-7-kent.overstreet@gmail.com>
        <20220422042017.GA9946@lst.de>
        <YmI5yA1LrYrTg8pB@moria.home.lan>
        <20220422052208.GA10745@lst.de>
        <YmI/v35IvxhOZpXJ@moria.home.lan>
        <20220422113736.460058cc@gandalf.local.home>
        <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
        <20220422153916.7ebf20c3@gandalf.local.home>
        <20220422203057.iscsmurtrmwkpwnq@moria.home.lan>
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

On Fri, 22 Apr 2022 16:30:57 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> So here's the story of how I got from where seq_buf is now to where printbuf is
> now:
> 
>  - Printbuf started out as almost an exact duplicate of seq_buf (like I said,
>    not intentionally), with an external buffer typically allocated on the stack.

Basically seq_buf is designed to be used as an underlining infrastructure.
That's why it does not allocate any buffer and leaves that to the user
cases. Hence, trace_seq() allocates a page for use, and I even use seq_buf
in user space to dynamically allocate when needed.

> 
>  - As error/log messages got to be bigger and more structured, stack usage
>    eventually became an issue, so eventually I added the heap allocations. 

Which is something you could do on top of seq_buf. Point being, you do not
need to re-implement printbuf, and I have not looked at the code, but
instead, implement printbuf on top of seq_buf, and extend seq_buf where
needed. Like trace_seq does, and the patches I have for seq_file would do.
It would leave the string processing and buffer space management to
seq_buf, as there's ways to see "oh, we need more space, let's allocate
more" and then increase the heap.

> 
>  - This made them a lot more convenient to use, and made possible entirely new
>    ways of using them - so I started using them more, and converting everything
>    that outputted to strings to them.
> 
>  - This lead to the realization that when pretty-printers are easy and
>    convenient to write, that leads to writing pretty-printers for _more_ stuff,
>    which makes it easy to stay in the habit of adding anything relevant to
>    sysfs/debugfs - and log/error messages got a _whole_ lot better when I
>    realized instead of writing format strings for every basic C type I can just
>    use the .to_text() methods of the high level objects I'm working with.
> 
> Basically, my debugging life has gotten _drastically_ easier because of this
> change in process and approach - deadlocks that I used to have to attach a
> debugger for are now trivial because all the relevant state is in debugfs and
> greppable, and filesystem inconsistencies that used to suck to debug I now just
> take what's in the error message and grep through the journal for.
> 
> I can't understate how invaluable all this stuff has been, and I'm excited to
> take the lessons I've learned and apply them to the wider kernel and make other
> people's lives easier too.
> 
> The shrinkers-OOM-reporting patch was an obvious starting point because
>  - shrinkers have internal state that's definitely worth reporting on
>  - we shouldn't just be logging this on OOM, we should also make this available
>    in sysfs or debugfs.
> 
> Feature wise, printbufs have:
>  - heap allocation
>  - extra state for formatting: indent level, tabstops, and a way of specifying
>    units.
> 
> That's basically it. Heap allocation adds very little code and eliminates a
> _lot_ of headaches in playing the "how much do I need to/can I put on the stack"
> game, and you'll want the formatting options as soon as you start formatting
> multi line output and writing pretty printers that call other pretty printers.

I would be more willing to accept a printbuf, if it was built on top of
seq_buf. That is, you don't need to change all your user cases, you just
need to make printbuf an extension of seq_buf by using it underneath, like
trace_seq does. Then it would not be re-inventing the wheel, but just
building on top of it.

-- Steve

