Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFC740DF82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhIPQKp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 12:10:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:55002 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235627AbhIPQJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:09:11 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-162-75vixzp0Of-n5TQEq5DIEg-1; Thu, 16 Sep 2021 17:07:49 +0100
X-MC-Unique: 75vixzp0Of-n5TQEq5DIEg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 17:07:47 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 16 Sep 2021 17:07:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Will Deacon' <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux FS-devel Mailing List" <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [RFC PATCH] fs/compat_binfmt_elf: Introduce sysctl to disable
 compat ELF loader
Thread-Topic: [RFC PATCH] fs/compat_binfmt_elf: Introduce sysctl to disable
 compat ELF loader
Thread-Index: AQHXqw1xhvz/JjIwFE+lWY/Xr1h6SKum0nuw
Date:   Thu, 16 Sep 2021 16:07:47 +0000
Message-ID: <0594844caf4b4c4c815922e726f43d81@AcuMS.aculab.com>
References: <20210916131816.8841-1-will@kernel.org>
 <CAK8P3a0jQXiYg9u=o2LzqNSdiqMC=4=6o_NttPk_Wx4C3Gx98A@mail.gmail.com>
 <20210916151330.GA9000@willie-the-truck>
In-Reply-To: <20210916151330.GA9000@willie-the-truck>
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

From: Will Deacon
> Sent: 16 September 2021 16:14
...
> > I'm not sure I understand the logic behind the sysctl. Are you worried
> > about exposing attack surface on devices that don't support 32-bit
> > instructions at all but might be tricked into loading a 32-bit binary that
> > exploits a bug in the elf loader, or do you want to remove compat support
> > on some but not all devices running the same kernel?
> 
> It's the latter case. With the GKI effort in Android, we want to run the
> same kernel binary across multiple devices. However, for some devices
> we may be able to determine that there is no need to support 32-bit
> applications even though the hardware may support them, and we would
> like to ensure that things like the compat syscall wrappers, compat vDSO,
> signal handling etc are not accessible to applications.

Interesting because there is the opposite requirement to run
32bit user code under emulation on a 64bit only cpu.
This largely requires the kernel to contain the 32bit
compatibility code - even though it can't execute the instructions.

I suspect you could even embed the instruction emulator inside the
elf interpreter.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

