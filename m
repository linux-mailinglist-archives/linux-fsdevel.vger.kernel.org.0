Return-Path: <linux-fsdevel+bounces-9028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D1283D209
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 02:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868561C234B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 01:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE910F7;
	Fri, 26 Jan 2024 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vw6mzbkv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7AC387
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232353; cv=none; b=fQ36SPeYy5n8SuKtxVspHx+EQzuhbmusJcIpbJNgAUf9tWlInhqxMo3fj0yJP0d4rDBlX0eqzqIBwNecPZw4yzvAQDnllqduHvOGFIFMnW2qXYVlV1yLswE2krZFx4nR9Ekl+gFl0oB2BW0jaM297pRG1A0BKSVpz36ajiDsj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232353; c=relaxed/simple;
	bh=uOQRXLkepVViiBpubRVEm7Qts99jo6iGqZv5RJI8ERw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyWVfvnkJdHVGOT0VHmK4Mr70aWBZoHb3SJN85kpyVPfOMlKEU2SJ2Ww1uhUdTntAqVbxBus3qae8yNSK6Jbv1uWkV8wHqqGM55fKMoBr/o7n2aJQq9lZh2tRtpVS4PO+YhswJfqDiRT6xrGOOr4IQi1SoVkxX+SUY/S4ZKywck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vw6mzbkv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33934567777so5047371f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 17:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706232350; x=1706837150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7sgtjDmnNmYT5wo9p5HigR77VUYiLKMX+832fMlFkk=;
        b=vw6mzbkvZ4d7JfaQVJwvX1DnMSaE/xIXDBKpMQqM+SBZDMMJMkO64YxGvFd6U1I6IJ
         ciiWzOHzQ3a2pESZPeuLjV3ME5K/MWzra7DW7TlJwfnxajxKqX9wDnhBdPNkLGuCIVYz
         yq70XydkMpeJ5G9VA8FEEikuNEY3HQ+PGmvLSLmKiWzQ3uYkaKn7McabArT2FmCkabYN
         udJMk5IB8hIHE9k6/YQneLcjRqWILmwX6eaEfo8KgN+C49hFbzhc69dzZD+LBY2aWls6
         FNlnesg3U0xGvA51lXq5wpFqSw+CqXge3kHLmyd0vCUbA9g2J/J1XGrVaqe9Ns60yFqg
         dsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706232350; x=1706837150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7sgtjDmnNmYT5wo9p5HigR77VUYiLKMX+832fMlFkk=;
        b=HtLVZM+Xv+OgJ0BUSTIEKJBUNfdbokayH4/SKwj5zbt8eJtAhb1gBa8e+oQs3vV1Po
         z2yBlJz7BRnllkcq+XNrZ90n4tiig7LH+apzOt8mueg1C8sug/y8XIIiQ8hNL+9T/8d+
         HfOJXSDXL+8sXaJPZ1zmdmbuHbXtj3jdu5IvjxyNxVS68L9VwZvNwK6uQUweJ4uPbzzx
         SWqjE+cZJlw2379oWYx+IH+UID7M+c5uiU3Qi869NehZM2CpqB8Uf3CHQ0UjlfmDGUEJ
         q2DZpe9nSOcjm3JLDlCJzKaHl5l1GBg8eKIVTasDqs7nXpbdEHkdfDR2nAtYTITokkt/
         ajOw==
X-Gm-Message-State: AOJu0YyQ4unvCLy3CkkgUeQRpix6PaR5Zfd4Eib1re26iSXXDnhoXvPb
	C7I3QEKszvOxSiL3Indt6Msk/UQ/ddTGRqkjrr14yVVP9O1G3QdZdBbo3xMB33lOhv3sd2vloau
	ESk+yEs6FtdtN4dLhTrlxvpMdUAV4/MjHwbqD
X-Google-Smtp-Source: AGHT+IER/4v3zUypLyBKaJxlWHigPZgT5Qc7CB5E/NSTIAKyQ498U2hsglxxXV6b0MObkMfMt63Qm/Xbcm0c1PNOAtA=
X-Received: by 2002:a05:6000:12:b0:337:c075:d2b4 with SMTP id
 h18-20020a056000001200b00337c075d2b4mr372076wrx.62.1706232349633; Thu, 25 Jan
 2024 17:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125001328.335127-1-surenb@google.com>
In-Reply-To: <20240125001328.335127-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 25 Jan 2024 17:25:37 -0800
Message-ID: <CAJuCfpEXnrzr4YdPPzz7Dbeo6a=es03EGbCyYuh1hP97=mijqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] userfaultfd: handle zeropage moves by UFFDIO_MOVE
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 4:13=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Current implementation of UFFDIO_MOVE fails to move zeropages and returns
> EBUSY when it encounters one. We can handle them by mapping a zeropage
> at the destination and clearing the mapping at the source. This is done
> both for ordinary and for huge zeropages.

I made a stupid mistake when formatting this patch and it says [PATCH
1/2] but it should be the only patch in the set. So, please do not
look for [2/2]. Sorry about the confusion.
Thanks,
Suren.

>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Applies cleanly over mm-unstable branch.
>
>  mm/huge_memory.c | 105 +++++++++++++++++++++++++++--------------------
>  mm/userfaultfd.c |  42 +++++++++++++++----
>  2 files changed, 96 insertions(+), 51 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f40feb31b507..5dcc02c25e97 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2190,13 +2190,18 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd, pm
>         }
>
>         src_page =3D pmd_page(src_pmdval);
> -       if (unlikely(!PageAnonExclusive(src_page))) {
> -               spin_unlock(src_ptl);
> -               return -EBUSY;
> -       }
>
> -       src_folio =3D page_folio(src_page);
> -       folio_get(src_folio);
> +       if (!is_huge_zero_pmd(src_pmdval)) {
> +               if (unlikely(!PageAnonExclusive(src_page))) {
> +                       spin_unlock(src_ptl);
> +                       return -EBUSY;
> +               }
> +
> +               src_folio =3D page_folio(src_page);
> +               folio_get(src_folio);
> +       } else
> +               src_folio =3D NULL;
> +
>         spin_unlock(src_ptl);
>
>         flush_cache_range(src_vma, src_addr, src_addr + HPAGE_PMD_SIZE);
> @@ -2204,19 +2209,22 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd, pm
>                                 src_addr + HPAGE_PMD_SIZE);
>         mmu_notifier_invalidate_range_start(&range);
>
> -       folio_lock(src_folio);
> +       if (src_folio) {
> +               folio_lock(src_folio);
>
> -       /*
> -        * split_huge_page walks the anon_vma chain without the page
> -        * lock. Serialize against it with the anon_vma lock, the page
> -        * lock is not enough.
> -        */
> -       src_anon_vma =3D folio_get_anon_vma(src_folio);
> -       if (!src_anon_vma) {
> -               err =3D -EAGAIN;
> -               goto unlock_folio;
> -       }
> -       anon_vma_lock_write(src_anon_vma);
> +               /*
> +                * split_huge_page walks the anon_vma chain without the p=
age
> +                * lock. Serialize against it with the anon_vma lock, the=
 page
> +                * lock is not enough.
> +                */
> +               src_anon_vma =3D folio_get_anon_vma(src_folio);
> +               if (!src_anon_vma) {
> +                       err =3D -EAGAIN;
> +                       goto unlock_folio;
> +               }
> +               anon_vma_lock_write(src_anon_vma);
> +       } else
> +               src_anon_vma =3D NULL;
>
>         dst_ptl =3D pmd_lockptr(mm, dst_pmd);
>         double_pt_lock(src_ptl, dst_ptl);
> @@ -2225,45 +2233,54 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd, pm
>                 err =3D -EAGAIN;
>                 goto unlock_ptls;
>         }
> -       if (folio_maybe_dma_pinned(src_folio) ||
> -           !PageAnonExclusive(&src_folio->page)) {
> -               err =3D -EBUSY;
> -               goto unlock_ptls;
> -       }
> +       if (src_folio) {
> +               if (folio_maybe_dma_pinned(src_folio) ||
> +                   !PageAnonExclusive(&src_folio->page)) {
> +                       err =3D -EBUSY;
> +                       goto unlock_ptls;
> +               }
>
> -       if (WARN_ON_ONCE(!folio_test_head(src_folio)) ||
> -           WARN_ON_ONCE(!folio_test_anon(src_folio))) {
> -               err =3D -EBUSY;
> -               goto unlock_ptls;
> -       }
> +               if (WARN_ON_ONCE(!folio_test_head(src_folio)) ||
> +                   WARN_ON_ONCE(!folio_test_anon(src_folio))) {
> +                       err =3D -EBUSY;
> +                       goto unlock_ptls;
> +               }
>
> -       folio_move_anon_rmap(src_folio, dst_vma);
> -       WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr)=
);
> +               folio_move_anon_rmap(src_folio, dst_vma);
> +               WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, d=
st_addr));
>
> -       src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
> -       /* Folio got pinned from under us. Put it back and fail the move.=
 */
> -       if (folio_maybe_dma_pinned(src_folio)) {
> -               set_pmd_at(mm, src_addr, src_pmd, src_pmdval);
> -               err =3D -EBUSY;
> -               goto unlock_ptls;
> -       }
> +               src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_addr, s=
rc_pmd);
> +               /* Folio got pinned from under us. Put it back and fail t=
he move. */
> +               if (folio_maybe_dma_pinned(src_folio)) {
> +                       set_pmd_at(mm, src_addr, src_pmd, src_pmdval);
> +                       err =3D -EBUSY;
> +                       goto unlock_ptls;
> +               }
>
> -       _dst_pmd =3D mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot)=
;
> -       /* Follow mremap() behavior and treat the entry dirty after the m=
ove */
> -       _dst_pmd =3D pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
> +               _dst_pmd =3D mk_huge_pmd(&src_folio->page, dst_vma->vm_pa=
ge_prot);
> +               /* Follow mremap() behavior and treat the entry dirty aft=
er the move */
> +               _dst_pmd =3D pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
> +       } else {
> +               src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_addr, s=
rc_pmd);
> +               _dst_pmd =3D mk_huge_pmd(src_page, dst_vma->vm_page_prot)=
;
> +       }
>         set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
>
>         src_pgtable =3D pgtable_trans_huge_withdraw(mm, src_pmd);
>         pgtable_trans_huge_deposit(mm, dst_pmd, src_pgtable);
>  unlock_ptls:
>         double_pt_unlock(src_ptl, dst_ptl);
> -       anon_vma_unlock_write(src_anon_vma);
> -       put_anon_vma(src_anon_vma);
> +       if (src_anon_vma) {
> +               anon_vma_unlock_write(src_anon_vma);
> +               put_anon_vma(src_anon_vma);
> +       }
>  unlock_folio:
>         /* unblock rmap walks */
> -       folio_unlock(src_folio);
> +       if (src_folio)
> +               folio_unlock(src_folio);
>         mmu_notifier_invalidate_range_end(&range);
> -       folio_put(src_folio);
> +       if (src_folio)
> +               folio_put(src_folio);
>         return err;
>  }
>  #endif /* CONFIG_USERFAULTFD */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 3548b3e31a97..5fbf4da15c5c 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -959,6 +959,31 @@ static int move_swap_pte(struct mm_struct *mm,
>         return 0;
>  }
>
> +static int move_zeropage_pte(struct mm_struct *mm,
> +                            struct vm_area_struct *dst_vma,
> +                            struct vm_area_struct *src_vma,
> +                            unsigned long dst_addr, unsigned long src_ad=
dr,
> +                            pte_t *dst_pte, pte_t *src_pte,
> +                            pte_t orig_dst_pte, pte_t orig_src_pte,
> +                            spinlock_t *dst_ptl, spinlock_t *src_ptl)
> +{
> +       pte_t zero_pte;
> +
> +       double_pt_lock(dst_ptl, src_ptl);
> +       if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
> +           !pte_same(ptep_get(dst_pte), orig_dst_pte))
> +               return -EAGAIN;
> +
> +       zero_pte =3D pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
> +                                        dst_vma->vm_page_prot));
> +       ptep_clear_flush(src_vma, src_addr, src_pte);
> +       set_pte_at(mm, dst_addr, dst_pte, zero_pte);
> +       double_pt_unlock(dst_ptl, src_ptl);
> +
> +       return 0;
> +}
> +
> +
>  /*
>   * The mmap_lock for reading is held by the caller. Just move the page
>   * from src_pmd to dst_pmd if possible, and return true if succeeded
> @@ -1041,6 +1066,14 @@ static int move_pages_pte(struct mm_struct *mm, pm=
d_t *dst_pmd, pmd_t *src_pmd,
>         }
>
>         if (pte_present(orig_src_pte)) {
> +               if (is_zero_pfn(pte_pfn(orig_src_pte))) {
> +                       err =3D move_zeropage_pte(mm, dst_vma, src_vma,
> +                                              dst_addr, src_addr, dst_pt=
e, src_pte,
> +                                              orig_dst_pte, orig_src_pte=
,
> +                                              dst_ptl, src_ptl);
> +                       goto out;
> +               }
> +
>                 /*
>                  * Pin and lock both source folio and anon_vma. Since we =
are in
>                  * RCU read section, we can't block, so on contention hav=
e to
> @@ -1404,19 +1437,14 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, s=
truct mm_struct *mm,
>                                 err =3D -ENOENT;
>                                 break;
>                         }
> -                       /* Avoid moving zeropages for now */
> -                       if (is_huge_zero_pmd(*src_pmd)) {
> -                               spin_unlock(ptl);
> -                               err =3D -EBUSY;
> -                               break;
> -                       }
>
>                         /* Check if we can move the pmd without splitting=
 it. */
>                         if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
>                             !pmd_none(dst_pmdval)) {
>                                 struct folio *folio =3D pfn_folio(pmd_pfn=
(*src_pmd));
>
> -                               if (!folio || !PageAnonExclusive(&folio->=
page)) {
> +                               if (!folio || (!is_huge_zero_page(&folio-=
>page) &&
> +                                              !PageAnonExclusive(&folio-=
>page))) {
>                                         spin_unlock(ptl);
>                                         err =3D -EBUSY;
>                                         break;
> --
> 2.43.0.429.g432eaa2c6b-goog
>

