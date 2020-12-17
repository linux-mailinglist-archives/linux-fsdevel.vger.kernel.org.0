Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA192DCF88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 11:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgLQKcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 05:32:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:52466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbgLQKco (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:32:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60722AC90;
        Thu, 17 Dec 2020 10:32:03 +0000 (UTC)
Date:   Thu, 17 Dec 2020 11:31:59 +0100
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
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 11/11] mm/hugetlb: Optimize the code with the help of
 the compiler
Message-ID: <20201217103154.GA8481@linux>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-12-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213154534.54826-12-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 11:45:34PM +0800, Muchun Song wrote:
>  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
>  {
> -	return h->nr_free_vmemmap_pages;
> +	return h->nr_free_vmemmap_pages && is_power_of_2(sizeof(struct page));

This is wrong as it will return either true or false, but not what we want:

	static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
	{
	        return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
	}

the above will compute to 4096, which is wrong for obvious reasons.

-- 
Oscar Salvador
SUSE L3
