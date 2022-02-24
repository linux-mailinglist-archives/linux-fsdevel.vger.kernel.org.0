Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFE24C2A4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 12:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiBXLGL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 06:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiBXLGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:06:09 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91B3B293A08
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 03:05:39 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-231-L_oAWQfwOO-nrY_yIXSoNw-1; Thu, 24 Feb 2022 11:05:36 +0000
X-MC-Unique: L_oAWQfwOO-nrY_yIXSoNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 24 Feb 2022 11:05:35 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 24 Feb 2022 11:05:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Meng Tang' <tangmeng@uniontech.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>
CC:     "guoren@kernel.org" <guoren@kernel.org>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "wad@chromium.org" <wad@chromium.org>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v2] fs/proc: Optimize arrays defined by struct ctl_path
Thread-Topic: [PATCH v2] fs/proc: Optimize arrays defined by struct ctl_path
Thread-Index: AQHYKWy3HNMHKpP9M0mvOc+sJsFjY6yiiFdA
Date:   Thu, 24 Feb 2022 11:05:35 +0000
Message-ID: <376fe4403af346ccbdc7294259b8d11a@AcuMS.aculab.com>
References: <20220224105234.19379-1-tangmeng@uniontech.com>
In-Reply-To: <20220224105234.19379-1-tangmeng@uniontech.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Meng Tang <tangmeng@uniontech.com>
> Sent: 24 February 2022 10:53
> 
> Previously, arrays defined by struct ctl_path is terminated
> with an empty one. For example, when we actually only register
> one ctl_path, we've gone from 8 bytes to 16 bytes.
> 
...
> diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
> index 2df115d0e210..b9290a252d84 100644
> --- a/arch/csky/abiv1/alignment.c
> +++ b/arch/csky/abiv1/alignment.c
> @@ -340,14 +340,14 @@ static struct ctl_table sysctl_table[2] = {
>  	{}
>  };
> 
> -static struct ctl_path sysctl_path[2] = {
> -	{.procname = "csky"},
> -	{}
> +static struct ctl_path sysctl_path[1] = {
> +	{.procname = "csky"}
>  };
> +#define SYSCTL_PATH_NUM ARRAY_SIZE(sysctl_path)
> 
>  static int __init csky_alignment_init(void)
>  {
> -	 (sysctl_path, sysctl_table);
> +	register_sysctl_paths(sysctl_path, SYSCTL_PATH_NUM, sysctl_table);
>  	return 0;
>  }

That is horribly error prone.
What might work is to add the ctl_path_num parameter but leave in the
check for NULL.
Then add:

#define register_sysctl_paths(p, t) register_sysctl_paths(p, ARRAY_SIZE(t), t)

in the header file after the prototype.
Put the function name in () in the definition to stop the macro expansion.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

