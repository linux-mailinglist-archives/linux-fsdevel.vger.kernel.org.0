Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7D2F32A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 15:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbhALOIe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 09:08:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:25105 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727700AbhALOId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:08:33 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-190-LrEcQ_I1My-Flm7q2b_3Gw-1; Tue, 12 Jan 2021 14:06:55 +0000
X-MC-Unique: LrEcQ_I1My-Flm7q2b_3Gw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 12 Jan 2021 14:06:54 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 12 Jan 2021 14:06:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhongwei Cai' <sunrise_l@sjtu.edu.cn>,
        Mingkai Dong <mingkaidong@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: Expense of read_iter
Thread-Topic: Expense of read_iter
Thread-Index: Adbo7C52XXt2HSHdSaqZSwQZFrXi9Q==
Date:   Tue, 12 Jan 2021 14:06:53 +0000
Message-ID: <68567cb68fec4d79be79a655301effe1@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com>
 <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
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

From: Zhongwei Cai
> Sent: 12 January 2021 13:45
..
> The overhead mainly consists of two parts. The first is constructing
> struct iov_iter and iterating it (i.e., new_sync, _copy_mc_to_iter and
> iov_iter_init). The second is the dax io mechanism provided by VFS (i.e.,
> dax_iomap_rw, iomap_apply and ext4_iomap_begin).

Setting up an iov_iter with a single buffer ought to be relatively
cheap - compared to a file system read.

The iteration should be over the total length
calling copy_from/to_iter() for 'chunks' that don't
depend on the size of the iov[] fragments.

So copy_to/from_iter() should directly replace the copy_to/from_user()
calls in the 'read' method.
For a single buffer this really ought to be noise as well.

Clearly is the iov[] has a lot of short fragments the copy
will be more expensive.

Access to /dev/null and /dev/zero are much more likely to show
the additional costs of the iov_iter code than fs code.


	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

