Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8E38249D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 08:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhEQGpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 02:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhEQGpH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 02:45:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68C6361222;
        Mon, 17 May 2021 06:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621233831;
        bh=iVkxnDqQwpjrvJxXr6u24PcRby2BSTwHKSdPjJSUJ5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogor81X1A8Eh/ncAo15e7z4ugTGkNL3ChO3x+Hv3aKTzEtnifDg0uwpUSy+Sr0Jfl
         6/5Dhjut2z14RKcXwWaOFZj2Ja1TQDEyZZ3m0XnRmN9/nY1TB6Yl+VWzKTE+frPaiY
         kY6bn2KIk6JH6pXRKRlsrFEBCPh3qraFilRzNOvQS+yaz0+8obR9z9o5U1D64lAFty
         lbBG1S5mhNUEuuNF9q/+L2c0Vk4p2CvdvFyF+AZ3Ad/8VIAXUbGWS2uGu4ptdO0JjE
         nH4OD3XqTlfDE8mb3UyTd/1R5PM1or23JHARwN56MqeKT2wS6GghvRCaC/wlmgNycn
         TnOAkP4yLxqfQ==
Date:   Mon, 17 May 2021 09:43:40 +0300
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
Subject: Re: [PATCH v2 5/6] virtio-mem: use page_offline_(start|end) when
 setting PageOffline()
Message-ID: <YKIQnOYaVHktjgON@kernel.org>
References: <20210514172247.176750-1-david@redhat.com>
 <20210514172247.176750-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514172247.176750-6-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 07:22:46PM +0200, David Hildenbrand wrote:
> Let's properly use page_offline_(start|end) to synchronize setting
> PageOffline(), so we won't have valid page access to unplugged memory
> regions from /proc/kcore.
> 
> Existing balloon implementations usually allow reading inflated memory;
> doing so might result in unnecessary overhead in the hypervisor, which
> is currently the case with virtio-mem.
> 
> For future virtio-mem use cases, it will be different when using shmem,
> huge pages, !anonymous private mappings, ... as backing storage for a VM.
> virtio-mem unplugged memory must no longer be accessed and access might
> result in undefined behavior. There will be a virtio spec extension to
> document this change, including a new feature flag indicating the
> changed behavior. We really don't want to race against PFN walkers
> reading random page content.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 10ec60d81e84..dc2a2e2b2ff8 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1065,6 +1065,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
>  static void virtio_mem_set_fake_offline(unsigned long pfn,
>  					unsigned long nr_pages, bool onlined)
>  {
> +	page_offline_begin();
>  	for (; nr_pages--; pfn++) {
>  		struct page *page = pfn_to_page(pfn);
>  
> @@ -1075,6 +1076,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
>  			ClearPageReserved(page);
>  		}
>  	}
> +	page_offline_end();
>  }
>  
>  /*
> -- 
> 2.31.1
> 
> 

-- 
Sincerely yours,
Mike.
