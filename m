Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45AF780919
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359447AbjHRJ4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 05:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359439AbjHRJz6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:55:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A130DC;
        Fri, 18 Aug 2023 02:55:51 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.185.42])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33CE8660723E;
        Fri, 18 Aug 2023 10:55:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692352549;
        bh=jSm113VK4O5di5c9amVgQ+0TBD3Pa6bZ1kfgpxOAP9M=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=UkcqyLrBG7zmA6SoRIwPH7RykRwITDLpCgmJzIMdpZSSGhWDnrqRYMckR2Ls97+1O
         0KztY/htn/6tBVPKzD01airJtHNIkqolcF/lC4qxZdCcCIz0gKOCCLv2FjRpMskBkk
         UeZiPrsN3/kUd9pD3jXw+oIN5b/NJFtUmtohzW+ITtuPbs7qXaJx5LSdvXHazL9IEL
         kvf1bfULa2BqMZenCP6KxI8mWcvO8ZeR4dqMraAPw/0NXKm2QCqvYCXIoJygu4Usld
         p15w4ECqknF0FBilW+t7TgLKsYAPiwMeekZe3NUEtFlJ2WI1ff5f7dfE/Z3k+L9w7X
         Y3wx4Hg2pc+OA==
Message-ID: <ea2af063-67da-137b-1dc4-bace40568187@collabora.com>
Date:   Fri, 18 Aug 2023 14:55:36 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Greg KH <greg@kroah.com>,
        kernel@collabora.com, Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v32 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     kernel test robot <lkp@intel.com>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>
References: <20230816113049.1697849-3-usama.anjum@collabora.com>
 <202308181520.yCq9Z26w-lkp@intel.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202308181520.yCq9Z26w-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/18/23 12:16 PM, kernel test robot wrote:
> Hi Muhammad,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on next-20230817]
> [cannot apply to linus/master v6.5-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230816-193454
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230816113049.1697849-3-usama.anjum%40collabora.com
> patch subject: [PATCH v32 2/6] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
> config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230818/202308181520.yCq9Z26w-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230818/202308181520.yCq9Z26w-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308181520.yCq9Z26w-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    fs/proc/task_mmu.c: In function 'pagemap_scan_thp_entry':
>>> fs/proc/task_mmu.c:2077:28: error: 'HPAGE_SIZE' undeclared (first use in this function); did you mean 'PAGE_SIZE'?
>     2077 |         if (end != start + HPAGE_SIZE) {
>          |                            ^~~~~~~~~~
>          |                            PAGE_SIZE
I've been emailing arc maintainers for resolution of this error from April,
but nobody replies there:
https://lore.kernel.org/all/0e6b318a-bbf8-3701-00af-1802c6347897@collabora.com

>    fs/proc/task_mmu.c:2077:28: note: each undeclared identifier is reported only once for each function it appears in
> 
> 
> vim +2077 fs/proc/task_mmu.c
> 
>   2044	
>   2045	static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
>   2046					  unsigned long end, struct mm_walk *walk)
>   2047	{
>   2048	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   2049		struct pagemap_scan_private *p = walk->private;
>   2050		struct vm_area_struct *vma = walk->vma;
>   2051		unsigned long categories;
>   2052		spinlock_t *ptl;
>   2053		int ret = 0;
>   2054	
>   2055		ptl = pmd_trans_huge_lock(pmd, vma);
>   2056		if (!ptl)
>   2057			return -ENOENT;
>   2058	
>   2059		categories = p->cur_vma_category | pagemap_thp_category(*pmd);
>   2060	
>   2061		if (!pagemap_scan_is_interesting_page(categories, p))
>   2062			goto out_unlock;
>   2063	
>   2064		ret = pagemap_scan_output(categories, p, start, &end);
>   2065		if (start == end)
>   2066			goto out_unlock;
>   2067	
>   2068		if (~p->arg.flags & PM_SCAN_WP_MATCHING)
>   2069			goto out_unlock;
>   2070		if (~categories & PAGE_IS_WRITTEN)
>   2071			goto out_unlock;
>   2072	
>   2073		/*
>   2074		 * Break huge page into small pages if the WP operation
>   2075		 * needs to be performed on a portion of the huge page.
>   2076		 */
>> 2077		if (end != start + HPAGE_SIZE) {
>   2078			spin_unlock(ptl);
>   2079			split_huge_pmd(vma, pmd, start);
>   2080			pagemap_scan_backout_range(p, start, end);
>   2081			/* Report as if there was no THP */
>   2082			return -ENOENT;
>   2083		}
>   2084	
>   2085		make_uffd_wp_pmd(vma, start, pmd);
>   2086		flush_tlb_range(vma, start, end);
>   2087	out_unlock:
>   2088		spin_unlock(ptl);
>   2089		return ret;
>   2090	#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
>   2091		return -ENOENT;
>   2092	#endif
>   2093	}
>   2094	
> 

-- 
BR,
Muhammad Usama Anjum
