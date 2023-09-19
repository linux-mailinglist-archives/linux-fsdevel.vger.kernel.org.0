Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514917A66CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjISOfz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjISOfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:35:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4580BF
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 07:35:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-286-os4Jn-dCOAGz3FBPVajm3w-1; Tue, 19 Sep 2023 15:35:30 +0100
X-MC-Unique: os4Jn-dCOAGz3FBPVajm3w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 19 Sep
 2023 15:35:25 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 19 Sep 2023 15:35:25 +0100
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
Thread-Index: AQHZ6Kr+hLdybFnA00ugx5L/MFgM8bAiJxPQgAABTgCAABHZMA==
Date:   Tue, 19 Sep 2023 14:35:25 +0000
Message-ID: <cffc2a427ae74f62b07345ec9348e43e@AcuMS.aculab.com>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
 <ZQmvhC+pGWNs9R23@casper.infradead.org>
In-Reply-To: <ZQmvhC+pGWNs9R23@casper.infradead.org>
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

From: Matthew Wilcox <willy@infradead.org>
> Sent: 19 September 2023 15:26
> 
> On Tue, Sep 19, 2023 at 01:23:08PM +0000, David Laight wrote:
> > > Well, that sucks.  What do you suggest for Coldfire?
> >
> > Can you just do a 32bit xor ?
> > Unless you've got smp m68k I'd presume it is ok?
> > (And assuming you aren't falling off a page.)
> 
> Patch welcome.

My 68020 book seems to be at work and I'm at home.
(The 286, 386 and cy7c600 (sparc 32) books don't help).

But if the code is trying to do *ptr ^= 0x80 and check the
sign flag then you just need to use eor.l with 0x80000000
on the same address.
All the 68k I used would do misaligned accesses.
Although they can fault mid-instruction on the microcode stack.
Any smp 68020 had to be certain to resume on the same cpu.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

