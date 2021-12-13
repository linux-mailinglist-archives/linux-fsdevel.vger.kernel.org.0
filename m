Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5721D4722B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 09:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhLMIak convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 03:30:40 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:44479 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231845AbhLMIaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:30:39 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-48-uEn-QkNbO3KqUuXVw7bKDg-1; Mon, 13 Dec 2021 08:30:34 +0000
X-MC-Unique: uEn-QkNbO3KqUuXVw7bKDg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 08:30:33 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Mon, 13 Dec 2021 08:30:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>
CC:     'Tiezhu Yang' <yangtiezhu@loongson.cn>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: RE: [PATCH v2 0/2] kdump: simplify code
Thread-Topic: [PATCH v2 0/2] kdump: simplify code
Thread-Index: AQHX7j/jzYqw5kMpA0qY43nH0kUm2Kwtku5wgAEsrYCAAVr28A==
Date:   Mon, 13 Dec 2021 08:30:33 +0000
Message-ID: <b7a75ae9253445af81ff2fedd5268af4@AcuMS.aculab.com>
References: <1639193588-7027-1-git-send-email-yangtiezhu@loongson.cn>
 <0c5cb37139af4f3e85cc2c5115d7d006@AcuMS.aculab.com>
 <YbXhVxRJfjvKw++W@casper.infradead.org>
In-Reply-To: <YbXhVxRJfjvKw++W@casper.infradead.org>
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

From: Matthew Wilcox
> Sent: 12 December 2021 11:48
> 
> On Sat, Dec 11, 2021 at 05:53:46PM +0000, David Laight wrote:
> > From: Tiezhu Yang
> > > Sent: 11 December 2021 03:33
> > >
> > > v2:
> > >   -- add copy_to_user_or_kernel() in lib/usercopy.c
> > >   -- define userbuf as bool type
> >
> > Instead of having a flag to indicate whether the buffer is user or kernel,
> > would it be better to have two separate buffer pointers.
> > One for a user space buffer, the other for a kernel space buffer.
> > Exactly one of the buffers should always be NULL.
> 
> No.  You should be using an iov_iter instead.  See
> https://lore.kernel.org/all/Ya4bdB0UBJCZhUSo@casper.infradead.org/
> for a start on this.

iov_iter gets horribly expensive...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

