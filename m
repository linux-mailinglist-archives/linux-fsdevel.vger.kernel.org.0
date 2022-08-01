Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B7586E5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiHAQNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 12:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiHAQM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CB37220D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659370375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJUjThABraUhNy6LWcAMkngL85HJMPWyf0Ew8APs7Fo=;
        b=gv5pYDiDkwOgPKWlg2B0RnDG9zwdYUdFJaDLbAxyPx1xLS1vY5A1rVFy13s7O7PUW8KC3g
        k394a10nTHZmCFdsMlHHivnozE/0/MfZiC9ubtxoQ+cF0IyWzaA9C4Zpx+PqlHQCZ1xOyI
        to98y77Fpimre4DGyc92sCGchA3w0bg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-7QkM_1D2Mlui_BZok73Ckg-1; Mon, 01 Aug 2022 12:12:50 -0400
X-MC-Unique: 7QkM_1D2Mlui_BZok73Ckg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 383333C0CD56;
        Mon,  1 Aug 2022 16:12:48 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C47CD90A11;
        Mon,  1 Aug 2022 16:12:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 271GClpF032719;
        Mon, 1 Aug 2022 12:12:47 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 271GClqI032715;
        Mon, 1 Aug 2022 12:12:47 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 1 Aug 2022 12:12:47 -0400 (EDT)
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
In-Reply-To: <20220801155421.GB26280@willie-the-truck>
Message-ID: <alpine.LRH.2.02.2208011206430.31960@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com> <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com> <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com> <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com> <alpine.LRH.2.02.2208010640260.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <20220801155421.GB26280@willie-the-truck>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 1 Aug 2022, Will Deacon wrote:

> On Mon, Aug 01, 2022 at 06:42:15AM -0400, Mikulas Patocka wrote:
> 
> > Index: linux-2.6/arch/x86/include/asm/bitops.h
> > ===================================================================
> > --- linux-2.6.orig/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > +++ linux-2.6/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > @@ -203,8 +203,10 @@ arch_test_and_change_bit(long nr, volati
> >  
> >  static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
> >  {
> > -	return ((1UL << (nr & (BITS_PER_LONG-1))) &
> > +	bool r = ((1UL << (nr & (BITS_PER_LONG-1))) &
> >  		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> > +	barrier();
> > +	return r;
> 
> Hmm, I find it a bit weird to have a barrier() here given that 'addr' is
> volatile and we don't need a barrier() like this in the definition of
> READ_ONCE(), for example.

gcc doesn't reorder two volatile accesses, but it can reorder non-volatile
accesses around volatile accesses.

The purpose of the compiler barrier is to make sure that the non-volatile 
accesses that follow test_bit are not reordered by the compiler before the 
volatile access to addr.

> > Index: linux-2.6/include/linux/wait_bit.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/wait_bit.h	2022-08-01 12:27:43.000000000 +0200
> > +++ linux-2.6/include/linux/wait_bit.h	2022-08-01 12:27:43.000000000 +0200
> > @@ -71,7 +71,7 @@ static inline int
> >  wait_on_bit(unsigned long *word, int bit, unsigned mode)
> >  {
> >  	might_sleep();
> > -	if (!test_bit(bit, word))
> > +	if (!test_bit_acquire(bit, word))
> >  		return 0;
> >  	return out_of_line_wait_on_bit(word, bit,
> >  				       bit_wait,
> 
> Yet another approach here would be to leave test_bit as-is and add a call to
> smp_acquire__after_ctrl_dep() since that exists already -- I don't have
> strong opinions about it, but it saves you having to add another stub to
> x86.

It would be the same as my previous patch with smp_rmb() that Linus didn't 
like. But I think smp_rmb (or smp_acquire__after_ctrl_dep) would be 
correct here.

> Will

Mikulas

