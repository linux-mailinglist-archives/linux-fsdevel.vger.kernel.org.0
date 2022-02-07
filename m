Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0AA4AB304
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 02:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbiBGBGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 20:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGBGG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:06:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E31C06173B;
        Sun,  6 Feb 2022 17:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=w0dj39EYy9mbYnttD34L/fMNS6VGPw0fdayuGTpq4Eo=; b=I2OGsHUy4+QvHwYlgdDDQclC34
        dd4QrdG2PiVTU5J3B1cOkJrfXsUlY0JHVcMexdTsr24YZDS1axz9CcIMPEruzHH07zqJfNq34vOLB
        hMdKdH2ZYdbS2HocBmBWPPSCfgro8LmiaVb+l6Z8Iqwh3+W+7LJXv6fSl0+cUb93hhTHN0TOBtZNr
        KVSflV0iguDpb5BRrq45ZSknYk3ufIwg2V4i3SoOyGWLT1G9MqZHMUNagKi0d/9D7ON/ZOlSMbOrY
        2r6Vj8wjeuFWh9kRPKdzAiSndesXSM1VEEEZm00ItoDNQcbu7QbyhdGY52RIpuaF+kkmaGTmkkDk1
        Ux0GDmKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGsTi-00GJP0-Jz; Mon, 07 Feb 2022 01:06:02 +0000
Date:   Mon, 7 Feb 2022 01:06:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     FMDF <fmdefrancesco@gmail.com>, linux-fsdevel@vger.kernel.org,
        BTRFS <linux-btrfs@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: How to debug stuck read?
Message-ID: <YgBwet7Av2qkaMaJ@casper.infradead.org>
References: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
 <YfrX1BVIlIwiVYzs@casper.infradead.org>
 <CAOE4rSz1OTRYQPa4PUrQ-=cwSM3iVY977Uz_d77E2j-kH0G3rA@mail.gmail.com>
 <CAPj211uKvndvR40Vjh9WAf4wRbaV5MSnmUsvDAEAKv3Q+2tDkA@mail.gmail.com>
 <Yf/DiefrNOkib5mm@casper.infradead.org>
 <CAPj211uFgCyri=RKnOJs2cV7-9FRFjOPLti8Jo0ODZeHEPgGAw@mail.gmail.com>
 <CAOE4rSzJtDwDpb6PDN-E1i=b5p6jePu7wnKKgwr8dnwextaxUw@mail.gmail.com>
 <YgBegj4a/0/PkRlc@casper.infradead.org>
 <CAOE4rSxV-BbpwNYe7cfY8Ag_mWY930yG3pubqASKHjsKXAp6TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOE4rSxV-BbpwNYe7cfY8Ag_mWY930yG3pubqASKHjsKXAp6TA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 07, 2022 at 02:07:47AM +0200, Dāvis Mosāns wrote:
> > > I think there should be a way to see which locks (and by who/where)
> > > have been taken for a long time.
> >
> > Well ... we do, but the problem is that the page lock is a single bit.
> > We just don't have the space in struct page for a pointer to a stack
> > trace.  So the page lock isn't like a spinlock or a mutex where we can
> > use the LOCKDEP infrastructure to tell us this kind of thing.
> >
> > Also, in this case, we know exactly where the lock was taken and by whom
> > -- and it would be no more information than you had from the stack trace.
> 
> The issue here is that you have a stuck task that doesn't have any
> crash/stack trace. The process itself is waiting in
> folio_wait_bit_common but I need to find the other side of it.

Right, but what you're asking for won't help find the other side.
It's just an automated way to find the side you did find.

> > kmap() doesn't lock the page; it's already locked at this point.
> > But if the memcpy() does crash then you're right, the page will never
> > be unlocked because it was this thread's job to unlock it when the page
> > was uptodate.  The thread will be dead, so there's no way to find it.
> > Do we not dump the thread's stack on its death?
> 
> Yeah there was, but as I said it happens only once per boot. So you
> have one (potentially old) crash/stacktrace but many stuck processes
> with no clear cause. Eg. you get crash and stuck process, kill
> process. Then days later you try reading that file again and it will
> get stuck but there won't be stacktrace as it won't reach that memcpy
> anymore.

I can't think of a way to solve that.  We can't know whether a dying task
"was going to" unlock a page.  So we have a locked page in the page cache
that nobody will ever unlock.  We can't remove it, because we don't know
that task died.  We can't start I/O on it again, because it looks like
I/O is already in progress.

I think the only answer is "Don't ignore stack dumps in dmesg".
