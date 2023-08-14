Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7AD77C285
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 23:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjHNVlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 17:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjHNVlD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BD8127
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692049215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H5gBerhDXN5yQmi8dwHCH++G4wOxfiolb2e6nV1A4Vk=;
        b=VrQfLvpy1QPDYa+U5hs6mK8h63vECTEw+t+MBp1trS3r42W0rWiVVtGG91IKj4ozgI6/1G
        SWVBjo8OoRbKU/xfjPDy35qjuP0M7oxgBZilLUBmmUF1JMJUhS70ovdL7ZfQP+s81r6o9P
        4jwBL0vLVjbu/RzFP1gyQwUz0JntbiI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-W8n2-_KrPZSuaq9MdIkjzQ-1; Mon, 14 Aug 2023 17:40:10 -0400
X-MC-Unique: W8n2-_KrPZSuaq9MdIkjzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4081F38008B4;
        Mon, 14 Aug 2023 21:40:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0D6E40C2063;
        Mon, 14 Aug 2023 21:40:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <855.1692047347@warthog.procyon.org.uk>
References: <855.1692047347@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] iov_iter: Convert iterate*() to inline funcs
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date:   Mon, 14 Aug 2023 22:40:08 +0100
Message-ID: <5247.1692049208@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain


>         _copy_from_iter                          inc 0x36e -> 0x395 +0x27

Here a disassembly of _copy_from_iter() from unpatched and patched, marked up for
the different iterator-type branches.  To summarise:

		UNPATCHED	PATCHED
		START	LEN	START	LEN
		=======	=======	=======	=======
Prologue	0	77	0	76
UBUF		77	36	76	36
IOVEC		113	148	112	105
BVEC		261	159	217	163
KVEC		420	125	380	116
XARRAY		545	286	496	374
DISCARD/Epi	831	42	870	42
Return		873	-	912	-


The overall change in the entire file, according to size, is:
   19855     744       0   20599    5077 build3/lib/iov_iter.o -- before
   19739     864       0   20603    507b build3/lib/iov_iter.o -- after

David


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=dump_a

UNPATCHED
<+0>:	push   %r15
<+2>:	push   %r14
<+4>:	push   %r13
<+6>:	push   %r12
<+8>:	push   %rbp
<+9>:	push   %rbx
<+10>:	sub    $0x50,%rsp
<+14>:	mov    %rdi,(%rsp)
<+18>:	mov    %gs:0x28,%rax
<+27>:	mov    %rax,0x48(%rsp)
<+32>:	xor    %eax,%eax
<+34>:	cmpb   $0x0,0x3(%rdx)
<+38>:	je     0xffffffff81779593 <_copy_from_iter+67>
<+40>:	mov    0x18(%rdx),%rax
<+44>:	mov    %rdx,%r15
<+47>:	cmp    %rax,%rsi
<+50>:	cmovbe %rsi,%rax
<+54>:	test   %rax,%rax
<+57>:	mov    %rax,%r13
<+60>:	jne    0xffffffff8177959d <_copy_from_iter+77>
<+62>:	jmp    0xffffffff81779893 <_copy_from_iter+835>
<+67>:	ud2
<+69>:	xor    %r13d,%r13d
<+72>:	jmp    0xffffffff81779893 <_copy_from_iter+835>

# ITER_UBUF
<+77>:	mov    (%rdx),%al
<+79>:	cmp    $0x5,%al
<+81>:	jne    0xffffffff817795c1 <_copy_from_iter+113>
<+83>:	mov    0x8(%rdx),%rsi
<+87>:	mov    (%rsp),%rdi
<+91>:	add    0x10(%rdx),%rsi
<+95>:	mov    %r13,%rdx
<+98>:	call   0xffffffff81777905 <copyin>
<+103>:	cltq
<+105>:	sub    %rax,%r13
<+108>:	jmp    0xffffffff8177988b <_copy_from_iter+827>

# ITER_IOVEC
<+113>:	test   %al,%al
<+115>:	jne    0xffffffff81779655 <_copy_from_iter+261>
<+121>:	mov    0x10(%rdx),%rbp
<+125>:	xor    %r12d,%r12d
<+128>:	mov    0x8(%rdx),%rbx
<+132>:	mov    0x8(%rbp),%rdx
<+136>:	sub    %rbx,%rdx
<+139>:	cmp    %r13,%rdx
<+142>:	cmova  %r13,%rdx
<+146>:	test   %rdx,%rdx
<+149>:	je     0xffffffff81779619 <_copy_from_iter+201>
<+151>:	mov    0x0(%rbp),%rsi
<+155>:	mov    (%rsp),%rax
<+159>:	add    %rbx,%rsi
<+162>:	lea    (%rax,%r12,1),%rdi
<+166>:	call   0xffffffff81777905 <copyin>
<+171>:	mov    %rdx,%rcx
<+174>:	mov    %r13,%r8
<+177>:	cltq
<+179>:	sub    %rdx,%r8
<+182>:	lea    (%r8,%rax,1),%r13
<+186>:	sub    %rax,%rcx
<+189>:	add    %rcx,%r12
<+192>:	add    %rcx,%rbx
<+195>:	cmp    0x8(%rbp),%rbx
<+199>:	jb     0xffffffff81779626 <_copy_from_iter+214>
<+201>:	add    $0x10,%rbp
<+205>:	xor    %ebx,%ebx
<+207>:	test   %r13,%r13
<+210>:	jne    0xffffffff817795d4 <_copy_from_iter+132>
<+212>:	jmp    0xffffffff81779629 <_copy_from_iter+217>
<+214>:	mov    %rbx,%r13
<+217>:	cmpb   $0x5,(%r15)
<+221>:	mov    %r13,0x8(%r15)
<+225>:	lea    0x10(%r15),%rdx
<+229>:	je     0xffffffff8177963b <_copy_from_iter+235>
<+231>:	mov    0x10(%r15),%rdx
<+235>:	mov    %rbp,%rax
<+238>:	mov    %rbp,0x10(%r15)
<+242>:	mov    %r12,%r13
<+245>:	sub    %rdx,%rax
<+248>:	sar    $0x4,%rax
<+252>:	sub    %rax,0x20(%r15)
<+256>:	jmp    0xffffffff8177988f <_copy_from_iter+831>

# ITER_BVEC
<+261>:	cmp    $0x2,%al
<+263>:	jne    0xffffffff817796f4 <_copy_from_iter+420>
<+269>:	mov    0x10(%rdx),%r14
<+273>:	xor    %ebp,%ebp
<+275>:	mov    0x8(%rdx),%r12d
<+279>:	mov    0xc(%r14),%ecx
<+283>:	add    %r12d,%ecx
<+286>:	mov    %ecx,%edi
<+288>:	and    $0xfff,%ecx
<+294>:	shr    $0xc,%edi
<+297>:	shl    $0x6,%rdi
<+301>:	add    (%r14),%rdi
<+304>:	call   0xffffffff81777282 <kmap_local_page>
<+309>:	mov    0x8(%r14),%ebx
<+313>:	mov    $0x1000,%edx
<+318>:	mov    0x1(%r15),%dil
<+322>:	sub    %r12d,%ebx
<+325>:	cmp    %r13,%rbx
<+328>:	cmova  %r13,%rbx
<+332>:	sub    %rcx,%rdx
<+335>:	cmp    %rdx,%rbx
<+338>:	cmova  %rdx,%rbx
<+342>:	lea    (%rax,%rcx,1),%rdx
<+346>:	mov    (%rsp),%rax
<+350>:	mov    %rbx,%rcx
<+353>:	add    %ebx,%r12d
<+356>:	lea    (%rax,%rbp,1),%rsi
<+360>:	add    %rbx,%rbp
<+363>:	call   0xffffffff81779531 <memcpy_from_iter>
<+368>:	cmp    %r12d,0x8(%r14)
<+372>:	jne    0xffffffff817796cd <_copy_from_iter+381>
<+374>:	add    $0x10,%r14
<+378>:	xor    %r12d,%r12d
<+381>:	sub    %rbx,%r13
<+384>:	jne    0xffffffff81779667 <_copy_from_iter+279>
<+386>:	mov    %r12d,%eax
<+389>:	mov    %rbp,%r13
<+392>:	mov    %rax,0x8(%r15)
<+396>:	mov    %r14,%rax
<+399>:	sub    0x10(%r15),%rax
<+403>:	mov    %r14,0x10(%r15)
<+407>:	sar    $0x4,%rax
<+411>:	sub    %rax,0x20(%r15)
<+415>:	jmp    0xffffffff8177988f <_copy_from_iter+831>

# ITER_KVEC
<+420>:	cmp    $0x1,%al
<+422>:	jne    0xffffffff81779771 <_copy_from_iter+545>
<+424>:	mov    0x10(%rdx),%r12
<+428>:	xor    %r14d,%r14d
<+431>:	mov    0x8(%rdx),%rbp
<+435>:	mov    0x8(%r12),%rbx
<+440>:	sub    %rbp,%rbx
<+443>:	cmp    %r13,%rbx
<+446>:	cmova  %r13,%rbx
<+450>:	test   %rbx,%rbx
<+453>:	je     0xffffffff81779742 <_copy_from_iter+498>
<+455>:	mov    (%r12),%rdx
<+459>:	mov    %rbx,%rcx
<+462>:	sub    %rbx,%r13
<+465>:	mov    (%rsp),%rax
<+469>:	mov    0x1(%r15),%dil
<+473>:	add    %rbp,%rdx
<+476>:	add    %rbx,%rbp
<+479>:	lea    (%rax,%r14,1),%rsi
<+483>:	add    %rbx,%r14
<+486>:	call   0xffffffff81779531 <memcpy_from_iter>
<+491>:	cmp    0x8(%r12),%rbp
<+496>:	jb     0xffffffff8177974f <_copy_from_iter+511>
<+498>:	add    $0x10,%r12
<+502>:	xor    %ebp,%ebp
<+504>:	test   %r13,%r13
<+507>:	jne    0xffffffff81779703 <_copy_from_iter+435>
<+509>:	jmp    0xffffffff81779752 <_copy_from_iter+514>
<+511>:	mov    %rbp,%r13
<+514>:	mov    %r12,%rax
<+517>:	sub    0x10(%r15),%rax
<+521>:	mov    %r13,0x8(%r15)
<+525>:	mov    %r14,%r13
<+528>:	mov    %r12,0x10(%r15)
<+532>:	sar    $0x4,%rax
<+536>:	sub    %rax,0x20(%r15)
<+540>:	jmp    0xffffffff8177988f <_copy_from_iter+831>

# ITER_XARRAY
<+545>:	cmp    $0x3,%al
<+547>:	jne    0xffffffff8177988f <_copy_from_iter+831>
<+553>:	mov    0x10(%rdx),%rax
<+557>:	mov    $0x1000,%ebp
<+562>:	movq   $0x3,0x28(%rsp)
<+571>:	mov    0x8(%rdx),%r14
<+575>:	add    0x20(%rdx),%r14
<+579>:	xor    %edx,%edx
<+581>:	mov    %rdx,0x30(%rsp)
<+586>:	mov    %rax,0x10(%rsp)
<+591>:	mov    %rdx,0x38(%rsp)
<+596>:	mov    %r14,%rax
<+599>:	mov    %rdx,0x40(%rsp)
<+604>:	shr    $0xc,%rax
<+608>:	mov    %rax,0x18(%rsp)
<+613>:	xor    %eax,%eax
<+615>:	mov    %eax,0x20(%rsp)
<+619>:	mov    %r14,%rax
<+622>:	and    $0xfff,%eax
<+627>:	sub    %rax,%rbp
<+630>:	call   0xffffffff81126bcf <__rcu_read_lock>
<+635>:	or     $0xffffffffffffffff,%rsi
<+639>:	lea    0x10(%rsp),%rdi
<+644>:	call   0xffffffff81d5edaf <xas_find>
<+649>:	mov    %r13,0x8(%rsp)
<+654>:	mov    %rax,%rbx
<+657>:	xor    %r13d,%r13d
<+660>:	test   %rbx,%rbx
<+663>:	je     0xffffffff81779886 <_copy_from_iter+822>
<+669>:	lea    0x10(%rsp),%rdi
<+674>:	mov    %rbx,%rsi
<+677>:	call   0xffffffff81777300 <xas_retry>
<+682>:	test   %al,%al
<+684>:	jne    0xffffffff81779874 <_copy_from_iter+804>
<+686>:	test   $0x1,%bl
<+689>:	jne    0xffffffff81779824 <_copy_from_iter+724>
<+691>:	mov    %rbx,%rdi
<+694>:	call   0xffffffff81270e56 <folio_test_hugetlb>
<+699>:	test   %al,%al
<+701>:	jne    0xffffffff81779824 <_copy_from_iter+724>
<+703>:	lea    (%r14,%r13,1),%rdx
<+707>:	mov    %rbx,%rdi
<+710>:	call   0xffffffff81777266 <folio_size>
<+715>:	lea    -0x1(%rax),%r12
<+719>:	and    %rdx,%r12
<+722>:	jmp    0xffffffff81779867 <_copy_from_iter+791>
<+724>:	ud2
<+726>:	jmp    0xffffffff81779886 <_copy_from_iter+822>
<+728>:	mov    %r12,%rsi
<+731>:	mov    %rbx,%rdi
<+734>:	call   0xffffffff817772a7 <kmap_local_folio>
<+739>:	mov    0x1(%r15),%dil
<+743>:	mov    %rax,%rdx
<+746>:	mov    (%rsp),%rax
<+750>:	cmp    %rbp,0x8(%rsp)
<+755>:	cmovbe 0x8(%rsp),%rbp
<+761>:	mov    %rbp,%rcx
<+764>:	lea    (%rax,%r13,1),%rsi
<+768>:	add    %rbp,%r13
<+771>:	call   0xffffffff81779531 <memcpy_from_iter>
<+776>:	sub    %rbp,0x8(%rsp)
<+781>:	je     0xffffffff81779886 <_copy_from_iter+822>
<+783>:	add    %rbp,%r12
<+786>:	mov    $0x1000,%ebp
<+791>:	mov    %rbx,%rdi
<+794>:	call   0xffffffff81777266 <folio_size>
<+799>:	cmp    %rax,%r12
<+802>:	jb     0xffffffff81779828 <_copy_from_iter+728>
<+804>:	lea    0x10(%rsp),%rdi
<+809>:	call   0xffffffff81777d61 <xas_next_entry>
<+814>:	mov    %rax,%rbx
<+817>:	jmp    0xffffffff817797e4 <_copy_from_iter+660>
<+822>:	call   0xffffffff811299a3 <__rcu_read_unlock>
<+827>:	add    %r13,0x8(%r15)

# ITER_DISCARD / default
<+831>:	sub    %r13,0x18(%r15)
<+835>:	mov    0x48(%rsp),%rax
<+840>:	sub    %gs:0x28,%rax
<+849>:	je     0xffffffff817798a8 <_copy_from_iter+856>
<+851>:	call   0xffffffff81d657ac <__stack_chk_fail>
<+856>:	add    $0x50,%rsp
<+860>:	mov    %r13,%rax
<+863>:	pop    %rbx
<+864>:	pop    %rbp
<+865>:	pop    %r12
<+867>:	pop    %r13
<+869>:	pop    %r14
<+871>:	pop    %r15
<+873>:	jmp    0xffffffff81d72960 <__x86_return_thunk>

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=dump_b

PATCHED
<+0>:	push   %r15
<+2>:	push   %r14
<+4>:	push   %r13
<+6>:	push   %r12
<+8>:	push   %rbp
<+9>:	push   %rbx
<+10>:	sub    $0x68,%rsp
<+14>:	mov    %rdi,(%rsp)
<+18>:	mov    %gs:0x28,%rax
<+27>:	mov    %rax,0x60(%rsp)
<+32>:	xor    %eax,%eax
<+34>:	cmpb   $0x0,0x3(%rdx)
<+38>:	je     0xffffffff8177931e <_copy_from_iter+67>
<+40>:	mov    0x18(%rdx),%rax
<+44>:	mov    %rdx,%r15
<+47>:	cmp    %rax,%rsi
<+50>:	cmovbe %rsi,%rax
<+54>:	test   %rax,%rax
<+57>:	mov    %rax,%rbx
<+60>:	jne    0xffffffff81779327 <_copy_from_iter+76>
<+62>:	jmp    0xffffffff81779645 <_copy_from_iter+874>
<+67>:	ud2
<+69>:	xor    %ebx,%ebx
<+71>:	jmp    0xffffffff81779645 <_copy_from_iter+874>

# ITER_UBUF
<+76>:	mov    (%rdx),%al
<+78>:	cmp    $0x5,%al
<+80>:	jne    0xffffffff8177934b <_copy_from_iter+112>
<+82>:	mov    0x8(%rdx),%rdi
<+86>:	xor    %esi,%esi
<+88>:	add    0x10(%rdx),%rdi
<+92>:	mov    %rbx,%rdx
<+95>:	mov    (%rsp),%rcx
<+99>:	call   0xffffffff81778207 <copy_from_user_iter>
<+104>:	sub    %rax,%rbx
<+107>:	jmp    0xffffffff8177963d <_copy_from_iter+866>

# ITER_IOVEC
<+112>:	test   %al,%al
<+114>:	jne    0xffffffff817793b4 <_copy_from_iter+217>
<+116>:	mov    0x10(%rdx),%r13
<+120>:	xor    %r14d,%r14d
<+123>:	mov    0x8(%rdx),%r12
<+127>:	mov    0x8(%r13),%rbp
<+131>:	sub    %r12,%rbp
<+134>:	cmp    %rbx,%rbp
<+137>:	cmova  %rbx,%rbp
<+141>:	test   %rbp,%rbp
<+144>:	je     0xffffffff8177939b <_copy_from_iter+192>
<+146>:	mov    0x0(%r13),%rdi
<+150>:	mov    %rbp,%rdx
<+153>:	mov    %r14,%rsi
<+156>:	sub    %rbp,%rbx
<+159>:	mov    (%rsp),%rcx
<+163>:	add    %r12,%rdi
<+166>:	call   0xffffffff81778207 <copy_from_user_iter>
<+171>:	mov    %rbp,%rdx
<+174>:	sub    %rax,%rdx
<+177>:	add    %rax,%rbx
<+180>:	add    %rdx,%r14
<+183>:	add    %r12,%rdx
<+186>:	cmp    0x8(%r13),%rdx
<+190>:	jb     0xffffffff817793ac <_copy_from_iter+209>
<+192>:	add    $0x10,%r13
<+196>:	xor    %r12d,%r12d
<+199>:	test   %rbx,%rbx
<+202>:	jne    0xffffffff8177935a <_copy_from_iter+127>
<+204>:	jmp    0xffffffff817794bb <_copy_from_iter+480>
<+209>:	mov    %rdx,%rbx
<+212>:	jmp    0xffffffff817794bb <_copy_from_iter+480>

# ITER_BVEC
<+217>:	cmp    $0x2,%al
<+219>:	jne    0xffffffff81779457 <_copy_from_iter+380>
<+225>:	mov    0x10(%rdx),%r13
<+229>:	xor    %r12d,%r12d
<+232>:	mov    0x8(%rdx),%r14
<+236>:	mov    0xc(%r13),%ecx
<+240>:	mov    %r12,%rsi
<+243>:	mov    %r15,%r8
<+246>:	add    %r14,%rcx
<+249>:	mov    %rcx,%rdi
<+252>:	and    $0xfff,%ecx
<+258>:	shr    $0xc,%rdi
<+262>:	shl    $0x6,%rdi
<+266>:	add    0x0(%r13),%rdi
<+270>:	call   0xffffffff81777282 <kmap_local_page>
<+275>:	mov    0x8(%r13),%ebp
<+279>:	mov    $0x1000,%edx
<+284>:	lea    (%rax,%rcx,1),%rdi
<+288>:	sub    %r14,%rbp
<+291>:	cmp    %rbx,%rbp
<+294>:	cmova  %rbx,%rbp
<+298>:	sub    %rcx,%rdx
<+301>:	mov    (%rsp),%rcx
<+305>:	cmp    %rdx,%rbp
<+308>:	cmova  %rdx,%rbp
<+312>:	mov    %rbp,%rdx
<+315>:	call   0xffffffff81777934 <memcpy_from_iter_mc>
<+320>:	mov    %rbp,%rdx
<+323>:	sub    %rax,%rdx
<+326>:	add    %rax,%rbx
<+329>:	add    %rdx,%r12
<+332>:	add    %rdx,%r14
<+335>:	mov    0x8(%r13),%edx
<+339>:	sub    %rbp,%rbx
<+342>:	cmp    %rdx,%r14
<+345>:	jb     0xffffffff8177943d <_copy_from_iter+354>
<+347>:	add    $0x10,%r13
<+351>:	xor    %r14d,%r14d
<+354>:	test   %rax,%rax
<+357>:	jne    0xffffffff81779447 <_copy_from_iter+364>
<+359>:	test   %rbx,%rbx
<+362>:	jne    0xffffffff817793c7 <_copy_from_iter+236>
<+364>:	mov    %r13,0x10(%r15)
<+368>:	mov    %r12,%rbx
<+371>:	mov    %r14,0x8(%r15)
<+375>:	jmp    0xffffffff81779641 <_copy_from_iter+870>

# ITER_KVEC
<+380>:	cmp    $0x1,%al
<+382>:	jne    0xffffffff817794cb <_copy_from_iter+496>
<+384>:	mov    0x10(%rdx),%r13
<+388>:	xor    %r14d,%r14d
<+391>:	mov    0x8(%rdx),%r12
<+395>:	mov    0x8(%r13),%rbp
<+399>:	sub    %r12,%rbp
<+402>:	cmp    %rbx,%rbp
<+405>:	cmova  %rbx,%rbp
<+409>:	test   %rbp,%rbp
<+412>:	je     0xffffffff817794aa <_copy_from_iter+463>
<+414>:	mov    0x0(%r13),%rdi
<+418>:	mov    %rbp,%rdx
<+421>:	mov    %r14,%rsi
<+424>:	mov    %r15,%r8
<+427>:	mov    (%rsp),%rcx
<+431>:	sub    %rbp,%rbx
<+434>:	add    %r12,%rdi
<+437>:	call   0xffffffff81777934 <memcpy_from_iter_mc>
<+442>:	mov    %rbp,%rdx
<+445>:	sub    %rax,%rdx
<+448>:	add    %rax,%rbx
<+451>:	add    %rdx,%r14
<+454>:	add    %rdx,%r12
<+457>:	cmp    0x8(%r13),%r12
<+461>:	jb     0xffffffff817794b8 <_copy_from_iter+477>
<+463>:	add    $0x10,%r13
<+467>:	xor    %r12d,%r12d
<+470>:	test   %rbx,%rbx
<+473>:	jne    0xffffffff81779466 <_copy_from_iter+395>
<+475>:	jmp    0xffffffff817794bb <_copy_from_iter+480>
<+477>:	mov    %r12,%rbx
<+480>:	mov    %rbx,0x8(%r15)
<+484>:	mov    %r14,%rbx
<+487>:	mov    %r13,0x10(%r15)
<+491>:	jmp    0xffffffff81779641 <_copy_from_iter+870>

# ITER_XARRAY
<+496>:	cmp    $0x3,%al
<+498>:	jne    0xffffffff81779641 <_copy_from_iter+870>
<+504>:	movq   $0x3,0x40(%rsp)
<+513>:	mov    0x10(%rdx),%rax
<+517>:	mov    0x8(%rdx),%r13
<+521>:	add    0x20(%rdx),%r13
<+525>:	xor    %edx,%edx
<+527>:	mov    %rdx,0x48(%rsp)
<+532>:	mov    %rax,0x28(%rsp)
<+537>:	mov    %rdx,0x50(%rsp)
<+542>:	mov    %r13,%rax
<+545>:	mov    %rdx,0x58(%rsp)
<+550>:	shr    $0xc,%rax
<+554>:	mov    %rax,0x30(%rsp)
<+559>:	xor    %eax,%eax
<+561>:	mov    %eax,0x38(%rsp)
<+565>:	call   0xffffffff81126bcf <__rcu_read_lock>
<+570>:	or     $0xffffffffffffffff,%rsi
<+574>:	lea    0x28(%rsp),%rdi
<+579>:	call   0xffffffff81d5ed2f <xas_find>
<+584>:	xor    %ecx,%ecx
<+586>:	mov    %rax,%rbp
<+589>:	mov    %rcx,0x8(%rsp)
<+594>:	test   %rbp,%rbp
<+597>:	je     0xffffffff81779589 <_copy_from_iter+686>
<+599>:	lea    0x28(%rsp),%rdi
<+604>:	mov    %rbp,%rsi
<+607>:	call   0xffffffff81777300 <xas_retry>
<+612>:	test   %al,%al
<+614>:	jne    0xffffffff81779626 <_copy_from_iter+843>
<+620>:	test   $0x1,%ebp
<+626>:	jne    0xffffffff81779587 <_copy_from_iter+684>
<+628>:	mov    %rbp,%rdi
<+631>:	call   0xffffffff81270e56 <folio_test_hugetlb>
<+636>:	test   %al,%al
<+638>:	jne    0xffffffff81779593 <_copy_from_iter+696>
<+640>:	mov    %rbp,%rdi
<+643>:	mov    %rbx,%r11
<+646>:	call   0xffffffff81777266 <folio_size>
<+651>:	lea    -0x1(%rax),%r12
<+655>:	call   0xffffffff81777266 <folio_size>
<+660>:	and    %r13,%r12
<+663>:	sub    %r12,%rax
<+666>:	cmp    %rbx,%rax
<+669>:	cmova  %rbx,%rax
<+673>:	mov    %rax,%r9
<+676>:	mov    %rax,%r14
<+679>:	jmp    0xffffffff81779617 <_copy_from_iter+828>
<+684>:	ud2
<+686>:	mov    0x8(%rsp),%rbx
<+691>:	jmp    0xffffffff81779638 <_copy_from_iter+861>
<+696>:	ud2
<+698>:	jmp    0xffffffff81779589 <_copy_from_iter+686>
<+700>:	mov    %r12,%rsi
<+703>:	mov    %rbp,%rdi
<+706>:	mov    %r11,0x20(%rsp)
<+711>:	mov    %r15,%r8
<+714>:	mov    %r9,0x18(%rsp)
<+719>:	call   0xffffffff817772a7 <kmap_local_folio>
<+724>:	mov    $0x1000,%edx
<+729>:	mov    (%rsp),%rcx
<+733>:	mov    %rax,%rdi
<+736>:	mov    %r12,%rax
<+739>:	mov    0x8(%rsp),%rsi
<+744>:	and    $0xfff,%eax
<+749>:	sub    %rax,%rdx
<+752>:	cmp    %r14,%rdx
<+755>:	cmova  %r14,%rdx
<+759>:	mov    %rdx,0x10(%rsp)
<+764>:	call   0xffffffff81777934 <memcpy_from_iter_mc>
<+769>:	mov    0x10(%rsp),%rdx
<+774>:	mov    0x8(%rsp),%rbx
<+779>:	mov    %rax,%rsi
<+782>:	mov    0x20(%rsp),%r11
<+787>:	mov    %rdx,%rcx
<+790>:	sub    %rdx,%rsi
<+793>:	sub    %rax,%rcx
<+796>:	add    %rcx,%rbx
<+799>:	add    %rsi,%r11
<+802>:	test   %rax,%rax
<+805>:	jne    0xffffffff81779638 <_copy_from_iter+861>
<+807>:	test   %r11,%r11
<+810>:	je     0xffffffff81779638 <_copy_from_iter+861>
<+812>:	mov    0x18(%rsp),%r9
<+817>:	add    %rsi,%r14
<+820>:	add    %rcx,%r12
<+823>:	mov    %rbx,0x8(%rsp)
<+828>:	test   %r14,%r14
<+831>:	jne    0xffffffff81779597 <_copy_from_iter+700>
<+837>:	add    %r9,%r13
<+840>:	mov    %r11,%rbx
<+843>:	lea    0x28(%rsp),%rdi
<+848>:	call   0xffffffff81777d00 <xas_next_entry>
<+853>:	mov    %rax,%rbp
<+856>:	jmp    0xffffffff8177952d <_copy_from_iter+594>
<+861>:	call   0xffffffff811299a3 <__rcu_read_unlock>
<+866>:	add    %rbx,0x8(%r15)

# ITER_DISCARD / default
<+870>:	sub    %rbx,0x18(%r15)
<+874>:	mov    0x60(%rsp),%rax
<+879>:	sub    %gs:0x28,%rax
<+888>:	je     0xffffffff8177965a <_copy_from_iter+895>
<+890>:	call   0xffffffff81d6572c <__stack_chk_fail>
<+895>:	add    $0x68,%rsp
<+899>:	mov    %rbx,%rax
<+902>:	pop    %rbx
<+903>:	pop    %rbp
<+904>:	pop    %r12
<+906>:	pop    %r13
<+908>:	pop    %r14
<+910>:	pop    %r15
<+912>:	jmp    0xffffffff81d728e0 <__x86_return_thunk>

--=-=-=--

