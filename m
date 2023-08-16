Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6E77E02B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 13:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbjHPLUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 07:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbjHPLUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778141985
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 04:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692184750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9DmGZYcSr2I9SiRg9Pn0WyLYqr3/OyAYXMXaLgBZidY=;
        b=Pga2q02diFL+wHBvThQA0zT3fjcFvGmAlDqFtsM7JDLMLfDg8hTgMvbkoWTAgzx4EfzHgI
        O8c5ua8wIISvFcKALgic4rQSuTzNnFuFtkcv1mh7iDNqrgSh4yZm6P82GIF5jpTC+ZE4Zc
        MSTrJjRRdfwIKd2EIVJZ9M/SsSRrDYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-E48cI-hyNleWg9BbfLx0XA-1; Wed, 16 Aug 2023 07:19:07 -0400
X-MC-Unique: E48cI-hyNleWg9BbfLx0XA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB9FF101A528;
        Wed, 16 Aug 2023 11:19:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 322881121314;
        Wed, 16 Aug 2023 11:19:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <a72036d57d50464ea4fe7fa556ee1a72@AcuMS.aculab.com>
References: <a72036d57d50464ea4fe7fa556ee1a72@AcuMS.aculab.com> <8722207799c342e780e1162a983dc48b@AcuMS.aculab.com> <855.1692047347@warthog.procyon.org.uk> <5247.1692049208@warthog.procyon.org.uk> <440141.1692179410@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] iov_iter: Convert iterate*() to inline funcs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <532384.1692184743.1@warthog.procyon.org.uk>
Date:   Wed, 16 Aug 2023 12:19:03 +0100
Message-ID: <532385.1692184743@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> > That can't be avoided if I convert everything to inline functions and
> > function pointers - but the optimiser can get rid of it where it can
> > inline the step function.
> 
> AFAICT the IOVEC one was only called directly.

I've made some changes that I'll post shortly, and I now get this:

	...
	<+36>:	cmpb   $0x0,0x1(%rdx)	# iter->copy_mc
	...
	<+46>:	je     0xffffffff81779aae <_copy_from_iter+98>
	<+48>:	jmp    0xffffffff81779a87 <_copy_from_iter+59>
	...
	# Handle ->copy_mc == true
	<+59>:	mov    0x38(%rsp),%rax
	<+64>:	sub    %gs:0x28,%rax
	<+73>:	jne    0xffffffff81779db1 <_copy_from_iter+869>
	<+79>:	add    $0x40,%rsp
	<+83>:	pop    %rbx
	<+84>:	pop    %rbp
	<+85>:	pop    %r12
	<+87>:	pop    %r13
	<+89>:	pop    %r14
	<+91>:	pop    %r15
	<+93>:	jmp    0xffffffff81777934 <__copy_from_iter_mc>
	...
	# ITER_UBUF
	<+121>:	mov    (%rdx),%al
	<+123>:	cmp    $0x5,%al
	<+125>:	jne    0xffffffff81779b01 <_copy_from_iter+181>
	...
	<+147>:	call   0xffffffff817777ee <__access_ok>
	<+152>:	test   %al,%al
	<+154>:	je     0xffffffff81779af9 <_copy_from_iter+173>
	<+156>:	nop
	<+157>:	nop
	<+158>:	nop
	<+159>:	mov    %r12,%rdi
	<+162>:	mov    %rdx,%rsi
	<+165>:	rep movsb %ds:(%rsi),%es:(%rdi)
	...
	# ITER_IOVEC
	<+181>:	test   %al,%al
	<+183>:	jne    0xffffffff81779b8d <_copy_from_iter+321>
	...
	<+234>:	call   0xffffffff817777ee <__access_ok>
	<+239>:	test   %al,%al
	<+241>:	je     0xffffffff81779b54 <_copy_from_iter+264>
	<+243>:	nop
	<+244>:	nop
	<+245>:	nop
	<+246>:	lea    (%r12,%r15,1),%rax
	<+250>:	mov    %r8,%rsi
	<+253>:	mov    %rax,%rdi
	<+256>:	rep movsb %ds:(%rsi),%es:(%rdi)
	...
	# ITER_BVEC
	<+321>:	cmp    $0x2,%al
	<+323>:	jne    0xffffffff81779c1f <_copy_from_iter+467>
	...
	<+375>:	call   0xffffffff81777282 <kmap_local_page>
	...
	<+431>:	rep movsb %ds:(%rsi),%es:(%rdi)
	...
	# ITER_KVEC
	<+467>:	cmp    $0x1,%al
	<+469>:	jne    0xffffffff81779c82 <_copy_from_iter+566>
	...
	<+526>:	rep movsb %ds:(%rsi),%es:(%rdi)
	...
	# ITER_XARRAY
	<+566>:	cmp    $0x3,%al
	<+568>:	jne    0xffffffff81779d9d <_copy_from_iter+849>
	...
	<+639>:	call   0xffffffff81126bcf <__rcu_read_lock>
	...
	<+651>:	call   0xffffffff81d5ed97 <xas_find>
	...
	<+764>:	call   0xffffffff817772a7 <kmap_local_folio>
	...
	<+806>:	rep movsb %ds:(%rsi),%es:(%rdi)
	...
	# ITER_DISCARD/default
	<+849>:	sub    %rbx,0x18(%rbp)
	<+853>:	mov    0x38(%rsp),%rax
	<+858>:	sub    %gs:0x28,%rax
	<+867>:	je     0xffffffff81779db6 <_copy_from_iter+874>
	<+869>:	call   0xffffffff81d6578c <__stack_chk_fail>
	<+874>:	add    $0x40,%rsp
	<+878>:	mov    %rbx,%rax
	<+881>:	pop    %rbx
	<+882>:	pop    %rbp
	<+883>:	pop    %r12
	<+885>:	pop    %r13
	<+887>:	pop    %r14
	<+889>:	pop    %r15
	<+891>:	jmp    0xffffffff81d72920 <__x86_return_thunk>

David

