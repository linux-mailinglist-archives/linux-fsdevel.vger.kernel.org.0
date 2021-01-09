Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAFC2F03E6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 22:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbhAIVvR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sat, 9 Jan 2021 16:51:17 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:59450 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbhAIVvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:51:16 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-29-ccqyaF9BNQizm39n7NY-ag-1; Sat, 09 Jan 2021 21:49:28 +0000
X-MC-Unique: ccqyaF9BNQizm39n7NY-ag-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 9 Jan 2021 21:49:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 9 Jan 2021 21:49:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iov_iter: optimise iter type checking
Thread-Topic: [PATCH] iov_iter: optimise iter type checking
Thread-Index: AQHW5qm9/hT6YRd33Eq5lMaMuw9mB6of0+hQ
Date:   Sat, 9 Jan 2021 21:49:27 +0000
Message-ID: <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210109170359.GT3579531@ZenIV.linux.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro
> Sent: 09 January 2021 17:04
> 
> On Sat, Jan 09, 2021 at 04:09:08PM +0000, Pavel Begunkov wrote:
> > On 06/12/2020 16:01, Pavel Begunkov wrote:
> > > On 21/11/2020 14:37, Pavel Begunkov wrote:
> > >> The problem here is that iov_iter_is_*() helpers check types for
> > >> equality, but all iterate_* helpers do bitwise ands. This confuses
> > >> compilers, so even if some cases were handled separately with
> > >> iov_iter_is_*(), corresponding ifs in iterate*() right after are not
> > >> eliminated.
> > >>
> > >> E.g. iov_iter_npages() first handles discards, but iterate_all_kinds()
> > >> still checks for discard iter type and generates unreachable code down
> > >> the line.
> > >
> > > Ping. This one should be pretty simple
> >
> > Ping please. Any doubts about this patch?
> 
> Sorry, had been buried in other crap.  I'm really not fond of the
> bitmap use; if anything, I would rather turn iterate_and_advance() et.al.
> into switches...

That loses any optimisations in the order of the comparisons.
The bitmap also allows different groups to be optimised for in different code paths.

> How about moving the READ/WRITE part into MSB?  Checking is just as fast
> (if not faster - check for sign vs. checking bit 0).  And turn the
> types into straight (dense) enum.

Does any code actually look at the fields as a pair?
Would it even be better to use separate bytes?
Even growing the on-stack structure by a word won't really matter.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

