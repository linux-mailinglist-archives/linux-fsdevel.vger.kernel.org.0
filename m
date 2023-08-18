Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804FA7814D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 23:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbjHRVjo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 17:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbjHRVj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:39:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433D730FE
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 14:39:24 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-156-hPJ_18syOlyCB1PGiL-aSA-1; Fri, 18 Aug 2023 22:39:21 +0100
X-MC-Unique: hPJ_18syOlyCB1PGiL-aSA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 18 Aug
 2023 22:39:20 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 18 Aug 2023 22:39:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Topic: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Index: AQHZ0DpP/l59sWTPXU+UuQ9VGbJikq/s16Kg///6foCAACRpIIAA7PpbgABGFYCAAgTAc4AAASpwgAAG9ACAAFxrAA==
Date:   Fri, 18 Aug 2023 21:39:20 +0000
Message-ID: <04ee44bc6c2d4c5bb1c143bcb6803b7b@AcuMS.aculab.com>
References: <d8fce3c159b04fdca65cc4d5c307854d@AcuMS.aculab.com>
 <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
 <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com>
 <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk>
 <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk>
 <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
 <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
 <2058762.1692371971@warthog.procyon.org.uk>
 <2093413.1692377320@warthog.procyon.org.uk>
In-Reply-To: <2093413.1692377320@warthog.procyon.org.uk>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells
> Sent: Friday, August 18, 2023 5:49 PM
> 
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > > iov_iter_init                            inc 0x27 -> 0x31 +0xa
> >
> > Are you hitting the gcc bug that loads the constant from memory?
> 
> I'm not sure what that looks like.  For your perusal, here's a disassembly of
> the use-switch-on-enum variant:
> 
>    0xffffffff8177726c <+0>:     cmp    $0x1,%esi
>    0xffffffff8177726f <+3>:     jbe    0xffffffff81777273 <iov_iter_init+7>
>    0xffffffff81777271 <+5>:     ud2
>    0xffffffff81777273 <+7>:     test   %esi,%esi
>    0xffffffff81777275 <+9>:     movw   $0x1,(%rdi)
>    0xffffffff8177727a <+14>:    setne  0x3(%rdi)
>    0xffffffff8177727e <+18>:    xor    %eax,%eax
>    0xffffffff81777280 <+20>:    movb   $0x0,0x2(%rdi)
>    0xffffffff81777284 <+24>:    movb   $0x1,0x4(%rdi)
>    0xffffffff81777288 <+28>:    mov    %rax,0x8(%rdi)
>    0xffffffff8177728c <+32>:    mov    %rdx,0x10(%rdi)
>    0xffffffff81777290 <+36>:    mov    %r8,0x18(%rdi)
>    0xffffffff81777294 <+40>:    mov    %rcx,0x20(%rdi)
>    0xffffffff81777298 <+44>:    jmp    0xffffffff81d728a0 <__x86_return_thunk>
> 
> versus the use-bitmap variant:
> 
>    0xffffffff81777311 <+0>:     cmp    $0x1,%esi
>    0xffffffff81777314 <+3>:     jbe    0xffffffff81777318 <iov_iter_init+7>
>    0xffffffff81777316 <+5>:     ud2
>    0xffffffff81777318 <+7>:     test   %esi,%esi
>    0xffffffff8177731a <+9>:     movb   $0x2,(%rdi)
>    0xffffffff8177731d <+12>:    setne  0x1(%rdi)
>    0xffffffff81777321 <+16>:    xor    %eax,%eax
>    0xffffffff81777323 <+18>:    mov    %rdx,0x10(%rdi)
>    0xffffffff81777327 <+22>:    mov    %rax,0x8(%rdi)
>    0xffffffff8177732b <+26>:    mov    %r8,0x18(%rdi)
>    0xffffffff8177732f <+30>:    mov    %rcx,0x20(%rdi)
>    0xffffffff81777333 <+34>:    jmp    0xffffffff81d72960 <__x86_return_thunk>
> 
> It seems to be that the former is loading byte constants individually, whereas
> Linus combined all those fields into a single byte and eliminated one of them.

I think you need to re-order the structure.
The top set writes to bytes 0..4 with:
>    0xffffffff81777275 <+9>:     movw   $0x1,(%rdi)
>    0xffffffff8177727a <+14>:    setne  0x3(%rdi)
>    0xffffffff81777280 <+20>:    movb   $0x0,0x2(%rdi)
>    0xffffffff81777284 <+24>:    movb   $0x1,0x4(%rdi)
Note that the 'setne' writes into the middle of the constants.

The lower writes bytes 0..1 with:
>    0xffffffff8177731a <+9>:     movb   $0x2,(%rdi)
>    0xffffffff8177731d <+12>:    setne  0x1(%rdi)

I think that if you move the 'conditional' value to offset 4
you'll get fewer writes.
Probably a 32bit load into %eax and then a write.

I don't think gcc likes generating 16bit immediates.
In some tests I did it loaded a 32bit value into %eax
and then wrote the low bits.
So the code is much the same (on x86) for 2 or 4 bytes
of constants.
I'm sure you can use the 'data-16' prefix with an immediate.

I'm not sure why you have two non-zero values when Linus
only had one though.

OTOH you don't want to be writing 3 bytes of constants.
Also gcc won't generate:
	movl $0xaabbccdd,%eax
	setne %al   // overwriting the dd
	movl %eax,(%rdi)
and I suspect the partial write (to %al) will be a stall.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

