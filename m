Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C73C7A3145
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbjIPP7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjIPP7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:59:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32BC114;
        Sat, 16 Sep 2023 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w48b1gTGXHiaqxwJXgXOFHKSen7VOnpQ1+UdzbtV8mQ=; b=mSUuCOplScq5spGBc4yY1EjuuG
        C+5Ns+4ln0AVgDoLmm4dW2C3bau1nzQZSkJRoTq+kJi4tZNl1mPhkXfvuMSjRgc9NM1zrCZuomzJm
        5Lc9LWVh1e5QLAuTK3Hx8tnZ/DdaVqJpU6X0ZBs5/kt3I/pUJgkz2fQNhred2Y9uy4XvQze7BT+C1
        5npTOgn387mrIi6cQLGkUARogmX8+2Vpe8/1gpB8fw3S/HP/sSKuR74sr7xuHWSCzpkLrQksiQLBp
        b0N1qW+pkcz7JwohapppuB0nK9KYwRtxp8wIFD9mBTK6GEWEYrBzu4HwP8JO1CA10ObpqeXMl13qE
        yXT1oZ5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhXhk-00H0Wr-8s; Sat, 16 Sep 2023 15:59:32 +0000
Date:   Sat, 16 Sep 2023 16:59:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
Message-ID: <ZQXQ5OnAgisxVyKs@casper.infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-9-willy@infradead.org>
 <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
 <ZQT4/gA4vIa/7H6q@casper.infradead.org>
 <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 07:01:14PM -0700, Linus Torvalds wrote:
> On Fri, 15 Sept 2023 at 17:38, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Sep 15, 2023 at 05:27:17PM -0700, Linus Torvalds wrote:
> > > On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
> > > <willy@infradead.org> wrote:
> > > >
> > > > +       "1:     ldl_l %0,%4\n"
> > > > +       "       xor %0,%3,%0\n"
> > > > +       "       xor %0,%3,%2\n"
> > > > +       "       stl_c %0,%1\n"
> > >
> > > What an odd thing to do.
> > >
> > > Why don't you just save the old value? That double xor looks all kinds
> > > of strange, and is a data dependency for no good reason that I can
> > > see.
> > >
> > > Why isn't this "ldl_l + mov %0,%2 + xor + stl_c" instead?
> > >
> > > Not that I think alpha matters, but since I was looking through the
> > > series, this just made me go "Whaa?"
> >
> > Well, this is my first time writing Alpha assembler ;-)  I stole this
> > from ATOMIC_OP_RETURN:
> >
> >         "1:     ldl_l %0,%1\n"                                          \
> >         "       " #asm_op " %0,%3,%2\n"                                 \
> >         "       " #asm_op " %0,%3,%0\n"                                 \
> 
> Note how that does "orig" assignment first (ie the '%2" destination is
> the first instruction), unlike your version.

Wow.  I totally missed that I'd transposed those two lines.  I read
it back with the lines in the order that they should have been in.
Every time I read it.  I was wondering why you were talking about a data
dependency, and I just couldn't see it.  With the lines in the order that
they're actually in, it's quite obvious and totally not what I meant.
Of course, it doesn't matter which order they're in from the point of
view of testing the waiters bit since we don't change the waiters bit.

> Does any of this matter? Nope. It's alpha. There's probably a handful
> of machines, and it's maybe one extra cycle. It's really the oddity
> that threw me.

I'll admit to spending far more time on the m68k version of this than
the alpha version ;-)
