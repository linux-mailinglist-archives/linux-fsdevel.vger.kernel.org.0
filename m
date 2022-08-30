Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0580E5A59FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 05:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiH3Daj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 23:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiH3Da2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:30:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBE85D0D7;
        Mon, 29 Aug 2022 20:30:25 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MGt7S4bZtzHnVw;
        Tue, 30 Aug 2022 11:28:36 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 11:30:21 +0800
Subject: Re: [PATCH 4/4] mm/memory-failure: Fall back to vma_address() when
 ->notify_failure() fails
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Jane Chu <jane.chu@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        <nvdimm@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <djwong@kernel.org>
References: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
 <166153429427.2758201.14605968329933175594.stgit@dwillia2-xfh.jf.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <76fb4464-73eb-256c-60e0-a0c3dc152e78@huawei.com>
Date:   Tue, 30 Aug 2022 11:30:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <166153429427.2758201.14605968329933175594.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/8/27 1:18, Dan Williams wrote:
> In the case where a filesystem is polled to take over the memory failure
> and receives -EOPNOTSUPP it indicates that page->index and page->mapping
> are valid for reverse mapping the failure address. Introduce
> FSDAX_INVALID_PGOFF to distinguish when add_to_kill() is being called
> from mf_dax_kill_procs() by a filesytem vs the typical memory_failure()
> path.

Thanks for fixing.
I'm sorry but I can't find the bug report email. Do you mean mf_dax_kill_procs() can
pass an invalid pgoff to the add_to_kill()? But it seems pgoff is guarded against invalid
value by vma_interval_tree_foreach() in collect_procs_fsdax(). So pgoff should be an valid
value. Or am I miss something?

Thanks,
Miaohe Lin

> 
> Otherwise, vma_pgoff_address() is called with an invalid fsdax_pgoff
> which then trips this failing signature:
> 
>  kernel BUG at mm/memory-failure.c:319!
>  invalid opcode: 0000 [#1] PREEMPT SMP PTI
>  CPU: 13 PID: 1262 Comm: dax-pmd Tainted: G           OE    N 6.0.0-rc2+ #62
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  RIP: 0010:add_to_kill.cold+0x19d/0x209
>  [..]
>  Call Trace:
>   <TASK>
>   collect_procs.part.0+0x2c4/0x460
>   memory_failure+0x71b/0xba0
>   ? _printk+0x58/0x73
>   do_madvise.part.0.cold+0xaf/0xc5
> 
> Fixes: c36e20249571 ("mm: introduce mf_dax_kill_procs() for fsdax case")
> Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Ritesh Harjani <riteshh@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/memory-failure.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 8a4294afbfa0..e424a9dac749 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -345,13 +345,17 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
>   * not much we can do.	We just print a message and ignore otherwise.
>   */
>  
> +#define FSDAX_INVALID_PGOFF ULONG_MAX
> +
>  /*
>   * Schedule a process for later kill.
>   * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
>   *
> - * Notice: @fsdax_pgoff is used only when @p is a fsdax page.
> - *   In other cases, such as anonymous and file-backend page, the address to be
> - *   killed can be caculated by @p itself.
> + * Note: @fsdax_pgoff is used only when @p is a fsdax page and a
> + * filesystem with a memory failure handler has claimed the
> + * memory_failure event. In all other cases, page->index and
> + * page->mapping are sufficient for mapping the page back to its
> + * corresponding user virtual address.
>   */
>  static void add_to_kill(struct task_struct *tsk, struct page *p,
>  			pgoff_t fsdax_pgoff, struct vm_area_struct *vma,
> @@ -367,11 +371,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>  
>  	tk->addr = page_address_in_vma(p, vma);
>  	if (is_zone_device_page(p)) {
> -		/*
> -		 * Since page->mapping is not used for fsdax, we need
> -		 * calculate the address based on the vma.
> -		 */
> -		if (p->pgmap->type == MEMORY_DEVICE_FS_DAX)
> +		if (fsdax_pgoff != FSDAX_INVALID_PGOFF)
>  			tk->addr = vma_pgoff_address(fsdax_pgoff, 1, vma);
>  		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
>  	} else
> @@ -523,7 +523,8 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
>  			if (!page_mapped_in_vma(page, vma))
>  				continue;
>  			if (vma->vm_mm == t->mm)
> -				add_to_kill(t, page, 0, vma, to_kill);
> +				add_to_kill(t, page, FSDAX_INVALID_PGOFF, vma,
> +					    to_kill);
>  		}
>  	}
>  	read_unlock(&tasklist_lock);
> @@ -559,7 +560,8 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>  			 * to be informed of all such data corruptions.
>  			 */
>  			if (vma->vm_mm == t->mm)
> -				add_to_kill(t, page, 0, vma, to_kill);
> +				add_to_kill(t, page, FSDAX_INVALID_PGOFF, vma,
> +					    to_kill);
>  		}
>  	}
>  	read_unlock(&tasklist_lock);
> 
> 
> .
> 

