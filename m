Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894A530763F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 13:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhA1MjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 07:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhA1Mi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:38:59 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC7C0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 04:38:18 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id f63so3889313pfa.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 04:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WaOltVmRWY4A85dkkyKWm4CB5hPuoSl1c1lXUzFBBo=;
        b=CtMUy+LGS6RZ6wo05NIVWOeVZapiGPFCG7S6qJhU2IbnzcVusdLgW/ZbNsskfVWrUN
         MQywc7znYQ5UERN4AzrEKHe2ItHXgXNU5klDm31oxeP/khbY+vUSQryPVBBIAfEDw/Vv
         3gTs3OJ9VpgcBuGYgOcVbeDMqBlEe0o+q3OSkydmSSa0Tv4WpFi3eaD3wE5ZpbL0crjv
         gcdSagrLpFTsVhn1PVCAnGY9EaYJOiVYJDDn8QKGR432e9cmrI7pxQk3XQYVNmAj5Ajm
         CgzxOmE5U8+7o8LkzGpeB3UemRiwygv/eyF+McqBGgVLBIXVvJtsjPIFFsjT6R04v3tk
         hOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WaOltVmRWY4A85dkkyKWm4CB5hPuoSl1c1lXUzFBBo=;
        b=fCHjTviAoYONEwINtzDxCQGja85ljxvxcgsLHu3HYoAFJuU3RoCG8ESiiPV39Umgya
         8/GpgbRbBCk+8xvEP2lW0HtalpmdTDeYC47y85JboK5cCpCyB17E+3qcAri3RJzbt6nP
         xqkggB0RRwK33t9/nCu0FeEdxYVRLjyKek0yiQhC0dknzACHBr96EtZ1Ln7YVUAftaoB
         nJVTvJZ2vJq7AyI9WjZLTFh/pBVTB3EyNeggFkHLD6JcKEJqMD3S4m+qFi5QWZG+8PYW
         OQteCJinl5RKl47gMXMC3SiSWqhJOvkm0gS1EtxiI1PI1a2Ombp/gV95W64OuyDmFpjF
         Nmwg==
X-Gm-Message-State: AOAM530S5DxmnSCvnHM1aFlmVQmYa2Ez77pg04GLugxyEUIxeHcSA2oE
        X2uoP1TAeazMwduuOidKtyMNAXQZ5w55SyeHfi1w/Q==
X-Google-Smtp-Source: ABdhPJyw1u0Xr3B5Tu98ZrHbYMZERXsgmC0lR2sLTrtGK6j+NRKrFU5g/BHrH5XrtlG5N0b0Kqx1Q95yjO3O+N/Ejxk=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr16523781pgf.31.1611837498467;
 Thu, 28 Jan 2021 04:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com> <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com> <20210126145819.GB16870@linux>
 <259b9669-0515-01a2-d714-617011f87194@redhat.com> <20210126153448.GA17455@linux>
 <9475b139-1b33-76c7-ef5c-d43d2ea1dba5@redhat.com> <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
In-Reply-To: <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 28 Jan 2021 20:37:41 +0800
Message-ID: <CAMZfGtWCu95Qve8p9mH7C7rm=F+znsc8+VL_6Z-_k4e5hAHzhA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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

On Wed, Jan 27, 2021 at 6:36 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 26.01.21 16:56, David Hildenbrand wrote:
> > On 26.01.21 16:34, Oscar Salvador wrote:
> >> On Tue, Jan 26, 2021 at 04:10:53PM +0100, David Hildenbrand wrote:
> >>> The real issue seems to be discarding the vmemmap on any memory that has
> >>> movability constraints - CMA and ZONE_MOVABLE; otherwise, as discussed, we
> >>> can reuse parts of the thingy we're freeing for the vmemmap. Not that it
> >>> would be ideal: that once-a-huge-page thing will never ever be a huge page
> >>> again - but if it helps with OOM in corner cases, sure.
> >>
> >> Yes, that is one way, but I am not sure how hard would it be to implement.
> >> Plus the fact that as you pointed out, once that memory is used for vmemmap
> >> array, we cannot use it again.
> >> Actually, we would fragment the memory eventually?
> >>
> >>> Possible simplification: don't perform the optimization for now with free
> >>> huge pages residing on ZONE_MOVABLE or CMA. Certainly not perfect: what
> >>> happens when migrating a huge page from ZONE_NORMAL to (ZONE_MOVABLE|CMA)?
> >>
> >> But if we do not allow theose pages to be in ZONE_MOVABLE or CMA, there is no
> >> point in migrate them, right?
> >
> > Well, memory unplug "could" still work and migrate them and
> > alloc_contig_range() "could in the future" still want to migrate them
> > (virtio-mem, gigantic pages, powernv memtrace). Especially, the latter
> > two don't work with ZONE_MOVABLE/CMA. But, I mean, it would be fair
> > enough to say "there are no guarantees for
> > alloc_contig_range()/offline_pages() with ZONE_NORMAL, so we can break
> > these use cases when a magic switch is flipped and make these pages
> > non-migratable anymore".
> >
> > I assume compaction doesn't care about huge pages either way, not sure
> > about numa balancing etc.
> >
> >
> > However, note that there is a fundamental issue with any approach that
> > allocates a significant amount of unmovable memory for user-space
> > purposes (excluding CMA allocations for unmovable stuff, CMA is
> > special): pairing it with ZONE_MOVABLE becomes very tricky as your user
> > space might just end up eating all kernel memory, although the system
> > still looks like there is plenty of free memory residing in
> > ZONE_MOVABLE. I mentioned that in the context of secretmem in a reduced
> > form as well.
> >
> > We theoretically have that issue with dynamic allocation of gigantic
> > pages, but it's something a user explicitly/rarely triggers and it can
> > be documented to cause problems well enough. We'll have the same issue
> > with GUP+ZONE_MOVABLE that Pavel is fixing right now - but GUP is
> > already known to be broken in various ways and that it has to be treated
> > in a special way. I'd like to limit the nasty corner cases.
> >
> > Of course, we could have smart rules like "don't online memory to
> > ZONE_MOVABLE automatically when the magic switch is active". That's just
> > ugly, but could work.
> >
>
> Extending on that, I just discovered that only x86-64, ppc64, and arm64
> really support hugepage migration.
>
> Maybe one approach with the "magic switch" really would be to disable
> hugepage migration completely in hugepage_migration_supported(), and
> consequently making hugepage_movable_supported() always return false.
>
> Huge pages would never get placed onto ZONE_MOVABLE/CMA and cannot be
> migrated. The problem I describe would apply (careful with using
> ZONE_MOVABLE), but well, it can at least be documented.

Thanks for your explanation.

All thinking seems to be introduced by encountering OOM. :-(

In order to move forward and free the hugepage. We should add some
restrictions below.

1. Only free the hugepage which is allocated from the ZONE_NORMAL.
2. Disable hugepage migration when this feature is enabled.
3. Using GFP_ATOMIC to allocate vmemmap pages firstly (it can reduce
   memory fragmentation), if it fails, we use part of the hugepage to
   remap.

Hi Oscar, Mike and David H

What's your opinion about this? Should we take this approach?

Thanks.

>
> --
> Thanks,
>
> David / dhildenb
>
