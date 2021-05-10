Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F5B378F29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhEJNd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 09:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbhEJM2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 08:28:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8CCC061361
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 05:20:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gx21-20020a17090b1255b02901589d39576eso3654446pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 05:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BI1jSnICccHTcWNyJHFkwBq+AW9OzrNQiZKeObmRK4=;
        b=a8rST2miP7qSaV/2yY/wevlxGY74E+Twgg6XlkrTXm9yArxegR0bQChWDP+s2oe3lk
         BYGJZwfrSQ7xEy7+8wD4MZyIUpcKi1cIOpoK4RcJWRMhPo4wioG9Vd/g+cTV6dlZr4+8
         6Xz7tpl9dw7r2TgkygHob6pyhmnugAmmI+gzeYcgh/Zwbe8D3acYULeOZ5eqte8BIrmX
         Rqz6Q9vqKqo66QIglUJlEvHgc/jx0/+aOnhmezipMbFM8OnN7KzA6Bup4IihaTvHBgFN
         YvQQhkoqySQ3/LlALHoPPPNGIRtdHg3kqgJjIIZcAXgoW4qwHyGYZhFLHUKkk8XaCCw8
         pkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BI1jSnICccHTcWNyJHFkwBq+AW9OzrNQiZKeObmRK4=;
        b=JhbJsYaxt4h0JFbu5ob/6E6dFhojTWcnc+cw+G0MdT2XBFB2X1c4zvf0Fz5CHYkizY
         GEen4hjaf0H6iBE0N+LJ2q5q2X9bmbTZRyShClDcWZEf+Z69Lsqx+9pRzwugN7GBh8Dz
         XfAQ7fKhVXuvayLiMib60cHVEVvX1lGcnR/fzRx16adMFNnC2L8BZ2ZNoZ3Ie5RghXRe
         VkS//80DjIHFeJNpYHspc8gEsU54rBPf2DkFlSQuctBWZ5f3QouC6R1PJJQZnuLb6r+X
         x4HqwbflpmPIlQrixEDMYydf5AkoVIog9RsXqsl/Wo8Ey8h1eZeSGrfQW17/eTpx4wjc
         ICUg==
X-Gm-Message-State: AOAM533i+H3rvTOi30pxnX60jS6ptDhV19FiHwFa8uOhbuLhRoR2gO1n
        yAviMoXLeW4pge1qeL4AeTKDSGNNVWZXYxJosokUIw==
X-Google-Smtp-Source: ABdhPJzjSdNf9S10m0zIQ+hBoQkHxcth5YYGDzQqqyXgieyswQfDpPrpCdqsF2ikjcZd73al3xYDipgLwoxSN2xsA+4=
X-Received: by 2002:a17:90a:3c8d:: with SMTP id g13mr27968104pjc.13.1620649224150;
 Mon, 10 May 2021 05:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210510030027.56044-1-songmuchun@bytedance.com>
 <20210510030027.56044-7-songmuchun@bytedance.com> <20210510104524.GD22664@linux>
In-Reply-To: <20210510104524.GD22664@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 10 May 2021 20:19:47 +0800
Message-ID: <CAMZfGtUrYismcOai6zsx+X+Mixy=uUtrWU0CQJLxJn8kcfB+8A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v23 6/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 6:45 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, May 10, 2021 at 11:00:24AM +0800, Muchun Song wrote:
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1376,6 +1376,39 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
> >       h->nr_huge_pages_node[nid]--;
> >  }
> >
> > +static void add_hugetlb_page(struct hstate *h, struct page *page,
> > +                          bool adjust_surplus)
> > +{
> > +     int zeroed;
> > +     int nid = page_to_nid(page);
> > +
> > +     VM_BUG_ON_PAGE(!HPageVmemmapOptimized(page), page);
> > +
> > +     lockdep_assert_held(&hugetlb_lock);
> > +
> > +     INIT_LIST_HEAD(&page->lru);
> > +     h->nr_huge_pages++;
> > +     h->nr_huge_pages_node[nid]++;
> > +
> > +     if (adjust_surplus) {
> > +             h->surplus_huge_pages++;
> > +             h->surplus_huge_pages_node[nid]++;
> > +     }
> > +
> > +     set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> > +     set_page_private(page, 0);
>
> I think this has already been discused, so sorry about this.
>
> The only reason to need the set_page_private() is because of the dissolving
> function right? add_hugetlb_page() can only get reached via free_huge_page(),
> or dissolve_free_huge_page, and while the former clears the flags, the latter
> it does not.

Not exactly right. free_huge_page() does not clear HPageTemporary
if the page is temporarily allocated when freeing. You are right that
dissolve_free_huge_page() does not clear HPageFreed.

>
> I think this function would benefit from some renaming. add_hugetlb_page() gives
> me no hint of what is this about, although I can figure it out reading the code.

Because I think it is the reverse operation of remove_hugetlb_page,
I named it add_hugetlb_page. Do you have any suggestions for
renaming?

Thanks.

>
> With that: Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
>
>
>
> --
> Oscar Salvador
> SUSE L3
