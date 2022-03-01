Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A554C8767
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 10:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiCAJIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 04:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiCAJHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:07:53 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A359689CD8;
        Tue,  1 Mar 2022 01:07:11 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K7BDc6q0nzdZmq;
        Tue,  1 Mar 2022 17:05:52 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 17:07:08 +0800
Subject: Re: [PATCH 2/8] mm: khugepaged: remove redundant check for
 VM_NO_KHUGEPAGED
To:     Yang Shi <shy828301@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vbabka@suse.cz>,
        <kirill.shutemov@linux.intel.com>, <songliubraving@fb.com>,
        <riel@surriel.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <akpm@linux-foundation.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <darrick.wong@oracle.com>
References: <20220228235741.102941-1-shy828301@gmail.com>
 <20220228235741.102941-3-shy828301@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <968ccc31-a87c-4657-7193-464f6b5b9259@huawei.com>
Date:   Tue, 1 Mar 2022 17:07:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220228235741.102941-3-shy828301@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/3/1 7:57, Yang Shi wrote:
> The hugepage_vma_check() called by khugepaged_enter_vma_merge() does
> check VM_NO_KHUGEPAGED. Remove the check from caller and move the check
> in hugepage_vma_check() up.
> 
> More checks may be run for VM_NO_KHUGEPAGED vmas, but MADV_HUGEPAGE is
> definitely not a hot path, so cleaner code does outweigh.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/khugepaged.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 131492fd1148..82c71c6da9ce 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -366,8 +366,7 @@ int hugepage_madvise(struct vm_area_struct *vma,
>  		 * register it here without waiting a page fault that
>  		 * may not happen any time soon.
>  		 */
> -		if (!(*vm_flags & VM_NO_KHUGEPAGED) &&
> -				khugepaged_enter_vma_merge(vma, *vm_flags))
> +		if (khugepaged_enter_vma_merge(vma, *vm_flags))
>  			return -ENOMEM;
>  		break;
>  	case MADV_NOHUGEPAGE:
> @@ -446,6 +445,9 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>  	if (!transhuge_vma_enabled(vma, vm_flags))
>  		return false;
>  
> +	if (vm_flags & VM_NO_KHUGEPAGED)
> +		return false;
> +

This patch does improve the readability. But I have a question.
It seems VM_NO_KHUGEPAGED is not checked in the below if-condition:

	/* Only regular file is valid */
	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
	    (vm_flags & VM_EXEC)) {
		struct inode *inode = vma->vm_file->f_inode;

		return !inode_is_open_for_write(inode) &&
			S_ISREG(inode->i_mode);
	}

If we return false due to VM_NO_KHUGEPAGED here, it seems it will affect the
return value of this CONFIG_READ_ONLY_THP_FOR_FS condition check.
Or am I miss something?

Thanks.

>  	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
>  				vma->vm_pgoff, HPAGE_PMD_NR))
>  		return false;
> @@ -471,7 +473,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>  		return false;
>  	if (vma_is_temporary_stack(vma))
>  		return false;
> -	return !(vm_flags & VM_NO_KHUGEPAGED);
> +
> +	return true;
>  }
>  
>  int __khugepaged_enter(struct mm_struct *mm)
> 

