Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF9326B2C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgIOWxG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:53:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:49059 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727423AbgIOPk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:40:57 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-53-W38LQ2b8OBS5NKJlBcK7FA-1; Tue, 15 Sep 2020 16:40:53 +0100
X-MC-Unique: W38LQ2b8OBS5NKJlBcK7FA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 15 Sep 2020 16:40:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 15 Sep 2020 16:40:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        Christoph Hellwig <hch@lst.de>,
        "Dave Chinner" <dchinner@redhat.com>
Subject: RE: [PATCH v2 2/9] fs: Introduce i_blocks_per_page
Thread-Topic: [PATCH v2 2/9] fs: Introduce i_blocks_per_page
Thread-Index: AQHWh8zSUX5EB+iAm0+PkXaO9U0VzKlp3UwQ
Date:   Tue, 15 Sep 2020 15:40:52 +0000
Message-ID: <0c874f14499c4d819f3e8e09f5086d77@AcuMS.aculab.com>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-3-willy@infradead.org>
In-Reply-To: <20200910234707.5504-3-willy@infradead.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox (Oracle)
> Sent: 11 September 2020 00:47
> This helper is useful for both THPs and for supporting block size larger
> than page size.  Convert all users that I could find (we have a few
> different ways of writing this idiom, and I may have missed some).
> 
...
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d81a9a86c5aa..330f86b825d7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -46,7 +46,7 @@ iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
> 
> -	if (iop || i_blocksize(inode) == PAGE_SIZE)
> +	if (iop || i_blocks_per_page(inode, page) <= 1)
>  		return iop;
> 
>  	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
> @@ -147,7 +147,7 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	unsigned int i;
> 
>  	spin_lock_irqsave(&iop->uptodate_lock, flags);
> -	for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
> +	for (i = 0; i < i_blocks_per_page(inode, page); i++) {

You probably don't want to call the helper every time
around the loop.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

