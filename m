Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F5332CBC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 06:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCDFHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 00:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCDFHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 00:07:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E826DC061574;
        Wed,  3 Mar 2021 21:06:24 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d8so5030975plg.10;
        Wed, 03 Mar 2021 21:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=emvx6EGccNj6Ydsl4VIT/MapySsYN/1eggzsPky2Bqg=;
        b=AlGlq+xLEuvo/Vc+kPNJEBcVKI/sHnodi8Jx8UTm4EaWSUtECl+ig6dpsb2yNshbXH
         P627aXAL3t6+GWqIWlyn/c76pLoZcKFxde/drVkpjKfo4fF/rkMZ394mO8FKvXGz+H4j
         pcKhEwQR7VfbE4H2XnDVSJK4Up/gwTqx3OenSIj5l1yXSj5pZY4XIHkmh0tVuqkApwc3
         qJZ8Bsj43FKTseZRq+ks68ssiovr2xsMWf6IF7aMD0UiwQ1WCkMsD6w6eU5drZvOKDhM
         KfM3J8w7XzM+QfvnB9EANNKG/FYPMPsGv2IlJIlaY57KoHPhCjeb8r75fS3pVYdS5eW7
         arTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=emvx6EGccNj6Ydsl4VIT/MapySsYN/1eggzsPky2Bqg=;
        b=P/amwh10QL1V90mkvxaeDWV5Uir0jERBYZOOlvTgMkJyVNqoWCogCX1RbgZs8HmLnb
         r2bFDV3YRbfL5aQYfPyKGRGIPfaBeaRuhbk1d7FOE2Hi5lRVlSto7esUQIeogNkh94Y9
         k0xXeUHwcjWcqyGFO5bxIZuBWMdDdqYwoY3iRDtqPfJtS2a14V8jngRI016fG6A+CTzR
         Lhze9+jHt1rzhYntkWVLQBPax/tkt8e6EM/E+h8kLx9W24wmmuDtEWQ+dOAxjrzk3jWe
         KC80i/wHaVEAsl1qxiwj2aMOb78UThF8nX1521XdP51k4ggXe0eGJZ6racsjoZUD9yhM
         QQjA==
X-Gm-Message-State: AOAM532MaIQSt10ucKlTG/ngrSEHqNBrNvDBGdSFtlTH7OEGEswMuo7t
        kbb8m0mnfsA0fMvaInVSkLY=
X-Google-Smtp-Source: ABdhPJzjrm43e7Byowg0g5bCTtT6JJKmNM5oQ0ifxTHweqTpc+KNPB9SmA1zgtUxtn+T2FeMn1vjAQ==
X-Received: by 2002:a17:90a:a384:: with SMTP id x4mr2648884pjp.84.1614834384259;
        Wed, 03 Mar 2021 21:06:24 -0800 (PST)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id a3sm433368pfi.206.2021.03.03.21.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 21:06:22 -0800 (PST)
Date:   Thu, 4 Mar 2021 16:06:19 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v17 2/9] mm: hugetlb: introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
Message-ID: <20210304050619.GC1223287@balbir-desktop>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225132130.26451-3-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 25, 2021 at 09:21:23PM +0800, Muchun Song wrote:
> The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
> some vmemmap pages associated with pre-allocated HugeTLB pages.
> For example, on X86_64 6 vmemmap pages of size 4KB each can be
> saved for each 2MB HugeTLB page. 4094 vmemmap pages of size 4KB
> each can be saved for each 1GB HugeTLB page.
> 
> When a HugeTLB page is allocated or freed, the vmemmap array
> representing the range associated with the page will need to be
> remapped. When a page is allocated, vmemmap pages are freed
> after remapping. When a page is freed, previously discarded
> vmemmap pages must be allocated before remapping.
> 
> The config option is introduced early so that supporting code
> can be written to depend on the option. The initial version of
> the code only provides support for x86-64.
> 
> Like other code which frees vmemmap, this config option depends on
> HAVE_BOOTMEM_INFO_NODE. The routine register_page_bootmem_info() is
> used to register bootmem info. Therefore, make sure
> register_page_bootmem_info is enabled if HUGETLB_PAGE_FREE_VMEMMAP
> is defined.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
