Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400582F20F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 21:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403920AbhAKUjp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 15:39:45 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:30756 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730894AbhAKUjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:39:44 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-181-LrIHlJGROP60njMXGZJVxQ-1; Mon, 11 Jan 2021 20:38:05 +0000
X-MC-Unique: LrIHlJGROP60njMXGZJVxQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 Jan 2021 20:38:04 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 Jan 2021 20:38:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] iov_iter: fix the uaccess area in
 copy_compat_iovec_from_user
Thread-Topic: [PATCH] iov_iter: fix the uaccess area in
 copy_compat_iovec_from_user
Thread-Index: AQHW6D4kBTWqpwzzr0yPRBs9OThlYaoi4ZVg
Date:   Mon, 11 Jan 2021 20:38:04 +0000
Message-ID: <051a78cc73484e7db68ee86a359a1ab5@AcuMS.aculab.com>
References: <20210111171926.1528615-1-hch@lst.de>
In-Reply-To: <20210111171926.1528615-1-hch@lst.de>
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

From: Christoph Hellwig
> Sent: 11 January 2021 17:19
> 
> sizeof needs to be called on the compat pointer, not the native one.
> 
> Fixes: 89cd35c58bc2 ("iov_iter: transparently handle compat iovecs in import_iovec")
> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  lib/iov_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1635111c5bd2af..586215aa0f15ce 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1658,7 +1658,7 @@ static int copy_compat_iovec_from_user(struct iovec *iov,
>  		(const struct compat_iovec __user *)uvec;
>  	int ret = -EFAULT, i;
> 
> -	if (!user_access_begin(uvec, nr_segs * sizeof(*uvec)))
> +	if (!user_access_begin(uvec, nr_segs * sizeof(*uiov)))

The first 'uvec' probably ought to be changed as well.
Even though both variables have the same value.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

