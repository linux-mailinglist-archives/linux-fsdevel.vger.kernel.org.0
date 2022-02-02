Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF04A6CFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 09:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244979AbiBBIge convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 2 Feb 2022 03:36:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:47841 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244976AbiBBIgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:36:32 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-304-qvtV4wYlOH6zdYT9C5g9RA-1; Wed, 02 Feb 2022 08:36:07 +0000
X-MC-Unique: qvtV4wYlOH6zdYT9C5g9RA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 2 Feb 2022 08:36:05 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 2 Feb 2022 08:36:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christian Brauner' <brauner@kernel.org>, Eryu Guan <guan@eryu.me>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     Ariadne Conill <ariadne@dereferenced.org>,
        Kees Cook <keescook@chromium.org>,
        Rich Felker <dalias@libc.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: RE: [PATCH] generic/633: adapt execveat() invocations
Thread-Topic: [PATCH] generic/633: adapt execveat() invocations
Thread-Index: AQHYFsV/LMkcY0pxnUSlYg+O6JXWfqx/8a7A
Date:   Wed, 2 Feb 2022 08:36:05 +0000
Message-ID: <08ff2c7dd57449a7ae9de70ba007c5fd@AcuMS.aculab.com>
References: <20220131171023.2836753-1-brauner@kernel.org>
In-Reply-To: <20220131171023.2836753-1-brauner@kernel.org>
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

From: Christian Brauner
> Sent: 31 January 2022 17:10
> 
> There's a push by Ariadne to enforce that argv[0] cannot be NULL. So far
> we've allowed this. Fix the execveat() invocations to set argv[0] to the
> name of the file we're about to execute.
> 
...
>  src/idmapped-mounts/idmapped-mounts.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index 4cf6c3bb..76b559ae 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -3598,7 +3598,7 @@ static int setid_binaries(void)
>  			NULL,
>  		};
>  		static char *argv[] = {
> -			NULL,
> +			"",
>  		};

Isn't that just plain wrong?
argv[] needs to be terminated by a NULL so you need to add the ""
before the NULL not replace the NULL by it.

Quite how this matches the patch description is another matter...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

