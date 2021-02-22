Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D49321195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 08:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBVHrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 02:47:49 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36346 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230148AbhBVHrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:47:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UPD0JAf_1613980020;
Received: from 30.225.32.201(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0UPD0JAf_1613980020)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 15:47:00 +0800
Subject: Re: [PATCH 1/7] fsdax: Output address in dax_iomap_pfn() and rename
 it
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
Cc:     darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-2-ruansy.fnst@cn.fujitsu.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <cd067457-5aaf-a2a9-06b0-953f49437500@linux.alibaba.com>
Date:   Mon, 22 Feb 2021 15:44:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210207170924.2933035-2-ruansy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi,

> Add address output in dax_iomap_pfn() in order to perform a memcpy() in
> CoW case.  Since this function both output address and pfn, rename it to
> dax_iomap_direct_access().
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>   fs/dax.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 5b47834f2e1b..b012b2db7ba2 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -998,8 +998,8 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
>   	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
>   }
>   
> -static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> -			 pfn_t *pfnp)
> +static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
> +		void **kaddr, pfn_t *pfnp)
>   {
>   	const sector_t sector = dax_iomap_sector(iomap, pos);
>   	pgoff_t pgoff;
> @@ -1011,11 +1011,13 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
>   		return rc;
>   	id = dax_read_lock();
>   	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
> -				   NULL, pfnp);
> +				   kaddr, pfnp);
>   	if (length < 0) {
>   		rc = length;
>   		goto out;
>   	}
> +	if (!pfnp)
Should this be "if (!*pfnp)"?

Regards,
Xiaoguang Wang
> +		goto out_check_addr;
>   	rc = -EINVAL;
>   	if (PFN_PHYS(length) < size)
>   		goto out;
> @@ -1025,6 +1027,12 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
>   	if (length > 1 && !pfn_t_devmap(*pfnp))
>   		goto out;
>   	rc = 0;
> +
> +out_check_addr:
> +	if (!kaddr)
> +		goto out;
> +	if (!*kaddr)
> +		rc = -EFAULT;
>   out:
>   	dax_read_unlock(id);
>   	return rc;
> @@ -1348,7 +1356,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>   			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
>   			major = VM_FAULT_MAJOR;
>   		}
> -		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn);
> +		error = dax_iomap_direct_access(&iomap, pos, PAGE_SIZE,
> +						NULL, &pfn);
>   		if (error < 0)
>   			goto error_finish_iomap;
>   
> @@ -1566,7 +1575,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>   
>   	switch (iomap.type) {
>   	case IOMAP_MAPPED:
> -		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn);
> +		error = dax_iomap_direct_access(&iomap, pos, PMD_SIZE,
> +						NULL, &pfn);
>   		if (error < 0)
>   			goto finish_iomap;
>   
> 
