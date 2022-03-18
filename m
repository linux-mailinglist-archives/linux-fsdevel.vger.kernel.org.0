Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050624DDAD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 14:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiCRNtb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiCRNta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:49:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6E3C3DA4C
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 06:48:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-230-7BPTG6E3OgCK3NW-RJ4mhA-1; Fri, 18 Mar 2022 13:48:08 +0000
X-MC-Unique: 7BPTG6E3OgCK3NW-RJ4mhA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 13:48:07 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 18 Mar 2022 13:48:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Baoquan He' <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "willy@infradead.org" <willy@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "amit.kachhap@arm.com" <amit.kachhap@arm.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH v4 4/4] fs/proc/vmcore: Use iov_iter_count()
Thread-Topic: [PATCH v4 4/4] fs/proc/vmcore: Use iov_iter_count()
Thread-Index: AQHYOqvdJiWddWfO9ESrhwkm/5kbyKzFJutw
Date:   Fri, 18 Mar 2022 13:48:07 +0000
Message-ID: <1592a861bd9e46e5adf1431ad6bbd25c@AcuMS.aculab.com>
References: <20220318093706.161534-1-bhe@redhat.com>
 <20220318093706.161534-5-bhe@redhat.com>
In-Reply-To: <20220318093706.161534-5-bhe@redhat.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Baoquan He
> Sent: 18 March 2022 09:37
> 
> To replace open coded iter->count. This makes code cleaner.
...
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4cbb8db7c507..ed58a7edc821 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -319,21 +319,21 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
>  	u64 start;
>  	struct vmcore *m = NULL;
> 
> -	if (iter->count == 0 || *fpos >= vmcore_size)
> +	if (!iov_iter_count(iter) || *fpos >= vmcore_size)

For some definition of 'cleaner' :-)

iter->count is clearly a simple, cheap structure member lookup.
OTOH iov_iter_count(iter) might be an expensive traversal of
the vector (or worse).

So a quick read of the code by someone who isn't an expert
in the iov functions leaves them wondering what is going on
or having to spend time locating the definition ...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

