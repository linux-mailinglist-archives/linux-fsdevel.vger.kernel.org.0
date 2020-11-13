Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA612B1ABF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 13:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMMFI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 07:05:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23464 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbgKML1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:27:48 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-74-q55dkbMJN9iy_mSgtJxHNQ-1; Fri, 13 Nov 2020 11:27:42 +0000
X-MC-Unique: q55dkbMJN9iy_mSgtJxHNQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 13 Nov 2020 11:27:41 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 13 Nov 2020 11:27:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yicong Yang' <yangyicong@hisilicon.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "prime.zeng@huawei.com" <prime.zeng@huawei.com>
Subject: RE: [PATCH v2] libfs: fix error cast of negative value in
 simple_attr_write()
Thread-Topic: [PATCH v2] libfs: fix error cast of negative value in
 simple_attr_write()
Thread-Index: AQHWuaN2HYrg6O40uUKH2XiBcGhEHanF7BWQ
Date:   Fri, 13 Nov 2020 11:27:41 +0000
Message-ID: <accad76be7dd4b20a3206bbb4ee86688@AcuMS.aculab.com>
References: <1605261369-551-1-git-send-email-yangyicong@hisilicon.com>
In-Reply-To: <1605261369-551-1-git-send-email-yangyicong@hisilicon.com>
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

From: Yicong Yang
> Sent: 13 November 2020 09:56
> The attr->set() receive a value of u64, but simple_strtoll() is used
> for doing the conversion. It will lead to the error cast if user inputs
> a negative value.
> 
> Use kstrtoull() instead of simple_strtoll() to convert a string got
> from the user to an unsigned value. The former will return '-EINVAL' if
> it gets a negetive value, but the latter can't handle the situation
> correctly.
> 
> Fixes: f7b88631a897 ("fs/libfs.c: fix simple_attr_write() on 32bit machines")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Change since v1:
> - address the compile warning for non-64 bit platform
> 
>  fs/libfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index fc34361..3a0d99c 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -977,7 +977,9 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
>  		goto out;
> 
>  	attr->set_buf[size] = '\0';
> -	val = simple_strtoll(attr->set_buf, NULL, 0);
> +	ret = kstrtoull(attr->set_buf, 0, (unsigned long long *)&val);

That cast is horrid.
Casting 'pointer to integer' types is just asking for trouble.
You either need to change the type of 'val' or use an
intermediary variable of the correct type.

	David

> +	if (ret)
> +		goto out;
>  	ret = attr->set(attr->data, val);
>  	if (ret == 0)
>  		ret = len; /* on success, claim we got the whole input */
> --
> 2.8.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

