Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD12BA45F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgKTIL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:11:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:59024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgKTILZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:11:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605859884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=POm2upnSpy8lgJ9BozivrNRInBH5i4/oOnz1KLQ0wVs=;
        b=PzJ3jlLWTN2U/kyBTyLSPcBdx1xw2KXRrDbXt6VoCLIpeyoxr02RjaSrVnquca5Hzcf+Rk
        Uno/i0l38a9XVd31/wRMsOY7MLATJC+fb0nwhT7t/aSdrc6wjPgeMVYBpmJqXXz0dI9yuy
        mCfK4/e04gdHAH0UFpztAkkGR2imKvo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 204F7AB3D;
        Fri, 20 Nov 2020 08:11:24 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:11:23 +0100
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
Subject: Re: [PATCH v5 11/21] mm/hugetlb: Allocate the vmemmap pages
 associated with each hugetlb page
Message-ID: <20201120081123.GC3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-12-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120064325.34492-12-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 14:43:15, Muchun Song wrote:
[...]
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index eda7e3a0b67c..361c4174e222 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -117,6 +117,8 @@
>  #define RESERVE_VMEMMAP_NR		2U
>  #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
>  #define TAIL_PAGE_REUSE			-1
> +#define GFP_VMEMMAP_PAGE		\
> +	(GFP_KERNEL | __GFP_NOFAIL | __GFP_MEMALLOC)

This is really dangerous! __GFP_MEMALLOC would allow a complete memory
depletion. I am not even sure triggering the OOM killer is a reasonable
behavior. It is just unexpected that shrinking a hugetlb pool can have
destructive side effects. I believe it would be more reasonable to
simply refuse to shrink the pool if we cannot free those pages up. This
sucks as well but it isn't destructive at least.
-- 
Michal Hocko
SUSE Labs
