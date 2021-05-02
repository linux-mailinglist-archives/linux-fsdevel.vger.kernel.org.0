Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6DE370A81
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 08:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhEBGeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 02:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhEBGeO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 02:34:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25C6A61408;
        Sun,  2 May 2021 06:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937203;
        bh=xCHXh8bLinDeqYhXWURePtlkQbRyXAxtzpNH6qseAsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AL85wToj2jGrctsZ0HQQHbsSMt44YWw4Z8REWyA6PNEHF0KvUISqbJC4d3+nPxC9y
         jbsunE8U4QW5sBdGsAfnnNB6HI2lC5CBXdk6PtPcEEb+G2B8cOK9ukA1ZNKBsqeIjw
         eEIy5SKRaRFyKkxHLNUykNIPS3XVrQuXbQzlI9tmKyb7Y0XQtB77sog4tikowZqPMF
         J1J7ZD2hnQNzQgaMVgdc92cya3uwzf/fQmZN0OKRxtylB3n8MXy9wfvAbda08PjxUr
         7KnYRKaGqcdN9kHIoBfexZXHidgYuGisApHdpqiHk/NRiPqHIInsENYcU9KgBC/a+q
         xYb+XUXyasQPw==
Date:   Sun, 2 May 2021 09:33:11 +0300
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
Subject: Re: [PATCH v1 5/7] mm: introduce
 page_offline_(begin|end|freeze|unfreeze) to synchronize setting
 PageOffline()
Message-ID: <YI5Hp49AmWgfTzNy@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429122519.15183-6-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:25:17PM +0200, David Hildenbrand wrote:
> A driver might set a page logically offline -- PageOffline() -- and
> turn the page inaccessible in the hypervisor; after that, access to page
> content can be fatal. One example is virtio-mem; while unplugged memory
> -- marked as PageOffline() can currently be read in the hypervisor, this
> will no longer be the case in the future; for example, when having
> a virtio-mem device backed by huge pages in the hypervisor.
> 
> Some special PFN walkers -- i.e., /proc/kcore -- read content of random
> pages after checking PageOffline(); however, these PFN walkers can race
> with drivers that set PageOffline().
> 
> Let's introduce page_offline_(begin|end|freeze|unfreeze) for

Bikeshed: freeze|thaw?

> synchronizing.
> 
> page_offline_freeze()/page_offline_unfreeze() allows for a subsystem to
> synchronize with such drivers, achieving that a page cannot be set
> PageOffline() while frozen.
> 
> page_offline_begin()/page_offline_end() is used by drivers that care about
> such races when setting a page PageOffline().
> 
> For simplicity, use a rwsem for now; neither drivers nor users are
> performance sensitive.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/page-flags.h |  5 +++++
>  mm/util.c                  | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b8c56672a588..e3d00c72f459 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -767,6 +767,11 @@ PAGE_TYPE_OPS(Buddy, buddy)
>   */
>  PAGE_TYPE_OPS(Offline, offline)
>  
> +extern void page_offline_freeze(void);
> +extern void page_offline_unfreeze(void);
> +extern void page_offline_begin(void);
> +extern void page_offline_end(void);
> +
>  /*
>   * Marks pages in use as page tables.
>   */
> diff --git a/mm/util.c b/mm/util.c
> index 54870226cea6..95395d4e4209 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1013,3 +1013,41 @@ void mem_dump_obj(void *object)
>  	}
>  	pr_cont(" non-slab/vmalloc memory.\n");
>  }
> +
> +/*
> + * A driver might set a page logically offline -- PageOffline() -- and
> + * turn the page inaccessible in the hypervisor; after that, access to page
> + * content can be fatal.
> + *
> + * Some special PFN walkers -- i.e., /proc/kcore -- read content of random
> + * pages after checking PageOffline(); however, these PFN walkers can race
> + * with drivers that set PageOffline().
> + *
> + * page_offline_freeze()/page_offline_unfreeze() allows for a subsystem to
> + * synchronize with such drivers, achieving that a page cannot be set
> + * PageOffline() while frozen.
> + *
> + * page_offline_begin()/page_offline_end() is used by drivers that care about
> + * such races when setting a page PageOffline().
> + */
> +static DECLARE_RWSEM(page_offline_rwsem);
> +
> +void page_offline_freeze(void)
> +{
> +	down_read(&page_offline_rwsem);
> +}
> +
> +void page_offline_unfreeze(void)
> +{
> +	up_read(&page_offline_rwsem);
> +}
> +
> +void page_offline_begin(void)
> +{
> +	down_write(&page_offline_rwsem);
> +}
> +
> +void page_offline_end(void)
> +{
> +	up_write(&page_offline_rwsem);
> +}
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
