Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DFA2E157F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 03:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgLWCtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 21:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbgLWCtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 21:49:17 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDC9C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 18:48:37 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w5so9692810pgj.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 18:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wP7Uq2lowyz2FH8P5+5koRz57WTCSgXorU4PTle7rdo=;
        b=bI+yNYRnrvlvKm0GFWJ0h8Zo4CX+ntNyT8egYkggS18UBmlB5Ej5FmqGO/cmC3a6io
         rjiGb4MIW9QvltzrZxdJDzjP+HmGGr5CTERjUc21VMF44i38G1LMaWQLTgrM96CfxFn7
         OHEBz4+sDNwo1WVSAhW+l3nQjVStyrz8JeZdfW5gSfDdodXi7/SWiyuWPdb+Y4OdrSY0
         qrE5QZFwaicGQDZ3c3tyX5pIzN+bjhBHG7uGbox0Hr6tS7uoZZsNklQGcEz9jqgvjR9z
         5dkVJSklQB4IqZEVi5p0kBVeJaOfBJh5fgfsaUpmA25RoNGn4WfFbNliDSRu8yCgpVOt
         hNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wP7Uq2lowyz2FH8P5+5koRz57WTCSgXorU4PTle7rdo=;
        b=G8rqhBUl5iRWg9DBc63Qt/mQaXFtBU+XTXs/39ntI9GhopuwfZnsBb+yfJ4dC4cpOe
         lIrDV7UYLOWpiQqXjRsZ3B/j79eRYkfJvcL2UHFrnpMiySV6aCyl+gDiVKtYu+jZga5q
         tMbpVsxTGwa48bwBHhooRAVWZpv9ygJmskU209RmEiUpklur1KJzsmNYcQ6r8bZvZlGw
         edH+4bg3+4EX/XELYCZ65F3nggr7ZQsIM3391uh4/bgYZETnWxlcsY/cRYuyjAYKVcdH
         pV3o0Pko7NsoQSZaw4XgZDRj0+I9VBw5+sMro3TajGqQKIr4oGDpzwWjH68YDOHEtogQ
         IGAg==
X-Gm-Message-State: AOAM532OGT+Q1+2G9vcc8H0NNUR6+/raPSeL5F+45f14jKo3iILrDjEV
        G7Mru5siKtnazFmZZ9lBvQQHw97VWkxlzlNHQShkHA==
X-Google-Smtp-Source: ABdhPJyZhq4UXodKoW1yonKLx7SJbDUeopHTSj9WphsfAsFA9xHEfINldXo3tXZS2SFAgF7o8OQRmc7gOerPeZ7KwJo=
X-Received: by 2002:a63:480f:: with SMTP id v15mr9021169pga.341.1608691717231;
 Tue, 22 Dec 2020 18:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20201222142440.28930-1-songmuchun@bytedance.com>
 <20201222142440.28930-4-songmuchun@bytedance.com> <20201222163248.GB31385@linux>
In-Reply-To: <20201222163248.GB31385@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 23 Dec 2020 10:47:59 +0800
Message-ID: <CAMZfGtU5x6kcdL32zL8Mz6DBp3pEQ+kMC5=yOda9arUm5p0=Xg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 03/11] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
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

On Wed, Dec 23, 2020 at 12:32 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Dec 22, 2020 at 10:24:32PM +0800, Muchun Song wrote:
> > diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> > index 5d0767cb424a..eff5b13a6945 100644
> > --- a/include/linux/mmdebug.h
> > +++ b/include/linux/mmdebug.h
> > @@ -37,6 +37,13 @@ void dump_mm(const struct mm_struct *mm);
> >                       BUG();                                          \
> >               }                                                       \
> >       } while (0)
> > +#define VM_WARN_ON_PAGE(cond, page)                                  \
> > +     do {                                                            \
> > +             if (unlikely(cond)) {                                   \
> > +                     dump_page(page, "VM_WARN_ON_PAGE(" __stringify(cond)")");\
> > +                     WARN_ON(1);                                     \
> > +             }                                                       \
> > +     } while (0)
> >  #define VM_WARN_ON_ONCE_PAGE(cond, page)     ({                      \
> >       static bool __section(".data.once") __warned;                   \
> >       int __ret_warn_once = !!(cond);                                 \
> > @@ -60,6 +67,7 @@ void dump_mm(const struct mm_struct *mm);
> >  #define VM_BUG_ON_MM(cond, mm) VM_BUG_ON(cond)
> >  #define VM_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)
> >  #define VM_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
> > +#define VM_WARN_ON_PAGE(cond, page) BUILD_BUG_ON_INVALID(cond)
> >  #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
> >  #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
> >  #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
>
> Take this off this patch and make it a preparation patch prior to this one.
> A new VM_WARN_ON_ macro does not make much sense in this patch as it is
> not related.

OK. Will do in the next version. Thanks.

>
> I will have a look later today at the other changes, but so far looks good.
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
