Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989917524B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjGMOLL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 10:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjGMOLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:11:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C162B26B1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 07:11:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-144-1i9aKoPaM_W-GNyv47tB6g-1; Thu, 13 Jul 2023 15:11:03 +0100
X-MC-Unique: 1i9aKoPaM_W-GNyv47tB6g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 13 Jul
 2023 15:11:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 13 Jul 2023 15:11:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dan Carpenter' <dan.carpenter@linaro.org>,
        Linke Li <lilinke99@foxmail.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Linke Li <lilinke99@gmail.com>
Subject: RE: [PATCH] isofs: fix undefined behavior in iso_date()
Thread-Topic: [PATCH] isofs: fix undefined behavior in iso_date()
Thread-Index: AQHZsxUvEtRKesRhGUaBvhjBmnh2ha+3wHiQ
Date:   Thu, 13 Jul 2023 14:11:02 +0000
Message-ID: <aa811b76ac704140bfa98884c8d6f51e@AcuMS.aculab.com>
References: <tencent_4D921A8D1F69E70C85C28875DC829E28EC09@qq.com>
 <79582844-3178-451c-822e-a692bfd27e9c@moroto.mountain>
In-Reply-To: <79582844-3178-451c-822e-a692bfd27e9c@moroto.mountain>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dan Carpenter
> Sent: 10 July 2023 10:57
> 
> It looks like maybe there is an issue with "year" as well.
> 
> fs/isofs/util.c
>     19  int iso_date(u8 *p, int flag)
>     20  {
>     21          int year, month, day, hour, minute, second, tz;
>     22          int crtime;
>     23
>     24          year = p[0];
>                        ^^^^^
> year is 0-255.
....
>     32
>     33          if (year < 0) {
>                     ^^^^^^^^
> But this checks year for < 0 which is impossible.  Should it be:
> 
> 	year = (signed char)p[0];?

Or not?

What happens in 2027 ?
I bet the value has to be treated an unsigned.

> 
>     34                  crtime = 0;
>     35          } else {
>     36                  crtime = mktime64(year+1900, month, day, hour, minute, second);
>     37
>     38                  /* sign extend */
>     39                  if (tz & 0x80)
>     40                          tz |= (-1 << 8);

Just change the definition of tz from 'int' to 's8'
and it will all happen 'by magic'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

