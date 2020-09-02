Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1D125ABF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBNXw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 2 Sep 2020 09:23:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55759 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgIBNNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:13:50 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-164-H07lfWV_NS6c2T74vCbBog-1; Wed, 02 Sep 2020 14:13:23 +0100
X-MC-Unique: H07lfWV_NS6c2T74vCbBog-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 2 Sep 2020 14:13:22 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 2 Sep 2020 14:13:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
Thread-Topic: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
Thread-Index: AQHWgSXGxcHfrrTX9UCmYjSyVg3SwKlVUsKA
Date:   Wed, 2 Sep 2020 13:13:22 +0000
Message-ID: <61b9a880a6424a34b841cf3dddb463ad@AcuMS.aculab.com>
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-11-hch@lst.de>
 <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu>
 <20200902123646.GA31184@lst.de>
In-Reply-To: <20200902123646.GA31184@lst.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig
> Sent: 02 September 2020 13:37
> 
> On Wed, Sep 02, 2020 at 08:15:12AM +0200, Christophe Leroy wrote:
> >> -		return 0;
> >> -	return (size == 0 || size - 1 <= seg.seg - addr);
> >> +	if (addr >= TASK_SIZE_MAX)
> >> +		return false;
> >> +	if (size == 0)
> >> +		return false;
> >
> > __access_ok() was returning true when size == 0 up to now. Any reason to
> > return false now ?
> 
> No, this is accidental and broken.  Can you re-run your benchmark with
> this fixed?

Is TASK_SIZE_MASK defined such that you can do:

	return (addr | size) < TASK_SIZE_MAX) || !size;

    David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

