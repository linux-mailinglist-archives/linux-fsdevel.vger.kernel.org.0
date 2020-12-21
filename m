Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799E32DFADE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 11:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgLUKLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 05:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgLUKLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:11:07 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE23C061257
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 02:10:22 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id x1so485490pgh.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 02:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9oI6PpbsNinrAY/UY/16dtjoAnO4VqhB1tmPSdI/mzw=;
        b=rhSiOJwy3U4u0Kw1EqHDbBvUoYsSF7bEya7dN9TqYVff8KYrfn4UChVh7IQq/1A9Hl
         dAjMNaS84HENeb8/nKBjvZN7gmKZ5lgqJI4lpX58TXd2r4oCuqj4CB7BHPmKKSaLaHoc
         lHMzUSmt9hw8K+yONpy8aFqQ/L4Do1Cwy4ZZR3ZFOnacCdVA1DOo5MzeguNrLwsgsRHo
         gHIvGZr71szBt0uZE3efY7l8C2RF2iWCb351IPFzUuia9o9b5npWOw8JAXptrZz+dY+h
         eHA8JHujNp0vf2XAROIjtg0hYg6zm6xieVMPX69Oh7q1hOHDsB+1qvQt/w4VACFcfLJg
         SL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9oI6PpbsNinrAY/UY/16dtjoAnO4VqhB1tmPSdI/mzw=;
        b=XSjP7RNNtgE72sT3lOc6MbjwOAzwmjbReoXblYS/nWYHjT2Jb+OFwqd4XRmzra0/FG
         U/4pJVsFeHpwkArtkqlRN/goVcXAVaAXoxwIv8LV2SVCMNBEUvGUNFJMsX0OgFw5w8bl
         J8lVvDD6A7+thzK338cWbrdb4w7t9HEBTUfzkVsRGuK8I5ooFlXWQZk32ae8+SY/KNcq
         N5OPSPpQ8dCPSn+6xtHDmXBOdrauSp2LjWLZWvIUgzWA5YiiXZxsFi2bgOIwZuY6osFW
         siJ0QZK97YFIQ2HbNVCvkJw1Tcn5qmq1+aB78bXc3+BR6vxBpkzFu/XiM312PrXOdZyi
         auaA==
X-Gm-Message-State: AOAM530rIemdFrNCtaxhbzAoweB60NZoy1Pc3jcqR5MTjisg38MnzzS5
        PfERysQqNUUHwpgf9JVM/2V9R+umsaNfIkDXKmmcOtrVcQtDuw==
X-Google-Smtp-Source: ABdhPJy5FiyRxWb1/yg6+OenrVe7Jltn8hbV9VjG+MoGHrsui5ke3eBLjJR+w4cjHgORyzwDp0wmtCT4SrAgqQp2DHs=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr14505632pgf.31.1608543266172;
 Mon, 21 Dec 2020 01:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-10-songmuchun@bytedance.com> <20201221080414.GA14343@linux>
In-Reply-To: <20201221080414.GA14343@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 21 Dec 2020 17:33:47 +0800
Message-ID: <CAMZfGtUr5NhScQDVF+DzsUHxYVD6vEs+2wEz6SOi-Y84+PXK2A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v10 09/11] mm/hugetlb: Introduce
 nr_free_vmemmap_pages in the struct hstate
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>, naoya.horiguchi@nec.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 21, 2020 at 4:17 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 17, 2020 at 08:13:01PM +0800, Muchun Song wrote:
> > @@ -182,6 +184,12 @@ bool hugetlb_free_vmemmap_enabled;
> >
> >  static int __init early_hugetlb_free_vmemmap_param(char *buf)
> >  {
> > +     /* We cannot optimize if a "struct page" crosses page boundaries. */
> > +     if ((!is_power_of_2(sizeof(struct page)))) {
> > +             pr_warn("cannot free vmemmap pages because \"struct page\" crosses page boundaries\n");
> > +             return 0;
> > +     }
>
> Unless there is a strong reason behind, I would move this to the previous patch,
> where early_hugetlb_free_vmemmap_param is introduced.

OK. Will do. Thanks.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
