Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31C72A76D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 03:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFJB35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 21:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFJB34 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 21:29:56 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCB730F4
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 18:29:55 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565cdb77b01so21178067b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686360595; x=1688952595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FKJ3xPJEDetSK5auCGGcapjjk91ewFvgiFRw0hqYb0=;
        b=tOtScZVwZNwDUDalvhpk5D8h1duHJC9b998fE1WumdZZRJbExd+da8AJdP3IZ5Wae/
         5nb6O/f3+WMjQJEFgWrI+wFdIr3WJVKy361rNGexVno4GyofOLxRv1ED9LyOv0G6wFeB
         +L352ZuS1kMGc/90BnLCPWkAVDvU27yfXKYtSLR6CaI8aVSeFy0dW9+txuuI0F2lbPLL
         NC4qerfdGfI11b3wj41HVyB+zsVPrh3x3ibIqdsrqPV68CtMPa1de9kcnwc95D/rDVm6
         9n6gjQcHxvlnY2Q+i64cRlcbQikt5Absa2MZ2QUQHi/nTePPVQFHvumqFwkSXlDNzeO6
         NKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686360595; x=1688952595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FKJ3xPJEDetSK5auCGGcapjjk91ewFvgiFRw0hqYb0=;
        b=NhDVCbhmZ/YbNUe838XAZsNulwujKeuxMLDXNunvsaKpNhkawbMx3xo4TYwZbZQIYq
         5cODJJOcnAvCAlymiANq8d+PfOPPn5vfabX1u0ZFGYcGCUd6oJS0DRWhUHtGTzIMAYH1
         CqrxTDZ4hy348fFgp4He39HXj0vvePgY3lkXRd4SGDBrNtSPvjQ52hK90Xd2MlOB97S7
         UXtR+tTvFQ3yBPdc/bWMmX3tZsCbcYsoq61IbYv2QYNUNwJs5/NcowKJwIaFYQh9YeGE
         /yNQN/fUM/9HUjoRNUaS7Nmr/DEOhWVnFzpFhdhtu1y66HneCdkczmFfvVsOZOzNuYAF
         Jl0w==
X-Gm-Message-State: AC+VfDyW6cpkH5paYM/L+a6sl6L2W2s0TT0uTIJN0ZhC6z7icJou9TBX
        yUbGWTBNEOEH4BW2XzqiqxkioDMQch32zF9ItpJQ0g==
X-Google-Smtp-Source: ACHHUZ5olS/VKLyw26AHgQlVBf0OLVFr6x8YW8avTg9PVS60xY2nu8cfesfDPnrAVmkdYUX3hVIVpz5CG9a0BKsTOWA=
X-Received: by 2002:a0d:df97:0:b0:561:baee:ee8 with SMTP id
 i145-20020a0ddf97000000b00561baee0ee8mr2916493ywe.32.1686360594592; Fri, 09
 Jun 2023 18:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-5-surenb@google.com>
 <ZIOOmC26qh4EXUEX@x1n> <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
In-Reply-To: <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jun 2023 18:29:43 -0700
Message-ID: <CAJuCfpG3PrbGxpDAEkyGQXW88+otb=FsbrhPJ4ePN7Xhn0a+_A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: drop VMA lock before waiting for migration
To:     Peter Xu <peterx@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 3:30=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Fri, Jun 9, 2023 at 1:42=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
> >
> > On Thu, Jun 08, 2023 at 05:51:56PM -0700, Suren Baghdasaryan wrote:
> > > migration_entry_wait does not need VMA lock, therefore it can be drop=
ped
> > > before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VMA
> > > lock was dropped while in handle_mm_fault().
> > > Note that once VMA lock is dropped, the VMA reference can't be used a=
s
> > > there are no guarantees it was not freed.
> >
> > Then vma lock behaves differently from mmap read lock, am I right?  Can=
 we
> > still make them match on behaviors, or there's reason not to do so?
>
> I think we could match their behavior by also dropping mmap_lock here
> when fault is handled under mmap_lock (!(fault->flags &
> FAULT_FLAG_VMA_LOCK)).
> I missed the fact that VM_FAULT_COMPLETED can be used to skip dropping
> mmap_lock in do_page_fault(), so indeed, I might be able to use
> VM_FAULT_COMPLETED to skip vma_end_read(vma) for per-vma locks as well
> instead of introducing FAULT_FLAG_VMA_LOCK. I think that was your idea
> of reusing existing flags?
Sorry, I meant VM_FAULT_VMA_UNLOCKED, not FAULT_FLAG_VMA_LOCK in the
above reply.

I took a closer look into using VM_FAULT_COMPLETED instead of
VM_FAULT_VMA_UNLOCKED but when we fall back from per-vma lock to
mmap_lock we need to retry with an indication that the per-vma lock
was dropped. Returning (VM_FAULT_RETRY | VM_FAULT_COMPLETE) to
indicate such state seems strange to me ("retry" and "complete" seem
like contradicting concepts to be used in a single result). I could
use VM_FAULT_COMPLETE when releasing mmap_lock since we don't use it
in combination with VM_FAULT_RETRY and (VM_FAULT_RETRY |
VM_FAULT_VMA_UNLOCKED) when dropping per-vma lock and falling back to
mmap_lock. It still requires the new VM_FAULT_VMA_UNLOCKED flag but I
think logically that makes more sense. WDYT?

>
> >
> > One reason is if they match they can reuse existing flags and there'll =
be
> > less confusing, e.g. this:
> >
> >   (fault->flags & FAULT_FLAG_VMA_LOCK) &&
> >     (vm_fault_ret && (VM_FAULT_RETRY || VM_FAULT_COMPLETE))
> >
> > can replace the new flag, iiuc.
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
