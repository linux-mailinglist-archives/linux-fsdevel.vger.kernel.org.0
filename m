Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830CD361E71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 13:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhDPLJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 07:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhDPLJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:09:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC5C061574;
        Fri, 16 Apr 2021 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wricDXbRsfuITNqF2TYSCApfJgf/TrNtRqhvMhFAZJs=; b=Y26Meg6YAb9XQNiI4oEZ9AFQuy
        wWYeKyW7C8HS2jwil4L54VgZ33G3sI1oaIR7z8ndqNXOo2388OcOr6TTZCjNFkcJ2m+ytYNdxpb7E
        YwQgab6tdRx2Q02tudGG62J7NUz4fzFm+2Q2OMzUhiGofWME4QtAVudHl3QpPG4jClPZLPzaLSAqE
        bhVhHnQDYbGu1sqBqxrgJxy4Dr0zOOPeosynVnO0Uj33kcCQ3tyg91sUGnlxgg1z1CudTO/kri5LE
        h/etKdNOg4QTmPIhRJyi/XN5u7l0YvkwsvkMAp86iH2jLCcYgrldJnXbqQnev78jJOiDvmCBIIh0X
        zb00LSVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXMLY-009rOM-P1; Fri, 16 Apr 2021 11:09:13 +0000
Date:   Fri, 16 Apr 2021 12:09:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <20210416110912.GI2531743@casper.infradead.org>
References: <20210416093719.6197-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416093719.6197-1-peter.enderborg@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:37:19AM +0200, Peter Enderborg wrote:
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c9cc78..3c1a82b51a6f 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -16,6 +16,7 @@
>  #ifdef CONFIG_CMA
>  #include <linux/cma.h>
>  #endif
> +#include <linux/dma-buf.h>
>  #include <asm/page.h>
>  #include "internal.h"
>  
> @@ -145,6 +146,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "CmaFree:        ",
>  		    global_zone_page_state(NR_FREE_CMA_PAGES));
>  #endif
> +	show_val_kb(m, "DmaBufTotal:    ", dma_buf_get_size());
>  
>  	hugetlb_report_meminfo(m);
>  

... and if CONFIG_DMA_SHARED_BUFFER is not set ...?
