Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F4A370A78
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 08:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhEBGc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 02:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhEBGcz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 02:32:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99E0761057;
        Sun,  2 May 2021 06:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937124;
        bh=qL1B1QT4PpYn1h9YGj03tGeQZLDs+ChkBvvTAwTmFBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgIeVS0ngZ+Uig3csISk5AB6RZ07CQ3YfksmsyKupiBZXIUwJYBS2eBdaRZvkSjcX
         WIrV6ut42Yj5gR1+UdA/NnKAE3yUqRPVma6wwzMelniHeh4csUjFXQ6lhjhT7meFTH
         5fxUM4a+tXZJOChTH8nFx4i71BqQe0QG2ObXpWPiv2UJTXApHo3+1mgNmdgjv4PmMT
         Ayf+NSTkA8A5TXNOkfapVPaDtzUcXZXOngTVM9y9L6O/b6Ht5czAV7Dl5B0HQNJv/X
         yhXdpBxZ/QwOG42gYF63XGRRC72Ae1izFm1A5V6AJCFKr2w64Gfa7DPAjIUgwfPu1f
         x/30S+CYcAPbQ==
Date:   Sun, 2 May 2021 09:31:52 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/7] fs/proc/kcore: drop KCORE_REMAP and KCORE_OTHER
Message-ID: <YI5HWCDgHJzb4nkt@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429122519.15183-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:25:13PM +0200, David Hildenbrand wrote:
> Commit db779ef67ffe ("proc/kcore: Remove unused kclist_add_remap()")
> removed the last user of KCORE_REMAP.
> 
> Commit 595dd46ebfc1 ("vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when
> dumping vsyscall user page") removed the last user of KCORE_OTHER.
> 
> Let's drop both types. While at it, also drop vaddr in "struct
> kcore_list", used by KCORE_REMAP only.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  fs/proc/kcore.c       | 7 ++-----
>  include/linux/kcore.h | 3 ---
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 4d2e64e9016c..09f77d3c6e15 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -380,11 +380,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  			phdr->p_type = PT_LOAD;
>  			phdr->p_flags = PF_R | PF_W | PF_X;
>  			phdr->p_offset = kc_vaddr_to_offset(m->addr) + data_offset;
> -			if (m->type == KCORE_REMAP)
> -				phdr->p_vaddr = (size_t)m->vaddr;
> -			else
> -				phdr->p_vaddr = (size_t)m->addr;
> -			if (m->type == KCORE_RAM || m->type == KCORE_REMAP)
> +			phdr->p_vaddr = (size_t)m->addr;
> +			if (m->type == KCORE_RAM)
>  				phdr->p_paddr = __pa(m->addr);
>  			else if (m->type == KCORE_TEXT)
>  				phdr->p_paddr = __pa_symbol(m->addr);
> diff --git a/include/linux/kcore.h b/include/linux/kcore.h
> index da676cdbd727..86c0f1d18998 100644
> --- a/include/linux/kcore.h
> +++ b/include/linux/kcore.h
> @@ -11,14 +11,11 @@ enum kcore_type {
>  	KCORE_RAM,
>  	KCORE_VMEMMAP,
>  	KCORE_USER,
> -	KCORE_OTHER,
> -	KCORE_REMAP,
>  };
>  
>  struct kcore_list {
>  	struct list_head list;
>  	unsigned long addr;
> -	unsigned long vaddr;
>  	size_t size;
>  	int type;
>  };
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
