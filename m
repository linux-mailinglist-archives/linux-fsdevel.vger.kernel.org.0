Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB92DC1A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 14:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgLPNxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 08:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgLPNxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:53:00 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EFEC06179C
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 05:52:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y8so12959571plp.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 05:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MByjt13D8dTyrL9LXVO8Wl4qrEzL2nVUzZj2LIZjinw=;
        b=xEkeeDNDwEctBCEW9+sGNx6t6X+u7em43nG+lu0z1gifW1MLYSuSRYohoEK1GimBgo
         5ysElzKFdJdmrlfMoN8ewUO4Mbc2vtErLMpfDT2aRJ5HH4ehchKTb570hxvzmaG2tFbB
         DywlXF+1AZePbf8VAlGJzwcs8HhJoSiXSJQEbUnZlKp23eQqeDeujY3ojoCn0ybg7s9W
         fzzYP908pt2emtJw6hmoNyAI6I5AAWl8zqcAXweTum3yZgh5QXY51iqO+k8NTADI2Hc5
         dJNmh3EeznSKLV1uleZNGocmGHCFSDOofG/skh/EHGrVyRmuqGtje5nrrcR/sZu+CDEl
         Yj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MByjt13D8dTyrL9LXVO8Wl4qrEzL2nVUzZj2LIZjinw=;
        b=cBCyosQTd2KmZ4xfcVFGlPP3WNMa435qkcbHNL7afsung1i8ynRaXetPeP4G61xawO
         UCySVc7zSv4gsK8fUU3GOfAvGkQS3S3OqU+KbSyouF5jEZT18S385nNU9PD6DyF2moHv
         hhH+FxR4eJMC4vI7x+MNTMYyO+2e9bnGeFCYTqAmPbVWokMoS3pVuyTM845XtJfBf7i1
         04NgNlyO3pl3SwWQvo3n/FHbhXAIEKsgrgnFnP3U2E7DP4wcGoe9X5emIJoIyNlR6NWD
         l2cbmg9lUdXjwBmUJLOotPSYPKQ79Cvul0uxNt2UktRwwesZxqsIZbsZZPri7PCGIoJa
         LOog==
X-Gm-Message-State: AOAM532YNxuSb6qaeM10GMrGv4TrmQM1l46SCkkPokjTu5twoAobmJpK
        VojN2jOVasAhXVlArZOP1pmBWGwp7wJvuLPHK+37xw==
X-Google-Smtp-Source: ABdhPJxx5e3AsxCiCIXYZp2OHM5MtCHWVOP/WNUpVGJcXgHZNqGgFqJxEOwTYxQekrQT8Wj7ZuvNdf7qNno8pHo21lo=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr3286702pjh.13.1608126739730;
 Wed, 16 Dec 2020 05:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-7-songmuchun@bytedance.com> <20201216132847.GB29394@linux>
In-Reply-To: <20201216132847.GB29394@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Dec 2020 21:51:43 +0800
Message-ID: <CAMZfGtWfXYn5Na=qQJHEZJO3wTOrf1m=-xarxTLp_pYpZoqjWw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 06/11] mm/hugetlb: Set the PageHWPoison
 to the raw error page
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

On Wed, Dec 16, 2020 at 9:28 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Dec 13, 2020 at 11:45:29PM +0800, Muchun Song wrote:
> > Because we reuse the first tail vmemmap page frame and remap it
> > with read-only, we cannot set the PageHWPosion on a tail page.
> > So we can use the head[4].private to record the real error page
> > index and set the raw error page PageHWPoison later.
>
> Maybe the following is better?
>
> "Since the first page of tail page structs is remapped read-only,
>  we cannot modify any tail struct page, and so we cannot set
>  the HWPoison flag on a tail page.
>  We can make use of head[4].private to record the real hwpoisoned
>  page index.
>  Right before freeing the page the real raw page will be retrieved
>  and marked as HWPoison.
> "
>
> I think it is slighly clearer, but whatever.

Thank you.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> I do not quite like the name hwpoison_subpage_deliver, but I cannot
> come up with a better one myself, so:
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks for your review.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
