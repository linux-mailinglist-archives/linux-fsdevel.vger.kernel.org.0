Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C277A6871
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjISP6J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjISP6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:58:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3BBF2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 08:57:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-232-by0VL1p0PYKojar-QhGBLQ-1; Tue, 19 Sep 2023 16:57:41 +0100
X-MC-Unique: by0VL1p0PYKojar-QhGBLQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 19 Sep
 2023 16:57:36 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 19 Sep 2023 16:57:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>
CC:     Greg Ungerer <gregungerer@westnet.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: RE: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Thread-Topic: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Thread-Index: AQHZ6Kr+hLdybFnA00ugx5L/MFgM8bAiJxPQgAABTgCAABHZMP//+8IAgAARftD///eTgIAAEctA
Date:   Tue, 19 Sep 2023 15:57:36 +0000
Message-ID: <bfbf4d9ae5674d5dbe8c509abf5b0f84@AcuMS.aculab.com>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
 <ZQmvhC+pGWNs9R23@casper.infradead.org>
 <cffc2a427ae74f62b07345ec9348e43e@AcuMS.aculab.com>
 <ZQm67lGOBBdC2Dl9@casper.infradead.org>
 <c61a58a1f5a34f2b96c6043840635197@AcuMS.aculab.com>
 <ZQnCiZuMbFnwbEUt@casper.infradead.org>
In-Reply-To: <ZQnCiZuMbFnwbEUt@casper.infradead.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox
> Sent: 19 September 2023 16:47
> 
> On Tue, Sep 19, 2023 at 03:22:25PM +0000, David Laight wrote:
> > > Anyway, that's not the brief.  We're looking to (eg) clear bit 0
> > > and test whether bit 7 was set.  So it's the sign bit of the byte,
> > > not the sign bit of the int.
> >
> > Use the address of the byte as an int and xor with 1u<<24.
> > The xor will do a rmw on the three bytes following, but I
> > doubt that matters.
> 
> Bet you a shiny penny that Coldfire takes an unaligned access trap ...

and then the 'firmware' silently fixed it up for you a few 1000
clocks later...

> and besides, this is done on _every_ call to unlock_page().  That might
> cross not only a cacheline boundary but also a page boundary.  I cannot
> believe that would be a high-performing solution.  It might be just fine
> on m68000 but I bet even by the 030 it's lower performing.

I do remember managing to use 'cas2' to add an item to a linked list.
But it is so painful so setup it was better just to disable interrupts.
For non-smp that is almost certainly ok.
(Unless the instructions are slow because of synchronisation.)
Otherwise you need to use 'cas' on the aligned word.
Assuming coldfire even has cas.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

