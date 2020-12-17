Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D108F2DCFA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 11:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgLQKn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 05:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLQKnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:43:25 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3124C0617B0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 02:42:39 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q22so18757617pfk.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 02:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ISaOxv2M3y6rzTF7V0ZUu/XvyKLY1Lh8tc0RjKV/bE=;
        b=JdIliH6SeXTydvTW28vuoACmBG9WQrqrb7eKRimd1Cl9Rh8HMO0wnx7XJRZaA7s0sN
         dgXttyNW31CGIl4D9+NBOs8ygxpG55qZVW0OepUVtuNnw3MCLFVAP8MXJfyAaEmEMArH
         ud1l8hYWYRDL5TTsIuEMt8tTHpvlXlQG80iRvj6OkWGBKjMjpHnHEcRqFIr6t4P4hGRg
         92iWo0ce2iAyOZv/ULkYH33m4ThMTdyKMzWezF9P85dqlZkW/btdOv1Jfr18pK85a3JX
         DuIGt2ihK02S2meZ+b1yNUwpJafxowwwPbj1PT3Hc/3fWv9yv5zlIYE8AG2IVjjmPq/N
         XxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ISaOxv2M3y6rzTF7V0ZUu/XvyKLY1Lh8tc0RjKV/bE=;
        b=HmKCj88KuwzI5dpEUEPeGkb+927hy3DkhfSgh7iZOwXT2wR5h2QMET4MF8Jk9Ds5+P
         VGKBE5LtHNlELfSyVuAOy+tz7eFz7TLBXy1BtiTGcB4QB9uQdOpdtGXrsqmrJAldjIJr
         ZqdhMzrMpbJ6baCt11wlNpGvt7PM2ugzXpN/Mc/s6i9utQgBG6odq2mOHjmnsJKiEuIB
         wzm+0e1zfQ0gmg88LC/OeLH1qjw6DMkQEnckpMOVRw+ieJM1zRvyonWyRwapFuZ9CYQi
         H9T7OCgP6NsrAAE+JRdMYvrYz38MvY4lu9em0ddOYAhmbiwNGR8tEGk1dIk1+C7+PqU+
         6VCQ==
X-Gm-Message-State: AOAM5328tkIEWud7vXS7qD88bBbVrc6cq5hlxG6y0YANFZPljelBW0C6
        wgV+olqTTdoOggcD3948p4d8QVwkQmyS0HiyBCabPA==
X-Google-Smtp-Source: ABdhPJyQqONmSuuKMNSnMEKXcxXk9UVbNjaPbYGZ8ABrFQ0kIzVpoir8YmisZWEI9RBFKOOPGshygmfRmOp3NTZUEXA=
X-Received: by 2002:a63:50a:: with SMTP id 10mr9159315pgf.273.1608201758996;
 Thu, 17 Dec 2020 02:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-12-songmuchun@bytedance.com> <20201217103154.GA8481@linux>
In-Reply-To: <20201217103154.GA8481@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 17 Dec 2020 18:42:02 +0800
Message-ID: <CAMZfGtUesG88wnwN6XEXWSyDFgWFGqNS153sUkXqxZu-U0h9DA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 11/11] mm/hugetlb: Optimize the code
 with the help of the compiler
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
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 6:32 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Dec 13, 2020 at 11:45:34PM +0800, Muchun Song wrote:
> >  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> >  {
> > -     return h->nr_free_vmemmap_pages;
> > +     return h->nr_free_vmemmap_pages && is_power_of_2(sizeof(struct page));
>
> This is wrong as it will return either true or false, but not what we want:

Yeah, very thanks for pointing that out.

>
>         static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
>         {
>                 return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
>         }
>
> the above will compute to 4096, which is wrong for obvious reasons.

You are right. It is my mistake. Thanks Oscar.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
