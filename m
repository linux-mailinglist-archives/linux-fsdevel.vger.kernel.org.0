Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC231302197
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 06:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbhAYFIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 00:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbhAYFIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 00:08:00 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38696C061573
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 21:07:20 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 11so7733177pfu.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 21:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOUhfnWWdDSn5rx6Y3alCW/0otHcbj316dnvYqN7gu4=;
        b=tsUFnxshHE+L1KHEKNbr7GW5VWbpojZwNMWTulN94mLxAv5nmHR7FU5jkiJkbLDiE5
         V2ApnArVL/VkkZmSeKVcldSXit/+C4iDHMVeKZHLwgfxAeD47Z84LDZQbeiT+HHmZYPg
         vhR2WbNrS3ybuGoEaHuW03cfqBHkGveM7jl9/RmRpGuE+kaGS59pDNCGnh3xcxougmPa
         p5iwfNjdh3OX84dG6S1nsOx92g93IwETYXENEkA23sHcgYRNnGYk0XN0GuINmTB5VT0N
         5L72Gi8F+chKV5JbtZpv9Y3Np+0lxsXH9bDLf1Y/OnavILi1C9rC3WvB65TvMTatvJYY
         riEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOUhfnWWdDSn5rx6Y3alCW/0otHcbj316dnvYqN7gu4=;
        b=ECoZGkdgDK91Fg/5TCxOrLIlLdVgK2BELYcl9Xjg6/z8phbVdkM36dvI+QcbgcZUNv
         Ff9tKpsqwuWB7byucwKeDrg+Qh07ugONpbQrKLDRkod1hTw41Kj8DGoYpI3/lcqxKkWw
         8OCV7H18l5zAJk8HvYILqJLx8jFCL++7Hr8etWu3OYSDqJCeHOCNJQIVqZCf9rV4dHH3
         Fz1ImXVl5wdaKoxzdOf7xCpiDehzjKeMvGtjqCtbuNDRqFVe2oIWw6gC2W3tCscC+eVX
         MGQKYtu5ebUdzf2hmq3pSk1NfKijn5o64MfZsvLM0Azr3RyvskYLCM8BHtsXYP37H8ku
         o6Mw==
X-Gm-Message-State: AOAM530KdXxtk9M0jT2XWhUykmp7mjzIiNIh/DVkpR0/puonr15wghaf
        n01p4AD7KpbZDzawNMhLfNmEU4afBnaLEVnzFGIZng==
X-Google-Smtp-Source: ABdhPJyeBE3eTqrFGflPEz5F2VO+wo1F0NwBGgPBQd4npB+pBnnp/e4ggx1odd0vcPNrzmFXdQJHbZsp2DakZO11Wz8=
X-Received: by 2002:a63:50a:: with SMTP id 10mr327154pgf.273.1611551239885;
 Sun, 24 Jan 2021 21:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-7-songmuchun@bytedance.com> <88a384ba-8487-c66b-e7b-eb6055e3775@google.com>
In-Reply-To: <88a384ba-8487-c66b-e7b-eb6055e3775@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 25 Jan 2021 13:06:44 +0800
Message-ID: <CAMZfGtW5S42rPtOJexNv+Zf2S-J0kG8T1KpWS_ozQb2eG-YH0A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 06/12] mm: hugetlb: set the
 PageHWPoison to the raw error page
To:     David Rientjes <rientjes@google.com>
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
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 8:06 AM David Rientjes <rientjes@google.com> wrote:
>
>
> On Sun, 17 Jan 2021, Muchun Song wrote:
>
> > Because we reuse the first tail vmemmap page frame and remap it
> > with read-only, we cannot set the PageHWPosion on a tail page.
> > So we can use the head[4].private to record the real error page
> > index and set the raw error page PageHWPoison later.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
> Acked-by: David Rientjes <rientjes@google.com>

Thanks.
