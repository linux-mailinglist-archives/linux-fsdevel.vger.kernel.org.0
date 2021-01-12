Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865442F2C1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 11:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbhALKCG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 05:02:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:60404 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726464AbhALKCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:02:06 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-122-Va9HPrs7PIaIxc2HrFtMoQ-1; Tue, 12 Jan 2021 10:00:26 +0000
X-MC-Unique: Va9HPrs7PIaIxc2HrFtMoQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 12 Jan 2021 10:00:25 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 12 Jan 2021 10:00:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg KH' <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] char_dev: replace cdev_map with an xarray
Thread-Topic: [PATCH] char_dev: replace cdev_map with an xarray
Thread-Index: AQHW6Mah9OTHy9UV2k2JY/e3E3NlEKojwICw
Date:   Tue, 12 Jan 2021 10:00:25 +0000
Message-ID: <4e46c186b6a4493992d3a5cc15fb3bf3@AcuMS.aculab.com>
References: <20210111170513.1526780-1-hch@lst.de>
 <20210111205818.GJ35215@casper.infradead.org> <X/1tXpCfzMrTUhDQ@kroah.com>
In-Reply-To: <X/1tXpCfzMrTUhDQ@kroah.com>
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

From: Greg KH
> Sent: 12 January 2021 09:35
> 
> On Mon, Jan 11, 2021 at 08:58:18PM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 11, 2021 at 06:05:13PM +0100, Christoph Hellwig wrote:
> > > @@ -486,14 +491,22 @@ int cdev_add(struct cdev *p, dev_t dev, unsigned count)
> > >  	if (WARN_ON(dev == WHITEOUT_DEV))
> > >  		return -EBUSY;
> > >
> > > -	error = kobj_map(cdev_map, dev, count, NULL,
> > > -			 exact_match, exact_lock, p);
> > > -	if (error)
> > > -		return error;
> > > +	mutex_lock(&chrdevs_lock);
> > > +	for (i = 0; i < count; i++) {
> > > +		error = xa_insert(&cdev_map, dev + i, p, GFP_KERNEL);
> > > +		if (error)
> > > +			goto out_unwind;
> > > +	}
> > > +	mutex_unlock(&chrdevs_lock);
> >
> > Looking at some of the users ...
> >
> > #define BSG_MAX_DEVS            32768
> > ...
> >         ret = cdev_add(&bsg_cdev, MKDEV(bsg_major, 0), BSG_MAX_DEVS);
> >
> > So this is going to allocate 32768 entries; at 8 bytes each, that's 256kB.
> > With XArray overhead, it works out to 73 pages or 292kB.  While I don't
> > have bsg loaded on my laptop, I imagine a lot of machines do.
> >
> > drivers/net/tap.c:#define TAP_NUM_DEVS (1U << MINORBITS)
> > include/linux/kdev_t.h:#define MINORBITS        20
> > drivers/net/tap.c:      err = cdev_add(tap_cdev, *tap_major, TAP_NUM_DEVS);
> >
> > That's going to be even worse -- 8MB plus the overhead to be closer to 9MB.
> >
> > I think we do need to implement the 'store a range' option ;-(
> 
> Looks like it will be needed here.
> 
> Wow that's a lot of tap devices allocated all at once, odd...

Aren't there two distinct use cases that probably need treating
separately?

1) A driver that uses it's own major (private) major number.
2) Drivers that share a major number (eg serial ports).

In the first case you just want all minors to come to your driver.
In the second case different (ranges of) minors need to go to
different drivers.

Until the major number is actually shared only the upper limit
is an any way relevant.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

