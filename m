Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2876C2E0D64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 17:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgLVQak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 11:30:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:45394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgLVQak (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:30:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4A22ABA1;
        Tue, 22 Dec 2020 16:29:58 +0000 (UTC)
Date:   Tue, 22 Dec 2020 17:29:52 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v11 10/11] mm/hugetlb: Gather discrete indexes of tail
 page
Message-ID: <20201222162948.GA31385@linux>
References: <20201222142440.28930-1-songmuchun@bytedance.com>
 <20201222142440.28930-11-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222142440.28930-11-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 10:24:39PM +0800, Muchun Song wrote:
> +#else
> +static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
> +{
> +}
> +
> +static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
> +					struct page *page)
> +{
> +	if (PageHWPoison(head) && page != head) {
> +		/*
> +		 * Move PageHWPoison flag from head page to the raw error page,
> +		 * which makes any subpages rather than the error page reusable.
> +		 */
> +		SetPageHWPoison(page);
> +		ClearPageHWPoison(head);
> +	}
> +}
> +#endif

Sorry, I guess I should have made a more clear statement.
This patch should really be about changing the numeric index to its symbolic
names, so the #ifdef handling of hwpoison_subpage_* should have been gone into
patch#6.

I will have a closer look later on though.

-- 
Oscar Salvador
SUSE L3
