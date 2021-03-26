Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA034ACC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCZQpO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 12:45:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:43507 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230289AbhCZQox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:44:53 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-213-YTy4IFWENUi9fJgzzqBpKg-2; Fri, 26 Mar 2021 16:44:49 +0000
X-MC-Unique: YTy4IFWENUi9fJgzzqBpKg-2
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 26 Mar 2021 16:44:48 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Fri, 26 Mar 2021 16:44:48 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 3/4] exec: simplify the compat syscall handling
Thread-Topic: [PATCH 3/4] exec: simplify the compat syscall handling
Thread-Index: AQHXIlr1GfPxLRNSxkCVNQRYzf6AcKqWeGLg
Date:   Fri, 26 Mar 2021 16:44:48 +0000
Message-ID: <da94e124fad244459fe3431077c7ffa8@AcuMS.aculab.com>
References: <20210326143831.1550030-1-hch@lst.de>
 <20210326143831.1550030-4-hch@lst.de>
 <YF4H58gozyNkoCeO@zeniv-ca.linux.org.uk>
In-Reply-To: <YF4H58gozyNkoCeO@zeniv-ca.linux.org.uk>
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

From: Al Viro
> Sent: 26 March 2021 16:12
> 
> On Fri, Mar 26, 2021 at 03:38:30PM +0100, Christoph Hellwig wrote:
> 
> > +static const char __user *
> > +get_user_arg_ptr(const char __user *const __user *argv, int nr)
> >  {
> > +	if (in_compat_syscall()) {
> > +		const compat_uptr_t __user *compat_argv =
> > +			compat_ptr((unsigned long)argv);
> >  		compat_uptr_t compat;
> >
> > +		if (get_user(compat, compat_argv + nr))
> >  			return ERR_PTR(-EFAULT);
> >  		return compat_ptr(compat);
> > +	} else {
> > +		const char __user *native;
> >
> > +		if (get_user(native, argv + nr))
> > +			return ERR_PTR(-EFAULT);
> > +		return native;
> > +	}
> >  }
> 
> Yecchhh....  So you have in_compat_syscall() called again and again, for
> each argument in the list?  I agree that current version is fucking ugly,
> but I really hate that approach ;-/

Especially since in_compat_syscall() isn't entirely trivial on x86-64.
Probably all in the noise for 'exec', but all the bits do add up.

You may not want separate get_user() on some architectures either.
The user_access_begin/end aren't cheap.

OTOH if you call copy_from_user() you get hit by the stupid
additional costs of 'user copy hardening'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

