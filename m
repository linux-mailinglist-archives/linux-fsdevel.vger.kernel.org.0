Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68E82C24FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 12:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbgKXLvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 06:51:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:60154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgKXLvN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:51:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606218671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R7XL6NbI/L1JqsoaBbCg/8rQlfbuYPIiCpwYgPMu2mg=;
        b=MIozIeOFbRW5Ry015oTrsjcDq4T7mnxR+twzbUa9fIW9K/f3oqhKhlhZd+LqIaCp5Bbwdy
        nijaaQDw2prFGMcM7lEa8aBYf85Mkh1wJaKucPhsT2IR+O2zTI6PikuLd2ZRFHhs1JRFJl
        Z49fqQu/QRyT6EKdt//6TbB8p28+J3o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04F77ADC5;
        Tue, 24 Nov 2020 11:51:11 +0000 (UTC)
Date:   Tue, 24 Nov 2020 12:51:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 09/16] mm/hugetlb: Defer freeing of HugeTLB pages
Message-ID: <20201124115109.GW27488@dhcp22.suse.cz>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
 <20201124095259.58755-10-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124095259.58755-10-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-11-20 17:52:52, Muchun Song wrote:
> In the subsequent patch, we will allocate the vmemmap pages when free
> HugeTLB pages. But update_and_free_page() is called from a non-task
> context(and hold hugetlb_lock), so we can defer the actual freeing in
> a workqueue to prevent use GFP_ATOMIC to allocate the vmemmap pages.

This has been brought up earlier without any satisfying answer. Do we
really have bother with the freeing from the pool and reconstructing the
vmemmap page tables? Do existing usecases really require such a dynamic
behavior? In other words, wouldn't it be much simpler to allow to use
hugetlb pages with sparse vmemmaps only for the boot time reservations
and never allow them to be freed back to the allocator. This is pretty
restrictive, no question about that, but it would drop quite some code
AFAICS and the resulting series would be much easier to review really
carefully. Additional enhancements can be done on top with specifics
about usecases which require more flexibility.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c         | 96 ++++++++++++++++++++++++++++++++++++++++++++++------
>  mm/hugetlb_vmemmap.c |  5 ---
>  mm/hugetlb_vmemmap.h | 10 ++++++
>  3 files changed, 95 insertions(+), 16 deletions(-)
-- 
Michal Hocko
SUSE Labs
