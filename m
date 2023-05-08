Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9247B6FA62B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 12:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjEHKRA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 8 May 2023 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjEHKQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 06:16:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BDB198A
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 May 2023 03:16:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-zOQH_hTdOyKBqVginv_Wrg-1; Mon, 08 May 2023 11:16:54 +0100
X-MC-Unique: zOQH_hTdOyKBqVginv_Wrg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 8 May
 2023 11:16:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 8 May 2023 11:16:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [GIT PULL] pipe: nonblocking rw for io_uring
Thread-Topic: [GIT PULL] pipe: nonblocking rw for io_uring
Thread-Index: AQHZgYiwlyUplQwnoEaMYF5kgipU769QJzcQ
Date:   Mon, 8 May 2023 10:16:53 +0000
Message-ID: <cdc5a86a8e6549ff90bb09b99d4cb651@AcuMS.aculab.com>
References: <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
 <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
 <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk>
 <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
 <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
 <CAHk-=wjSuGTLrmygUSNh==u81iWUtVzJ5GNSz0A-jbr4WGoZyw@mail.gmail.com>
 <20230425194910.GA1350354@hirez.programming.kicks-ass.net>
 <CAHk-=wjNfkT1oVLGbe2=Vymp66Ht=tk+YKa9gUL4T=_hA_JLjg@mail.gmail.com>
 <978690c4-1d25-46e8-3375-45940ec1ea51@huaweicloud.com>
 <20230508083929.GT83892@hirez.programming.kicks-ass.net>
In-Reply-To: <20230508083929.GT83892@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Peter Zijlstra
> Sent: 08 May 2023 09:39
> 
> On Sun, May 07, 2023 at 04:04:23PM +0200, Jonas Oberhauser wrote:
> >
> > Am 4/25/2023 um 9:58 PM schrieb Linus Torvalds:
> > > Yes, I think Mark is right. It's not that 'old' might be wrong - that
> > > doesn't matter because cmpxchg will work it out - it's just that 'new'
> > > might not be consistent with the old value we then use.
> >
> > In the general pattern, besides the potential issue raised by Mark, tearing
> > may also be an issue (longer example inspired by a case we met at the end of
> > the mail) where 'old' being wrong matters.
> 
> There is yet another pattern where it actually matters:
> 
> 	old = READ_ONCE(*ptr);
> 	do {
> 		if (cond(old))
> 			return false;
> 
> 		new = func(old);
> 	} while (!try_cmpxchg(ptr, &old, new));
> 
> 	return true;
> 
> In this case we rely on old being 'coherent'. The more obvious case is
> where it returns old (also not uncommon), but even if it just checks a
> (multi-bit) condition on old you don't want tearing.

It isn't as though READ_ONCE() is expensive.

For kernel/device driver code, while CSE is useful, you pretty
much always want the compiler to always do loads into local
variables.
It is rather a shame there isn't a compiler option that
avoids these unusual any annoying operations.

Since the current 'rules' seem to require READ_ONCE() and
WRITE_ONCE() be used as pairs, why not make the data 'volatile'?
That ought to be the same as using volatile casts on all accesses.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

