Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA781243711
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 11:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHMJBw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 05:01:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:36514 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgHMJBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:01:52 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-138-e8H63y_oORuTtNJUDzGgeQ-1; Thu, 13 Aug 2020 10:01:48 +0100
X-MC-Unique: e8H63y_oORuTtNJUDzGgeQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 13 Aug 2020 10:01:48 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 13 Aug 2020 10:01:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@infradead.org>,
        Daniel Axtens <dja@axtens.net>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fs/select.c: batch user writes in do_sys_poll
Thread-Topic: [PATCH] fs/select.c: batch user writes in do_sys_poll
Thread-Index: AQHWcUPllYrYWDsW9k2hVZh5/SyFEKk1vNpg
Date:   Thu, 13 Aug 2020 09:01:48 +0000
Message-ID: <edb8988b36b44ef392b2948c7ee1a8e9@AcuMS.aculab.com>
References: <20200813071120.2113039-1-dja@axtens.net>
 <20200813073220.GB15436@infradead.org>
In-Reply-To: <20200813073220.GB15436@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig
> Sent: 13 August 2020 08:32
> 
> On Thu, Aug 13, 2020 at 05:11:20PM +1000, Daniel Axtens wrote:
> > When returning results to userspace, do_sys_poll repeatedly calls
> > put_user() - once per fd that it's watching.
> >
> > This means that on architectures that support some form of
> > kernel-to-userspace access protection, we end up enabling and disabling
> > access once for each file descripter we're watching. This is inefficent
> > and we can improve things by batching the accesses together.
> >
> > To make sure there's not too much happening in the window when user
> > accesses are permitted, we don't walk the linked list with accesses on.
> > This leads to some slightly messy code in the loop, unfortunately.
> >
> > Unscientific benchmarking with the poll2_threads microbenchmark from
> > will-it-scale, run as `./poll2_threads -t 1 -s 15`:
> >
> >  - Bare-metal Power9 with KUAP: ~48.8% speed-up
> >  - VM on amd64 laptop with SMAP: ~25.5% speed-up
> >
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> Seem like this could simply use a copy_to_user to further simplify
> things?

That would copy out 8 bytes/fd instead of 2.
So a slight change for 32bit kernels.
However the 'user copy hardening' checks that copy_to_user()
does probably make a measurable difference.

> Also please don't pointlessly add overly long lines.

Shorten the error label?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

