Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C635E2BB217
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 19:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgKTSHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 13:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgKTSHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:07:24 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA491C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 10:07:23 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f15so4252468qto.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qzxXYsRioiP+WS2W7+JqANiIkJuxsiB0XH0K0d6+qtg=;
        b=kVX4x5fpgWWco5Ty/z9+LAK78NhaMagv/tDBnm6DUUeCWaj1HGUIBbp2aJhNnNEDUX
         3IMNQ6fbdY/PqyJeGpV5XT5MgmuXF/v6yWfNDjhcSQMDpwtr4+hJbu4qzdlNIbE032j8
         N6WJP4W+ttGh8C6hBS0bHnuTG8JeA6PqV00NQ1bEloyaSOSySEoGweqsuBTnHZ5oOVe5
         XKsn1y3u4gVoVT0r8VMZFNv/f6Pn/mmX1yQCnK2oUwYxk5go3vzZ3Bk/GbZSg3FiOcOx
         72YuC+2VxZ6koXFYbos9ZFiX1/r83F90VF+cOVa4au/lfdem40sM6v1eigLfygQrHcDA
         NXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qzxXYsRioiP+WS2W7+JqANiIkJuxsiB0XH0K0d6+qtg=;
        b=k3rBKl21ytEutWZEpZWwwJPh6XtdvnR6oorUIkUcXPq1Dmc2f/sp4ZonlM2b3o5gs2
         bcZLpFq5ODEpxGg66VxoPBdORr7CEGcGjTPou4HjAm7FVm4+FBVft0l3eBSJ8gbA6Sbf
         UXqC6KvfMGE7GmalU9X45dRxlSYqb3+ymv4TTIQnGnrCQzhycZNy/zMV7IQLCVSpDt1N
         SGSNJB7koJmE9eNLBZQNvisFtq6yserPeWLVaR9Om/wJII8O7m+vWibYnFoEkyJzwEm3
         0eVOS2yeUF4nB02zDP3RqAK4HC2mI52xs3fJgABdd/j355YXokmcYLeAP3pXW5LWNxni
         TrTg==
X-Gm-Message-State: AOAM531CzLwgZuqnKxP+PJW2w35+jAx9Pe6jiwDb+tntkVYLkyv8+Yxy
        lvJdmNtc3I8/f9qRQU5Gw+wkVHX7HsbHYDGF
X-Google-Smtp-Source: ABdhPJz17n7O3IQoUnG1lr3Y+t6u4VkEghZe6VwPVl7Std3Wem+S+IGdLYrv/xtqRZWsm/mbwrw9gw==
X-Received: by 2002:ac8:6a16:: with SMTP id t22mr16861888qtr.304.1605895641688;
        Fri, 20 Nov 2020 10:07:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q15sm2444862qki.13.2020.11.20.10.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 10:07:20 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kgAoZ-008uHM-Rm; Fri, 20 Nov 2020 14:07:19 -0400
Date:   Fri, 20 Nov 2020 14:07:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michel Lespinasse <walken@google.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Qian Cai <cai@lca.pw>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/3] mm: Extract might_alloc() debug check
Message-ID: <20201120180719.GO244516@ziepe.ca>
References: <20201120095445.1195585-1-daniel.vetter@ffwll.ch>
 <20201120095445.1195585-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120095445.1195585-3-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:54:43AM +0100, Daniel Vetter wrote:
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index d5ece7a9a403..f94405d43fd1 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -180,6 +180,22 @@ static inline void fs_reclaim_acquire(gfp_t gfp_mask) { }
>  static inline void fs_reclaim_release(gfp_t gfp_mask) { }
>  #endif
>  
> +/**
> + * might_alloc - Marks possible allocation sites
> + * @gfp_mask: gfp_t flags that would be use to allocate
> + *
> + * Similar to might_sleep() and other annotations this can be used in functions
> + * that might allocate, but often dont. Compiles to nothing without
> + * CONFIG_LOCKDEP. Includes a conditional might_sleep() if @gfp allows blocking.
> + */
> +static inline void might_alloc(gfp_t gfp_mask)
> +{
> +	fs_reclaim_acquire(gfp_mask);
> +	fs_reclaim_release(gfp_mask);
> +
> +	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
> +}

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Oh, I just had a another thread with Matt about xarray, this would be
perfect to add before xas_nomem():

diff --git a/lib/idr.c b/lib/idr.c
index f4ab4f4aa3c7f5..722d9ddff53221 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -391,6 +391,8 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 	if ((int)max < 0)
 		max = INT_MAX;
 
+	might_alloc(gfp);
+
 retry:
 	xas_lock_irqsave(&xas, flags);
 next:
diff --git a/lib/xarray.c b/lib/xarray.c
index 5fa51614802ada..dd260ee7dcae9a 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1534,6 +1534,8 @@ void *__xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 	XA_STATE(xas, xa, index);
 	void *curr;
 
+	might_alloc(gfp);
+
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return XA_ERROR(-EINVAL);
 	if (xa_track_free(xa) && !entry)
@@ -1600,6 +1602,8 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
 	XA_STATE(xas, xa, index);
 	void *curr;
 
+	might_alloc(gfp);
+
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return XA_ERROR(-EINVAL);
 
@@ -1637,6 +1641,8 @@ int __xa_insert(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 	XA_STATE(xas, xa, index);
 	void *curr;
 
+	might_alloc(gfp);
+
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return -EINVAL;
 	if (!entry)
@@ -1806,6 +1812,8 @@ int __xa_alloc(struct xarray *xa, u32 *id, void *entry,
 {
 	XA_STATE(xas, xa, 0);
 
+	might_alloc(gfp);
+
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return -EINVAL;
 	if (WARN_ON_ONCE(!xa_track_free(xa)))
