Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1002D121038
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 17:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLPQzs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 11:55:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43465 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfLPQzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:55:47 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-195-1f9oIHnwPl23IcvHT4alyA-1; Mon, 16 Dec 2019 16:55:45 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 16 Dec 2019 16:55:44 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 16 Dec 2019 16:55:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Aleksa Sarai' <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        "dev@opencontainers.org" <dev@opencontainers.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] openat2: switch to __attribute__((packed)) for open_how
Thread-Topic: [PATCH] openat2: switch to __attribute__((packed)) for open_how
Thread-Index: AQHVs0QYCtoODE3sD0awPNQRMi+YuKe8+0pQ
Date:   Mon, 16 Dec 2019 16:55:44 +0000
Message-ID: <b26ef210ec5b42009cf09b1015065768@AcuMS.aculab.com>
References: <20191213222351.14071-1-cyphar@cyphar.com>
 <a328b91d-fd8f-4f27-b3c2-91a9c45f18c0@rasmusvillemoes.dk>
 <20191215123443.jmfnrtgbscdwfohc@yavin.dot.cyphar.com>
In-Reply-To: <20191215123443.jmfnrtgbscdwfohc@yavin.dot.cyphar.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 1f9oIHnwPl23IcvHT4alyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From:  Aleksa Sarai
> Sent: 15 December 2019 12:35
> On 2019-12-14, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> > On 13/12/2019 23.23, Aleksa Sarai wrote:
> > > The design of the original open_how struct layout was such that it
> > > ensured that there would be no un-labelled (and thus potentially
> > > non-zero) padding to avoid issues with struct expansion, as well as
> > > providing a uniform representation on all architectures (to avoid
> > > complications with OPEN_HOW_SIZE versioning).
> > >
> > > However, there were a few other desirable features which were not
> > > fulfilled by the previous struct layout:
> > >
> > >  * Adding new features (other than new flags) should always result in
> > >    the struct getting larger. However, by including a padding field, it
> > >    was possible for new fields to be added without expanding the
> > >    structure. This would somewhat complicate version-number based
> > >    checking of feature support.
> > >
> > >  * A non-zero bit in __padding yielded -EINVAL when it should arguably
> > >    have been -E2BIG (because the padding bits are effectively
> > >    yet-to-be-used fields). However, the semantics are not entirely clear
> > >    because userspace may expect -E2BIG to only signify that the
> > >    structure is too big. It's much simpler to just provide the guarantee
> > >    that new fields will always result in a struct size increase, and
> > >    -E2BIG indicates you're using a field that's too recent for an older
> > >    kernel.
> >
> > And when the first extension adds another u64 field, that padding has to
> > be added back in and checked for being 0, at which point the padding is
> > again yet-to-be-used fields.
> 
> Maybe I'm missing something, but what is the issue with
> 
>   struct open_how {
>     u64 flags;
>     u64 resolve;
>     u16 mode;
> 	u64 next_extension;
>   } __attribute__((packed));

Compile anything that accesses it for (say) sparc and look at the object code.
You really, really, REALLY, don't want to EVER use 'packed'.

Just use u64 for all the fields.
Use 'flags' bits to indicate whether the additional fields should be looked at.
Error if a 'flags' bit requires a value that isn't passed in the structure.

Then you can add an extra field and old source code recompiled with the
new headers will still work - because the 'junk' value isn't looked at.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

