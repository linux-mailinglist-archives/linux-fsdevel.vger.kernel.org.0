Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06889371269
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhECIYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 04:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232959AbhECIYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 04:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620030235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bPRJDN7+PYmkwRc18YCW4pqF1oNECdl7EEdKg52HHCc=;
        b=fZOskuy4AziUojSmYmC8d9BYMWW0aNr5cQRHwhWwo9A0j4gHATn8awGPxiqiJ9s6HdDOEP
        eRUSpAM/yB//6wXWoyqIjtUcJSmCkeKCz63c6FM28v5OnnTzEfAZQR3AqhpcxjiIQqjhtS
        P4//sRoOoY7Kx0OJYWxf244IMCexSiw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Om1Kx7gMOEO-CzY_P7baTw-1; Mon, 03 May 2021 04:23:52 -0400
X-MC-Unique: Om1Kx7gMOEO-CzY_P7baTw-1
Received: by mail-wr1-f70.google.com with SMTP id x10-20020adfc18a0000b029010d83c83f2aso3486290wre.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 01:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bPRJDN7+PYmkwRc18YCW4pqF1oNECdl7EEdKg52HHCc=;
        b=kMlEblwE0We7lGKXdQ6NNtf3Q6Vh7xiUR5TixPlme7x4XD6iz72Wu2iyQd3atYYnCb
         7xVGnQ69CLTIH0dQhsKfo+pvaEpjucxd/cKhFJpqNYCNrqt5ElhBnVxNJGPPA0OiO29e
         7PMCtW13uHRv2WaFu/6yUDWkirNoi/BHO/iHa2Y/ScPlaGVNUZjOjYCv6ILcmY4KcAf1
         Hun7gpYe0Y3N0cSsoBkeXSvO++6JPB33zoizO0Vg9Tnx80dg+zWVW60rAsFcZi2+vmbG
         C2puszrM3CmStd2sF8zcHsjTKEN5B2ohY6huMd5wvc2rP5Q/KgtE3d+vSx5nJ/xAxthD
         e4TA==
X-Gm-Message-State: AOAM5337ZQTCRrLXpPaWq5gmuC2QpxndK6tmXaYmAvIz1WrDbIos7DAe
        fS1FJqKmui7bPXcjrJhz2XzU4dsNlQ1Y5ak94k92E/7s1MS6uEommz+MfdVBOMPCvC7D6lThOKh
        G4XtVtRUCNa2R7KPLaGSTkgU1Hw==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr23619886wri.237.1620030231115;
        Mon, 03 May 2021 01:23:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziGxRW4ZxIY4FY2qg1KRAZv5We9hL1OQjj2LLIG4bdcedtb0gAbjIZDrDWQnD40SLdnCFbag==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr23619863wri.237.1620030230987;
        Mon, 03 May 2021 01:23:50 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
        by smtp.gmail.com with ESMTPSA id n22sm8177060wmo.12.2021.05.03.01.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 01:23:50 -0700 (PDT)
Date:   Mon, 3 May 2021 04:23:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
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
Message-ID: <20210503042220-mutt-send-email-mst@kernel.org>
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


the patch looks good to me as such

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge with rest of patcgset - it seems to mostly
live in the fs/mm space.

IF you respin, maybe add the explanation you sent in response to Mike's comments
in the commit log.


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
>  
>  void page_offline_end(void)
>  {
>  	up_write(&page_offline_rwsem);
>  }
> +EXPORT_SYMBOL(page_offline_end);
> -- 
> 2.30.2

