Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DA950CB19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 16:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiDWOTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiDWOTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:19:39 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B96105204;
        Sat, 23 Apr 2022 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650723399;
        bh=jV2vpLEA5741pyZ1K9lAYpNQeQGdDpyVgF3p9U/WoBQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=aXnr2E8eQpMsv1eQwhSLtMxIs0Z5XLapfbA4QJjQhY8PT/i7L2resHXGFmWDL/tR0
         QTaPtQZ1XFihXsRGnH1jTFZj+BHfT9jBfRVbpuUmZi1uUAL2WO7LWRsibegzC5QEUK
         L2iTXzaf1FCBDkqrKq0FnMOdi7eT7w6pg2jZm3m4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DDE411280231;
        Sat, 23 Apr 2022 10:16:39 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OxDIAJPXVU-n; Sat, 23 Apr 2022 10:16:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650723399;
        bh=jV2vpLEA5741pyZ1K9lAYpNQeQGdDpyVgF3p9U/WoBQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=aXnr2E8eQpMsv1eQwhSLtMxIs0Z5XLapfbA4QJjQhY8PT/i7L2resHXGFmWDL/tR0
         QTaPtQZ1XFihXsRGnH1jTFZj+BHfT9jBfRVbpuUmZi1uUAL2WO7LWRsibegzC5QEUK
         L2iTXzaf1FCBDkqrKq0FnMOdi7eT7w6pg2jZm3m4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 969071280215;
        Sat, 23 Apr 2022 10:16:38 -0400 (EDT)
Message-ID: <afdda017cbd0dc0f41d673fe53d2a9c48fba9a6c.camel@HansenPartnership.com>
Subject: Rust and Kernel Vendoring [Was Re: [PATCH v2 1/8] lib/printbuf: New
 data structure for heap-allocated strings]
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Date:   Sat, 23 Apr 2022 10:16:37 -0400
In-Reply-To: <20220422211350.qn2brzkfwsulwbiq@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
         <20220421234837.3629927-7-kent.overstreet@gmail.com>
         <20220422042017.GA9946@lst.de> <YmI5yA1LrYrTg8pB@moria.home.lan>
         <20220422052208.GA10745@lst.de> <YmI/v35IvxhOZpXJ@moria.home.lan>
         <20220422113736.460058cc@gandalf.local.home>
         <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
         <1f3ce897240bf0f125ca3e5f6ded7c290118a8dc.camel@HansenPartnership.com>
         <20220422211350.qn2brzkfwsulwbiq@moria.home.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[change of subject for an easy thread kill, since I'm sure most people
on cc don't want to follow this]
On Fri, 2022-04-22 at 17:13 -0400, Kent Overstreet wrote:
> On Fri, Apr 22, 2022 at 04:03:12PM -0400, James Bottomley wrote:
> > Hey, I didn't say that at all.  I said vendoring the facebook
> > reference implementation wouldn't work (it being 74k lines and us
> > using 300) but that facebook was doing the right thing for us with
> > zstd because they were maintaining the core code we needed, even if
> > we couldn't vendor it from their code base:
> > 
> > https://lore.kernel.org/rust-for-linux/ea85b3bce5f172dc73e2be8eb4dbd21fae826fa1.camel@HansenPartnership.com/
> > 
> > You were the one who said all that about facebook, while
> > incorrectly implying I said it first (which is an interesting
> > variation on the strawman fallacy):
> 
> Hey, sorry for picking on you James - I didn't mean to single you
> out.
> 
> Let me explain where I'm coming from - actually, this email I
> received puts it better than I could:
> 
> From: "John Ericson" <mail@johnericson.me>
> To: "Kent Overstreet" <kent.overstreet@gmail.com>
> Subject: Nice email on cargo crates in Linux
> 
> Hi. I saw your email linked from https://lwn.net/Articles/889924/.
> Nicely put!
> 
> I was involved in some of the allocating try_* function work to avoid
> nasty panics, and thus make sure Rust in Linux didn't have to
> reinvent the wheel redoing the alloc library. I very much share your
> goals but suspect this will happen in a sort of boil-the-frog way
> over time. The basic portability method of "incentivize users to
> write code that's *more* portable than what they currently
> need" is a culture shock for user space and kernel space alike. But
> if we get all our ducks in a row on the Rust side, eventually it
> should just be "too tempting", and the code sharing will happen for
> economic reasons (rather than ideological ones about trying to smash
> down the arbitrary dichotomies :) going it alone).
> 
> The larger issue is major projects closed off unto themselves such as
> Linux, PostgreSQL, or even the Glasgow Haskell Compiler (something I
> am currently writing a plan to untangle) have fallen too deep in
> Conway's law's embrace, and thus are full of bad habits like
> https://johno.com/composition-over-configuration is arguing against.
> Over time, I hope using external libraries will not only result in
> less duplicated work, but also "pry open" their architecture a bit,
> tamping down on crazy configurability and replacing it with more
> principled composition.
> 
> I fear this is all way too spicy to bring up on the LKML in 2022, at
> least coming from someone like me without any landed kernel patches
> under his belt, but I wanted to let you know other people have
> similar thoughts.
> 
> Cheers,
> 
> John
> 
> -------
> 
> Re: Rust in Linux, I get frustrated when I see senior people tell the
> new Rust people "don't do that" to things that are standard practice
> in the outside world.

You stripped the nuance of that.  I said many no_std crates could be
used in the kernel.  I also said that the async crate couldn't because
the rust compiler itself would have to support the kernel threading
model.

> I think Linus said recently that Rust in the kernel is something that
> could fail, and he's right - but if it fails, it won't just be the
> failure of the Rust people to do the required work, it'll be _our_
> failure too, a failure to work with them.

The big risk is that rust needs to adapt to the kernel environment. 
This isn't rust specific, llvm had similar issues as an alternative C
compiler.  I think rust in the kernel would fail if it were only the
rust kernel people asking.  Fortunately the pressure to support rust in
embedded leading to the rise in no_std crates is a force which can also
get rust in the kernel over the finish line because of the focus it
puts on getting the language and crates to adapt to non standard
environments.

[...]
> The kernel community has a lot of that going on here. Again, sorry to
> pick on you James, but I wanted to make the argument that - maybe the
> kernel _should_ be adopting a more structured way of using code from
> outside repositories, like cargo, or git submodules (except I've
> never had a positive experience with git submodules, so ignore that
> suggestion, unless I've just been using them wrong, in which case
> someone please teach me). To read you and Greg saying "nah, just
> copy code from other repos, it's fine" - it felt like being back in
> the old days when we were still trying to get people to use source
> control, and having that one older colleague who _insisted_ on not
> using source control of any kind, and that's a bit disheartening.

Even in C terms, the kernel is a nostdlib environment.  If a C project
has too much libc dependency it's not going to work directly in the
kernel, nor should it.  Let's look at zstd (which is pretty much a
nostdlib project) as a great example: the facebook people didn't
actually port the top of their tree (1.5) to the kernel, they
backported bug fixes to the 1.4 branch and made a special release
(1.4.10) just for us.  Why did they do this?  It was because the 1.5
version vastly increased stack use to the extent it would run off the
end of the limited kernel stack so couldn't be ported directly into the
kernel.  A lot of C libraries that are nostdlib have problems like this
as well (you can use recursion, but not in the kernel).  There's no
easy way of shimming environmental constraints like this.

The lesson: it is possible to make the core of a project mobile, but
only if you're aware of all the environmental constraints it will run
into as it gets ported.  The list of possible environments is huge:
kernel, embedded, industrial control ..., so naturally not every (or
more accurately hardly any) project wants to do this.

James


