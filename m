Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E69023A0A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 10:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgHCII1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 3 Aug 2020 04:08:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:37073 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbgHCII0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:08:26 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-111-PHrlPE41MKu5ed8gAMWPYg-1; Mon, 03 Aug 2020 09:08:22 +0100
X-MC-Unique: PHrlPE41MKu5ed8gAMWPYg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 3 Aug 2020 09:08:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 3 Aug 2020 09:08:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Machek' <pavel@ucw.cz>
CC:     'Andy Lutomirski' <luto@kernel.org>,
        "madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "LSM List" <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
Subject: RE: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Thread-Topic: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Thread-Index: AQHWZQT/T+e4gDrzGEmP/30MMvDTCqkgFteggASWI4CAAWJTUA==
Date:   Mon, 3 Aug 2020 08:08:21 +0000
Message-ID: <c02fbae7a0754a58884b370657575845@AcuMS.aculab.com>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
 <b9879beef3e740c0aeb1af73485069a8@AcuMS.aculab.com>
 <20200802115600.GB1162@bug>
In-Reply-To: <20200802115600.GB1162@bug>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>
> Sent: 02 August 2020 12:56
> Hi!
> 
> > > This is quite clever, but now I???m wondering just how much kernel help
> > > is really needed. In your series, the trampoline is an non-executable
> > > page.  I can think of at least two alternative approaches, and I'd
> > > like to know the pros and cons.
> > >
> > > 1. Entirely userspace: a return trampoline would be something like:
> > >
> > > 1:
> > > pushq %rax
> > > pushq %rbc
> > > pushq %rcx
> > > ...
> > > pushq %r15
> > > movq %rsp, %rdi # pointer to saved regs
> > > leaq 1b(%rip), %rsi # pointer to the trampoline itself
> > > callq trampoline_handler # see below
> >
> > For nested calls (where the trampoline needs to pass the
> > original stack frame to the nested function) I think you
> > just need a page full of:
> > 	mov	$0, scratch_reg; jmp trampoline_handler
> 
> I believe you could do with mov %pc, scratch_reg; jmp ...
> 
> That has advantage of being able to share single physical
> page across multiple virtual pages...

A lot of architecture don't let you copy %pc that way so you would
have to use 'call' - but that trashes the return address cache.
It also needs the trampoline handler to know the addresses
of the trampolines.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

