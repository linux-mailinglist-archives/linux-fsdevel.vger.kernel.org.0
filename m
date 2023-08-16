Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80D577DC53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 10:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbjHPIdg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 04:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243093AbjHPIcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:32:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCBB30CA
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 01:31:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-102-GQJWoHGIPVK3nlIn0yNs6w-1; Wed, 16 Aug 2023 09:30:54 +0100
X-MC-Unique: GQJWoHGIPVK3nlIn0yNs6w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 16 Aug
 2023 09:30:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 16 Aug 2023 09:30:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2] iov_iter: Convert iterate*() to inline funcs
Thread-Topic: [RFC PATCH v2] iov_iter: Convert iterate*() to inline funcs
Thread-Index: AQHZzvgmq2lQZxPz+UuF+eoksadYZ6/rhpfw
Date:   Wed, 16 Aug 2023 08:30:52 +0000
Message-ID: <8722207799c342e780e1162a983dc48b@AcuMS.aculab.com>
References: <855.1692047347@warthog.procyon.org.uk>
 <5247.1692049208@warthog.procyon.org.uk>
In-Reply-To: <5247.1692049208@warthog.procyon.org.uk>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells
> Sent: 14 August 2023 22:40
> 
> 
> >         _copy_from_iter                          inc 0x36e -> 0x395 +0x27
> 
> Here a disassembly of _copy_from_iter() from unpatched and patched, marked up for
> the different iterator-type branches.  To summarise:
> 
> 		UNPATCHED	PATCHED
> 		START	LEN	START	LEN
> 		=======	=======	=======	=======
> Prologue	0	77	0	76
> UBUF		77	36	76	36
> IOVEC		113	148	112	105
> BVEC		261	159	217	163
> KVEC		420	125	380	116
> XARRAY		545	286	496	374
> DISCARD/Epi	831	42	870	42
> Return		873	-	912	-
> 
> 
> The overall change in the entire file, according to size, is:
>    19855     744       0   20599    5077 build3/lib/iov_iter.o -- before
>    19739     864       0   20603    507b build3/lib/iov_iter.o -- after

It is harder to compare because of some of the random name changes.
The version of the source I found seems to pass priv2 to functions
that don't use it?

Since the functions aren't inlined you get the cost of passing
the parameters.
This seems to affect the common cases.
Is that all left over from a version that passed function pointers
(with the hope they'd be inlined?).
Just directly inlining the simple copies should help.

I rather hope the should_fail_usercopy() and instrument_copy_xxx()
calls are usually either absent or, at most, nops.

This all seems to have a lot fewer options than last time I looked.
Is it worth optimising the KVEC case with a single buffer?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

