Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC2362D0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 05:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhDQDGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 23:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbhDQDGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:06:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52561C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 20:05:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g35so20376010pgg.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 20:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHCf5UQTYn2bzHAIxxFwJe4NilZMkFnnQjfN/tw6leQ=;
        b=n61e/1KAdf1RUa9/A0vGa+G1R5yn3UvamgGM5vioyOhvsC7h+wCTixVZg86TS541WU
         R8TU5pXU9MUbvdyWRtl6C0GfJENOWgnBmUU2hmOHFrJ9h2szYfycj7o+MnjynclzZ44P
         06lQZSZ3mYaaJ4nkMRlaCm26Sf0szLIkBUKc1J5cy5PMUyz1Z9kwM6jRJoYXa5U5RobQ
         zblfP1FbMCdsUMHqjPwP3GWYp/dgh0UATncRfnzYtHaZTtSkX1rBJdSZlKfs0edGZ5qz
         vvtkA1Jqv0BKExSE4L/W/o00frQk83IxteUEyIN0IHmvryYeMNP4yxxYZsLUfrTpNeNi
         5cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHCf5UQTYn2bzHAIxxFwJe4NilZMkFnnQjfN/tw6leQ=;
        b=IVzfVbVPzffpKreBa32wGDmPvtn6gOQJFBKRG8XViNQo2ML7EVZrVJCH5dgH2fiLUK
         HyxkGhRe8Q5acHcSC0Ay16TaA+qZROv/93UN6NeqJPOaCbCW9B/5EdaZCzz2XE2l+3gt
         dCXtJPq8kTksjZEXg6/XnqstHZSVjJjstyeiGXaDjI3mG0cyIkRepPHhhbnV7e6Xj+y8
         o277khMjAzOuu5ATjO52UToa4TgWZNKwGGzBVxcvXUNZVfoVkplt6q1Bi+Slwbxh9LRi
         V2ncRdvEoE4SmPT8oKUM0+HP+InGIZ01j53/HE6FwSgmC41gxj4MI3ruVLUKOdeh+FLa
         Reig==
X-Gm-Message-State: AOAM532mx/SFzU3fPYEPF3VyC5vMjdGNHgaqwAsxA3e6CO7PDeK3ZAPZ
        TgokETdOC3yLY88mhr6CMRDhc24lOF+O4hE6Smg7TA==
X-Google-Smtp-Source: ABdhPJyK4BBGaD9t3gPFxc+8SqQhlSLgQglphmgvYni9MGpWj4MATlSNlLHKChZw1xf3C/bEh5cLKwFgEjMc0mQw4kc=
X-Received: by 2002:a63:1665:: with SMTP id 37mr1844976pgw.31.1618628742644;
 Fri, 16 Apr 2021 20:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210416160754.2944-1-peter.enderborg@sony.com>
In-Reply-To: <20210416160754.2944-1-peter.enderborg@sony.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 17 Apr 2021 11:05:06 +0800
Message-ID: <CAMZfGtWtUkP69v3NDy8=k1Ze1OriJ3TWeY9868TTdzbQ4LJ5AA@mail.gmail.com>
Subject: Re: [External] [PATCH v3] dma-buf: Add DmaBufTotal counter in meminfo
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 17, 2021 at 12:08 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> This adds a total used dma-buf memory. Details
> can be found in debugfs, however it is not for everyone
> and not always available. dma-buf are indirect allocated by
> userspace. So with this value we can monitor and detect
> userspace applications that have problems.

I want to know more details about the problems.
Can you share what problems you have encountered?

Thanks.

>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  drivers/dma-buf/dma-buf.c | 12 ++++++++++++
>  fs/proc/meminfo.c         |  5 ++++-
>  include/linux/dma-buf.h   |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f264b70c383e..d40fff2ae1fa 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -37,6 +37,7 @@ struct dma_buf_list {
>  };
>
>  static struct dma_buf_list db_list;
> +static atomic_long_t dma_buf_global_allocated;
>
>  static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
>  {
> @@ -79,6 +80,7 @@ static void dma_buf_release(struct dentry *dentry)
>         if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
>                 dma_resv_fini(dmabuf->resv);
>
> +       atomic_long_sub(dmabuf->size, &dma_buf_global_allocated);
>         module_put(dmabuf->owner);
>         kfree(dmabuf->name);
>         kfree(dmabuf);
> @@ -586,6 +588,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>         mutex_lock(&db_list.lock);
>         list_add(&dmabuf->list_node, &db_list.head);
>         mutex_unlock(&db_list.lock);
> +       atomic_long_add(dmabuf->size, &dma_buf_global_allocated);
>
>         return dmabuf;
>
> @@ -1346,6 +1349,15 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_vunmap);
>
> +/**
> + * dma_buf_get_size - Return the used nr pages by dma-buf
> + */
> +long dma_buf_allocated_pages(void)
> +{
> +       return atomic_long_read(&dma_buf_global_allocated) >> PAGE_SHIFT;
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_allocated_pages);

Why need "EXPORT_SYMBOL_GPL"?

> +
>  #ifdef CONFIG_DEBUG_FS
>  static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  {
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c9cc78..ccc7c40c8db7 100644
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
> @@ -145,7 +146,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>         show_val_kb(m, "CmaFree:        ",
>                     global_zone_page_state(NR_FREE_CMA_PAGES));
>  #endif
> -
> +#ifdef CONFIG_DMA_SHARED_BUFFER
> +       show_val_kb(m, "DmaBufTotal:    ", dma_buf_allocated_pages());
> +#endif
>         hugetlb_report_meminfo(m);
>
>         arch_report_meminfo(m);
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index efdc56b9d95f..5b05816bd2cd 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -507,4 +507,5 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
>                  unsigned long);
>  int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
>  void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
> +long dma_buf_allocated_pages(void);
>  #endif /* __DMA_BUF_H__ */
> --
> 2.17.1
>
