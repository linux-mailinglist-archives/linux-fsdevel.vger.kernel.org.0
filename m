Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18DF50C159
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 00:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiDVWAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiDVWAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:00:48 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F142C5223;
        Fri, 22 Apr 2022 13:43:55 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id j16so8567745vsv.2;
        Fri, 22 Apr 2022 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3NGyHwNzcPpl7RBhf4au6sQueS2Jmki+EL6hXZnP8PQ=;
        b=QDq+OMzhXiDZE3ekAGb1VjqbjweR6q15vhiF8oMbAkui5VdjtN0MnvTvkPzXwTNfid
         wp+k4NSNy3zdWHIgDyAm2OCTr7k1D7/aotkTNki3fw8w796Pmo7fMMf+Wi0VkdbsY6gT
         TtP5jIFZLS146fJvbNfZJR2IEUqMEAmO8rF2Y0WhgolbJS9+5Wm9tXxgIUyP2wgfGzdk
         56LkNxicQnznIOk+Z63Zc2ynlTh8ZtDGTR4CtFvXBaDLHP/ZSsNrqyzyI9mF3W2uoO0b
         7l8q01HtgPOTX21HWNDPxfWs9iqsrMXPDmO4JFG9H/KchRQNvq50cgw8FfRVJIYwRo21
         n+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NGyHwNzcPpl7RBhf4au6sQueS2Jmki+EL6hXZnP8PQ=;
        b=q6rimmhhMR7wZ1gXO0xj2Vq+fOpWF6DFWJS1vLaZlR9PrrW8XBFW7P1UyuHUvSCW6p
         9qXeXLn014AvOvqdhSuG5Glxfcz4AiyNkf4kjq3HU+Lm9GeBvBqzpefz53E4CO4F/eU0
         D3s6Q1cPqgUh/t8+8brcryP8LveBOfipIvkAFcfFAU0jElK/Go4BiyywrYYpcWRAVn/t
         jzZFK7ajoKA9utV2Zsbr36oZ2uSvJFveV75E8vKpDLi/DuSZchvOYy8qWyMva3L+oxuu
         I8DfApynYbT6EUOcJ2l/gJXQb6MFNKHA7R1LjwiBlQvglhJHZl3CQal1LJXyN3HLemvs
         yfCg==
X-Gm-Message-State: AOAM5300NSFvHrPkbri8ujkcvDF3CZU5oJ3kytoH8C9hxtliUFVTal/Y
        zpMqBgTJyRkSeTvVKY5S12MkyJqb/45J
X-Google-Smtp-Source: ABdhPJxzISRgHHODXKrrwyPqtpJH5WzT+DrLyG8K/Zt/m0UNqJazuD3i0Bd7jVRhJazqucNnus+6QQ==
X-Received: by 2002:a0c:d7cb:0:b0:444:2b27:80d3 with SMTP id g11-20020a0cd7cb000000b004442b2780d3mr5088064qvj.57.1650659460120;
        Fri, 22 Apr 2022 13:31:00 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n22-20020ac85b56000000b002f1d7a2867dsm1790112qtw.67.2022.04.22.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 13:30:59 -0700 (PDT)
Date:   Fri, 22 Apr 2022 16:30:57 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422203057.iscsmurtrmwkpwnq@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <20220422042017.GA9946@lst.de>
 <YmI5yA1LrYrTg8pB@moria.home.lan>
 <20220422052208.GA10745@lst.de>
 <YmI/v35IvxhOZpXJ@moria.home.lan>
 <20220422113736.460058cc@gandalf.local.home>
 <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
 <20220422153916.7ebf20c3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422153916.7ebf20c3@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 03:39:16PM -0400, Steven Rostedt wrote:
> I do not consider Facebook an open source company. One reason I turned them
> down.

Surely you can see how NIH syndrome isn't something that just happens at
closed-source companies? How a default cultural assumption of "we do things the
way we've always done" leads to things getting insular?

> > The reason I bring that up is that in this case, printbuf is the more evolved,
> > more widely used implementation, and you're asking me to discard it so the
> > kernel can stick with its more primitive, less widely used implementation.
> > 
> > $ git grep -w seq_buf|wc -l
> > 86
> > 
> > $ git grep -w printbuf|wc -l
> > 366
> 
> $ git grep printbuf
> drivers/media/i2c/ccs/ccs-reg-access.c:                 char printbuf[(MAX_WRITE_LEN << 1) +
> drivers/media/i2c/ccs/ccs-reg-access.c:                 bin2hex(printbuf, regdata, msg.len);
> drivers/media/i2c/ccs/ccs-reg-access.c:                         regs->addr + j, printbuf);
> 
> I don't see it.

Here: https://evilpiepirate.org/git/bcachefs.git/

It may not be merged yet, but it is actively developed open source code with
active users that's intended to be merged!

> I'd like to know more to why seq_buf is not good for you. And just telling
> me that you never seriously tried to make it work because you were afraid
> of causing tracing regressions without ever asking the tracing maintainer
> is not going to cut it.

I didn't know about seq_buf until a day or two ago, that's literally all it was.

And Steve, apologies if I've come across as being a dick about this, that wasn't
my intent.  I've got nothing against you or your code - I'd love it if we could
just have a discussion about them on their merits, and if it feels like I'm
making an issue about this unnecessarily that's because I think there's
something about kernel process and culture worth improving that I want to raise,
so I'm sticking my neck out a bit here.

So here's the story of how I got from where seq_buf is now to where printbuf is
now:

 - Printbuf started out as almost an exact duplicate of seq_buf (like I said,
   not intentionally), with an external buffer typically allocated on the stack.

 - As error/log messages got to be bigger and more structured, stack usage
   eventually became an issue, so eventually I added the heap allocations. 

 - This made them a lot more convenient to use, and made possible entirely new
   ways of using them - so I started using them more, and converting everything
   that outputted to strings to them.

 - This lead to the realization that when pretty-printers are easy and
   convenient to write, that leads to writing pretty-printers for _more_ stuff,
   which makes it easy to stay in the habit of adding anything relevant to
   sysfs/debugfs - and log/error messages got a _whole_ lot better when I
   realized instead of writing format strings for every basic C type I can just
   use the .to_text() methods of the high level objects I'm working with.

Basically, my debugging life has gotten _drastically_ easier because of this
change in process and approach - deadlocks that I used to have to attach a
debugger for are now trivial because all the relevant state is in debugfs and
greppable, and filesystem inconsistencies that used to suck to debug I now just
take what's in the error message and grep through the journal for.

I can't understate how invaluable all this stuff has been, and I'm excited to
take the lessons I've learned and apply them to the wider kernel and make other
people's lives easier too.

The shrinkers-OOM-reporting patch was an obvious starting point because
 - shrinkers have internal state that's definitely worth reporting on
 - we shouldn't just be logging this on OOM, we should also make this available
   in sysfs or debugfs.

Feature wise, printbufs have:
 - heap allocation
 - extra state for formatting: indent level, tabstops, and a way of specifying
   units.

That's basically it. Heap allocation adds very little code and eliminates a
_lot_ of headaches in playing the "how much do I need to/can I put on the stack"
game, and you'll want the formatting options as soon as you start formatting
multi line output and writing pretty printers that call other pretty printers.
