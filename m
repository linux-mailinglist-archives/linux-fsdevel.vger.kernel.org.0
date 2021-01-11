Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E4D2F18DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 15:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbhAKOzw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 09:55:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:55728 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731088AbhAKOzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:55:51 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-259-cwMCCFf6NSqMv-TjxwzQZQ-1; Mon, 11 Jan 2021 14:54:12 +0000
X-MC-Unique: cwMCCFf6NSqMv-TjxwzQZQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 Jan 2021 14:54:11 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 Jan 2021 14:54:11 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>
CC:     'Mikulas Patocka' <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [RFC v2] nvfs: a filesystem for persistent memory
Thread-Topic: [RFC v2] nvfs: a filesystem for persistent memory
Thread-Index: AQHW52zcFLyucqAcQUmnqwhwPozPcaoiOfvQgAAVUICAAALF8IAAL2SAgAAB4jA=
Date:   Mon, 11 Jan 2021 14:54:11 +0000
Message-ID: <de2f960c4fee4b7c9d4ed466b49ec97e@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110162008.GV3579531@ZenIV.linux.org.uk>
 <c26db2b0ea1a4891a7cbd0363de856d3@AcuMS.aculab.com>
 <alpine.LRH.2.02.2101110641490.4356@file01.intranet.prod.int.rdu2.redhat.com>
 <57dad96341d34822a7943242c9bcad71@AcuMS.aculab.com>
 <20210111144341.GZ3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210111144341.GZ3579531@ZenIV.linux.org.uk>
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

From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: 11 January 2021 14:44
> On Mon, Jan 11, 2021 at 11:57:08AM +0000, David Laight wrote:
> > > > > 		size = copy_to_iter(to, ptr, size);
> > > > > 		if (unlikely(!size)) {
> > > > > 			r = -EFAULT;
> > > > > 			goto ret_r;
> > > > > 		}
> > > > >
> > > > > 		pos += size;
> > > > > 		total += size;
> > > > > 	}
> > > >
> > > > 	David
> > >
> > > I fixed the arguments to
> > > copy_to_iter - other than that, Al's function works.
> >
> 
> > Oh - the error return for copy_to_iter() is wrong.
> > It should (probably) return 'total' if it is nonzero.
> 
> 	copy_to_iter() call there has an obvious problem
> (arguments in the wrong order), but return value is handled
> correctly.  It does not do a blind return -EFAULT.  RTFS...

Ah I was looking at the version I'd cut the tail off...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

