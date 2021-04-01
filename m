Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7AB350F76
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 08:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhDAGwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 02:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhDAGwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:52:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30291C0613E6
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 23:52:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w11so532944ply.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b9ryqUXjlQ30IT8LdTW/JmPrwJayz7Foc4p5htGFNa0=;
        b=BVuxWfkvBVEvDB2Lpc+ukiSEQ2sj9+O7sLQZDIriWuhcrEcXX/nXmqIN1of31iR4TB
         lyhAFPc96fmbwROpGn4jt/GHL9j34UoXIu82i43V9EoV/svRyloI7pJya+iH8DijSd5n
         ftiGRVDHqxjMGX7NAibmk75+hSqVyopuTc41Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9ryqUXjlQ30IT8LdTW/JmPrwJayz7Foc4p5htGFNa0=;
        b=nndoLNiZV92+ajTK512t76IhEtLeBlaNrVcA6YWVcG7hqIwwWWUBsDMuvga0BVQFx0
         +PDnouJcD8q1FE4dCQSo/S8Q5aAnLA172PXPsz+kwksdrpYUcPpk0xxPlcGuMVNgUC5l
         abWICkeeb41Nuw3Pgrk9KZ/n1QQ5eTtOKdsmN2OBoi2YFtlOMa9zOPAVsGMMXSRLIl5b
         tI8QbFVpg/z3QKU9Q66DH+v00YPb0PeTGdDaPv+EAUghtHTEp7ao+FKL2mpO67pt7msB
         eX9T4jchk/8pUuLl7dg5vQgFdxbCx5zmdrcWh1+HPdVryCiNUDkKKCA+YznSv8Bp4CCC
         mvyA==
X-Gm-Message-State: AOAM533SxJR1geiBwiht41ble2RhbNjH2Ji2olyg9VfL4btCViIdEEu5
        eyYYKPAga7b0jQNFZCWiUrU6QA==
X-Google-Smtp-Source: ABdhPJwHJUQYxPWKm0HOzv69evNZgW/7ovx9+48lWgs2MIQnBKJubEUmheoM6gqLZ5fsPNAWKO7Zag==
X-Received: by 2002:a17:902:c317:b029:e4:aecd:8539 with SMTP id k23-20020a170902c317b02900e4aecd8539mr6758734plx.61.1617259941703;
        Wed, 31 Mar 2021 23:52:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1sm4258456pfj.209.2021.03.31.23.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:52:21 -0700 (PDT)
Date:   Wed, 31 Mar 2021 23:52:20 -0700
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
Message-ID: <202103312335.25EA9650@keescook>
References: <20210401022145.2019422-1-keescook@chromium.org>
 <YGVXSFMlvX4RQI8n@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGVXSFMlvX4RQI8n@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 07:16:56AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Mar 31, 2021 at 07:21:45PM -0700, Kees Cook wrote:
> > The sysfs interface to seq_file continues to be rather fragile
> > (seq_get_buf() should not be used outside of seq_file), as seen with
> > some recent exploits[1]. Move the seq_file buffer to the vmap area
> > (while retaining the accounting flag), since it has guard pages that
> > will catch and stop linear overflows. This seems justified given that
> > sysfs's use of seq_file already uses kvmalloc(), is almost always using
> > a PAGE_SIZE or larger allocation, has normally short-lived allocations,
> > and is not normally on a performance critical path.
> > 
> > Once seq_get_buf() has been removed (and all sysfs callbacks using
> > seq_file directly), this change can also be removed.
> > 
> > [1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v3:
> > - Limit to only sysfs (instead of all of seq_file).
> > v2: https://lore.kernel.org/lkml/20210315174851.622228-1-keescook@chromium.org/
> > v1: https://lore.kernel.org/lkml/20210312205558.2947488-1-keescook@chromium.org/
> > ---
> >  fs/sysfs/file.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > index 9aefa7779b29..70e7a450e5d1 100644
> > --- a/fs/sysfs/file.c
> > +++ b/fs/sysfs/file.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/mm.h>
> > +#include <linux/vmalloc.h>
> >  
> >  #include "sysfs.h"
> >  
> > @@ -32,6 +33,25 @@ static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
> >  	return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
> >  }
> >  
> > +/*
> > + * To be proactively defensive against sysfs show() handlers that do not
> > + * correctly stay within their PAGE_SIZE buffer, use the vmap area to gain
> > + * the trailing guard page which will stop linear buffer overflows.
> > + */
> > +static void *sysfs_kf_seq_start(struct seq_file *sf, loff_t *ppos)
> > +{
> > +	struct kernfs_open_file *of = sf->private;
> > +	struct kernfs_node *kn = of->kn;
> > +
> > +	WARN_ON_ONCE(sf->buf);
> 
> How can buf ever not be NULL?  And if it is, we will leak memory in the
> next line so we shouldn't have _ONCE, we should always know, but not
> rebooting the machine would be nice.

It should never be possible. I did this because seq_file has some
unusual buf allocation patterns in the kernel, and I liked the cheap
leak check. I use _ONCE because spewing endlessly doesn't help most
cases. And if you want to trigger it again, you don't have to reboot:
https://www.kernel.org/doc/html/latest/admin-guide/clearing-warn-once.html

> 
> > +	sf->buf = __vmalloc(kn->attr.size, GFP_KERNEL_ACCOUNT);
> > +	if (!sf->buf)
> > +		return ERR_PTR(-ENOMEM);
> > +	sf->size = kn->attr.size;
> > +
> > +	return NULL + !*ppos;
> > +}
> 
> Will this also cause the vmalloc fragmentation/abuse that others have
> mentioned as userspace can trigger this?

If I understood the concern correctly, it was about it being a risk for
doing it for all seq_file uses. This version confines the changes to only
sysfs seq_file uses.

> And what code frees it?

The existing hooks to seq_release() handle this already. This kind of
"preallocation" of the seq_file buffer is done in a few places already
(hence my desire for the sanity checking WARN lest future seq_file
semantics change).

-- 
Kees Cook
