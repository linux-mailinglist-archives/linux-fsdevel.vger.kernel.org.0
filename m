Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B0B230D5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 17:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgG1POK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 11:14:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:50303 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730719AbgG1PNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:13:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-235-JJgRaiMhNeeB2BdH3JMmbA-1; Tue, 28 Jul 2020 16:13:13 +0100
X-MC-Unique: JJgRaiMhNeeB2BdH3JMmbA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 28 Jul 2020 16:13:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 28 Jul 2020 16:13:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'madvenka@linux.microsoft.com'" <madvenka@linux.microsoft.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Thread-Topic: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Thread-Index: AQHWZOCQT+e4gDrzGEmP/30MMvDTCqkdFOrw
Date:   Tue, 28 Jul 2020 15:13:12 +0000
Message-ID: <c23de6ec47614f489943e1a89a21dfa3@AcuMS.aculab.com>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
In-Reply-To: <20200728131050.24443-1-madvenka@linux.microsoft.com>
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

From:  madvenka@linux.microsoft.com
> Sent: 28 July 2020 14:11
...
> The kernel creates the trampoline mapping without any permissions. When
> the trampoline is executed by user code, a page fault happens and the
> kernel gets control. The kernel recognizes that this is a trampoline
> invocation. It sets up the user registers based on the specified
> register context, and/or pushes values on the user stack based on the
> specified stack context, and sets the user PC to the requested target
> PC. When the kernel returns, execution continues at the target PC.
> So, the kernel does the work of the trampoline on behalf of the
> application.

Isn't the performance of this going to be horrid?

If you don't care that much about performance the fixup can
all be done in userspace within the fault signal handler.

Since whatever you do needs the application changed why
not change the implementation of nested functions to not
need on-stack executable trampolines.

I can think of other alternatives that don't need much more
than an array of 'push constant; jump trampoline' instructions
be created (all jump to the same place).

You might want something to create an executable page of such
instructions.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

