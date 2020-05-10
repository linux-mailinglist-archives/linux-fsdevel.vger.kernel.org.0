Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051491CCB93
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgEJOeI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 10:34:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:60998 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728714AbgEJOeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 10:34:08 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-46-WIrgiLb1OoGiMrDQB_cpGw-1; Sun, 10 May 2020 15:34:04 +0100
X-MC-Unique: WIrgiLb1OoGiMrDQB_cpGw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 10 May 2020 15:34:04 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 10 May 2020 15:34:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCHES] uaccess simple access_ok() removals
Thread-Topic: [PATCHES] uaccess simple access_ok() removals
Thread-Index: AQHWJltq6fE30OjG4EOuI+zbUBs5vKihYCkw
Date:   Sun, 10 May 2020 14:34:04 +0000
Message-ID: <847a5160e4e64a82962dc1531cd52e11@AcuMS.aculab.com>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
In-Reply-To: <20200509234124.GM23230@ZenIV.linux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro
> Sent: 10 May 2020 00:41
> 
> 	One of the uaccess-related branches; this one is just the
> cases when access_ok() calls are trivially pointless - the address
> in question gets fed only to primitives that do access_ok() checks
> themselves.

There is also the check in rw_copy_check_uvector() that should
always be replicated by the copy_to/from_user() in _copy_to/from_iter().

And the strange call to rw_copy_check_uvector() in mm/process_vm_access.c
which carefully avoids the access_ok() check for the target process.
I did a quick look, but failed to see an obvious check further
down the call path.
The code is doing a read/write from another process, not sure when it
is used - not by gdb.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

