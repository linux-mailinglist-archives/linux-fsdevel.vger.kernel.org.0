Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C10382496
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 08:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhEQGoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 02:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhEQGoh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 02:44:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06B8860C40;
        Mon, 17 May 2021 06:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621233801;
        bh=Auni3LFhqjW6BQy2QyQlRuaS4YtCakNMfUyiz2ozvTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dznbhxtN4oNAsEmlJLL+kv6OEZRZElm7Ww7seTYYHSYjSPymeyi0d1vvtHuYd1T7Z
         1uckVK7Kd6/b4OVdm45oH4GDKxIzIgzIqA6FD0OPbOVOqX2N5gON+bMliI+Zr/m10W
         nTBJzEAr/xTvZppZuRWf7i9YoMVxRMvnb02Y8sMIvBd7DOgEuV94HcesLCOZwBe5ta
         5g4J0t+VESbo5ZrdFyLF57F2ooLlydHb3cxm3FpdLJFey0oEKsB8pGqQiu9ZV0Kppl
         hDvc31B3TgvcA2jLUyJRaxb85Ii92pev5BZYdW36wAeknUQr0Wiykel0L+VaRO4xZp
         U8VWF+3NL+SkQ==
Date:   Mon, 17 May 2021 09:43:08 +0300
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
Subject: Re: [PATCH v2 4/6] mm: introduce
 page_offline_(begin|end|freeze|thaw) to synchronize setting PageOffline()
Message-ID: <YKIQfCjq13dSMHOs@kernel.org>
References: <20210514172247.176750-1-david@redhat.com>
 <20210514172247.176750-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514172247.176750-5-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 07:22:45PM +0200, David Hildenbrand wrote:
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
> Let's introduce page_offline_(begin|end|freeze|thaw) for
> synchronizing.
> 
> page_offline_freeze()/page_offline_thaw() allows for a subsystem to
> synchronize with such drivers, achieving that a page cannot be set
> PageOffline() while frozen.
> 
> page_offline_begin()/page_offline_end() is used by drivers that care about
> such races when setting a page PageOffline().
> 
> For simplicity, use a rwsem for now; neither drivers nor users are
> performance sensitive.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

One nit below, otherwise

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/page-flags.h | 10 ++++++++++
>  mm/util.c                  | 40 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index daed82744f4b..ea2df9a247b3 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -769,9 +769,19 @@ PAGE_TYPE_OPS(Buddy, buddy)
>   * relies on this feature is aware that re-onlining the memory block will
>   * require to re-set the pages PageOffline() and not giving them to the
>   * buddy via online_page_callback_t.
> + *
> + * There are drivers that mark a page PageOffline() and do not expect any

Maybe "and expect there won't be any further access"...

> + * further access to page content. PFN walkers that read content of random
> + * pages should check PageOffline() and synchronize with such drivers using
> + * page_offline_freeze()/page_offline_thaw().
>   */
>  PAGE_TYPE_OPS(Offline, offline)
>  
> +extern void page_offline_freeze(void);
> +extern void page_offline_thaw(void);
> +extern void page_offline_begin(void);
> +extern void page_offline_end(void);
> +
>  /*
>   * Marks pages in use as page tables.
>   */
> diff --git a/mm/util.c b/mm/util.c
> index a8bf17f18a81..a034525e7ba2 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1010,3 +1010,43 @@ void mem_dump_obj(void *object)
>  }
>  EXPORT_SYMBOL_GPL(mem_dump_obj);
>  #endif
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
> + * page_offline_freeze()/page_offline_thaw() allows for a subsystem to
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
> +void page_offline_thaw(void)
> +{
> +	up_read(&page_offline_rwsem);
> +}
> +
> +void page_offline_begin(void)
> +{
> +	down_write(&page_offline_rwsem);
> +}
> +EXPORT_SYMBOL(page_offline_begin);
> +
> +void page_offline_end(void)
> +{
> +	up_write(&page_offline_rwsem);
> +}
> +EXPORT_SYMBOL(page_offline_end);
> -- 
> 2.31.1
> 

-- 
Sincerely yours,
Mike.
