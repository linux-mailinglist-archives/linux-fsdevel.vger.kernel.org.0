Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F556350FE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 09:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhDAHKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 03:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhDAHKI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:10:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55F3660FEF;
        Thu,  1 Apr 2021 07:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617261008;
        bh=QIf5mgQ42j36vldjH9A5iJlCOIvsFsU9/pGT+bmlJzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCUgT57uil/6iDaWEF9gZ7ILDB953G7uePa86DPIggwvl5sOVAoGMaZW9QwK7DxHT
         +eAufu4LcqCgTMPwKjX0QQpOvXFExuW/EryaPExD5Fu56JbhNxGZ7wzXAXo0dOn2Xo
         WzOAqfVSjnHV+2ckvUCVPC0r5h1VoeOx3j7vwbkA=
Date:   Thu, 1 Apr 2021 09:10:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sysfs: Unconditionally use vmalloc for buffer
Message-ID: <YGVxzSH8fV9MwBDM@kroah.com>
References: <20210401022145.2019422-1-keescook@chromium.org>
 <YGVXSFMlvX4RQI8n@kroah.com>
 <202103312335.25EA9650@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103312335.25EA9650@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:52:20PM -0700, Kees Cook wrote:
> On Thu, Apr 01, 2021 at 07:16:56AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Mar 31, 2021 at 07:21:45PM -0700, Kees Cook wrote:
> > > The sysfs interface to seq_file continues to be rather fragile
> > > (seq_get_buf() should not be used outside of seq_file), as seen with
> > > some recent exploits[1]. Move the seq_file buffer to the vmap area
> > > (while retaining the accounting flag), since it has guard pages that
> > > will catch and stop linear overflows. This seems justified given that
> > > sysfs's use of seq_file already uses kvmalloc(), is almost always using
> > > a PAGE_SIZE or larger allocation, has normally short-lived allocations,
> > > and is not normally on a performance critical path.
> > > 
> > > Once seq_get_buf() has been removed (and all sysfs callbacks using
> > > seq_file directly), this change can also be removed.
> > > 
> > > [1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > v3:
> > > - Limit to only sysfs (instead of all of seq_file).
> > > v2: https://lore.kernel.org/lkml/20210315174851.622228-1-keescook@chromium.org/
> > > v1: https://lore.kernel.org/lkml/20210312205558.2947488-1-keescook@chromium.org/
> > > ---
> > >  fs/sysfs/file.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > > index 9aefa7779b29..70e7a450e5d1 100644
> > > --- a/fs/sysfs/file.c
> > > +++ b/fs/sysfs/file.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/mm.h>
> > > +#include <linux/vmalloc.h>
> > >  
> > >  #include "sysfs.h"
> > >  
> > > @@ -32,6 +33,25 @@ static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
> > >  	return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
> > >  }
> > >  
> > > +/*
> > > + * To be proactively defensive against sysfs show() handlers that do not
> > > + * correctly stay within their PAGE_SIZE buffer, use the vmap area to gain
> > > + * the trailing guard page which will stop linear buffer overflows.
> > > + */
> > > +static void *sysfs_kf_seq_start(struct seq_file *sf, loff_t *ppos)
> > > +{
> > > +	struct kernfs_open_file *of = sf->private;
> > > +	struct kernfs_node *kn = of->kn;
> > > +
> > > +	WARN_ON_ONCE(sf->buf);
> > 
> > How can buf ever not be NULL?  And if it is, we will leak memory in the
> > next line so we shouldn't have _ONCE, we should always know, but not
> > rebooting the machine would be nice.
> 
> It should never be possible. I did this because seq_file has some
> unusual buf allocation patterns in the kernel, and I liked the cheap
> leak check. I use _ONCE because spewing endlessly doesn't help most
> cases. And if you want to trigger it again, you don't have to reboot:
> https://www.kernel.org/doc/html/latest/admin-guide/clearing-warn-once.html

True, I was thinking of the panic-on-warn people, and the hesitation of
adding new WARN_ON() to the kernel code.  If this really can happen,
shouldn't we handle it properly?

> > > +	sf->buf = __vmalloc(kn->attr.size, GFP_KERNEL_ACCOUNT);
> > > +	if (!sf->buf)
> > > +		return ERR_PTR(-ENOMEM);
> > > +	sf->size = kn->attr.size;
> > > +
> > > +	return NULL + !*ppos;
> > > +}
> > 
> > Will this also cause the vmalloc fragmentation/abuse that others have
> > mentioned as userspace can trigger this?
> 
> If I understood the concern correctly, it was about it being a risk for
> doing it for all seq_file uses. This version confines the changes to only
> sysfs seq_file uses.

There are a few sysfs files that userspace can read from out there :)

> > And what code frees it?
> 
> The existing hooks to seq_release() handle this already. This kind of
> "preallocation" of the seq_file buffer is done in a few places already
> (hence my desire for the sanity checking WARN lest future seq_file
> semantics change).

Ah, "magic", gotta love it...

thanks,

greg k-h
