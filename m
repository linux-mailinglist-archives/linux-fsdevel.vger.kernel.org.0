Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D1D587893
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 10:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiHBIA4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 2 Aug 2022 04:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiHBIAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:00:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A70C627B
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 01:00:53 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-308-TQG7PYX_M7ubdYwPcl-8wA-1; Tue, 02 Aug 2022 09:00:50 +0100
X-MC-Unique: TQG7PYX_M7ubdYwPcl-8wA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 2 Aug 2022 09:00:48 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 2 Aug 2022 09:00:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Boqun Feng' <boqun.feng@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>
CC:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        "Luc Maranget" <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Daniel Lustig" <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] introduce test_bit_acquire and use it in
 wait_on_bit
Thread-Topic: [PATCH v4 1/2] introduce test_bit_acquire and use it in
 wait_on_bit
Thread-Index: AQHYpdMdL3R9dRhMTUG852+RirbLDa2bPhCA
Date:   Tue, 2 Aug 2022 08:00:48 +0000
Message-ID: <31eb3681cfcf4b238a12a82c175457bc@AcuMS.aculab.com>
References: <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
 <alpine.LRH.2.02.2208010640260.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <20220801155421.GB26280@willie-the-truck>
 <alpine.LRH.2.02.2208011206430.31960@file01.intranet.prod.int.rdu2.redhat.com>
 <YugYuBzIkr+gN5Vi@boqun-archlinux>
In-Reply-To: <YugYuBzIkr+gN5Vi@boqun-archlinux>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boqun Feng
> Sent: 01 August 2022 19:17
> 
> On Mon, Aug 01, 2022 at 12:12:47PM -0400, Mikulas Patocka wrote:
> >
> >
> > On Mon, 1 Aug 2022, Will Deacon wrote:
> >
> > > On Mon, Aug 01, 2022 at 06:42:15AM -0400, Mikulas Patocka wrote:
> > >
> > > > Index: linux-2.6/arch/x86/include/asm/bitops.h
> > > > ===================================================================
> > > > --- linux-2.6.orig/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > > > +++ linux-2.6/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > > > @@ -203,8 +203,10 @@ arch_test_and_change_bit(long nr, volati
> > > >
> > > >  static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
> > > >  {
> > > > -	return ((1UL << (nr & (BITS_PER_LONG-1))) &
> > > > +	bool r = ((1UL << (nr & (BITS_PER_LONG-1))) &
> > > >  		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> > > > +	barrier();
> > > > +	return r;
> > >
> > > Hmm, I find it a bit weird to have a barrier() here given that 'addr' is
> > > volatile and we don't need a barrier() like this in the definition of
> > > READ_ONCE(), for example.
> >
> > gcc doesn't reorder two volatile accesses, but it can reorder non-volatile
> > accesses around volatile accesses.
> >
> > The purpose of the compiler barrier is to make sure that the non-volatile
> > accesses that follow test_bit are not reordered by the compiler before the
> > volatile access to addr.
> >
> 
> Better to have a constant_test_bit_acquire()? I don't think all
> test_bit() call sites need the ordering?

It is also unlikely that the compiler will 'usefully' move a read
across the test_bit() call - which is likely to be in a conditional.
So barrier() is unlikely to significantly affect the generated code.

Indeed, perhaps test_bit() should always enforce read ordering
even one weakly ordered cpu?
It is used with set_bit() and clear_bit() which are expensive
locked operations - so a slightly more expensive test_bit()
probably doesn't matter.

Remember these aren't functions to replace &= and |=.
(In spite of some code paths.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

