Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440E6587F8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 17:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiHBP5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbiHBP5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56C2D30B
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659455865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbpYAhPaugN+6AMKh/dWW9aTUmKw8fgpyefe3Fi/aYY=;
        b=gIutJo8kh/9jIiqsGZfEIWpimnwSSxW/y2itzHoYZ80iONHQ2PIMM7MMV1+tARqE0VuuPP
        JIrZQ7LgNFyhs7bQXvoU0S0SZomiKG6UT1Vk6LxKZOL8H6FGyAig9BfIUCvW/6GLUtEMmo
        b1Qx5hupnnr4aKtlkLAnr7Qwnw4beXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-4_0Mpbu3NKef5BfpFsn6PA-1; Tue, 02 Aug 2022 11:57:34 -0400
X-MC-Unique: 4_0Mpbu3NKef5BfpFsn6PA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50AC28037AE;
        Tue,  2 Aug 2022 15:57:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2498040CF916;
        Tue,  2 Aug 2022 15:57:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 272FvXWb013148;
        Tue, 2 Aug 2022 11:57:33 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 272FvW1j013144;
        Tue, 2 Aug 2022 11:57:32 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 2 Aug 2022 11:57:32 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Will Deacon <will@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] introduce test_bit_acquire and use it in
 wait_on_bit
In-Reply-To: <20220802133652.GA27253@willie-the-truck>
Message-ID: <alpine.LRH.2.02.2208021137430.12343@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com> <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com> <alpine.LRH.2.02.2208010640260.22006@file01.intranet.prod.int.rdu2.redhat.com> <20220801155421.GB26280@willie-the-truck>
 <alpine.LRH.2.02.2208011206430.31960@file01.intranet.prod.int.rdu2.redhat.com> <20220802084015.GB26962@willie-the-truck> <alpine.LRH.2.02.2208020726220.6971@file01.intranet.prod.int.rdu2.redhat.com> <20220802133652.GA27253@willie-the-truck>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 2 Aug 2022, Will Deacon wrote:

> On Tue, Aug 02, 2022 at 07:38:17AM -0400, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 2 Aug 2022, Will Deacon wrote:
> > 
> > > On Mon, Aug 01, 2022 at 12:12:47PM -0400, Mikulas Patocka wrote:
> > > > On Mon, 1 Aug 2022, Will Deacon wrote:
> > > > > On Mon, Aug 01, 2022 at 06:42:15AM -0400, Mikulas Patocka wrote:
> > > > > 
> > > > > > Index: linux-2.6/arch/x86/include/asm/bitops.h
> > > > > > ===================================================================
> > > > > > --- linux-2.6.orig/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > > > > > +++ linux-2.6/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > > > > > @@ -203,8 +203,10 @@ arch_test_and_change_bit(long nr, volati
> > > > > >  
> > > > > >  static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
> > > > > >  {
> > > > > > -	return ((1UL << (nr & (BITS_PER_LONG-1))) &
> > > > > > +	bool r = ((1UL << (nr & (BITS_PER_LONG-1))) &
> > > > > >  		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> > > > > > +	barrier();
> > > > > > +	return r;
> > > > > 
> > > > > Hmm, I find it a bit weird to have a barrier() here given that 'addr' is
> > > > > volatile and we don't need a barrier() like this in the definition of
> > > > > READ_ONCE(), for example.
> > > > 
> > > > gcc doesn't reorder two volatile accesses, but it can reorder non-volatile
> > > > accesses around volatile accesses.
> > > > 
> > > > The purpose of the compiler barrier is to make sure that the non-volatile 
> > > > accesses that follow test_bit are not reordered by the compiler before the 
> > > > volatile access to addr.
> > > 
> > > If we need these accesses to be ordered reliably, then we need a CPU barrier
> > > and that will additionally prevent the compiler reordering. So I still don't
> > > think we need the barrier() here.
> > 
> > This is x86-specific code. x86 has strong memory ordering, so we only care 
> > about compiler reordering.
> 
> Indeed, but what I'm trying to say is that the _caller_ would have a memory
> barrier in this case, and so there's no need for one in here. test_bit() does
> not have ordering semantics.
> 
> Will

But constant_test_bit() is also used for test_bit_acquire(), and for 
test_bit_acquire(), the barrier is needed. Without the barrier, it doesn't 
have acquire semantics, because the compiler (not CPU) can move the 
following non-volatile accesses before the volatile access to "addr[nr >> 
_BITOPS_LONG_SHIFT]".

See this piece of code in arch/x86/include/asm/bitops.h in the patch:
+#define arch_test_bit_acquire(nr, addr)                \
+	arch_test_bit(nr, addr)

We could split constant_test_bit() to two functions: constant_test_bit() 
and constant_test_bit_acquire() and put the barrier only in 
constant_test_bit_acquire(). But I chose not to do it because code 
duplication is bad and because the overhead of the compiler barrier is 
none.

Mikulas

