Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD281370A84
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 08:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhEBGex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 02:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhEBGex (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 02:34:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CC7261466;
        Sun,  2 May 2021 06:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937242;
        bh=sp3LzQWqlyVK4KqVpRuyYmKMW2WBVY2bQhDsFYs/JIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Odz+FaFlS7Sa3nPJIMJtdmYFisF2DcMTFwlRGMlogH6i4gHeAtklI1v2fhZIXTmyc
         VuFnMOOPLD0PaTc3cOr5bXpQNtPH/ZQNyUb4rcYRMsxlM5/W2AF+Lr3lixJnqxOjEr
         gyiSKc8Aa08xobgVpGpW+kh4o5BiUaPrz0nMUFCWJs13RkCGKFcE8LyYt9435lHrDS
         DSzMzzzjH8RcT0hk5E85ykiiri3zuPSy/c9m+xw7Eb039FWlr5GLmwcfDhdU5D/uFv
         1SoDcEE1lUM3Uf/+yRjzrpDZEmHbwWJlB6CCX7LZXOpMIm2v61B9HuchJWShkYQl55
         L8kISYHyIFR7g==
Date:   Sun, 2 May 2021 09:33:49 +0300
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
Subject: Re: [PATCH v1 6/7] virtio-mem: use page_offline_(start|end) when
 setting PageOffline()
Message-ID: <YI5HzXN7+ZTNXtcI@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429122519.15183-7-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:25:18PM +0200, David Hildenbrand wrote:
> Let's properly use page_offline_(start|end) to synchronize setting
> PageOffline(), so we won't have valid page access to unplugged memory
> regions from /proc/kcore.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 ++
>  mm/util.c                   | 2 ++
>  2 files changed, 4 insertions(+)
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

I'm not really familiar with ballooning and memory hotplug, but is it the
only place that needs page_offline_{begin,end} ?

>  }
>  
>  /*
> diff --git a/mm/util.c b/mm/util.c
> index 95395d4e4209..d0e357bd65e6 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1046,8 +1046,10 @@ void page_offline_begin(void)
>  {
>  	down_write(&page_offline_rwsem);
>  }
> +EXPORT_SYMBOL(page_offline_begin);

Should have been a part of the previous patch.
  
>  void page_offline_end(void)
>  {
>  	up_write(&page_offline_rwsem);
>  }
> +EXPORT_SYMBOL(page_offline_end);

Ditto

> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
