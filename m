Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E63143048
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 17:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgATQvi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 11:51:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:42366 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbgATQvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:51:38 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-154-mp5ZcybCPZC3Psf2uuXE4w-1; Mon, 20 Jan 2020 16:51:35 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 20 Jan 2020 16:51:34 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 20 Jan 2020 16:51:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>
CC:     =?iso-8859-1?Q?=27Pali_Roh=E1r=27?= <pali.rohar@gmail.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Namjae Jeon" <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: RE: vfat: Broken case-insensitive support for UTF-8
Thread-Topic: vfat: Broken case-insensitive support for UTF-8
Thread-Index: AQHVz4FsiOVqsS4Qp0SucuDN4afIhKfzph4wgAAFE4CAAADOMIAADbUAgAAIwlA=
Date:   Mon, 20 Jan 2020 16:51:34 +0000
Message-ID: <db8161512f33468981cbc49e71b7bf05@AcuMS.aculab.com>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp> <20200120110438.ak7jpyy66clx5v6x@pali>
 <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
 <20200120152009.5vbemgmvhke4qupq@pali>
 <1a4c545dc7f14e33b7e59321a0aab868@AcuMS.aculab.com>
 <20200120161206.GC8904@ZenIV.linux.org.uk>
In-Reply-To: <20200120161206.GC8904@ZenIV.linux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: mp5ZcybCPZC3Psf2uuXE4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro
> Sent: 20 January 2020 16:12
> > From: Pali Rohár
> > > Sent: 20 January 2020 15:20
> > ...
> > > This is not possible. There is 1:1 mapping between UTF-8 sequence and
> > > Unicode code point. wchar_t in kernel represent either one Unicode code
> > > point (limited up to U+FFFF in NLS framework functions) or 2bytes in
> > > UTF-16 sequence (only in utf8s_to_utf16s() and utf16s_to_utf8s()
> > > functions).
> >
> > Unfortunately there is neither a 1:1 mapping of all possible byte sequences
> > to wchar_t (or unicode code points), nor a 1:1 mapping of all possible
> > wchar_t values to UTF-8.
> > Really both need to be defined - even for otherwise 'invalid' sequences.
> 
> Who.  Cares?
> 
> Filename is a sequence of octets, not codepoints.  Its interpretation is
> entirely up to the userland.

For filesystems that really ought to be true.
Saves a lot of problems in the kernel.

I guess the fat driver has to do something to convert the UCS-16 on-disk filenames
to/from a sequence of octets.

Even Microsoft have made it much easier to have case-dependant
NTS4 filesystems in windows 10.
(Ever watched the number of different cases in the list of c:/windows/system32/drivers/*.sys
filenames output when windows boots? They are nearly all different!)

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

