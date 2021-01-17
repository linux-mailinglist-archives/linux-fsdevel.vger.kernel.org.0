Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F22F9242
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 13:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbhAQMOa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 07:14:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:46933 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728131AbhAQMO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 07:14:27 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-235-t1_aKn7QNNi0mUNHc-a20Q-1; Sun, 17 Jan 2021 12:12:48 +0000
X-MC-Unique: t1_aKn7QNNi0mUNHc-a20Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 17 Jan 2021 12:12:47 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 17 Jan 2021 12:12:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iov_iter: optimise iter type checking
Thread-Topic: [PATCH] iov_iter: optimise iter type checking
Thread-Index: AQHW5qm9/hT6YRd33Eq5lMaMuw9mB6of0+hQgAnsyIGAAgC4EA==
Date:   Sun, 17 Jan 2021 12:12:47 +0000
Message-ID: <6d5bd939aeaf425bbecf36a95c307f94@AcuMS.aculab.com>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
 <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
 <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
 <20210116051818.GF3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210116051818.GF3579531@ZenIV.linux.org.uk>
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
> Sent: 16 January 2021 05:18
> 
> On Sat, Jan 09, 2021 at 10:11:09PM +0000, Pavel Begunkov wrote:
> 
> > > Does any code actually look at the fields as a pair?
> > > Would it even be better to use separate bytes?
> > > Even growing the on-stack structure by a word won't really matter.
> >
> > u8 type, rw;
> >
> > That won't bloat the struct. I like the idea. If used together compilers
> > can treat it as u16.
> 
> Reasonable, and from what I remember from looking through the users,
> no readers will bother with looking at both at the same time.

I couldn't find any.
...
> So... something like (completely untested) variant below, perhaps?
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 72d88566694e..ed8ad2c5d384 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -19,20 +19,16 @@ struct kvec {
> 
>  enum iter_type {
>  	/* iter types */
> -	ITER_IOVEC = 4,
> -	ITER_KVEC = 8,
> -	ITER_BVEC = 16,
> -	ITER_PIPE = 32,
> -	ITER_DISCARD = 64,
> +	ITER_IOVEC,
> +	ITER_KVEC,
> +	ITER_BVEC,
> +	ITER_PIPE,
> +	ITER_DISCARD
>  };
> 
>  struct iov_iter {
> -	/*
> -	 * Bit 0 is the read/write bit, set if we're writing.
> -	 * Bit 1 is the BVEC_FLAG_NO_REF bit, set if type is a bvec and
> -	 * the caller isn't expecting to drop a page reference when done.
> -	 */
> -	unsigned int type;
> +	u8 iter_type;
> +	bool data_source;

I'd leave it as 'u8 direction' and assign READ (0) or WRITE (1) to it.
It will always be confusing whether WRITE means a 'write' system call
or a transfer that will write into the buffer (eg a read system call).

I'm pretty sure I can detect the performance change from forcing
the compiler to convert values to 'bool'.

...

Since you've still got tests like:

> +	if (i->iter_type == ITER_BVEC || i->iter_type == ITER_KVEC) {

It is probably still worth using bit values.
After all, the only thing that benefits from small dense integers
is a case statement lookup table - and we don't do those any more.

Otherwise you might as well use 'i', 'k', 'b', 'p' and 'd' so that
anyone hexdumping the structure (or reading the asm decode) knows
the type without having to go and look it up.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

