Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F383702A73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjEOK30 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjEOK3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 06:29:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BE910C7
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 03:29:22 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-9-fk4fV_TIMaibnjx8Kk2ggA-1; Mon, 15 May 2023 11:29:20 +0100
X-MC-Unique: fk4fV_TIMaibnjx8Kk2ggA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 15 May
 2023 11:29:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 15 May 2023 11:29:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kent Overstreet' <kent.overstreet@linux.dev>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 07/32] mm: Bring back vmalloc_exec
Thread-Topic: [PATCH 07/32] mm: Bring back vmalloc_exec
Thread-Index: AQHZhidTKdvNQYED30e4lpVLdXSS2q9bIbmQ
Date:   Mon, 15 May 2023 10:29:18 +0000
Message-ID: <1f1d88a6a33f4e5db99544fda965c594@AcuMS.aculab.com>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org> <ZFq3SdSBJ_LWsOgd@murray>
 <ZFq7JhrhyrMTNfd/@moria.home.lan> <20230510064849.GC1851@quark.localdomain>
 <ZF6HHRDeUWLNtuL7@moria.home.lan> <20230513015752.GC3033@quark.localdomain>
 <ZGB1eevk/u2ssIBT@moria.home.lan>
In-Reply-To: <ZGB1eevk/u2ssIBT@moria.home.lan>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet
> Sent: 14 May 2023 06:45
...
> dynamically generated unpack:
> rand_insert: 20.0 MiB with 1 threads in    33 sec,  1609 nsec per iter, 607 KiB per sec
> 
> old C unpack:
> rand_insert: 20.0 MiB with 1 threads in    35 sec,  1672 nsec per iter, 584 KiB per sec
> 
> the Eric Biggers special:
> rand_insert: 20.0 MiB with 1 threads in    35 sec,  1676 nsec per iter, 583 KiB per sec
> 
> Tested two versions of your approach, one without a shift value, one
> where we use a shift value to try to avoid unaligned access - second was
> perhaps 1% faster

You won't notice any effect of avoiding unaligned accesses on x86.
I think then get split into 64bit accesses and again on 64 byte
boundaries (that is what I see for uncached access to PCIe).
The kernel won't be doing >64bit and the 'out of order'
pipeline will tend to cover the others (especially since you
get 2 reads/clock).

> so it's not looking good. This benchmark doesn't even hit on
> unpack_key() quite as much as I thought, so the difference is
> significant.

Beware: unless you manage to lock the cpu frequency (which is ~impossible
on some cpu) timings in nanoseconds are pretty useless.
You can use the performance counter to get accurate cycle times
(provided there isn't a cpu switch in the middle of a micro-benchmark).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

