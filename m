Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A649D2BFE8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 04:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgKWDPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 22:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgKWDPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:15:37 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F2C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2020 19:15:36 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id v21so12957485pgi.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2020 19:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PkJLLTHTHGvD+6CtGT0JeNBynTOmH00lzXh1tBHgdk=;
        b=AXE3qcuKn7MS7+bY1HUIYsfwTG1XJGA7xLViJTzXwgBVDETzOpmegz5ECIjDn2PI6h
         zrcfQeSm3Vptg3QLVl59UvnleVo11+Y/AKzjtWAFtcwkXUVGQfDwiF7QYd4CD4cGmN4w
         xioSYxW5L0BNvgRH3OJCAGFpx9iArOMLbfFhG0D78VIA8qMjQaKbSGu8OrRIJWaTFGzR
         wxtcXQR5QVGAablFJ6/mYQWeToPYeHaoIkBTLfHglYGcZvgIorxjZUYtuAMzI/o7lyF6
         0olX85dcFaO+Bt/dg9cNtpdq9kfu2AUcn0374Vr8dOaSvp90AbUGXjb3wimXzUg1dxyy
         N/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PkJLLTHTHGvD+6CtGT0JeNBynTOmH00lzXh1tBHgdk=;
        b=f4/rj6dxF41eYMEM61W8bNLXGPE2T8dfeGVlYBX3zNbTfXaR8E2X0icnYSzUhmXx4+
         PlNqW8ss8PcwvSM+3T6b7gHe7w54UKhWRI0wmUUjYIjYWGqLK8SiYg8QgYa2GN2bg6iJ
         87Hjte778Ib1lkXAg+h6ZWwa2Iac2ahtXi5EPjcEhvGPHZx8RpRUPDwdeE2etNBhDOCR
         EsL+/Mg6KTQi0MsCqW9VlLqJGIIfl/KnigjqsZb8ZDDn2qh/Oi7Rc2wGb8bdk/8kyP+v
         UPkA4hh1ZF5MWtHSFuoixu92aZLE+7IpkqQiiyZQt6+eAG9D3ysMEDgW+TsRKy9fRx+w
         GoXg==
X-Gm-Message-State: AOAM532Bo+hIR5mVF9GxSgSEQ2L5wWKwBnn4ZWqOGVshCuZVnbjHoGww
        6hBgy2SQnpMzgFin9CuMMJHQzYVHsHl9mmeIvOmstw==
X-Google-Smtp-Source: ABdhPJxKovdhcbkAgrBDEdjMU7ZJHmMEXN8Mq3F1RYkM6JeOu075ftsAAt6nPr79OpJpAUY1RCGxxxOksG4bUMsVeKQ=
X-Received: by 2002:a63:594a:: with SMTP id j10mr25427312pgm.341.1606101336098;
 Sun, 22 Nov 2020 19:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-22-songmuchun@bytedance.com> <20201120082552.GI3200@dhcp22.suse.cz>
 <20201122190002.GH4327@casper.infradead.org>
In-Reply-To: <20201122190002.GH4327@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 23 Nov 2020 11:14:59 +0800
Message-ID: <CAMZfGtW9drQ7OBhf0wMG4joVz=5UAN1d8P=GQxs2M4MjKoBwxw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 21/21] mm/hugetlb: Disable freeing
 vmemmap if struct page size is not power of two
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
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
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 3:00 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Nov 20, 2020 at 09:25:52AM +0100, Michal Hocko wrote:
> > On Fri 20-11-20 14:43:25, Muchun Song wrote:
> > > We only can free the unused vmemmap to the buddy system when the
> > > size of struct page is a power of two.
> >
> > Can we actually have !power_of_2 struct pages?
>
> Yes.  On x86-64, if you don't enable MEMCG, it's 56 bytes.  On SPARC64,
> if you do enable MEMCG, it's 72 bytes.  On 32-bit systems, it's
> anything from 32-44 bytes, depending on MEMCG, WANT_PAGE_VIRTUAL and
> LAST_CPUPID_NOT_IN_PAGE_FLAGS.
>

On x86-64, even if you do not enable MEMCG, it's also 64 bytes. Because
CONFIG_HAVE_ALIGNED_STRUCT_PAGE is defined if we use SLUB.



-- 
Yours,
Muchun
