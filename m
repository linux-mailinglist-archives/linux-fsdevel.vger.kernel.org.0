Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4A87AA6D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 03:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjIVB6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 21:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjIVB6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:58:02 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD12F5
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 18:57:56 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d857c8a1d50so1979922276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695347875; x=1695952675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VO+Ge+AE8f/BpXh60ZRTwmlgGyLBpX4NWc4kauL7gk=;
        b=pmQOuQek+Dl/zj3tPrIx7LwBXB4aerpHjaEzxIZuB7M/N3H1KuPpemDl6z0YPLq0CM
         3uAkTbLuX+PZb46BGuARtF1YHeCEzkpzP+r59XPuhw2JHxDTTnlqB5zwdHxVFuVDlitV
         MQiWo/qKUdmaxb1EmRVw8jC6ZnQ63IQ3tOYvPAFZwpZlQgUfhkeKkpIhu1cSPYhkdYJi
         gi5HGnq9FcwvIXhwU0wVH8IExu3D5n6Ssiz0dgWxGvUkcx2eqA3VhDvCPz06IafRmSHV
         8N37wdUbbqKQ3x9pV2A9vC+7cZfoK6lRC6wQHaxc+mai2/dCIBxyT90eO6b5YDUuev7E
         yjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695347875; x=1695952675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VO+Ge+AE8f/BpXh60ZRTwmlgGyLBpX4NWc4kauL7gk=;
        b=j6Ebl1K/Sid94U0z+Q3ek5u4Y7MeLYIZ5aF7UOZxvfdzrYNbzqOY2hyOatavqDg7PM
         RBT44xaEu5D5CqYMjika39rdojZ+r58LkH+QQ/di2gi4biGxq9WlzKDD+lTkObqSAypc
         eQZuuxM1YpY6tAm5p+FLCRYDwaTRYjMG59019kVp1P8nTa6Wwe3VUe3MMr05DX4V5c52
         MFV+7B+ppPlYqeDWyllv85EnpTJ7vUjBtO4Q2Noq83ffpxgJ7ioASRSR9dSe0aRwgiB6
         Z759ZWX559uDuhVNynzEhhpZkcgKJhBR9YRCT0yIo0yh1LTbjcBZI60DK4y8bVYDXXCO
         2AsA==
X-Gm-Message-State: AOJu0Ywbr4Q1hfATBJhUtsFoCYpXP960Q1yJzvFqgxZofmLOumHH7nNQ
        /w9L/QPygd1aNUE8PXIVIxNEAax7n3lfURFTyy9ppQ==
X-Google-Smtp-Source: AGHT+IFDkyyPEsrC9Wj9nF/S+MbVDC6dnqaz+XU/fSuXkDfbU5BW9gEPn4qeHv0lwMKIpSIhy5Aq1Uhhnng66UQqtWU=
X-Received: by 2002:a25:cf48:0:b0:d7e:df89:dda1 with SMTP id
 f69-20020a25cf48000000b00d7edf89dda1mr7254798ybg.7.1695347874999; Thu, 21 Sep
 2023 18:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-3-surenb@google.com>
 <ZQNMze6SXdIm13CW@casper.infradead.org> <e77b75f9-ab9e-f20b-6484-22f73524c159@redhat.com>
 <f6e350f4-1bf3-ca10-93f8-c11db44ce62b@redhat.com> <CAJuCfpGqt1V5puRMhLkjG6F2T4xtsDY8qy--ZfBPNL9kxPyWtg@mail.gmail.com>
 <354f2508-74d5-2723-502c-32d009f77a3e@redhat.com>
In-Reply-To: <354f2508-74d5-2723-502c-32d009f77a3e@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 21 Sep 2023 18:57:42 -0700
Message-ID: <CAJuCfpFk6tfP=nJng4G1dSsSEy-piQUSAShrVdBJzXBH=YF3aQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:17=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 21.09.23 20:04, Suren Baghdasaryan wrote:
> > On Thu, Sep 14, 2023 at 6:45=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 14.09.23 20:43, David Hildenbrand wrote:
> >>> On 14.09.23 20:11, Matthew Wilcox wrote:
> >>>> On Thu, Sep 14, 2023 at 08:26:12AM -0700, Suren Baghdasaryan wrote:
> >>>>> +++ b/include/linux/userfaultfd_k.h
> >>>>> @@ -93,6 +93,23 @@ extern int mwriteprotect_range(struct mm_struct =
*dst_mm,
> >>>>>     extern long uffd_wp_range(struct vm_area_struct *vma,
> >>>>>                        unsigned long start, unsigned long len, bool=
 enable_wp);
> >>>>>
> >>>>> +/* remap_pages */
> >>>>> +extern void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> >>>>> +extern void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> >>>>> +extern ssize_t remap_pages(struct mm_struct *dst_mm,
> >>>>> +                      struct mm_struct *src_mm,
> >>>>> +                      unsigned long dst_start,
> >>>>> +                      unsigned long src_start,
> >>>>> +                      unsigned long len, __u64 flags);
> >>>>> +extern int remap_pages_huge_pmd(struct mm_struct *dst_mm,
> >>>>> +                           struct mm_struct *src_mm,
> >>>>> +                           pmd_t *dst_pmd, pmd_t *src_pmd,
> >>>>> +                           pmd_t dst_pmdval,
> >>>>> +                           struct vm_area_struct *dst_vma,
> >>>>> +                           struct vm_area_struct *src_vma,
> >>>>> +                           unsigned long dst_addr,
> >>>>> +                           unsigned long src_addr);
> >>>>
> >>>> Drop the 'extern' markers from function declarations.
> >>>>
> >>>>> +int remap_pages_huge_pmd(struct mm_struct *dst_mm,
> >>>>> +                    struct mm_struct *src_mm,
> >>>>> +                    pmd_t *dst_pmd, pmd_t *src_pmd,
> >>>>> +                    pmd_t dst_pmdval,
> >>>>> +                    struct vm_area_struct *dst_vma,
> >>>>> +                    struct vm_area_struct *src_vma,
> >>>>> +                    unsigned long dst_addr,
> >>>>> +                    unsigned long src_addr)
> >>>>> +{
> >>>>> +   pmd_t _dst_pmd, src_pmdval;
> >>>>> +   struct page *src_page;
> >>>>> +   struct anon_vma *src_anon_vma, *dst_anon_vma;
> >>>>> +   spinlock_t *src_ptl, *dst_ptl;
> >>>>> +   pgtable_t pgtable;
> >>>>> +   struct mmu_notifier_range range;
> >>>>> +
> >>>>> +   src_pmdval =3D *src_pmd;
> >>>>> +   src_ptl =3D pmd_lockptr(src_mm, src_pmd);
> >>>>> +
> >>>>> +   BUG_ON(!pmd_trans_huge(src_pmdval));
> >>>>> +   BUG_ON(!pmd_none(dst_pmdval));
> >>>>> +   BUG_ON(!spin_is_locked(src_ptl));
> >>>>> +   mmap_assert_locked(src_mm);
> >>>>> +   mmap_assert_locked(dst_mm);
> >>>>> +   BUG_ON(src_addr & ~HPAGE_PMD_MASK);
> >>>>> +   BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
> >>>>> +
> >>>>> +   src_page =3D pmd_page(src_pmdval);
> >>>>> +   BUG_ON(!PageHead(src_page));
> >>>>> +   BUG_ON(!PageAnon(src_page));
> >>>>
> >>>> Better to add a src_folio =3D page_folio(src_page);
> >>>> and then folio_test_anon() here.
> >>>>
> >>>>> +   if (unlikely(page_mapcount(src_page) !=3D 1)) {
> >>>>
> >>>> Brr, this is going to miss PTE mappings of this folio.  I think you
> >>>> actually want folio_mapcount() instead, although it'd be more effici=
ent
> >>>> to look at folio->_entire_mapcount =3D=3D 1 and _nr_pages_mapped =3D=
=3D 0.
> >>>> Not wure what a good name for that predicate would be.
> >>>
> >>> We have
> >>>
> >>>     * It only works on non shared anonymous pages because those can
> >>>     * be relocated without generating non linear anon_vmas in the rma=
p
> >>>     * code.
> >>>     *
> >>>     * It provides a zero copy mechanism to handle userspace page faul=
ts.
> >>>     * The source vma pages should have mapcount =3D=3D 1, which can b=
e
> >>>     * enforced by using madvise(MADV_DONTFORK) on src vma.
> >>>
> >>> Use PageAnonExclusive(). As long as KSM is not involved and you don't
> >>> use fork(), that flag should be good enough for that use case here.
> >>>
> >> ... and similarly don't do any of that swapcount stuff and only check =
if
> >> the swap pte is anon exclusive.
> >
> > I'm preparing v2 and this is the only part left for me to address but
> > I'm not clear how. David, could you please clarify how I should be
> > checking swap pte to be exclusive without swapcount?
>
> If you have a real swp pte (not a non-swap pte like migration entries)
> you should be able to just use pte_swp_exclusive().

Got it. Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>
