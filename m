Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7793373C4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhEENZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 09:25:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:49522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231774AbhEENZT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 09:25:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620221062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aSIc/lDgtqLluSkN8lwArkLOvYYY16AGyEezAwvl+AY=;
        b=bvA4G+QBmgc3mkDjrCQOl7LWQXn8USiuFiw+pa8xnUItusUWADT+mFHhgCSn26vV+rBUU9
        pOYdePL4OmedwlIo4eFr4C8mcM/1rW/BXH2AEwTL500kavySpYOB3rV/L0nthKhb61seS/
        XCvo9Farq+XVMr9m+Zs/DULxlVV5QuQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF87CAE5E;
        Wed,  5 May 2021 13:24:21 +0000 (UTC)
Date:   Wed, 5 May 2021 15:24:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Roman Gushchin <guro@fb.com>,
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
Message-ID: <YJKcg06C3xE8fCfu@dhcp22.suse.cz>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429122519.15183-6-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-04-21 14:25:17, David Hildenbrand wrote:
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

Please add a note to the PageOffline documentation as well. While are
adding the api close enough an explicit note there wouldn't hurt.

> Signed-off-by: David Hildenbrand <david@redhat.com>

As to the patch itself, I am slightly worried that other pfn walkers
might be less tolerant to the locking than the proc ones. On the other
hand most users shouldn't really care as they do not tend to touch the
memory content and PageOffline check without any synchronization should
be sufficient for those. Let's try this out and see where we get...

Acked-by: Michal Hocko <mhocko@suse.com>

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
Michal Hocko
SUSE Labs
