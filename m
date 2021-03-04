Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BC532CAC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 04:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhCDDPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 22:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhCDDPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:15:19 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5DDC061756;
        Wed,  3 Mar 2021 19:14:39 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id j12so17865195pfj.12;
        Wed, 03 Mar 2021 19:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=py5d53PIjzcRnYKcamh11BoSIUkTsgMTbei02sa+otc=;
        b=fTJ2tA0c7JFg7dnnRHR6CdoBbG2mFJs+s2eOkvOk3JJsqmHUZRdbtKCjLE8MT09PHf
         HCoC1TdlXw5/Yrlkc16B7j0Cx4AkGM4V0SIgySqr8V9lu2MvYbelrgmH4N6T2BKekTd/
         CukJXMlaXh00oWJLeZA6u5v9sK4JbEt3Eod6XXyQ2dR2fTmKjnjiF9JpzIH2UbIhCXH+
         EAFvNf1VUB02zEDVyWQs2C8BoLBR54jRDIMSnNn9ClesW3bqdC0YSZvYulfXoeUJ6FfW
         Wihd1SiVPP6e/AT3Fs80KCPFDeYeAcL9bV1Rt4c5gZL5wHYz17VmSfzsmVUad2jhjEi2
         zmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=py5d53PIjzcRnYKcamh11BoSIUkTsgMTbei02sa+otc=;
        b=XGpkpOn2vEa29aiN1QP6S8yECrKNIBtCDEfWuJIhSPLWaShfSHj7292XA8xURaGWz2
         NfSTH+LwOhXligwItUiQDXHLUAH/d4BiK35BHAuJvSOp/u+527u9iGeWanesqfwwtQE8
         hpBbbSZpUF8WoeNlPGKOwfnFKHjuaUGM+9rLBNSuQx7AVnc73GwhJMyyCo5dvrFmN5uQ
         F/xv4y0HuyfuKr04AM5O9vfXr5ZjlkN0c/DwLwnoHP10oiZDFkMZ2BYTvX3TRXCkTmtJ
         tSuBWtP8uuB1IIBPwpxemxoFGwG2+OVUuDH6LqOfoGeGVO9KZ0LJAgosY4wL2V472HWr
         2dJg==
X-Gm-Message-State: AOAM533Mr3CYsvvkxeHhyRlR/scUQ4SyNeYuqPX+7aOvU5ihgkrvnyE5
        Pzs1g7wFQr9cCfSc3vscJFdtt6GdMqaTgw==
X-Google-Smtp-Source: ABdhPJwy36NGTxjWIikcPaX8mkhPNvLNBEB9ubbuv1sYLrF8z23JrB3Ni0F/5/plMZN3kWP75Gi7dQ==
X-Received: by 2002:aa7:9154:0:b029:1ee:fa0d:24dd with SMTP id 20-20020aa791540000b02901eefa0d24ddmr1819352pfi.17.1614827678304;
        Wed, 03 Mar 2021 19:14:38 -0800 (PST)
Received: from f8ffc2228008.ant.amazon.com ([54.240.193.129])
        by smtp.gmail.com with ESMTPSA id q23sm13760798pgj.66.2021.03.03.19.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 19:14:37 -0800 (PST)
Subject: Re: [PATCH v17 0/9] Free some vmemmap pages of HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210225132130.26451-1-songmuchun@bytedance.com>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <e9ef3479-24f1-9304-ee0e-6f06fb457d50@gmail.com>
Date:   Thu, 4 Mar 2021 14:14:23 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210225132130.26451-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/2/21 12:21 am, Muchun Song wrote:
> Hi all,
> 
> This patch series will free some vmemmap pages(struct page structures)
> associated with each hugetlbpage when preallocated to save memory.
> 
> In order to reduce the difficulty of the first version of code review.
> From this version, we disable PMD/huge page mapping of vmemmap if this
> feature was enabled. This accutualy eliminate a bunch of the complex code
> doing page table manipulation. When this patch series is solid, we cam add
> the code of vmemmap page table manipulation in the future.
> 
> The struct page structures (page structs) are used to describe a physical
> page frame. By default, there is a one-to-one mapping from a page frame to
> it's corresponding page struct.
> 
> The HugeTLB pages consist of multiple base page size pages and is supported
> by many architectures. See hugetlbpage.rst in the Documentation directory
> for more details. On the x86 architecture, HugeTLB pages of size 2MB and 1GB
> are currently supported. Since the base page size on x86 is 4KB, a 2MB
> HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
> 4096 base pages. For each base page, there is a corresponding page struct.
> 
> Within the HugeTLB subsystem, only the first 4 page structs are used to
> contain unique information about a HugeTLB page. HUGETLB_CGROUP_MIN_ORDER
> provides this upper limit. The only 'useful' information in the remaining
> page structs is the compound_head field, and this field is the same for all
> tail pages.

The HUGETLB_CGROUP_MIN_ORDER is only when CGROUP_HUGETLB is enabled, but I guess
that does not matter

> 
> By removing redundant page structs for HugeTLB pages, memory can returned to
> the buddy allocator for other uses.
> 
> When the system boot up, every 2M HugeTLB has 512 struct page structs which
> size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
> 
>     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
>  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>  |           |                     |     0     | -------------> |     0     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     1     | -------------> |     1     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     2     | -------------> |     2     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     3     | -------------> |     3     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     4     | -------------> |     4     |
>  |    2MB    |                     +-----------+                +-----------+
>  |           |                     |     5     | -------------> |     5     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     6     | -------------> |     6     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     7     | -------------> |     7     |
>  |           |                     +-----------+                +-----------+
>  |           |
>  |           |
>  |           |
>  +-----------+
> 
> The value of page->compound_head is the same for all tail pages. The first
> page of page structs (page 0) associated with the HugeTLB page contains the 4
> page structs necessary to describe the HugeTLB. The only use of the remaining
> pages of page structs (page 1 to page 7) is to point to page->compound_head.
> Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
> will be used for each HugeTLB page. This will allow us to free the remaining
> 6 pages to the buddy allocator.

What is page 1 used for? page 0 carries the 4 struct pages needed, does compound_head
need a full page? IOW, why do we need two full pages -- may be the patches have the
answer to something I am missing?

> 
> Here is how things look after remapping.
> 
>     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
>  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>  |           |                     |     0     | -------------> |     0     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     1     | -------------> |     1     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
>  |           |                     +-----------+                   | | | | |
>  |           |                     |     3     | ------------------+ | | | |
>  |           |                     +-----------+                     | | | |
>  |           |                     |     4     | --------------------+ | | |
>  |    2MB    |                     +-----------+                       | | |
>  |           |                     |     5     | ----------------------+ | |
>  |           |                     +-----------+                         | |
>  |           |                     |     6     | ------------------------+ |
>  |           |                     +-----------+                           |
>  |           |                     |     7     | --------------------------+
>  |           |                     +-----------+
>  |           |
>  |           |
>  |           |
>  +-----------+
> 
> When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
> vmemmap pages and restore the previous mapping relationship.
> 

Can these 6 pages come from the hugeTLB page itself? When you say 6 pages,
I presume you mean 6 pages of PAGE_SIZE

> Apart from 2MB HugeTLB page, we also have 1GB HugeTLB page. It is similar
> to the 2MB HugeTLB page. We also can use this approach to free the vmemmap
> pages.
> 
> In this case, for the 1GB HugeTLB page, we can save 4094 pages. This is a
> very substantial gain. On our server, run some SPDK/QEMU applications which
> will use 1024GB hugetlbpage. With this feature enabled, we can save ~16GB
> (1G hugepage)/~12GB (2MB hugepage) memory.

Thanks,
Balbir Singh













