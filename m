Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D84AB2D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 00:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbiBFXt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 18:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiBFXt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 18:49:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97BDC06173B;
        Sun,  6 Feb 2022 15:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MpQjrlTLnVxKgZ7jCVb5tO5mQ1meEPBYeK4gt4DOvhY=; b=WwOlhNowNrHrdSPA6N4WDTuEQO
        Xt5oFx2/3Y0szKUljYS4634SPvxdb/HEG+TDdMPgCpr9ZEblgjYqTWVvChNykIk4+wJO+LAHSIpgA
        N69CxswjusSnEUhGGdpTRvi7wmQYZe4DGDBln9vTrAltNa9HyFVRJ0Ct7qwBu/xh8KWwuSfIzh8lE
        eTrzhAU6gFVu9CFbI4KvISakbbNNxmhoyRX2WADdSGX/cmZjdYF4fcMUIZH8ZYxuIR+nKMPy+2LJs
        1rLJAl22beKdbcD0U+Qyd1fjchpiZNODBuGvtaWLKWq5YxiWc05BW40iaTGpTmFfuYGh6W5LZ6HnU
        bV8Qn9+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGrHW-00G6b5-OO; Sun, 06 Feb 2022 23:49:22 +0000
Date:   Sun, 6 Feb 2022 23:49:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     FMDF <fmdefrancesco@gmail.com>, linux-fsdevel@vger.kernel.org,
        BTRFS <linux-btrfs@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: How to debug stuck read?
Message-ID: <YgBegj4a/0/PkRlc@casper.infradead.org>
References: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
 <YfrX1BVIlIwiVYzs@casper.infradead.org>
 <CAOE4rSz1OTRYQPa4PUrQ-=cwSM3iVY977Uz_d77E2j-kH0G3rA@mail.gmail.com>
 <CAPj211uKvndvR40Vjh9WAf4wRbaV5MSnmUsvDAEAKv3Q+2tDkA@mail.gmail.com>
 <Yf/DiefrNOkib5mm@casper.infradead.org>
 <CAPj211uFgCyri=RKnOJs2cV7-9FRFjOPLti8Jo0ODZeHEPgGAw@mail.gmail.com>
 <CAOE4rSzJtDwDpb6PDN-E1i=b5p6jePu7wnKKgwr8dnwextaxUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOE4rSzJtDwDpb6PDN-E1i=b5p6jePu7wnKKgwr8dnwextaxUw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 07, 2022 at 01:21:53AM +0200, Dāvis Mosāns wrote:
> svētd., 2022. g. 6. febr., plkst. 13:01 — lietotājs FMDF
> (<fmdefrancesco@gmail.com>) rakstīja:
> [...]
> > There is no special recipe for debugging "this properly" :)
> >
> > You wrote that "by pure luck" you found a memcpy() that wrote beyond the
> > limit of allocated memory. I suppose that you found that faulty memcpy()
> > somewhere in one of the function listed in the stack trace.
> >
> > That's the right approach! You read the calls chain and find out where something
> > looks wrong and then fix it. This is why stack traces are so helpful.
> >
> > It was not "pure luck". I think that you did what developers usually do after
> > decoding a stack trace. If not, how did you find that faulty memcpy() buried
> > somewhere in 40 millions lines of code?
> >
> > it seems that you've found the right way to figure out the problems in code
> > that (probably) you had not ever worked on or read before you hit that bug.
> >
> 
> I think there should be a way to see which locks (and by who/where)
> have been taken for a long time.

Well ... we do, but the problem is that the page lock is a single bit.
We just don't have the space in struct page for a pointer to a stack
trace.  So the page lock isn't like a spinlock or a mutex where we can
use the LOCKDEP infrastructure to tell us this kind of thing.

Also, in this case, we know exactly where the lock was taken and by whom
-- and it would be no more information than you had from the stack trace.
Something I slightly regret is that you used to get a "task blocked for
more than 120 seconds" message from check_hung_task().  But I made
that not show up in this path because I made the sleep killable and
that's only called for UNINTERRUPTIBLE tasks.

Maybe that should be changed.  Perhaps we should emit those messages
for TASK_KILLABLE too.

> Yep, fully sure and tested :P I'm able to reproduce stuck process with
> 100% reliability. After applying my patch it returns EIO as expected
> and doesn't get stuck.
> If you look at copy_compressed_segment (in fs/btrfs/lzo.c) you'll see
>   kaddr = kmap(cur_page);
>   memcpy(dest + *cur_in - orig_in,
>                  kaddr + offset_in_page(*cur_in), copy_len);
>   kunmap(cur_page);
> 
> My guess is that kmap(cur_page) locks that page, then memcpy crashes
> so that page never gets unmapped causing anyone that tries to map it
> to wait forever. Hence this can be reproduced only once per boot. If I
> knew how to find kernel thread that is running this we could check
> it's stack and it should be stuck here on kmap.

kmap() doesn't lock the page; it's already locked at this point.
But if the memcpy() does crash then you're right, the page will never
be unlocked because it was this thread's job to unlock it when the page
was uptodate.  The thread will be dead, so there's no way to find it.
Do we not dump the thread's stack on its death?
