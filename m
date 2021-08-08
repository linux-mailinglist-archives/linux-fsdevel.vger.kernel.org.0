Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F122A3E3AD9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhHHOli convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 8 Aug 2021 10:41:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:45367 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231218AbhHHOlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 10:41:37 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-230-4gOXD3bKO7GKpbzy2TrY7g-1; Sun, 08 Aug 2021 15:41:15 +0100
X-MC-Unique: 4gOXD3bKO7GKpbzy2TrY7g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Sun, 8 Aug 2021 15:41:13 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Sun, 8 Aug 2021 15:41:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fs: optimise generic_write_check_limits()
Thread-Topic: [PATCH] fs: optimise generic_write_check_limits()
Thread-Index: AQHXiscVgxiDCvywqEuIzni6Qp/HSatpr+8g
Date:   Sun, 8 Aug 2021 14:41:13 +0000
Message-ID: <567d7e15f59a45f6ab94428261b3e473@AcuMS.aculab.com>
References: <dc92d8ac746eaa95e5c22ca5e366b824c210a3f4.1628248828.git.asml.silence@gmail.com>
 <YQ04/NFn8b6cykPQ@casper.infradead.org>
In-Reply-To: <YQ04/NFn8b6cykPQ@casper.infradead.org>
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
> Sent: 06 August 2021 14:28
> 
> On Fri, Aug 06, 2021 at 12:22:10PM +0100, Pavel Begunkov wrote:
> > Even though ->s_maxbytes is used by generic_write_check_limits() only in
> > case of O_LARGEFILE, the value is loaded unconditionally, which is heavy
> > and takes 4 indirect loads. Optimise it by not touching ->s_maxbytes,
> > if it's not going to be used.
> 
> Is this "optimisation" actually worth anything?  Look at how
> force_o_largefile() is used.  I would suggest that on the vast majority
> of machines, O_LARGEFILE is always set.

An option would be to only determine ->s_maxbytes when the size
if larger than MAX_NON_LFS.

So you'd end up with something like:

	if (pos >= max_size) {
		if (!(file->f_flags & O_LARGEFILE))
			return -EFBIG;
		inode = file->f_mapping->host;
		if (pos >= inode->i_sb->s_maxbytes)
			return -EFBIG;
	}

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

