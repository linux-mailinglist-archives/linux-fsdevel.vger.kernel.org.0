Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8602BAA56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 13:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgKTMla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 07:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKTMla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:41:30 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABA2C061A04
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 04:41:30 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r18so7190635pgu.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 04:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xmKB7TKmyuJqAeHaXMBy48tPAGfs/Dc4x/Ex91iYPg=;
        b=QtGGwEfCUUfQtF6A4LP4HRak+3zHqLMer9XuFEfRr7YiX37HK0ez2RQIKrjEKckYk0
         LlQ5hEPW49q3qOwBrRHEE9T6kimslhXPXCIt8+xP6cguuYLGRbjwn/oquxWnwlwi3+6D
         cHPYyX6fg6/P5NVhLIjQ0409FlWkJ1a1MqS7P3vsxtyLDLnQo/wmrut9s9wyXCd1naMo
         BOdclSR5a3Gev9lqt3duFEdBgSFQA0vIBxgTRHEq36RKzQicNOdOpBpn/aqvTBIxYAnS
         gwRz5YivYvPPMiw6p16AwteVC8H1QpCWuQhLCXAmRFAgv8ybc/1uURlnaafFFttStnga
         cXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xmKB7TKmyuJqAeHaXMBy48tPAGfs/Dc4x/Ex91iYPg=;
        b=G5g0ZK10TPew03efl5FauvdfVMRSC+L0450gJlpYOtU0Eqzx0HhUgCQumHUH7dJbeU
         mbddkknSai74o4a60IeAJCe2ImOfxoVZrefCJ4tvPKQJ7rS6BTCudXxr2lCiXYCFwEVH
         smbG0wiXXSz7qvrj4iflHc/TNJfGEU8/GXcW5lEl/ICFeNIOZFYQ+p+lX7g/rbuWvJMb
         LGwXBT0ggC3pSVB2WmU5h7nmZUwxPJg0vk6XBvSur7m238zO155kdtzm0itMtIJiRTIu
         qWwO4GFd59hh70rhnRpn9YuqTv21fv/VN+2JxvjIiM67J3QKRTKWs0qlow0KkXbHNzep
         QYhQ==
X-Gm-Message-State: AOAM533IX+ZM3x/ea8sBmIyIrHuew5cALOL98ZKU1HBC1rWS3TcJHEXc
        wInEY8nKCVxMRKnPgcCpfCpZ2t/4UPS2dcmyOhuljw==
X-Google-Smtp-Source: ABdhPJzaMHjGp7RmlCC2dPw3XwN836wo8cYS+yqSHJ8vjWJsnq+Pj+Qa4bwNtUmvR7lSR54QIGbJwmaQW9nRh3wcRQQ=
X-Received: by 2002:aa7:9aaf:0:b029:197:c3e4:88e8 with SMTP id
 x15-20020aa79aaf0000b0290197c3e488e8mr5849185pfi.2.1605876089605; Fri, 20 Nov
 2020 04:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com> <20201120084202.GJ3200@dhcp22.suse.cz>
In-Reply-To: <20201120084202.GJ3200@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Nov 2020 20:40:46 +0800
Message-ID: <CAMZfGtWJXni21J=Yn55gksKy9KZnDScCjKmMasNz5XUwx3OcKw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 00/21] Free some vmemmap pages of
 hugetlb page
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 4:42 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 14:43:04, Muchun Song wrote:
> [...]
>
> Thanks for improving the cover letter and providing some numbers. I have
> only glanced through the patchset because I didn't really have more time
> to dive depply into them.
>
> Overall it looks promissing. To summarize. I would prefer to not have
> the feature enablement controlled by compile time option and the kernel
> command line option should be opt-in. I also do not like that freeing
> the pool can trigger the oom killer or even shut the system down if no
> oom victim is eligible.

Hi Michal,

I have replied to you about those questions on the other mail thread.

Thanks.

>
> One thing that I didn't really get to think hard about is what is the
> effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
> invalid when racing with the split. How do we enforce that this won't
> blow up?

This feature depends on the CONFIG_SPARSEMEM_VMEMMAP,
in this case, the pfn_to_page can work. The return value of the
pfn_to_page is actually the address of it's struct page struct.
I can not figure out where the problem is. Can you describe the
problem in detail please? Thanks.

>
> I have also asked in a previous version whether the vmemmap manipulation
> should be really unconditional. E.g. shortlived hugetlb pages allocated
> from the buddy allocator directly rather than for a pool. Maybe it
> should be restricted for the pool allocation as those are considered
> long term and therefore the overhead will be amortized and freeing path
> restrictions better understandable.

Yeah, I agree with you. This can be an optimization. And we can
add it to the todo list and implement it in the future. Now the patch
series is already huge.

>
> >  Documentation/admin-guide/kernel-parameters.txt |   9 +
> >  Documentation/admin-guide/mm/hugetlbpage.rst    |   3 +
> >  arch/x86/include/asm/hugetlb.h                  |  17 +
> >  arch/x86/include/asm/pgtable_64_types.h         |   8 +
> >  arch/x86/mm/init_64.c                           |   7 +-
> >  fs/Kconfig                                      |  14 +
> >  include/linux/bootmem_info.h                    |  78 +++
> >  include/linux/hugetlb.h                         |  19 +
> >  include/linux/hugetlb_cgroup.h                  |  15 +-
> >  include/linux/memory_hotplug.h                  |  27 -
> >  mm/Makefile                                     |   2 +
> >  mm/bootmem_info.c                               | 124 ++++
> >  mm/hugetlb.c                                    | 163 ++++-
> >  mm/hugetlb_vmemmap.c                            | 765 ++++++++++++++++++++++++
> >  mm/hugetlb_vmemmap.h                            | 103 ++++
>
> I will need to look closer but I suspect that a non-trivial part of the
> vmemmap manipulation really belongs to mm/sparse-vmemmap.c because the
> split and remapping shouldn't really be hugetlb specific. Sure hugetlb
> knows how to split but all the splitting should be implemented in
> vmemmap proper.
>
> >  mm/memory_hotplug.c                             | 116 ----
> >  mm/sparse.c                                     |   5 +-
> >  17 files changed, 1295 insertions(+), 180 deletions(-)
> >  create mode 100644 include/linux/bootmem_info.h
> >  create mode 100644 mm/bootmem_info.c
> >  create mode 100644 mm/hugetlb_vmemmap.c
> >  create mode 100644 mm/hugetlb_vmemmap.h
>
> Thanks!
> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
