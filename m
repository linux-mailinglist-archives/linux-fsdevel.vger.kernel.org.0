Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2812DFFE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 19:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgLUSf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 13:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgLUSf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:35:59 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E12C061282
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 10:35:19 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id 75so9715252ilv.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 10:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YliUtlY76/UIPuQ5v8deFXxZeb8eSvRLcMxme2JxEEk=;
        b=HDksKqgKauZN6tvbdPBgggj8IeeTS2c7JRuSWMI+pRG1FwKAhMCJxMCv7JOIqk50wv
         3X1HRLkpEKIsTmGLQK6vIyf/RMl8sqUJoc0+IVGVdkvPNiQkOjCyDbUhahzYluorDnrk
         1PDsuxVXgwT/JnDR/e8fyiqWr/gjcp4gXGi2ngqD9bS5/EBS76qfZPKMvDBaRcXFxHGt
         YOSyX7QbQ/Koym0Jms6BgoWpgnw/5heVHu2j7+FeQsRTUWVZEWILea7Byq/nnV5Cq6bO
         YDDYicvRlZMY5s2D5oa9p6I/4Nwjhwv9qDpErWN/14vrvlkMgsgZNqe/YH2kcc3Fnt+d
         1eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YliUtlY76/UIPuQ5v8deFXxZeb8eSvRLcMxme2JxEEk=;
        b=TvZpAje5HGbVJLznW3sA/nWNZFJJvBEjRjmV3cFs/kqdGwPuH1UW8ppsQE4wiLlKga
         ZifD4ii298eq406vfZU7XkuGDdQJ7a7YpVOOXR37UBwy4IPz9F4m1HComDb2xLo5V94R
         TZRgPdDQfrUgaXP4bdk5fLgmvu6zghNXqW0eG2ZjKxMc+7Uw+mknyyD/HreirsbaQbkU
         CiiajQzeKELRDlyNuy3/dM+/xbHOl6bNYCz2UPhgPWPr+JPiO/okC501/AosV7ZNo+1T
         Myn9aA9jdAg3AfQ3NOdlZ9Z6/RUtiyZDSEDqcTsfpm3Hl10Nqp9833uP3DGAqLDoJ6PY
         mFCg==
X-Gm-Message-State: AOAM530fShi9NHZNzovy9WvjTPMMUckSVkRmUZHqh4q6d3VKXLriRM5s
        hnw1RrlhwAeJ8d7X73cgXFeahFE+HtI3nF6RQELENvFQHOBdK9Td
X-Google-Smtp-Source: ABdhPJxKT6tC6/ndV2N5i1FwKZxN3yOMknKcMYRbpSq6pVUOWTKpPSP2SnmFD7tg+Np8Z6fWmUqBTLjQBM+VPNs1bYw=
X-Received: by 2002:a63:480f:: with SMTP id v15mr2249541pga.341.1608565986866;
 Mon, 21 Dec 2020 07:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-4-songmuchun@bytedance.com> <20201221091123.GB14343@linux>
 <CAMZfGtVnS=_m4fpGBfDpOpdgzP02QCteUQn-gGiLADWfGiVJ=A@mail.gmail.com> <20201221134345.GA19324@linux>
In-Reply-To: <20201221134345.GA19324@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 21 Dec 2020 23:52:30 +0800
Message-ID: <CAMZfGtVTqYXOvTHSay-6WS+gtDSCtcN5ksnkj8hJgrUs_XWoWQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v10 03/11] mm/hugetlb: Free the vmemmap
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

On Mon, Dec 21, 2020 at 9:44 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Dec 21, 2020 at 07:25:15PM +0800, Muchun Song wrote:
>
> > Should we add a BUG_ON in vmemmap_remap_free() for now?
> >
> >         BUG_ON(reuse != start + PAGE_SIZE);
>
> I do not think we have to, plus we would be BUG_ing for some specific use
> case in "generic" function.

The vmemmap_remap_range() walks page table range [start, end),
if reuse is equal to (start + PAGE_SIZE), the range can adjust to
[start - PAGE_SIZE, end). But if not, we need some work to
implement the "generic" function.

  - adjust range to [min(start, reuse), end) and call
    vmemmap_remap_rangeand which skip the hole
    which is [reuse + PAGE_SIZE, start) or [end, reuse).
  - call vmemmap_remap_range(reuse, reuse + PAGE_SIZE)
    to get the reuse page.Then, call vmemmap_remap_range(start, end)
    again to remap.

Which one do you prefer?

> Maybe others think different though.
>
> --
> Oscar Salvador
> SUSE L3



--
Yours,
Muchun
