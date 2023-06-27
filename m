Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD3E7400CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjF0QXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF0QXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:23:40 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BBB26A9
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:23:38 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so3772643276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687883018; x=1690475018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qymS9y/iBQJ/Nbtgv3hEJrG0PMa0rrPgMrPQ2j32eRU=;
        b=cX6aE86FpHdfRFsdIIgbTpEgKD/Vu2YaitK2vLRrQg49v5sfKauLKa+/hmPC64QbWN
         lZYVvZRR80L6HLdIU1vhGPGJgnwsxf1Bb1wEeoKAGrBVzk9Snfun7mghg9W+u+hgR67X
         LKWGZLIeNqusorujboi2uhuN3vpDdOMs35gUGte5KRAInUeSoXLZgk1a1evNWDsoxNxs
         w9Yfer2GlW92ulsQm+8CRdz7cjowDs3WNqV7wk0jO6lpXK1T/0JYTv0w9+eN9kPgEFGd
         fPoLKr1qMrEYyPrEv4eyZ/0ZuMTU/sWbL0AjFqwNzLkgZd/fbZjfirILKN37PGDUIk+G
         NM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883018; x=1690475018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qymS9y/iBQJ/Nbtgv3hEJrG0PMa0rrPgMrPQ2j32eRU=;
        b=IxuXUkNBWQEoHRmGAPgEdhYtydvPmxFyR+WN7HA1c8HYWk8LnynjzHo80vhfVEq+nv
         FRgNuTS9BFhxjt2SiA7UDnXtSeNx1SkhYIy2EAzR2/EoBviLmtU04WmbCy6CagCfqddt
         sYIuXlkdzTz6sbtbsQEGStOSlv0fe6kPlVmQ7Q120R5yR8xsAP5wtU0ejFFnGexFLfkv
         O7c0R6u+3mF7dBizfRcgw/+B/n18d8Cc4fcCvGa1Zh1COySBQkehB8YH9AYLd8eudNzR
         jD/63rjw6BHjTSenfnrCkJbP65LNXReOpJ/yW0JCkZlCpkwiec22YumHGqcxFhXcVYiH
         6bzw==
X-Gm-Message-State: AC+VfDzWNVLwr3++WyCSFQfDxKiQ9UdmJS/gm3Z+N+GXy8f7T+ZwaxwV
        ouZTbMgiL3L899UAL2NMw9mxQIP1dxHqgLc2AXVU3A==
X-Google-Smtp-Source: ACHHUZ55vtvWXDpDJ91JhVYJu5OqOdjEzz1lOxA79ilXOPa63gdyb/WDbHmi+KEDsz//Yk8mxcBPvYE5d1gzq1EXwZk=
X-Received: by 2002:a05:6902:1342:b0:c1c:f99e:ef55 with SMTP id
 g2-20020a056902134200b00c1cf99eef55mr6600031ybu.57.1687883017742; Tue, 27 Jun
 2023 09:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com> <20230627042321.1763765-8-surenb@google.com>
 <ZJsFFzKG3W7UPCeo@x1n>
In-Reply-To: <ZJsFFzKG3W7UPCeo@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 09:23:26 -0700
Message-ID: <CAJuCfpFC05vCwAONO7YxG=LhqteyYmOy1Nprg2NyjQ6hKaHgOA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm: drop VMA lock before waiting for migration
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 8:49=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jun 26, 2023 at 09:23:20PM -0700, Suren Baghdasaryan wrote:
> > migration_entry_wait does not need VMA lock, therefore it can be
> > dropped before waiting.
>
> Hmm, I'm not sure..
>
> Note that we're still dereferencing *vmf->pmd when waiting, while *pmd is
> on the page table and IIUC only be guaranteed if the vma is still there.
> If without both mmap / vma lock I don't see what makes sure the pgtable i=
s
> always there.  E.g. IIUC a race can happen where unmap() runs right after
> vma_end_read() below but before pmdp_get_lockless() (inside
> migration_entry_wait()), then pmdp_get_lockless() can read some random
> things if the pgtable is freed.

That sounds correct. I thought ptl would keep pmd stable but there is
time between vma_end_read() and spin_lock(ptl) when it can be freed
from under us. I think it would work if we do vma_end_read() after
spin_lock(ptl) but that requires code refactoring. I'll probably drop
this optimization from the patchset for now to keep things simple and
will get back to it later.

>
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/memory.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 5caaa4c66ea2..bdf46fdc58d6 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3715,8 +3715,18 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> >       if (unlikely(non_swap_entry(entry))) {
> >               if (is_migration_entry(entry)) {
> > -                     migration_entry_wait(vma->vm_mm, vmf->pmd,
> > -                                          vmf->address);
> > +                     /* Save mm in case VMA lock is dropped */
> > +                     struct mm_struct *mm =3D vma->vm_mm;
> > +
> > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > +                             /*
> > +                              * No need to hold VMA lock for migration=
.
> > +                              * WARNING: vma can't be used after this!
> > +                              */
> > +                             vma_end_read(vma);
> > +                             ret |=3D VM_FAULT_COMPLETED;
> > +                     }
> > +                     migration_entry_wait(mm, vmf->pmd, vmf->address);
> >               } else if (is_device_exclusive_entry(entry)) {
> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
> >                       ret =3D remove_device_exclusive_entry(vmf);
> > --
> > 2.41.0.178.g377b9f9a00-goog
> >
>
> --
> Peter Xu
>
