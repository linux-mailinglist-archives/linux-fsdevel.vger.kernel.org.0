Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74358615B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 22:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiGaUjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 16:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiGaUjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B115A469
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659299974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r8N6mOR4eh4HYhZleYP/ElZD6zJ57nbHlhorHDpdL2o=;
        b=dOmUtFgv5xaENLvmCD4x0irleJcIcSn8xtOFXS3GDS8qNKpJFh9IHaT7vJBvVUrLC7Ije5
        GvjxSxZGD+RIgxk0IRodvFh0VL1Qa398ezzYWMqiXvis2NwEmfgY9iy3gRUpnjO6w2pSNV
        BU7jSiHf1Kipjp2QLjBS5fH6GeRNFxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-h-HHsLhWPmufZYIPa7O8ZA-1; Sun, 31 Jul 2022 16:39:28 -0400
X-MC-Unique: h-HHsLhWPmufZYIPa7O8ZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48C2285A581;
        Sun, 31 Jul 2022 20:39:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15871492C3B;
        Sun, 31 Jul 2022 20:39:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 26VKdRbp006781;
        Sun, 31 Jul 2022 16:39:27 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 26VKdQgX006778;
        Sun, 31 Jul 2022 16:39:26 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 31 Jul 2022 16:39:26 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v2] make buffer_locked provide an acquire semantics
In-Reply-To: <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com> <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com> <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sun, 31 Jul 2022, Linus Torvalds wrote:

> [ Will and Paul, question for you below ]
> 
> On Sun, Jul 31, 2022 at 8:08 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > Also, there is this pattern present several times:
> >         wait_on_buffer(bh);
> >         if (!buffer_uptodate(bh))
> >                 err = -EIO;
> > It may be possible that buffer_uptodate is executed before wait_on_buffer
> > and it may return spurious error.
> 
> I'm not convinced that's actually valid.
> 
> They are testing the same memory location, and I don't think our
> memory ordering model allows for _that_ to be out-of-order. Memory
> barriers are for accesses to different memory locations.

You are right. And the bit tests are volatile, so the compiler can't 
reorder them.

But the compiler can reorder non-volatile accesses around volatile 
accesses (gcc does this, clang afaik doesn't), so the bit tests need at 
least a compiler barrier after them.

> But the patch looks fine, though I agree that the ordering in
> __wait_on_buffer should probably be moved into
> wait_on_bit/wait_on_bit_io.

Yes, there are more bugs where the code does wait_on_bit and then reads 
some data without any barrier. Adding the barrier to wait_on_bit fixes 
that.

I'll send two patches, one for wait_on_bit and the other for 
buffer_locked.

Do you think that wait_event also needs a read memory barrier? It is 
defined as:
#define wait_event(wq_head, condition)                                          \
do {                                                                            \
        might_sleep();                                                          \
        if (condition)                                                          \
                break;                                                          \
        __wait_event(wq_head, condition);                                       \
} while (0)

Mikulas

> And would we perhaps want the bitops to have the different ordering
> versions? Like "set_bit_release()" and "test_bit_acquire()"? That
> would seem to be (a) cleaner and (b) possibly generate better code for
> architectures where that makes a difference?
> 
>                Linus
> 

