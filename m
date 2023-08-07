Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501C17718CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 05:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjHGDdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 23:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjHGDdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:33:07 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915F89D;
        Sun,  6 Aug 2023 20:33:05 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d4f022c6c91so1223947276.2;
        Sun, 06 Aug 2023 20:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691379185; x=1691983985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS6IeiZC33tTmiycd5oF9VziudnWFwA4fXSnPFJgzm0=;
        b=jt1NcVkycFoQG/yHGtB+0jJlF/PZNamsiqBz0RYMIxTM2FlSh/KhjEUFsd4aHnhmP6
         MIhB9FV/feBXmmOswUlFFjoABsS06vHrlIE7o9OtVnaXAJ66xaoRySmjFz/hP+hlylat
         nmRdzA9UoLApEKAH12FPgawBGQ4j8n52ukQCgNh3Oxt1MTXRI+QvXD4qU2HrCGhDA/eq
         S81N6xgsx7YR+qmVSykEcXlQlbvpyNttJ8kmT0uQgRkAX46FLXaHjXRCAGyusZrFz+sB
         /qeAWIvGmiYogbK/PblG/PRiZ4NINhBEMonwBXNXWdaRYuFmAKV54FBzEQRXUk3aL7un
         /xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691379185; x=1691983985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS6IeiZC33tTmiycd5oF9VziudnWFwA4fXSnPFJgzm0=;
        b=ifd7vK+EOrLWK1QzyPoCeCDsfPFVT2lCb38Pqntv/pjYw+2a86V1FUF6MmSfELvzim
         3MmTBp5Nr8ZKJPFOkGg/W3vcz1DpTm34Yx0T0IAK2pVHdan6Yazg8n+mOUqoAgK7L8GT
         AoUMG/YVCoNvLPrGChDnBrqp3somKIynOe6iHUYpCam+oyOqd9bE4nOEwgby01vieeSJ
         xOFaMpYzOimdRU7VkI5VQacSVsEWoY5Wpi5YGt5wlT1i5aNuY/mKQenr8trAlSRljbSM
         6nXb5SGx7AuYRbAya5domUgA1+Jus3G1xTr16Gs4EHwZrL3ye8v3xfGzswWgrFnbBYxr
         mHjw==
X-Gm-Message-State: AOJu0YwS2RVlDDjKPaHsw1Us5JIqiX+ghVoO51mRM2iWVJpdIGAOiOjb
        IeyQbjSrsR99Td2XMBTxKCn7YrcaB5/cIBSXnHo=
X-Google-Smtp-Source: AGHT+IGPWU9smSGwGTr83XrOkHe/s5ajPSR2PQbL5KXhpXzqbR4Ms/gkpEunaKMSN++k3I+OK1Jz5YNuHLhT1H1UCHQ=
X-Received: by 2002:a25:26c9:0:b0:d0d:786:2999 with SMTP id
 m192-20020a2526c9000000b00d0d07862999mr7742055ybm.29.1691379184552; Sun, 06
 Aug 2023 20:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230727093637.1262110-1-usama.anjum@collabora.com>
 <20230727093637.1262110-3-usama.anjum@collabora.com> <CABb0KFFtjTve+uM=CTPChzUbJvJ=Tr3Q8espo_Rr_hutZPPAiw@mail.gmail.com>
 <6b6a4e1c-a9e9-9592-d5b4-3c9210c8b650@collabora.com>
In-Reply-To: <6b6a4e1c-a9e9-9592-d5b4-3c9210c8b650@collabora.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Sun, 6 Aug 2023 20:32:53 -0700
Message-ID: <CANaxB-wf6OeEAk0VtZoo6gJOBY9QAJHpO4=ctKHz1Nf8O1uw1g@mail.gmail.com>
Subject: Re: WIP: Performance improvements
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023 at 4:02=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> We are optimizing for more performance. Please find the change-set below
> for easy review before next revision and post your comments:
>
> - Replace memcpy() with direct copy as it proving to be very expensive
> - Don't check if PAGE_IS_FILE if no mask needs it as it is very
>   expensive to check per pte
> - Add question in comment for discussion purpose
> - Add fast path for exclusive WP for ptes
> ---
>  fs/proc/task_mmu.c | 54 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 7e92c33635cab..879baf896ed0b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1757,37 +1757,51 @@ static int pagemap_release(struct inode *inode,
> struct file *file)
>                                  PAGE_IS_HUGE)
>  #define PM_SCAN_FLAGS          (PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPAS=
YNC)
>
> +#define MASKS_OF_INTEREST(a)   (a.category_inverted | a.category_mask | =
\
> +                                a.category_anyof_mask | a.return_mask)
> +
>  struct pagemap_scan_private {
>         struct pm_scan_arg arg;
> +       unsigned long masks_of_interest;
>         unsigned long cur_vma_category;
>         struct page_region *vec_buf, cur_buf;
>         unsigned long vec_buf_len, vec_buf_index, found_pages, end_addr;
>         struct page_region __user *vec_out;
>  };
>
> -static unsigned long pagemap_page_category(struct vm_area_struct *vma,
> +static unsigned long pagemap_page_category(struct pagemap_scan_private *=
p,
> +                                          struct vm_area_struct *vma,
>                                            unsigned long addr, pte_t pte)
>  {
>         unsigned long categories =3D 0;
>
>         if (pte_present(pte)) {
> -               struct page *page =3D vm_normal_page(vma, addr, pte);
> +               struct page *page;
>
>                 categories |=3D PAGE_IS_PRESENT;
>                 if (!pte_uffd_wp(pte))
>                         categories |=3D PAGE_IS_WRITTEN;
> -               if (page && !PageAnon(page))
> -                       categories |=3D PAGE_IS_FILE;
> +
> +               if (p->masks_of_interest & PAGE_IS_FILE) {
> +                       page =3D vm_normal_page(vma, addr, pte);
> +                       if (page && !PageAnon(page))
> +                               categories |=3D PAGE_IS_FILE;
> +               }
> +
>                 if (is_zero_pfn(pte_pfn(pte)))
>                         categories |=3D PAGE_IS_PFNZERO;
>         } else if (is_swap_pte(pte)) {
> -               swp_entry_t swp =3D pte_to_swp_entry(pte);
> +               swp_entry_t swp;
>
>                 categories |=3D PAGE_IS_SWAPPED;
>                 if (!pte_swp_uffd_wp_any(pte))
>                         categories |=3D PAGE_IS_WRITTEN;
> -               if (is_pfn_swap_entry(swp) && !PageAnon(pfn_swap_entry_to=
_page(swp)))
> -                       categories |=3D PAGE_IS_FILE;
> +
> +               if (p->masks_of_interest & PAGE_IS_FILE) {
> +                       swp =3D pte_to_swp_entry(pte);
> +                       if (is_pfn_swap_entry(swp) && !PageAnon(pfn_swap_=
entry_to_page(swp)))
> +                               categories |=3D PAGE_IS_FILE;
> +               }
>         }
>
>         return categories;
> @@ -1957,9 +1971,7 @@ static bool pagemap_scan_push_range(unsigned long
> categories,
>                 if (p->vec_buf_index >=3D p->vec_buf_len)
>                         return false;
>
> -               memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
> -                      sizeof(*p->vec_buf));
> -               ++p->vec_buf_index;
> +               p->vec_buf[p->vec_buf_index++] =3D *cur_buf;
>         }
>
>         cur_buf->start =3D addr;
> @@ -2095,9 +2107,24 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
> unsigned long start,
>                 return 0;
>         }
>
> +       if (!p->vec_buf) {
> +               /* Fast path for performing exclusive WP */
> +               for (addr =3D start; addr !=3D end; pte++, addr +=3D PAGE=
_SIZE) {
> +                       if (pte_uffd_wp(ptep_get(pte)))
> +                               continue;
> +                       make_uffd_wp_pte(vma, addr, pte);
> +                       if (!flush) {
> +                               start =3D addr;
> +                               flush =3D true;
> +                       }
> +               }
> +               ret =3D 0;
> +               goto flush_and_return;
> +       }
> +
>         for (addr =3D start; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
>                 unsigned long categories =3D p->cur_vma_category |
> -                                          pagemap_page_category(vma, add=
r, ptep_get(pte));
> +                                          pagemap_page_category(p, vma, =
addr, ptep_get(pte));
>                 unsigned long next =3D addr + PAGE_SIZE;
>
>                 ret =3D pagemap_scan_output(categories, p, addr, &next);
> @@ -2119,6 +2146,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
> unsigned long start,
>                 }
>         }
>
> +flush_and_return:
>         if (flush)
>                 flush_tlb_range(vma, start, addr);
>
> @@ -2284,6 +2312,9 @@ static int pagemap_scan_init_bounce_buffer(struct
> pagemap_scan_private *p)
>          * consecutive ranges that have the same categories returned acro=
ss
>          * walk_page_range() calls.
>          */
> +       // Question: Increasing the vec_buf_len increases the execution s=
peed.
> +       // But it'll increase the memory needed to run the IOCTL. Can we =
do
> something here?
> +       // Right now only have space for 512 entries of page_region

The main problem here is that walk_page_range is executed for 512 pages.
I think we need to execute it for the whole range and interrupt it
when we need to
drain the bounce buffer.

For a trivial program that scans its address space the time is reduced from=
 20
seconds to 0.001 seconds. The test program and perf data are here:
https://gist.github.com/avagin/c5a22f3c78f8cb34281602dfe9c43d10

>         p->vec_buf_len =3D min_t(size_t, PAGEMAP_WALK_SIZE >> PAGE_SHIFT,
>                                p->arg.vec_len - 1);
>         p->vec_buf =3D kmalloc_array(p->vec_buf_len, sizeof(*p->vec_buf),
> @@ -2329,6 +2360,7 @@ static long do_pagemap_scan(struct mm_struct *mm,
> unsigned long uarg)
>         if (ret)
>                 return ret;
>
> +       p.masks_of_interest =3D MASKS_OF_INTEREST(p.arg);
>         ret =3D pagemap_scan_init_bounce_buffer(&p);
>         if (ret)
>                 return ret;
> --
> 2.39.2
>
