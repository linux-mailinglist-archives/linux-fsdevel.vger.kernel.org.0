Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1826B9AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 04:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIPCLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 22:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgIPCLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:11:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79044C06174A;
        Tue, 15 Sep 2020 19:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nTKIBWOP6+WpdGT2H6jGa3P9YtQ8grc6+Ik6AGR2Qb8=; b=jge5AAJnaS9TAKULysr8Xc2YMC
        s9CakwAKXd+snWykDY8VDpiXY3MlJAy8TAr2fbKuIIDozCIZfMVJqOvnfcAuJpbRvcz9U8/adLuKI
        xDxs/NUBIeNIbSQZmn691oWqIYHm6/TMRuA51NWsMVusavMrO8hTNcizmjKAxc9xup1sR/bPoO5v+
        73WQPIQ/mHAwn1I3Hj1bH5gkEJvqfyD74V2rhI81ujeqyLxdit5YaLGL942QCotj3mVsbZxg8qCwc
        h8RwIQ9ikhgFawVW3ozqFvoUEYMBGAowuzZOHcC9CNrwv8DlljmTE9GLrQgyYSJsHoBDj51RMWvl4
        nosL32/g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIMuc-00021E-TN; Wed, 16 Sep 2020 02:11:11 +0000
Subject: Re: [RFC PATCH 20/24] mm/hugetlb: Add a kernel parameter
 hugetlb_free_vmemmap
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de, almasrymina@google.com,
        rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915125947.26204-21-songmuchun@bytedance.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <defc8d4f-b143-d4ae-f609-fd22624aafc3@infradead.org>
Date:   Tue, 15 Sep 2020 19:10:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915125947.26204-21-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
Please see comments below.

On 9/15/20 5:59 AM, Muchun Song wrote:
> Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
> freeing unused vmemmap pages associated with each hugetlb page on boot.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  9 ++++++++
>  Documentation/admin-guide/mm/hugetlbpage.rst  |  3 +++
>  mm/hugetlb.c                                  | 23 +++++++++++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 5debfe238027..69d18ef6f66b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1551,6 +1551,15 @@
>  			Documentation/admin-guide/mm/hugetlbpage.rst.
>  			Format: size[KMG]
>  
> +	hugetlb_free_vmemmap=
> +			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
> +			this disables freeing unused vmemmap pages associated

			this controls

> +			each HugeTLB page.

			with each HugeTLB page.

> +			Format: { on (default) | off }
> +
> +			on:  enable the feature
> +			off: dosable the feature

			     disable

> +
>  	hung_task_panic=
>  			[KNL] Should the hung task detector generate panics.
>  			Format: 0 | 1
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index f7b1c7462991..7d6129ee97dd 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -145,6 +145,9 @@ default_hugepagesz
>  
>  	will all result in 256 2M huge pages being allocated.  Valid default
>  	huge page size is architecture dependent.

insert blank line here.

> +hugetlb_free_vmemmap
> +	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this disables freeing
> +	unused vmemmap pages associated each HugeTLB page.
>  
>  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
>  indicates the current number of pre-allocated huge pages of the default size.


-- 
~Randy

