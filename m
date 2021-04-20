Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF1936559F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 11:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhDTJmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 05:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhDTJmY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:42:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BECBB610A1;
        Tue, 20 Apr 2021 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618911713;
        bh=Un7yeElEVIiqeGbXSh4qF0s7poSaThN9A0qIRjII9EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccb3aIcShAtpQ1+dsYpH8kdgCeXxaAxKBoeXCpxSwnZwfSpb9sySHQCBFd98lmhm5
         3jlS2a4hksP9dXywhk1Uaf1FQyWT/6hPyFqgFOrjpj4M3MB3kfmiFwBMXZZsrDPJNJ
         IWDmncrJ2X4DvFBvoMkBhhHWwDWCRNlwkZHkVYWBUYXfVJjfgoavuUuJ2/g66OhySt
         dunjEpf8/TZPONQcGJRsU3Z+Gmajnml3UZd9ywTZGwce6Tx2ML96hMHTdEkwYKV/fe
         zq+RLOYdQ18onjmVODdXYGLMB8F04PTkBumblC5NNN3Qfx6hLB7xBsUMHCX8wCxfPo
         QGplo/Mad3MOw==
Date:   Tue, 20 Apr 2021 12:41:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Peter.Enderborg@sony.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        mhocko@suse.com, neilb@suse.de, samitolvanen@google.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, willy@infradead.org
Subject: Re: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <YH6h16hviixphaHV@kernel.org>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
 <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Peter,

On Tue, Apr 20, 2021 at 09:26:00AM +0000, Peter.Enderborg@sony.com wrote:
> On 4/20/21 10:58 AM, Daniel Vetter wrote:
> > On Sat, Apr 17, 2021 at 06:38:35PM +0200, Peter Enderborg wrote:
> >> This adds a total used dma-buf memory. Details
> >> can be found in debugfs, however it is not for everyone
> >> and not always available. dma-buf are indirect allocated by
> >> userspace. So with this value we can monitor and detect
> >> userspace applications that have problems.
> >>
> >> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> > So there have been tons of discussions around how to track dma-buf and
> > why, and I really need to understand the use-cass here first I think. proc
> > uapi is as much forever as anything else, and depending what you're doing
> > this doesn't make any sense at all:
> >
> > - on most linux systems dma-buf are only instantiated for shared buffer.
> >   So there this gives you a fairly meaningless number and not anything
> >   reflecting gpu memory usage at all.
> >
> > - on Android all buffers are allocated through dma-buf afaik. But there
> >   we've recently had some discussions about how exactly we should track
> >   all this, and the conclusion was that most of this should be solved by
> >   cgroups long term. So if this is for Android, then I don't think adding
> >   random quick stop-gaps to upstream is a good idea (because it's a pretty
> >   long list of patches that have come up on this).
> >
> > So what is this for?
> 
> For the overview. dma-buf today only have debugfs for info. Debugfs
> is not allowed by google to use in andoid. So this aggregate the information
> so we can get information on what going on on the system. 
 
Can you send an example debugfs output to see what data are we talking
about?

> And the LKML standard respond to that is "SHOW ME THE CODE".
> 
> When the top memgc has a aggregated information on dma-buf it is maybe
> a better source to meminfo. But then it also imply that dma-buf requires memcg.
> 
> And I dont see any problem to replace this with something better with it is ready.

Well, the problem with replacing the counter in /proc/meminfo is that it
requires all users of /proc/meminfo to adapt to the changes.

That's why it's way less painful to go an extra mile and define (hopefully)
stable user ABI up front.

Why can't you use fdinfo to show how much memory consumed by a dma-buf?

> > -Daniel
> >
> >> ---
> >>  drivers/dma-buf/dma-buf.c | 12 ++++++++++++
> >>  fs/proc/meminfo.c         |  5 ++++-
> >>  include/linux/dma-buf.h   |  1 +
> >>  3 files changed, 17 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> >> index f264b70c383e..4dc37cd4293b 100644
> >> --- a/drivers/dma-buf/dma-buf.c
> >> +++ b/drivers/dma-buf/dma-buf.c
> >> @@ -37,6 +37,7 @@ struct dma_buf_list {
> >>  };
> >>  
> >>  static struct dma_buf_list db_list;
> >> +static atomic_long_t dma_buf_global_allocated;
> >>  
> >>  static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
> >>  {
> >> @@ -79,6 +80,7 @@ static void dma_buf_release(struct dentry *dentry)
> >>  	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
> >>  		dma_resv_fini(dmabuf->resv);
> >>  
> >> +	atomic_long_sub(dmabuf->size, &dma_buf_global_allocated);
> >>  	module_put(dmabuf->owner);
> >>  	kfree(dmabuf->name);
> >>  	kfree(dmabuf);
> >> @@ -586,6 +588,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
> >>  	mutex_lock(&db_list.lock);
> >>  	list_add(&dmabuf->list_node, &db_list.head);
> >>  	mutex_unlock(&db_list.lock);
> >> +	atomic_long_add(dmabuf->size, &dma_buf_global_allocated);
> >>  
> >>  	return dmabuf;
> >>  
> >> @@ -1346,6 +1349,15 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
> >>  }
> >>  EXPORT_SYMBOL_GPL(dma_buf_vunmap);
> >>  
> >> +/**
> >> + * dma_buf_allocated_pages - Return the used nr of pages
> >> + * allocated for dma-buf
> >> + */
> >> +long dma_buf_allocated_pages(void)
> >> +{
> >> +	return atomic_long_read(&dma_buf_global_allocated) >> PAGE_SHIFT;
> >> +}
> >> +
> >>  #ifdef CONFIG_DEBUG_FS
> >>  static int dma_buf_debug_show(struct seq_file *s, void *unused)
> >>  {
> >> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> >> index 6fa761c9cc78..ccc7c40c8db7 100644
> >> --- a/fs/proc/meminfo.c
> >> +++ b/fs/proc/meminfo.c
> >> @@ -16,6 +16,7 @@
> >>  #ifdef CONFIG_CMA
> >>  #include <linux/cma.h>
> >>  #endif
> >> +#include <linux/dma-buf.h>
> >>  #include <asm/page.h>
> >>  #include "internal.h"
> >>  
> >> @@ -145,7 +146,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >>  	show_val_kb(m, "CmaFree:        ",
> >>  		    global_zone_page_state(NR_FREE_CMA_PAGES));
> >>  #endif
> >> -
> >> +#ifdef CONFIG_DMA_SHARED_BUFFER
> >> +	show_val_kb(m, "DmaBufTotal:    ", dma_buf_allocated_pages());
> >> +#endif
> >>  	hugetlb_report_meminfo(m);
> >>  
> >>  	arch_report_meminfo(m);
> >> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> >> index efdc56b9d95f..5b05816bd2cd 100644
> >> --- a/include/linux/dma-buf.h
> >> +++ b/include/linux/dma-buf.h
> >> @@ -507,4 +507,5 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
> >>  		 unsigned long);
> >>  int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
> >>  void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
> >> +long dma_buf_allocated_pages(void);
> >>  #endif /* __DMA_BUF_H__ */
> >> -- 
> >> 2.17.1
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://urldefense.com/v3/__https://lists.freedesktop.org/mailman/listinfo/dri-devel__;!!JmoZiZGBv3RvKRSx!qW8kUOZyY4Dkew6OvqgfoM-5unQNVeF_M1biaIAyQQBR0KB7ksRzZjoh382ZdGGQR9k$ 
> 

-- 
Sincerely yours,
Mike.
