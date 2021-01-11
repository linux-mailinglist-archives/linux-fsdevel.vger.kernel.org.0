Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486362F0FC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 11:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbhAKKM6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 05:12:58 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:48343 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728834AbhAKKM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:12:58 -0500
X-Greylist: delayed 2122 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2021 05:12:57 EST
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-68-LSP2TgUWPoW5OYymkm_RvQ-1; Mon, 11 Jan 2021 10:11:18 +0000
X-MC-Unique: LSP2TgUWPoW5OYymkm_RvQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 Jan 2021 10:11:17 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 Jan 2021 10:11:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
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
Subject: RE: Expense of read_iter
Thread-Topic: Expense of read_iter
Thread-Index: AQHW5xgPc3YVJbtxFkyYJqwIgIdF7KoiMj8g
Date:   Mon, 11 Jan 2021 10:11:17 +0000
Message-ID: <647fe440ab4640038a6ccaf59ab99685@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110061321.GC35215@casper.infradead.org>
In-Reply-To: <20210110061321.GC35215@casper.infradead.org>
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
> Sent: 10 January 2021 06:13
...
> nvfs_rw_iter_locked() looks very complicated.  I suspect it can
> be simplified.  Of course new_sync_read() needs to be improved too,
> as do the other functions here, but fully a third of the difference
> between read() and read_iter() is the difference between nvfs_read()
> and nvfs_rw_iter_locked().

There is also the non-zero cost of import_iovec().
I've got some slight speedups, but haven't measured an
old kernel yet to see how much slower 5.11-rc1 made it.

Basic test is:
	fd = open("/dev/null", O_RDWR);
	for (1 = 0; 1 < 10000; i++) {
		start = rdtsc();
		writev(fd, iovec, count);
		histogram[rdtsc() - start]++;
	}

This doesn't actually copy any data - the iovec
isn't iterated.

I'm seeing pretty stable counts for most of the 10000 iterations.
But different program runs can give massively different timings.
I'm quessing that depends on cache collisions due to the addresses
(virtual of physical?) selected for some items.

For 5.11-rc2 -mx32 is slightly faster than 64bit.
Whereas -m32 has a much slower syscall entry/exit path,
but the difference between gettid() and writev() is lower.
The compat code for import_iovec() is actually faster.
This isn't really surprising since copy_from_user() is
absolutely horrid these days - especially with userspace hardening.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

