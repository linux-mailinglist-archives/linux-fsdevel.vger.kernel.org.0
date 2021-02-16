Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED21A31C609
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 05:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBPEgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 23:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhBPEgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 23:36:05 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1EFC061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 20:35:18 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x136so5418040pfc.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 20:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g7qpTlou0UffAXpPfgR9N8/GL392LZ2opI0sf/G4JIg=;
        b=m8rbbnrYMey0qJejmsTRkf4tpyM6s4gLo10+3401Taw8ixlTuFm9wGsQuodGaPIkhI
         2it0YGED3YR1mtZ7+jemAxpGgCkS5g2r8cbJ/Yxcv5r6sk+n7RcLZ+QpwT217So12cg4
         Vhd0WrY2xJiIkJHhcKMkVIIIbke+iRZ16ScH1foXA9t42pWF4xEs5AyGPK+bV4HGJPBT
         2im+gXmV5iurHyTWev/JsRw3MgYIcsthrLT9IE3G/Hrs9qa3jNwz9So7i3rmuYlpl0+8
         UoMjbLWQ6EA9GCADl/4iWcbrHnPkggOITGn8DxWjKlJpC3+K8Xb86KhkALjP4WqIwRAe
         PkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g7qpTlou0UffAXpPfgR9N8/GL392LZ2opI0sf/G4JIg=;
        b=nWrs2cNvueuoCMHgX9wLZ/lpe8WyuBCI73CgbKl01fNj/aegbVNjYT8pa0Hf6f3Hlc
         RtgUxcpN+zWKhRPj9sHRpQrwKd72G3npIn3kQO3vN4SZs5YfdIgeWGqXABjXDoFTERCJ
         he+S3honzkTcu02bMOsKTdazY+Jx+kitJhxWaP8grNVgBKW/j8QBuBamdpCaoN4W2qLd
         FtR+10ji4IhQ9LvzoDT2PjsTFlJVVGvy9qtgvQarGmEuyCqK0XnEhPsvUTtYDNyzcOTs
         zQstvWsm30cwOe9PoYw2P2OlDgqtHmb69UBIu3xn24iSlSa1x+nBFK2tEPlYz7LwVr/g
         pwFg==
X-Gm-Message-State: AOAM532i2YV5b7MmoFw5cNebhKTNpykGcGzUKhy9IXspOhVO+QdUfWnY
        YMZ3zsgrRd8ChFDzMugrKT0anhP6HQ3u2rQdKpc+Fg==
X-Google-Smtp-Source: ABdhPJyB3UwBSZXHSGLaF+VNg2XoceXdDzYRGQ0L/sN5CBcGW7SIylXtDTVsVAw7KDXOkN4b5CRNgsDavYCnxsTAZ18=
X-Received: by 2002:aa7:9790:0:b029:1d8:263e:cc9b with SMTP id
 o16-20020aa797900000b02901d8263ecc9bmr18547269pfp.2.1613450118006; Mon, 15
 Feb 2021 20:35:18 -0800 (PST)
MIME-Version: 1.0
References: <YCpN38i75olgispI@dhcp22.suse.cz> <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz> <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz> <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz> <CAMZfGtW6n_YUbZOPFbivzn-HP4Q2yi0DrUoQ3JAjSYy5m17VWw@mail.gmail.com>
 <CAMZfGtWVwEdBfiof3=wW2-FUN4PU-N5J=HfiAETVbwbEzdvAGQ@mail.gmail.com> <YCrN4/EWRTOwNw72@dhcp22.suse.cz>
In-Reply-To: <YCrN4/EWRTOwNw72@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 16 Feb 2021 12:34:41 +0800
Message-ID: <CAMZfGtX8xizYQxwB_Ffe6VcesaftkzGPDr=BP=6va_=aR3HikQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>
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
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 3:39 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 16-02-21 02:19:20, Muchun Song wrote:
> > On Tue, Feb 16, 2021 at 1:48 AM Muchun Song <songmuchun@bytedance.com> =
wrote:
> > >
> > > On Tue, Feb 16, 2021 at 12:28 AM Michal Hocko <mhocko@suse.com> wrote=
:
> > > >
> > > > On Mon 15-02-21 23:36:49, Muchun Song wrote:
> > > > [...]
> > > > > > There shouldn't be any real reason why the memory allocation fo=
r
> > > > > > vmemmaps, or handling vmemmap in general, has to be done from w=
ithin the
> > > > > > hugetlb lock and therefore requiring a non-sleeping semantic. A=
ll that
> > > > > > can be deferred to a more relaxed context. If you want to make =
a
> > > > >
> > > > > Yeah, you are right. We can put the freeing hugetlb routine to a
> > > > > workqueue. Just like I do in the previous version (before v13) pa=
tch.
> > > > > I will pick up these patches.
> > > >
> > > > I haven't seen your v13 and I will unlikely have time to revisit th=
at
> > > > version. I just wanted to point out that the actual allocation does=
n't
> > > > have to happen from under the spinlock. There are multiple ways to =
go
> > > > around that. Dropping the lock would be one of them. Preallocation
> > > > before the spin lock is taken is another. WQ is certainly an option=
 but
> > > > I would take it as the last resort when other paths are not feasibl=
e.
> > > >
> > >
> > > "Dropping the lock" and "Preallocation before the spin lock" can limi=
t
> > > the context of put_page to non-atomic context. I am not sure if there
> > > is a page puted somewhere under an atomic context. e.g. compaction.
> > > I am not an expert on this.
> >
> > Using GFP_KERNEL will also use the current task cpuset to allocate
> > memory. Do we have an interface to ignore current task cpuset=EF=BC=9FI=
f not,
> > WQ may be the only option and it also will not limit the context of
> > put_page. Right?
>
> Well, GFP_KERNEL is constrained to the task cpuset only if the said
> cpuset is hardwalled IIRC. But I do not see why this is a problem.

I mean that if there are more than one node in the system,
but the current task cpuset only allows one node. If current
node has no memory and other nodes have enough memory.
We can fail to allocate vmemmap pages. But actually it is
suitable to allocate vmemmap pages from other nodes.
Right?

Thanks.

> --
> Michal Hocko
> SUSE Labs
