Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27DD370A7E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 08:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhEBGds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 02:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhEBGds (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 02:33:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 584A561466;
        Sun,  2 May 2021 06:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937177;
        bh=AamYV1zarM8XROObHow2GS9jtvK08e2YVaUvh7HsmvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfsCipSZ7Oat5Tih3ZX2Yr+KpqdTvvfdz3DnLfEWTQ+gdClichLYDIqAOtHuQ2ui/
         Qm+PFOgyT8fEktmjbMUHa7UsJRxbTIUzMy7lJUA3ncrBKcZXW2P09S2aEMI6JXVt85
         U7q5MJ5XHq2LtHOIQLvXIHTNPzFrUN+cIRZGdSiWyumhz5ZYq5ubze/C9xO8DIYOaU
         m9LVPv64fB7BQTYpJAZetDfAwBE5jznlNPm2E/4eCwILYszSpc6Fu7OIXd0hQDttLE
         3yhzXWA7/Js/s9lT31k/6SVQNDlkRE4KDsF13L9LBfRG6tXxZ0KQUbFVVe/hirZA6t
         aFCUY99Y42pqA==
Date:   Sun, 2 May 2021 09:32:46 +0300
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
Subject: Re: [PATCH v1 4/7] fs/proc/kcore: don't read offline sections,
 logically offline pages and hwpoisoned pages
Message-ID: <YI5HjmpTMjDVM/4h@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429122519.15183-5-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:25:16PM +0200, David Hildenbrand wrote:
> Let's avoid reading:
> 
> 1) Offline memory sections: the content of offline memory sections is stale
>    as the memory is effectively unused by the kernel. On s390x with standby
>    memory, offline memory sections (belonging to offline storage
>    increments) are not accessible. With virtio-mem and the hyper-v balloon,
>    we can have unavailable memory chunks that should not be accessed inside
>    offline memory sections. Last but not least, offline memory sections
>    might contain hwpoisoned pages which we can no longer identify
>    because the memmap is stale.
> 
> 2) PG_offline pages: logically offline pages that are documented as
>    "The content of these pages is effectively stale. Such pages should not
>     be touched (read/write/dump/save) except by their owner.".
>    Examples include pages inflated in a balloon or unavailble memory
>    ranges inside hotplugged memory sections with virtio-mem or the hyper-v
>    balloon.
> 
> 3) PG_hwpoison pages: Reading pages marked as hwpoisoned can be fatal.
>    As documented: "Accessing is not safe since it may cause another machine
>    check. Don't touch!"
> 
> Reading /proc/kcore now performs similar checks as when reading
> /proc/vmcore for kdump via makedumpfile: problematic pages are exclude.
> It's also similar to hibernation code, however, we don't skip hwpoisoned
> pages when processing pages in kernel/power/snapshot.c:saveable_page() yet.
> 
> Note 1: we can race against memory offlining code, especially
> memory going offline and getting unplugged: however, we will properly tear
> down the identity mapping and handle faults gracefully when accessing
> this memory from kcore code.
> 
> Note 2: we can race against drivers setting PageOffline() and turning
> memory inaccessible in the hypervisor. We'll handle this in a follow-up
> patch.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  fs/proc/kcore.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index ed6fbb3bd50c..92ff1e4436cb 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -465,6 +465,9 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  
>  	m = NULL;
>  	while (buflen) {
> +		struct page *page;
> +		unsigned long pfn;
> +
>  		/*
>  		 * If this is the first iteration or the address is not within
>  		 * the previous entry, search for a matching entry.
> @@ -503,7 +506,16 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  			}
>  			break;
>  		case KCORE_RAM:
> -			if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
> +			pfn = __pa(start) >> PAGE_SHIFT;
> +			page = pfn_to_online_page(pfn);
> +
> +			/*
> +			 * Don't read offline sections, logically offline pages
> +			 * (e.g., inflated in a balloon), hwpoisoned pages,
> +			 * and explicitly excluded physical ranges.
> +			 */
> +			if (!page || PageOffline(page) ||
> +			    is_page_hwpoison(page) || !pfn_is_ram(pfn)) {
>  				if (clear_user(buffer, tsz)) {
>  					ret = -EFAULT;
>  					goto out;
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
