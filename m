Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E07810EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjHRQuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 12:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbjHRQte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735262D5A
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692377327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=veHnm8JIytX/ZN4b89EoSQLoYiAOvTxlrfzT5tPpVw4=;
        b=AeIMa+bX1kAsvbWGH3uITJA9pmftCFjV+E3mftZRz9UJiwU4pNMqPw7dN6VihVKY1CKtrL
        bkeRhmYtg/3s+T/JKtfryUq3V/R76/sIueI4me5iYsuxrEIgWmY0WYAWO8lrovbcy0ukgd
        XEPtJ1s4K+HEV5SnhSMkUHc5216Uw+w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-EkqRh9h2M7qdDKIFcGzgWw-1; Fri, 18 Aug 2023 12:48:43 -0400
X-MC-Unique: EkqRh9h2M7qdDKIFcGzgWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 602E8101A52E;
        Fri, 18 Aug 2023 16:48:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE1640C6E8A;
        Fri, 18 Aug 2023 16:48:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d8fce3c159b04fdca65cc4d5c307854d@AcuMS.aculab.com>
References: <d8fce3c159b04fdca65cc4d5c307854d@AcuMS.aculab.com> <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com> <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com> <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com> <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com> <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com> <665724.1692218114@warthog.procyon.org.uk> <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com> <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com> <2058762.1692371971@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        "Matthew Wilcox" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2093412.1692377320.1@warthog.procyon.org.uk>
Date:   Fri, 18 Aug 2023 17:48:40 +0100
Message-ID: <2093413.1692377320@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> > iov_iter_init                            inc 0x27 -> 0x31 +0xa
> 
> Are you hitting the gcc bug that loads the constant from memory?

I'm not sure what that looks like.  For your perusal, here's a disassembly of
the use-switch-on-enum variant:

   0xffffffff8177726c <+0>:     cmp    $0x1,%esi
   0xffffffff8177726f <+3>:     jbe    0xffffffff81777273 <iov_iter_init+7>
   0xffffffff81777271 <+5>:     ud2
   0xffffffff81777273 <+7>:     test   %esi,%esi
   0xffffffff81777275 <+9>:     movw   $0x1,(%rdi)
   0xffffffff8177727a <+14>:    setne  0x3(%rdi)
   0xffffffff8177727e <+18>:    xor    %eax,%eax
   0xffffffff81777280 <+20>:    movb   $0x0,0x2(%rdi)
   0xffffffff81777284 <+24>:    movb   $0x1,0x4(%rdi)
   0xffffffff81777288 <+28>:    mov    %rax,0x8(%rdi)
   0xffffffff8177728c <+32>:    mov    %rdx,0x10(%rdi)
   0xffffffff81777290 <+36>:    mov    %r8,0x18(%rdi)
   0xffffffff81777294 <+40>:    mov    %rcx,0x20(%rdi)
   0xffffffff81777298 <+44>:    jmp    0xffffffff81d728a0 <__x86_return_thunk>

versus the use-bitmap variant:

   0xffffffff81777311 <+0>:     cmp    $0x1,%esi
   0xffffffff81777314 <+3>:     jbe    0xffffffff81777318 <iov_iter_init+7>
   0xffffffff81777316 <+5>:     ud2
   0xffffffff81777318 <+7>:     test   %esi,%esi
   0xffffffff8177731a <+9>:     movb   $0x2,(%rdi)
   0xffffffff8177731d <+12>:    setne  0x1(%rdi)
   0xffffffff81777321 <+16>:    xor    %eax,%eax
   0xffffffff81777323 <+18>:    mov    %rdx,0x10(%rdi)
   0xffffffff81777327 <+22>:    mov    %rax,0x8(%rdi)
   0xffffffff8177732b <+26>:    mov    %r8,0x18(%rdi)
   0xffffffff8177732f <+30>:    mov    %rcx,0x20(%rdi)
   0xffffffff81777333 <+34>:    jmp    0xffffffff81d72960 <__x86_return_thunk>

It seems to be that the former is loading byte constants individually, whereas
Linus combined all those fields into a single byte and eliminated one of them.

David

