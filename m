Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DFA7B0D23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjI0UEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjI0UEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:04:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9671411F
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 13:04:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c6052422acso6935ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 13:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695845084; x=1696449884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+XWKbIJGAs+2CKK7tWSiWj10aUmSxPjwzc7ZpoiI1E=;
        b=4wNF6k0ql3NGzj+SCSfd8DA/aMLofLCcpjvNj3duDaEtESiv4nLwLmMYZNUOlspf/S
         eQNywfBXBxpUZFd+3YCosvvf02fjbevsOvaanDiZQaYZX2YD8UViio8WKWrY3e0je8Nz
         P217nt13Hm8lY4W7MyMJ2XxO64CpmDJR9U7+SWJhTNU5o1S7HxmbMUxDPhAgTN7gdtgt
         AUU0FoOza5Kmy6a7B0cUEn8pGstJj81sgThalaOQDDtDkUqzwPB3ZAV0HOJEvJ1Pu0gU
         SZKBnyXGH5Gd27MR7gRsptaGPUTpEoymoFb4NxFe5gOwalarsGuo/53jGxA+/j3tGpgQ
         i3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695845084; x=1696449884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+XWKbIJGAs+2CKK7tWSiWj10aUmSxPjwzc7ZpoiI1E=;
        b=vRZtppD2SjVnsacrSz3ESXjUbqgufgHsIXkZ5MBkLGCKP8NZj5j22RDQFQJ8d3wkoY
         V5Je17SfU4BzOTBFP2BTTATxRVwherpoO2JxYJzU864r96J47w5mXjJUYd754ctDVQex
         n4wF6X6N3d/ixDXjnkJRi04IHOBVj0GwSDL77gWa/3VYQuAKnFEfC3d252Wez4XnuxVU
         WQcKgoXZLxzdcIIi/iOl2d5DHvTLIqCAUtLEi9Tvbrp5NFtB0lmt0OzF0ENc/4yXm39f
         Hr3iRzvymo4keafIzAgENsg4A28VbjeELXWf8MJa/MRpkoy9N+s4Zq7LKwBSL5poENFe
         Aobw==
X-Gm-Message-State: AOJu0Yz976Q16TV0yvOxrMQKR4zvISalgsEMp+3OyDBzeGRaQxnR/pSy
        aENiCt4snnRF5K9mDkSaEYh+U0pcm7qmx0mtRYiFIiDu1EVoFzOHongjrw==
X-Google-Smtp-Source: AGHT+IGGVIFFSOgyJo8JdJxittG6SViQRjz4xTB/xRvT5NGB27U15736n2XSm+PW86J4HyH8mjwxAkUSePlEAP9pdsg=
X-Received: by 2002:a17:902:d482:b0:1c3:fe16:9f32 with SMTP id
 c2-20020a170902d48200b001c3fe169f32mr524985plg.15.1695845083776; Wed, 27 Sep
 2023 13:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com> <CAJuCfpGb5Amo9Sk0yyruJt9NKaYe9-y+5jmU442NSf3+VT5-dA@mail.gmail.com>
In-Reply-To: <CAJuCfpGb5Amo9Sk0yyruJt9NKaYe9-y+5jmU442NSf3+VT5-dA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 27 Sep 2023 22:04:06 +0200
Message-ID: <CAG48ez2WNOMwPo4OMVUHbS4mirwbqHUY5qUaaZ9DTkXdkzrjiQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 8:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Wed, Sep 27, 2023 at 5:47=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > On Sat, Sep 23, 2023 at 3:31=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > From: Andrea Arcangeli <aarcange@redhat.com>
> > >
> > > This implements the uABI of UFFDIO_REMAP.
> > >
> > > Notably one mode bitflag is also forwarded (and in turn known) by the
> > > lowlevel remap_pages method.
> > >
> > > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
[...]
> > > +                       /*
> > > +                        * folio_referenced walks the anon_vma chain
> > > +                        * without the folio lock. Serialize against =
it with
> > > +                        * the anon_vma lock, the folio lock is not e=
nough.
> > > +                        */
> > > +                       src_anon_vma =3D folio_get_anon_vma(src_folio=
);
> > > +                       if (!src_anon_vma) {
> > > +                               /* page was unmapped from under us */
> > > +                               err =3D -EAGAIN;
> > > +                               goto out;
> > > +                       }
> > > +                       if (!anon_vma_trylock_write(src_anon_vma)) {
> > > +                               pte_unmap(&orig_src_pte);
> > > +                               pte_unmap(&orig_dst_pte);
> > > +                               src_pte =3D dst_pte =3D NULL;
> > > +                               /* now we can block and wait */
> > > +                               anon_vma_lock_write(src_anon_vma);
> > > +                               goto retry;
> > > +                       }
> > > +               }
> >
> > So at this point we have:
> >
> >  - the current src_pte
> >  - some referenced+locked src_folio that used to be mapped exclusively
> > at src_addr
> >  - (the anon_vma associated with the src_folio)
> >
> > > +               err =3D remap_anon_pte(dst_mm, src_mm,  dst_vma, src_=
vma,
> > > +                                    dst_addr, src_addr, dst_pte, src=
_pte,
> > > +                                    orig_dst_pte, orig_src_pte,
> > > +                                    dst_ptl, src_ptl, src_folio);
> >
> > And then this will, without touching folio mapcounts/refcounts, delete
> > the current PTE at src_addr, and create a PTE at dst_addr pointing to
> > the old src_folio, leading to incorrect refcounts/mapcounts?
>
> I assume this still points to the missing previous_src_pte check
> discussed in the previous comments. Is that correct or is there yet
> another issue?

This is still referring to the missing previous_src_pte check.

> >
> > > +       } else {
> > [...]
> > > +       }
> > > +
> > > +out:
> > > +       if (src_anon_vma) {
> > > +               anon_vma_unlock_write(src_anon_vma);
> > > +               put_anon_vma(src_anon_vma);
> > > +       }
> > > +       if (src_folio) {
> > > +               folio_unlock(src_folio);
> > > +               folio_put(src_folio);
> > > +       }
> > > +       if (dst_pte)
> > > +               pte_unmap(dst_pte);
> > > +       if (src_pte)
> > > +               pte_unmap(src_pte);
> > > +       mmu_notifier_invalidate_range_end(&range);
> > > +
> > > +       return err;
> > > +}
> > [...]
> > > +ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *src_=
mm,
> > > +                   unsigned long dst_start, unsigned long src_start,
> > > +                   unsigned long len, __u64 mode)
> > > +{
> > > +       struct vm_area_struct *src_vma, *dst_vma;
> > > +       unsigned long src_addr, dst_addr;
> > > +       pmd_t *src_pmd, *dst_pmd;
> > > +       long err =3D -EINVAL;
> > > +       ssize_t moved =3D 0;
> > > +
> > > +       /*
> > > +        * Sanitize the command parameters:
> > > +        */
> > > +       BUG_ON(src_start & ~PAGE_MASK);
> > > +       BUG_ON(dst_start & ~PAGE_MASK);
> > > +       BUG_ON(len & ~PAGE_MASK);
> > > +
> > > +       /* Does the address range wrap, or is the span zero-sized? */
> > > +       BUG_ON(src_start + len <=3D src_start);
> > > +       BUG_ON(dst_start + len <=3D dst_start);
> > > +
> > > +       /*
> > > +        * Because these are read sempahores there's no risk of lock
> > > +        * inversion.
> > > +        */
> > > +       mmap_read_lock(dst_mm);
> > > +       if (dst_mm !=3D src_mm)
> > > +               mmap_read_lock(src_mm);
> > > +
> > > +       /*
> > > +        * Make sure the vma is not shared, that the src and dst rema=
p
> > > +        * ranges are both valid and fully within a single existing
> > > +        * vma.
> > > +        */
> > > +       src_vma =3D find_vma(src_mm, src_start);
> > > +       if (!src_vma || (src_vma->vm_flags & VM_SHARED))
> > > +               goto out;
> > > +       if (src_start < src_vma->vm_start ||
> > > +           src_start + len > src_vma->vm_end)
> > > +               goto out;
> > > +
> > > +       dst_vma =3D find_vma(dst_mm, dst_start);
> > > +       if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> > > +               goto out;
> > > +       if (dst_start < dst_vma->vm_start ||
> > > +           dst_start + len > dst_vma->vm_end)
> > > +               goto out;
> > > +
> > > +       err =3D validate_remap_areas(src_vma, dst_vma);
> > > +       if (err)
> > > +               goto out;
> > > +
> > > +       for (src_addr =3D src_start, dst_addr =3D dst_start;
> > > +            src_addr < src_start + len;) {
> > > +               spinlock_t *ptl;
> > > +               pmd_t dst_pmdval;
> > > +               unsigned long step_size;
> > > +
> > > +               BUG_ON(dst_addr >=3D dst_start + len);
> > > +               /*
> > > +                * Below works because anonymous area would not have =
a
> > > +                * transparent huge PUD. If file-backed support is ad=
ded,
> > > +                * that case would need to be handled here.
> > > +                */
> > > +               src_pmd =3D mm_find_pmd(src_mm, src_addr);
> > > +               if (unlikely(!src_pmd)) {
> > > +                       if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLE=
S)) {
> > > +                               err =3D -ENOENT;
> > > +                               break;
> > > +                       }
> > > +                       src_pmd =3D mm_alloc_pmd(src_mm, src_addr);
> > > +                       if (unlikely(!src_pmd)) {
> > > +                               err =3D -ENOMEM;
> > > +                               break;
> > > +                       }
> > > +               }
> > > +               dst_pmd =3D mm_alloc_pmd(dst_mm, dst_addr);
> > > +               if (unlikely(!dst_pmd)) {
> > > +                       err =3D -ENOMEM;
> > > +                       break;
> > > +               }
> > > +
> > > +               dst_pmdval =3D pmdp_get_lockless(dst_pmd);
> > > +               /*
> > > +                * If the dst_pmd is mapped as THP don't override it =
and just
> > > +                * be strict. If dst_pmd changes into TPH after this =
check, the
> > > +                * remap_pages_huge_pmd() will detect the change and =
retry
> > > +                * while remap_pages_pte() will detect the change and=
 fail.
> > > +                */
> > > +               if (unlikely(pmd_trans_huge(dst_pmdval))) {
> > > +                       err =3D -EEXIST;
> > > +                       break;
> > > +               }
> > > +
> > > +               ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > > +               if (ptl && !pmd_trans_huge(*src_pmd)) {
> > > +                       spin_unlock(ptl);
> > > +                       ptl =3D NULL;
> > > +               }
> >
> > This still looks wrong - we do still have to split_huge_pmd()
> > somewhere so that remap_pages_pte() works.
>
> Hmm, I guess this extra check is not even needed...

Hm, and instead we'd bail at the pte_offset_map_nolock() in
remap_pages_pte()? I guess that's unusual but works...

(It would be a thing to look out for if anyone tried to backport this,
since the checks in pte_offset_map_nolock() were only introduced in
6.5, but idk if anyone's doing that)
