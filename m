Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25062CE6A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 04:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgLDDky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 22:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLDDky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:40:54 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792B6C061A4F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 19:40:08 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id o9so2757305pfd.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kP0kqVxYlLhlxakYbEWvE8pzB4Mj7yplj9IQfIP/Nqo=;
        b=RXeno4fHs2hClfvDpmt84Kb0l0ffZ+tfCf4eGR4N2xKr5d+GEweCV3ikwwgvmK8Jz8
         7yRlfUm9ZgJHUw0G7xO4JpRTa6nHUnxHGOP3ecvxLWNCVn2qfP0+4sEXxg+TQ6dzvNdB
         8fFJclIAPEb3EGx/lzzZi/6MYFK1BUfwM3r0BthCHtK3IOfFmB7QRDuVsNQ+2GSAaMLj
         Fx7lToXjBVngkeA49IgqF5XW44cP2AB3Llrt2EDOfpZX1pB/6wcSb6Q/s5a06s8rxYkP
         f6HLsRbClLzTOVfJPPeTaEpznXSGk9wCHNM+A1LjcwaYFE4EheH05Ug+dHysIlihP4qm
         fqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kP0kqVxYlLhlxakYbEWvE8pzB4Mj7yplj9IQfIP/Nqo=;
        b=tSizZTGCZJ+c9fw3pgX2WlPE1em68lqg0nPiwCDrXoGd1XmdvWguTMWQw0nvWwERuq
         gUjpL4rc+wwbj/H0R0/bF3YGGRLhBWiI5soA0AmWPIOuQnDxe3HVcJg07KCpso870qXP
         QaLlnLA5fU1cIark9KxFQiTUM/DkGRvhiaebfzJyOJJnvu2DiM18yxXwlynGqhu2shLR
         ++fvdJeCLiMbm9MC6heuzaTI7woVZhEMvf92DtaQprHBAh5UzvOlSl6etx5PU6bYiIAq
         e717AExz7kZr2+IHJwYtvc4vi5c/f+y5ySfboEw+edoWqbvUUhpKGBh2tezWL3nvs546
         W2gw==
X-Gm-Message-State: AOAM532tMnlldWYa3VHw1i3uxK9LAyn6zQfKI5DghhEDVTbBwQAGMTMh
        CaAfex5WpRqug9o+O34Uae5abt9/TKGvvepaSL5lvQ==
X-Google-Smtp-Source: ABdhPJynCEO+aYzaCWwl98Gj7aTZquZAjP6gvBEF+xIuWOhnCtjsbj71ZJ7LyQ2PQpmasXLQiRg6kelKrNEq9MwhbLk=
X-Received: by 2002:a63:1203:: with SMTP id h3mr2402111pgl.273.1607053207913;
 Thu, 03 Dec 2020 19:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <CAMZfGtWvLEytN5gBN+OqntrNXNd3eNRWrfnkeCozvARmpTNAXw@mail.gmail.com> <600fd7e2-70b4-810f-8d12-62cba80af80d@oracle.com>
In-Reply-To: <600fd7e2-70b4-810f-8d12-62cba80af80d@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 4 Dec 2020 11:39:31 +0800
Message-ID: <CAMZfGtX2mu1tyE_898mQeEpmP4Pd+rEKOHpYF=KN=5v4WExpig@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 00/15] Free some vmemmap pages of
 hugetlb page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, bp@alien8.de, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, mchehab+huawei@kernel.org,
        paulmck@kernel.org, viro@zeniv.linux.org.uk,
        Peter Zijlstra <peterz@infradead.org>, luto@kernel.org,
        oneukum@suse.com, jroedel@suse.de,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        anshuman.khandual@arm.com, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 4, 2020 at 7:49 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/3/20 12:35 AM, Muchun Song wrote:
> > On Mon, Nov 30, 2020 at 11:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >>
> >> Hi all,
> >>
> >> This patch series will free some vmemmap pages(struct page structures)
> >> associated with each hugetlbpage when preallocated to save memory.
> >
> > Hi Mike,
> >
> > What's your opinion on this version?  Any comments or suggestions?
> > And hoping you or more people review the series. Thank you very
> > much.
>
> Sorry Muchun, I have been busy with other things and have not looked at
> this new version.  Should have some time soon.

Thanks very much.

>
> As previously mentioned, I feel qualified to review the hugetlb changes
> and some other closely related changes.  However, this patch set is
> touching quite a few areas and I do not feel qualified to make authoritative
> statements about them all.  I too hope others will take a look.

Agree. I also hope others can take a look at other modules(e.g.
sparse-vmemmap, memory-hotplug). Thanks for everyone's efforts
on this.

> --
> Mike Kravetz



-- 
Yours,
Muchun
