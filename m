Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC0472CE8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjFLSfj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbjFLSff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C0DE0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686594876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvY2kldHbnI0forOMXs5IpIoD8eht53xLaDy+C7VvMQ=;
        b=GuWF+e/xwM+LADy3QT8hmDQNX6af5EQKfNftoL04xitgsFbSIdzcHiWKshP0PHKBKF5koW
        7RKSFamuKtBbTMxAkE+ucmliOKynkbrsZnndxh5qWqOlttcpO9RugJsiff/eAlDYs8uRet
        DUODSFT7UrKUKn83LA7bF0LC6+wJWE4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-kUU3BuYHNQ2mmlizPCkFiQ-1; Mon, 12 Jun 2023 14:34:35 -0400
X-MC-Unique: kUU3BuYHNQ2mmlizPCkFiQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76077669a5aso36243185a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 11:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594874; x=1689186874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvY2kldHbnI0forOMXs5IpIoD8eht53xLaDy+C7VvMQ=;
        b=VlP1lew5d5IjDoYoKRYK4+NoQf4Nhl3MDpAczXbwnEpnD8skznnIsFFJ7Z+RednUch
         psbqvlKKYx0qtkv4LpCpKsnfGa+/j/lIXx9VONmd54KHPVRIvNmN0PDhWeyXroLlrHsp
         H5QCLPyPlDQc3AJRUukjlphw/BFeJHbzOOq0U4yu+Pw/7b+OSgnCPbUUjbGJyHt65lnL
         KAy3NVuqlGsGaz+jMD9mpULbXvWsV6b29AS+Mbips5KxpL243VvBETect6V+hCi8vznD
         4Dfgwe8+Kk/yC3QNaRukEIRemuQsV7Kvf8VRdPhwEC5nzCWotBGNmn62djFbcoivAkdI
         5hlA==
X-Gm-Message-State: AC+VfDxzR92WUFoZd5TO4uchKfoXmRbaHrIz1NMVNYuo+zy9ovDLW4bY
        Xx+rR3pe4J6gR9mOliw8ArO6h1kH/AteqQbRe1dqk3wYPpbwFPLsjkD4jJo4m+2HMeDeV+q7r4w
        M7XCm8E54hl5VbvikzcjKpYgEng==
X-Received: by 2002:a05:620a:3d91:b0:75b:23a1:69e4 with SMTP id ts17-20020a05620a3d9100b0075b23a169e4mr9377895qkn.4.1686594874613;
        Mon, 12 Jun 2023 11:34:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6aKEVKZ2FIzN1t/Op9owXNi1km2vS/VHCT9ZQ3B2W4JifsCVcQYVfg3PgJesSfBg/r/kd2kg==
X-Received: by 2002:a05:620a:3d91:b0:75b:23a1:69e4 with SMTP id ts17-20020a05620a3d9100b0075b23a169e4mr9377889qkn.4.1686594874287;
        Mon, 12 Jun 2023 11:34:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id 6-20020a05620a070600b0075f04e2f556sm2000172qkc.33.2023.06.12.11.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:34:33 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:34:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 4/6] mm: drop VMA lock before waiting for migration
Message-ID: <ZIdlNj+X2HDwfCeN@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-5-surenb@google.com>
 <ZIOOmC26qh4EXUEX@x1n>
 <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
 <CAJuCfpG3PrbGxpDAEkyGQXW88+otb=FsbrhPJ4ePN7Xhn0a+_A@mail.gmail.com>
 <ZIcfYQ1c5teMSHAX@x1n>
 <CAJuCfpGZvhBUdfNHojXwqZbspuhy0bstjT+-JMfwgmnqTnkoHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGZvhBUdfNHojXwqZbspuhy0bstjT+-JMfwgmnqTnkoHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:07:38AM -0700, Suren Baghdasaryan wrote:
> On Mon, Jun 12, 2023 at 6:36 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Jun 09, 2023 at 06:29:43PM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Jun 9, 2023 at 3:30 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Fri, Jun 9, 2023 at 1:42 PM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jun 08, 2023 at 05:51:56PM -0700, Suren Baghdasaryan wrote:
> > > > > > migration_entry_wait does not need VMA lock, therefore it can be dropped
> > > > > > before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VMA
> > > > > > lock was dropped while in handle_mm_fault().
> > > > > > Note that once VMA lock is dropped, the VMA reference can't be used as
> > > > > > there are no guarantees it was not freed.
> > > > >
> > > > > Then vma lock behaves differently from mmap read lock, am I right?  Can we
> > > > > still make them match on behaviors, or there's reason not to do so?
> > > >
> > > > I think we could match their behavior by also dropping mmap_lock here
> > > > when fault is handled under mmap_lock (!(fault->flags &
> > > > FAULT_FLAG_VMA_LOCK)).
> > > > I missed the fact that VM_FAULT_COMPLETED can be used to skip dropping
> > > > mmap_lock in do_page_fault(), so indeed, I might be able to use
> > > > VM_FAULT_COMPLETED to skip vma_end_read(vma) for per-vma locks as well
> > > > instead of introducing FAULT_FLAG_VMA_LOCK. I think that was your idea
> > > > of reusing existing flags?
> > > Sorry, I meant VM_FAULT_VMA_UNLOCKED, not FAULT_FLAG_VMA_LOCK in the
> > > above reply.
> > >
> > > I took a closer look into using VM_FAULT_COMPLETED instead of
> > > VM_FAULT_VMA_UNLOCKED but when we fall back from per-vma lock to
> > > mmap_lock we need to retry with an indication that the per-vma lock
> > > was dropped. Returning (VM_FAULT_RETRY | VM_FAULT_COMPLETE) to
> > > indicate such state seems strange to me ("retry" and "complete" seem
> >
> > Not relevant to this migration patch, but for the whole idea I was thinking
> > whether it should just work if we simply:
> >
> >         fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
> > -       vma_end_read(vma);
> > +       if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> > +               vma_end_read(vma);
> >
> > ?
> 
> Today when we can't handle a page fault under per-vma locks we return
> VM_FAULT_RETRY, in which case per-vma lock is dropped and the fault is

Oh I see what I missed.  I think it may not be a good idea to reuse
VM_FAULT_RETRY just for that, because it makes VM_FAULT_RETRY even more
complicated - now it adds one more case where the lock is not released,
that's when PER_VMA even if !NOWAIT.

> retried under mmap_lock. The condition you suggest above would not
> drop per-vma lock for VM_FAULT_RETRY case and would break the current
> fallback mechanism.
> However your suggestion gave me an idea. I could indicate that per-vma
> lock got dropped using vmf structure (like Matthew suggested before)
> and once handle_pte_fault(vmf) returns I could check if it returned
> VM_FAULT_RETRY but per-vma lock is still held.
> If that happens I can
> call vma_end_read() before returning from __handle_mm_fault(). That
> way any time handle_mm_fault() returns VM_FAULT_RETRY per-vma lock
> will be already released, so your condition in do_page_fault() will
> work correctly. That would eliminate the need for a new
> VM_FAULT_VMA_UNLOCKED flag. WDYT?

Sounds good.

So probably that's the major pain for now with the legacy fallback (I'll
have commented if I noticed it with the initial vma lock support..).  I
assume that'll go away as long as we recover the VM_FAULT_RETRY semantics
to before.

-- 
Peter Xu

