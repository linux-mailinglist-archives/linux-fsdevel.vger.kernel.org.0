Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A456277E1A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 14:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245222AbjHPM3f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 08:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbjHPM3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:29:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F32711
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 05:28:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-257-TgG9qBlyOWi2Hcyfbaq8PA-1; Wed, 16 Aug 2023 13:28:51 +0100
X-MC-Unique: TgG9qBlyOWi2Hcyfbaq8PA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 16 Aug
 2023 13:28:47 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 16 Aug 2023 13:28:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        "Christian Brauner" <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Topic: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Index: AQHZ0DpP/l59sWTPXU+UuQ9VGbJikq/s16Kg
Date:   Wed, 16 Aug 2023 12:28:47 +0000
Message-ID: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
References: <20230816120741.534415-1-dhowells@redhat.com>
 <20230816120741.534415-3-dhowells@redhat.com>
In-Reply-To: <20230816120741.534415-3-dhowells@redhat.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells
> Sent: Wednesday, August 16, 2023 1:08 PM

Given:

> iter->copy_mc is only used with a bvec iterator and only by
> dump_emit_page() in fs/coredump.c so rather than handle this in
> memcpy_from_iter_mc() where it is checked repeatedly by _copy_from_iter() and
> copy_page_from_iter_atomic(),

Instead of adding the extra check to every copy:

> +static __always_inline
> +size_t __copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
> +{
> +	if (unlikely(iov_iter_is_copy_mc(i)))
> +		return __copy_from_iter_mc(addr, bytes, i);
> +	return iterate_and_advance(i, bytes, addr,
> +				   copy_from_user_iter, memcpy_from_iter);
>  }

Couldn't the relevant code directly call __copy_frtom_iter_mc() ?
Or a version then checked iov_is_copy_mc() and then fell
back to the standard function.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

