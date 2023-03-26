Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6616C947E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Mar 2023 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCZN1F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 09:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCZN1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:27:05 -0400
Received: from eu-smtp-inbound-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A97ECF
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 06:27:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-34-QskMV83HPiqItOif3_5aJA-1; Sun, 26 Mar 2023 14:26:59 +0100
X-MC-Unique: QskMV83HPiqItOif3_5aJA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 26 Mar
 2023 14:26:57 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 26 Mar 2023 14:26:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Baoquan He' <bhe@redhat.com>, David Hildenbrand <david@redhat.com>
CC:     Lorenzo Stoakes <lstoakes@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH v7 4/4] mm: vmalloc: convert vread() to vread_iter()
Thread-Topic: [PATCH v7 4/4] mm: vmalloc: convert vread() to vread_iter()
Thread-Index: AQHZXYvy5HgRBBUkm0qsuDBYF9y6k68ND8zA
Date:   Sun, 26 Mar 2023 13:26:57 +0000
Message-ID: <0cff573c3a344504b1b1b77486b4d853@AcuMS.aculab.com>
References: <cover.1679511146.git.lstoakes@gmail.com>
 <941f88bc5ab928e6656e1e2593b91bf0f8c81e1b.1679511146.git.lstoakes@gmail.com>
 <ZBu+2cPCQvvFF/FY@MiWiFi-R3L-srv>
 <ff630c2e-42ff-42ec-9abb-38922d5107ec@lucifer.local>
 <ZBwroYh22pEqJYhv@MiWiFi-R3L-srv>
 <7aee68e9-6e31-925f-68bc-73557c032a42@redhat.com>
 <ZBxUvBFHcQvsl0r9@MiWiFi-R3L-srv>
In-Reply-To: <ZBxUvBFHcQvsl0r9@MiWiFi-R3L-srv>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Baoquan He
> Sent: 23 March 2023 13:32
...
> > > > If this fails, then we fault in, and try again. We loop because there could
> > > > be some extremely unfortunate timing with a race on e.g. swapping out or
> > > > migrating pages between faulting in and trying to write out again.
> > > >
> > > > This is extremely unlikely, but to avoid any chance of breaking userland we
> > > > repeat the operation until it completes. In nearly all real-world
> > > > situations it'll either work immediately or loop once.
> > >
> > > Thanks a lot for these helpful details with patience. I got it now. I was
> > > mainly confused by the while(true) loop in KCORE_VMALLOC case of read_kcore_iter.
> > >
> > > Now is there any chance that the faulted in memory is swapped out or
> > > migrated again before vread_iter()? fault_in_iov_iter_writeable() will
> > > pin the memory? I didn't find it from code and document. Seems it only
> > > falults in memory. If yes, there's window between faluting in and
> > > copy_to_user_nofault().
> > >
> >
> > See the documentation of fault_in_safe_writeable():
> >
> > "Note that we don't pin or otherwise hold the pages referenced that we fault
> > in.  There's no guarantee that they'll stay in memory for any duration of
> > time."
> 
> Thanks for the info. Then swapping out/migration could happen again, so
> that's why while(true) loop is meaningful.

One of the problems is that is the system is under severe memory
pressure and you try to fault in (say) 20 pages, the first page
might get unmapped in order to map the last one in.

So it is quite likely better to retry 'one page at a time'.

There have also been cases where the instruction to copy data
has faulted for reasons other than 'page fault'.
ISTR an infinite loop being caused by misaligned accesses failing
due to 'bad instruction choice' in the copy code.
While this is rally a bug, an infinite retry in a file read/write
didn't make it easy to spot.

So maybe there are cases where a dropping back to a 'bounce buffer'
may be necessary.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

