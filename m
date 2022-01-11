Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CF148BB4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 00:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiAKXO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 18:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiAKXO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:14:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3244FC06173F;
        Tue, 11 Jan 2022 15:14:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i5so2460362edf.9;
        Tue, 11 Jan 2022 15:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zodC5tAE+LTr3PkA8XyvCfIELEWqA7/RlSo76tDLh4k=;
        b=WTfGHqmDGKI2sZTDXuV9Z8kojFWW8RuR6q7BEdopfQiCk6PSJ1iD9Agn6yuLFIUlDm
         e3mTLubSBVpOEB8qLpsYNVqkcOkLs7Zj/rsK8yu5Un9z65NPwpRECgqz/0oNuzWYPQwA
         /YQ7dLbGnSQI5JKoXlsnV5lkd3ZFgOifu2NpbNghElhdFojZBhCiiRgVMh4xpMKiQN7a
         FIcqsMnv2bX2zjnix8L1U0Vj/YkqI9NRy0VsMNhKa1MFjXTvGvLO3jkwL9qbtaEpD4v/
         I2KUE95JdHDFS+cNf+NEu7CHnDy7opQL4R07OOeaa1NTPgd6MNZ9LDn3ELF/6yClUh+L
         F1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zodC5tAE+LTr3PkA8XyvCfIELEWqA7/RlSo76tDLh4k=;
        b=NcM5ITF9/AHJa4T+qPOyzGOpAs5GQeoFqEsVb2p6Dlbny1AGpxR4str/1qMRhAvyAW
         ho2UEXRnbc0b7QvLxvYYfPAxINOKHXFC4wISlqXnkT1ucuQe+nQVmZKx1tXRIy4Tfyo4
         OGvxoRnbgLzJXun0r3ZrxhOu5+ECMtBqeFwUSOjH2y6iIN4Jgjtq/neMA63f2gyY7Tqj
         lniDIKq932lM1rmReQtvF9x8EmEevMv5zADxeyyOTOWEv6qlRXqAZe3nmsAofkipKE8p
         kePgYzeSAzc1hXiGiDbFmferLUDPXX4EGAC7qfonATAO2OBRHXt6Lc8Qw/fO/D235nDc
         7hNQ==
X-Gm-Message-State: AOAM533iScEctJ8kWX/5gPpj3+vedTNIW+saYup3guEfz6aCAKLDwkmY
        Eztss9RwTEooz05Y1JRCFjrNvOpDxbo+rWdhS7vFXy+DuZU=
X-Google-Smtp-Source: ABdhPJw89ofAd9jHvMdmTk5XtB/xn9dI/SVADS6MAC33VWWg4HxB/h1vzzxGLaaAVqG0IvndIhm15awHTZjAFITzRkU=
X-Received: by 2002:a17:907:608b:: with SMTP id ht11mr4248949ejc.644.1641942864650;
 Tue, 11 Jan 2022 15:14:24 -0800 (PST)
MIME-Version: 1.0
References: <00000000000017977605c395a751@google.com> <0000000000009411bb05d3ab468f@google.com>
 <CAHbLzkoU_giAFiOyhHZvxLT9Vie2-8TmQv_XLDpRxbec5r5weg@mail.gmail.com>
 <YcIfj3nfuL0kzkFO@casper.infradead.org> <CAHbLzkqExMrdmJ=vy1Hmz16i6GhqWh_5RFaAZ9q4CzUpFv+v+g@mail.gmail.com>
In-Reply-To: <CAHbLzkqExMrdmJ=vy1Hmz16i6GhqWh_5RFaAZ9q4CzUpFv+v+g@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 11 Jan 2022 15:14:12 -0800
Message-ID: <CAHbLzkrcNAV2=mJmLnd+98-Qj6MEKq_Z2Ci=txYVpC8WyWq1Gg@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in __page_mapcount
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        chinwen.chang@mediatek.com, fgheet255t@gmail.com,
        Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 5, 2022 at 11:05 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Dec 21, 2021 at 10:40 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Dec 21, 2021 at 10:24:27AM -0800, Yang Shi wrote:
> > > It seems the THP is split during smaps walk. The reproducer does call
> > > MADV_FREE on partial THP which may split the huge page.
> > >
> > > The below fix (untested) should be able to fix it.
> >
> > Did you read the rest of the thread on this?  If the page is being
>
> I just revisited this. Now I see what you mean about "the rest of the
> thread". My gmail client doesn't put them in the same thread, sigh...
>
> Yeah, try_get_compound_head() seems like the right way.
>
> Or we just simply treat migration entries as mapcount == 1 as Kirill
> suggested or just skip migration entries since they are transient or
> show migration entries separately.

I think Kirill's suggestion makes some sense. The migration entry's
mapcount is 0 so "pss /= mapcount" is not called at all, so the
migration entry is actually treated like mapcount == 1. This doesn't
change the behavior. Not like swap entry, we actually can't tell how
many references for the migration entry.

But we should handle private device entry differently since its
mapcount is inc'ed when it is shared between processes. The regular
migration entry could be identified by is_migration_entry() easily.
Using try_get_compound_head() seems overkilling IMHO.

I just came up with the below patch (built and running the producer
didn't trigger the bug for me so far). If it looks fine, I will submit
it in a formal patch with more comments.

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad667dbc96f5..6a48bbb51efa 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -429,7 +429,8 @@ static void smaps_page_accumulate(struct
mem_size_stats *mss,
 }

 static void smaps_account(struct mem_size_stats *mss, struct page *page,
-               bool compound, bool young, bool dirty, bool locked)
+               bool compound, bool young, bool dirty, bool locked,
+               bool migration)
 {
        int i, nr = compound ? compound_nr(page) : 1;
        unsigned long size = nr * PAGE_SIZE;
@@ -457,7 +458,7 @@ static void smaps_account(struct mem_size_stats
*mss, struct page *page,
         * If any subpage of the compound page mapped with PTE it would elevate
         * page_count().
         */
-       if (page_count(page) == 1) {
+       if ((page_count(page) == 1) || migration) {
                smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
                        locked, true);
                return;
@@ -506,6 +507,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
        struct vm_area_struct *vma = walk->vma;
        bool locked = !!(vma->vm_flags & VM_LOCKED);
        struct page *page = NULL;
+       bool migration = false;

        if (pte_present(*pte)) {
                page = vm_normal_page(vma, addr, *pte);
@@ -525,8 +527,11 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
                        } else {
                                mss->swap_pss += (u64)PAGE_SIZE << PSS_SHIFT;
                        }
-               } else if (is_pfn_swap_entry(swpent))
+               } else if (is_pfn_swap_entry(swpent)) {
+                       if (is_migration_entry(swpent))
+                               migration = true;
                        page = pfn_swap_entry_to_page(swpent);
+               }
        } else {
                smaps_pte_hole_lookup(addr, walk);
                return;
@@ -535,7 +540,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
        if (!page)
                return;

-       smaps_account(mss, page, false, pte_young(*pte),
pte_dirty(*pte), locked);
+       smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte),
+                     locked, migration);
 }

 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -546,6 +552,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
        struct vm_area_struct *vma = walk->vma;
        bool locked = !!(vma->vm_flags & VM_LOCKED);
        struct page *page = NULL;
+       bool migration = false;

        if (pmd_present(*pmd)) {
                /* FOLL_DUMP will return -EFAULT on huge zero page */
@@ -553,8 +560,10 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
        } else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
                swp_entry_t entry = pmd_to_swp_entry(*pmd);

-               if (is_migration_entry(entry))
+               if (is_migration_entry(entry)) {
+                       migration = true;
                        page = pfn_swap_entry_to_page(entry);
+               }
        }
        if (IS_ERR_OR_NULL(page))
                return;
@@ -566,7 +575,9 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
                /* pass */;
        else
                mss->file_thp += HPAGE_PMD_SIZE;
-       smaps_account(mss, page, true, pmd_young(*pmd),
pmd_dirty(*pmd), locked);
+
+       smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
+                     locked, migration);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,

>
>
> > migrated, we should still account it ... also, you've changed the
> > refcount, so this:
> >
> >         if (page_count(page) == 1) {
> >                 smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
> >                         locked, true);
> >                 return;
> >         }
> >
> > will never trigger.
