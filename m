Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD0351016
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 09:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhDAHag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 03:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhDAHa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:30:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA21C06178A
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 00:30:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c204so802861pfc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=43NDXGgfotmd8T021xD/PzKrOkjvp9eU15TIWjuTS6Q=;
        b=T9iei2az1OzZPGs33+INYA6qjEddSZl9tKJhi1hESi0WIplLaJgW+ZEPKXy6x+ZIo+
         1f4ny5Hn1h7zTJsFFONy31149OM5jFoHqwnwlxZDw4tM8ASrDgyQ/KKcUgpv0+iku9kc
         Ru/zk+iH34T6x/4CJt2Gi2PjDS0NEw+r+H+ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=43NDXGgfotmd8T021xD/PzKrOkjvp9eU15TIWjuTS6Q=;
        b=cY9hHgTPkjaT8xk0iXMqcwz0gizh/j1Ktty3b6SiXDebcPT8T3sHyZGht63sjrM3pJ
         YHOsOSrkG+r1xWzxyQ8S5Nb2Nz4kqY6EzUAjIrHjKRMA6e/hz4j4LeE819OMNH6EsKWe
         Jx/lqOyuDB/mqm2S+LMUeEwJL3wucT1cC/Xzzix7NmVPvxBiHhhGGX3GZShy2rJVuqX8
         URUmjE5wHwBdx2yGAaUjdi+0gmMeL+vDIhymcT18D8lnS0kpxNEy8JR/E1bkbkg1piBu
         o+uzD6rFx2Q3/xL93xgIAxfP0HlllNkk+W7+cenn/492yUTCGK0DqrbLpkAOIR7EjgN2
         i/xQ==
X-Gm-Message-State: AOAM530u6jSgw8w1qMHn6W0eVDbkfG2CIaoyzGT/tdLB0DD0PqhCDL9F
        RURhet15Cqp0hDhg+4Bz8lV41XH+RNghLg==
X-Google-Smtp-Source: ABdhPJwOph9440oECFc16IlP9JvBFBtO6iz26JSpoM4SC7KHyxWIdK25RwtNSKbz1sSwmp7HkcBmrA==
X-Received: by 2002:a63:ee04:: with SMTP id e4mr6351016pgi.446.1617262225974;
        Thu, 01 Apr 2021 00:30:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q25sm4149183pfh.34.2021.04.01.00.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 00:30:25 -0700 (PDT)
Date:   Thu, 1 Apr 2021 00:30:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sysfs: Unconditionally use vmalloc for buffer
Message-ID: <202104010022.5E7FB3069@keescook>
References: <20210401022145.2019422-1-keescook@chromium.org>
 <YGVXSFMlvX4RQI8n@kroah.com>
 <202103312335.25EA9650@keescook>
 <YGVxzSH8fV9MwBDM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGVxzSH8fV9MwBDM@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 09:10:05AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Mar 31, 2021 at 11:52:20PM -0700, Kees Cook wrote:
> > On Thu, Apr 01, 2021 at 07:16:56AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Mar 31, 2021 at 07:21:45PM -0700, Kees Cook wrote:
> > > > The sysfs interface to seq_file continues to be rather fragile
> > > > (seq_get_buf() should not be used outside of seq_file), as seen with
> > > > some recent exploits[1]. Move the seq_file buffer to the vmap area
> > > > (while retaining the accounting flag), since it has guard pages that
> > > > will catch and stop linear overflows. This seems justified given that
> > > > sysfs's use of seq_file already uses kvmalloc(), is almost always using
> > > > a PAGE_SIZE or larger allocation, has normally short-lived allocations,
> > > > and is not normally on a performance critical path.
> > > > 
> > > > Once seq_get_buf() has been removed (and all sysfs callbacks using
> > > > seq_file directly), this change can also be removed.
> > > > 
> > > > [1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html
> > > > 
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > > v3:
> > > > - Limit to only sysfs (instead of all of seq_file).
> > > > v2: https://lore.kernel.org/lkml/20210315174851.622228-1-keescook@chromium.org/
> > > > v1: https://lore.kernel.org/lkml/20210312205558.2947488-1-keescook@chromium.org/
> > > > ---
> > > >  fs/sysfs/file.c | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > > 
> > > > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > > > index 9aefa7779b29..70e7a450e5d1 100644
> > > > --- a/fs/sysfs/file.c
> > > > +++ b/fs/sysfs/file.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/seq_file.h>
> > > >  #include <linux/mm.h>
> > > > +#include <linux/vmalloc.h>
> > > >  
> > > >  #include "sysfs.h"
> > > >  
> > > > @@ -32,6 +33,25 @@ static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
> > > >  	return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
> > > >  }
> > > >  
> > > > +/*
> > > > + * To be proactively defensive against sysfs show() handlers that do not
> > > > + * correctly stay within their PAGE_SIZE buffer, use the vmap area to gain
> > > > + * the trailing guard page which will stop linear buffer overflows.
> > > > + */
> > > > +static void *sysfs_kf_seq_start(struct seq_file *sf, loff_t *ppos)
> > > > +{
> > > > +	struct kernfs_open_file *of = sf->private;
> > > > +	struct kernfs_node *kn = of->kn;
> > > > +
> > > > +	WARN_ON_ONCE(sf->buf);
> > > 
> > > How can buf ever not be NULL?  And if it is, we will leak memory in the
> > > next line so we shouldn't have _ONCE, we should always know, but not
> > > rebooting the machine would be nice.
> > 
> > It should never be possible. I did this because seq_file has some
> > unusual buf allocation patterns in the kernel, and I liked the cheap
> > leak check. I use _ONCE because spewing endlessly doesn't help most
> > cases. And if you want to trigger it again, you don't have to reboot:
> > https://www.kernel.org/doc/html/latest/admin-guide/clearing-warn-once.html
> 
> True, I was thinking of the panic-on-warn people, and the hesitation of
> adding new WARN_ON() to the kernel code.  If this really can happen,
> shouldn't we handle it properly?

It should never happen, but I hate silent bugs. Given the existing
pattern of "external preallocation", it seems like a fragile interface
worth asserting our expectations.

The panic_on_warn folks will get exactly what they wanted: immediate
feedback on "expected to be impossible" cases:
https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

> > > > +	sf->buf = __vmalloc(kn->attr.size, GFP_KERNEL_ACCOUNT);
> > > > +	if (!sf->buf)
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +	sf->size = kn->attr.size;
> > > > +
> > > > +	return NULL + !*ppos;
> > > > +}
> > > 
> > > Will this also cause the vmalloc fragmentation/abuse that others have
> > > mentioned as userspace can trigger this?
> > 
> > If I understood the concern correctly, it was about it being a risk for
> > doing it for all seq_file uses. This version confines the changes to only
> > sysfs seq_file uses.
> 
> There are a few sysfs files that userspace can read from out there :)

Yes, but the vmap area is also used by default for process stacks, etc.
Malicious fragmentation is already possible. I understood the concern to
be about "regular" use. (And if I'm wrong, we can add a knob maybe?)

> > > And what code frees it?
> > 
> > The existing hooks to seq_release() handle this already. This kind of
> > "preallocation" of the seq_file buffer is done in a few places already
> > (hence my desire for the sanity checking WARN lest future seq_file
> > semantics change).
> 
> Ah, "magic", gotta love it...

Yeeeah. :P

-- 
Kees Cook
