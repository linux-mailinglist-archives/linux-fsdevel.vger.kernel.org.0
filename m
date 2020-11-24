Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A684D2C29BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 15:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbgKXOeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 09:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388854AbgKXOeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:34:16 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF08C061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 06:34:15 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so3498381wrs.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 06:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YQpCas1RNfDZEcGYI04yEm6odPOACipDcEuTBaoIULk=;
        b=UhV7hB9LJySyibtoHRqaxMir8P7FnhXAU96E4aHd3ofIMEZCRtLh+zeMX/RZH2wp/d
         ASfb7zsWToxZhdhECdglvYGnSj/gHkK+a128+ByWw8EqQuvRvEHVa/6FGH0Q/PMdeY8p
         cOVbuuXQq/r/33GWKbTOqEjjjzE0whLpLoOC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YQpCas1RNfDZEcGYI04yEm6odPOACipDcEuTBaoIULk=;
        b=F32xo09kDZiKJCifqA/fkDQPLSWrLHl+THXXeTCA4aLk8B0CCSOWKa3pynRBBtsFlj
         26u3QwSnF3ejex3GW8GpddnEP6hVcEiEFRirFvxlo/TRsVHxpm1MCGORPH1yPZfY+Hn8
         4PeKh5IH2cgSHuaD2n1yFEy10P9sPK3QwlxHNB/Ir+IxoBx61Vl/ZTKGi60fbuaNXZiI
         1+Y3DYSQXkgsNkoHD3wXm+g+lFeOLSMbr0XCBVCtTZsprpKhB+GXZPp7AEmjd88AYUWl
         pXlel2lw5zZVJzTdPNgPJvELhFZFCmTwrtuLdYTZ1ywrvOJhFOf3mJCVZBEavGXyvdeh
         2z9g==
X-Gm-Message-State: AOAM531ka+qjT2lmgjHmWDjmUzlyLk8GhQkENtMYCuHLDshm37WCs+Rx
        c/ui+XR7/vzfO+z4hwICg6TYcg==
X-Google-Smtp-Source: ABdhPJz6iTrOgvt95IAsr45xzCdl3M2C2ca0X4EFZPlX+gugzV3LnRN6/oGeySsazf01z6hbldI7qw==
X-Received: by 2002:a5d:50d1:: with SMTP id f17mr5715898wrt.264.1606228454425;
        Tue, 24 Nov 2020 06:34:14 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m18sm27135410wru.37.2020.11.24.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 06:34:13 -0800 (PST)
Date:   Tue, 24 Nov 2020 15:34:11 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
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
Message-ID: <20201124143411.GN401619@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
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
References: <20201120095445.1195585-1-daniel.vetter@ffwll.ch>
 <20201120095445.1195585-3-daniel.vetter@ffwll.ch>
 <20201120180719.GO244516@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120180719.GO244516@ziepe.ca>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:07:19PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 20, 2020 at 10:54:43AM +0100, Daniel Vetter wrote:
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index d5ece7a9a403..f94405d43fd1 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -180,6 +180,22 @@ static inline void fs_reclaim_acquire(gfp_t gfp_mask) { }
> >  static inline void fs_reclaim_release(gfp_t gfp_mask) { }
> >  #endif
> >  
> > +/**
> > + * might_alloc - Marks possible allocation sites
> > + * @gfp_mask: gfp_t flags that would be use to allocate
> > + *
> > + * Similar to might_sleep() and other annotations this can be used in functions
> > + * that might allocate, but often dont. Compiles to nothing without
> > + * CONFIG_LOCKDEP. Includes a conditional might_sleep() if @gfp allows blocking.
> > + */
> > +static inline void might_alloc(gfp_t gfp_mask)
> > +{
> > +	fs_reclaim_acquire(gfp_mask);
> > +	fs_reclaim_release(gfp_mask);
> > +
> > +	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
> > +}
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Oh, I just had a another thread with Matt about xarray, this would be
> perfect to add before xas_nomem():

Yeah I think there's plenty of places where this will be useful. Want to
slap a sob onto this diff so I can include it for the next round, or will
you or Matt send this out when my might_alloc has landed?
-Daniel

> 
> diff --git a/lib/idr.c b/lib/idr.c
> index f4ab4f4aa3c7f5..722d9ddff53221 100644
> --- a/lib/idr.c
> +++ b/lib/idr.c
> @@ -391,6 +391,8 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
>  	if ((int)max < 0)
>  		max = INT_MAX;
>  
> +	might_alloc(gfp);
> +
>  retry:
>  	xas_lock_irqsave(&xas, flags);
>  next:
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 5fa51614802ada..dd260ee7dcae9a 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1534,6 +1534,8 @@ void *__xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
>  	XA_STATE(xas, xa, index);
>  	void *curr;
>  
> +	might_alloc(gfp);
> +
>  	if (WARN_ON_ONCE(xa_is_advanced(entry)))
>  		return XA_ERROR(-EINVAL);
>  	if (xa_track_free(xa) && !entry)
> @@ -1600,6 +1602,8 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
>  	XA_STATE(xas, xa, index);
>  	void *curr;
>  
> +	might_alloc(gfp);
> +
>  	if (WARN_ON_ONCE(xa_is_advanced(entry)))
>  		return XA_ERROR(-EINVAL);
>  
> @@ -1637,6 +1641,8 @@ int __xa_insert(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
>  	XA_STATE(xas, xa, index);
>  	void *curr;
>  
> +	might_alloc(gfp);
> +
>  	if (WARN_ON_ONCE(xa_is_advanced(entry)))
>  		return -EINVAL;
>  	if (!entry)
> @@ -1806,6 +1812,8 @@ int __xa_alloc(struct xarray *xa, u32 *id, void *entry,
>  {
>  	XA_STATE(xas, xa, 0);
>  
> +	might_alloc(gfp);
> +
>  	if (WARN_ON_ONCE(xa_is_advanced(entry)))
>  		return -EINVAL;
>  	if (WARN_ON_ONCE(!xa_track_free(xa)))

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
