Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5C67D0F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 17:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjAZQJP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 11:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjAZQJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:09:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66660611C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 08:09:09 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-130-3ubTVGOQOF6GfUUMF1oHig-1; Thu, 26 Jan 2023 16:09:06 +0000
X-MC-Unique: 3ubTVGOQOF6GfUUMF1oHig-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 26 Jan
 2023 16:09:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 26 Jan 2023 16:09:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>
CC:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>
Subject: RE: [RFC 08/13] cifs: Add a function to read into an iter from a
 socket
Thread-Topic: [RFC 08/13] cifs: Add a function to read into an iter from a
 socket
Thread-Index: AQHZMQai4Pp239USek2HtsrL1M/WuK6wa3EwgABsh4CAAAWBEA==
Date:   Thu, 26 Jan 2023 16:09:05 +0000
Message-ID: <5d0bc437eebb4d5aa4774962a4970095@AcuMS.aculab.com>
References: <0d53a3cc9f9448298bba04d06f51b23d@AcuMS.aculab.com>
 <20230125214543.2337639-1-dhowells@redhat.com>
 <20230125214543.2337639-9-dhowells@redhat.com>
 <2862713.1674747841@warthog.procyon.org.uk>
In-Reply-To: <2862713.1674747841@warthog.procyon.org.uk>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells
> Sent: 26 January 2023 15:44
...
> > I'm also not 100% sure that taking a copy of an iov_iter is a good idea.
> 
> It shouldn't matter as the only problematic iterator is ITER_PIPE (advancing
> that has side effects) - and splice_read is handled specially by patch 4.  The
> problem with splice_read with the way cifs works is that it likes to subdivide
> its read/write requests across multiple reqs and then subsubdivide them if
> certain types of failure occur.  But you can't do that with ITER_PIPE.

I was thinking that even if ok at the moment it might be troublesome later.
Somewhere I started writing a patch to put the iov_cache[] for user
requests into the same structure as the iterator.
Copying those might cause oddities.

> I build an ITER_BVEC from ITER_PIPE, ITER_UBUF and ITER_IOVEC in the top
> levels with pins inserted as appropriate and hand the ITER_BVEC down.  For
> user-backed iterators it has to be done this way because the I/O may get
> shuffled off to a different thread.

For sub-page sided transfers it is probably worth doing a bounce buffer
copy of user requests - just to save all the complex page pinning code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

