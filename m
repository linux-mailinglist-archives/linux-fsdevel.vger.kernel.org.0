Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C03535102F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDAHhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 03:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhDAHhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:37:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DAEC06178C
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 00:37:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so570461pjv.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aud+dIcxPCJT/CZT/Avgbz5emttFAGl7iLysJkmv9HQ=;
        b=GIu6cSr7gEi7kr1eVD0E/FKPEHv2+ntW/buQZ2B8W7aBHsJypdoxS/0saK/383DCmU
         esv3wPdXsB6Q9hgwBt72cKTfpEqzyGcF+81O5TkRZvBvzaigTBUcTKBSQkXpcsd4tVkg
         UbWcqPKyK4KdqVevgR/Lc1sKz6fn6NfG/t6IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aud+dIcxPCJT/CZT/Avgbz5emttFAGl7iLysJkmv9HQ=;
        b=hM/+/MbhI0XN3M7zAdWGKzSFBxkORHJ+jmsrZeFQXjGAHqtPU5bbQxzL+tib4wVVP4
         733dcecfX8tLTLoHDyT3/k8VcEKasQ3ds6U7Ec34Fz4EHkUI2KrPXdSckvoSE+hICuff
         1GEapwzat/qbdcXe/dA9tZaZfrK/k+CvnYEEZ9y1PuALN4WxiRELXe9QAs09b3cPPNzE
         QsHrbHFiu2dV+72KU/Qfns6AGriehMCi67cc0e4xUtZh67eJwHmRcxUXSsV7Va0LnTGA
         68lAhY+TZiqFms8ZeAmn3/2b87qZQ6HQQBZSrco5YjYsf6AAbxKpIhfnwXgBi+RrnzSV
         LCoA==
X-Gm-Message-State: AOAM533fQ7ysj4kBZzAZAvwkTkoRIxwlUvW3P/Yc4ZzeQGp2a4DT029q
        /NBUUGnoWnzt/HqigwxxBfw46U2NFu1skw==
X-Google-Smtp-Source: ABdhPJwLCcrVg7CiJnE1FLkm7Zxzfm66PC6qjKPyS9K94ekCn1cm2DTfRkS5WAGVsuUhQUtVPEm//A==
X-Received: by 2002:a17:90a:f298:: with SMTP id fs24mr7717612pjb.57.1617262630639;
        Thu, 01 Apr 2021 00:37:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 15sm4289460pfx.167.2021.04.01.00.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 00:37:10 -0700 (PDT)
Date:   Thu, 1 Apr 2021 00:37:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sysfs: Unconditionally use vmalloc for buffer
Message-ID: <202104010030.42B460AB12@keescook>
References: <20210401022145.2019422-1-keescook@chromium.org>
 <YGVy0WUG1OEFfjhx@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGVy0WUG1OEFfjhx@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 09:14:25AM +0200, Michal Hocko wrote:
> On Wed 31-03-21 19:21:45, Kees Cook wrote:
> > The sysfs interface to seq_file continues to be rather fragile
> > (seq_get_buf() should not be used outside of seq_file), as seen with
> > some recent exploits[1]. Move the seq_file buffer to the vmap area
> > (while retaining the accounting flag), since it has guard pages that
> > will catch and stop linear overflows.
> 
> I thought the previous discussion has led to a conclusion that the
> preferred way is to disallow direct seq_file buffer usage. But this is
> obviously up to sysfs maintainers. I am happy you do not want to spread
> this out to all seq_file users anymore.

Yeah; I still want to remove external seq_get_buf(), but that'll take
time. I'll be doing the work, though, since I still need access to
f_cred for show() access control checks.

> > This seems justified given that
> > sysfs's use of seq_file already uses kvmalloc(), is almost always using
> > a PAGE_SIZE or larger allocation, has normally short-lived allocations,
> > and is not normally on a performance critical path.
> 
> Let me clarify on this, because this is not quite right. kvmalloc vs
> vmalloc (both with GFP_KERNEL) on PAGE_SIZE are two different beasts.
> The first one is almost always going to use kmalloc because the page
> allocator almost never fails those requests.

Yes, good point. I will adjust my changelog.

Thanks!

-Kees

> 
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
> > +	sf->buf = __vmalloc(kn->attr.size, GFP_KERNEL_ACCOUNT);
> > +	if (!sf->buf)
> > +		return ERR_PTR(-ENOMEM);
> > +	sf->size = kn->attr.size;
> > +
> > +	return NULL + !*ppos;
> > +}
> > +
> >  /*
> >   * Reads on sysfs are handled through seq_file, which takes care of hairy
> >   * details like buffering and seeking.  The following function pipes
> > @@ -206,14 +226,17 @@ static const struct kernfs_ops sysfs_file_kfops_empty = {
> >  };
> >  
> >  static const struct kernfs_ops sysfs_file_kfops_ro = {
> > +	.seq_start	= sysfs_kf_seq_start,
> >  	.seq_show	= sysfs_kf_seq_show,
> >  };
> >  
> >  static const struct kernfs_ops sysfs_file_kfops_wo = {
> > +	.seq_start	= sysfs_kf_seq_start,
> >  	.write		= sysfs_kf_write,
> >  };
> >  
> >  static const struct kernfs_ops sysfs_file_kfops_rw = {
> > +	.seq_start	= sysfs_kf_seq_start,
> >  	.seq_show	= sysfs_kf_seq_show,
> >  	.write		= sysfs_kf_write,
> >  };
> > -- 
> > 2.25.1
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Kees Cook
