Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF39E6C0601
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 23:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCSW2X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 18:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjCSW2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:28:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6480919C5E
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Mar 2023 15:28:19 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-181-_IBSa434P-uLEzTnXolkmw-1; Sun, 19 Mar 2023 22:28:14 +0000
X-MC-Unique: _IBSa434P-uLEzTnXolkmw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Sun, 19 Mar
 2023 22:28:12 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Sun, 19 Mar 2023 22:28:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "David Hildenbrand" <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        "Jiri Olsa" <jolsa@kernel.org>
Subject: RE: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
Thread-Topic: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
Thread-Index: AQHZWg2rkT8MGeJf90mcEtrkYLQB2q8Cr6Jw
Date:   Sun, 19 Mar 2023 22:28:12 +0000
Message-ID: <63c98c518c1e4bfbb36c5295ba7c959d@AcuMS.aculab.com>
References: <cover.1679183626.git.lstoakes@gmail.com>
 <119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes@gmail.com>
 <ZBZ4kLnFz9MEiyhM@casper.infradead.org>
In-Reply-To: <ZBZ4kLnFz9MEiyhM@casper.infradead.org>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox
> Sent: 19 March 2023 02:51
> 
> On Sun, Mar 19, 2023 at 12:20:12AM +0000, Lorenzo Stoakes wrote:
> >  /* for /proc/kcore */
> > -extern long vread(char *buf, char *addr, unsigned long count);
> > +extern long vread_iter(char *addr, size_t count, struct iov_iter *iter);
> 
> I don't love the order of the arguments here.  Usually we follow
> memcpy() and have (dst, src, len).  This sometimes gets a bit more
> complex when either src or dst need two arguments, but that's not the
> case here.

And, if 'addr' is the source (which Matthew's comment implies)
it ought to be 'const char *' (or probably even 'const void *').

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

