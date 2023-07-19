Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206F75A04B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 23:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGSVCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 17:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGSVCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:02:19 -0400
Received: from resdmta-h1p-028482.sys.comcast.net (resdmta-h1p-028482.sys.comcast.net [IPv6:2001:558:fd02:2446::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A011BF0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 14:02:17 -0700 (PDT)
Received: from resomta-h1p-027914.sys.comcast.net ([96.102.179.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resdmta-h1p-028482.sys.comcast.net with ESMTP
        id M7Ctqb4JKKSvQMEJNqoJgG; Wed, 19 Jul 2023 21:02:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1689800537;
        bh=xqMj+3VVjo+8UbUEghVnxRyNG8G2SG/j/lJTsRoSPsQ=;
        h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
         Content-Type:Xfinity-Spam-Result;
        b=bpXpu4cnAsB+PwhqcFILiRYvifqY7YsP2R73EKJI/mMKcD03KK9zSgEvJY6V1eQxZ
         O48cFGo04dxs1KwuFr1cY3DbMtWEe1nQSDLGquT9O4QJSrRkWsB5qHkrISkc8udFop
         xX8gK89pqLTwxiERr5TO86isabaitAD0JLyO2yTNtu556ggcUmivNG8ODVsMbT/FkY
         t7GUgbiEhC8FvQU8MleCzVQjkYwUQOFWfGkg9GygBTVlVR2OQyauOna1NpjEGxkXq/
         dqq5U4T5JXdFj7RXtJJF5hJyBGJDiJQAwjU+qZHCEm7pZ0McW6d2ZsmZh1wcAZyiWR
         Us2UjIZ1ynpeQ==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-h1p-027914.sys.comcast.net with ESMTPSA
        id MEJAqBpSU0WpqMEJCqnizK; Wed, 19 Jul 2023 21:02:12 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Matt Whitlock <kernel@mattwhitlock.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, <netdev@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@kvack.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after =?iso-8859-1?Q?splice()_returns?=
Date:   Wed, 19 Jul 2023 17:02:04 -0400
MIME-Version: 1.0
Message-ID: <6609f1b8-3264-4017-ac3c-84a01ea12690@mattwhitlock.name>
In-Reply-To: <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
 <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
 <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org>
 <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, 19 July 2023 16:16:07 EDT, Linus Torvalds wrote:
> The *ONLY* reason for splice() existing is for zero-copy.

The very first sentence of splice(2) reads: "splice() moves data between=20
two file descriptors without copying between kernel address space and user=20=

address space." Thus, it is not unreasonable to believe that the point of=20
splice is to avoid copying between user-space and kernel-space.

If you use read() and write(), then you're making two copies. If you use=20
splice(), then you're making one copy (or zero, but that's an optimization=20=

that should be invisible to the user).

> And no, we don't start some kind of crazy "versioned zero-copy with
> COW". That's a fundamental mistake.

Agreed. splice() should steal the reference if it can, copy the page data=20
if it must. Note that, even in the slow case where the page data must be=20
copied, this still gives a better-than-50% speedup over read()+write()=20
since an entire copy (and one syscall) is elided.

> IF YOU DON'T UNDERSTAND THE *POINT* OF SPLICE, DON'T USE SPLICE.

Thanks for being so condescending. Your reputation is deserved.

