Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE2249BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHSLkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 07:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgHSLkF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:40:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 919AE206FA;
        Wed, 19 Aug 2020 11:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837205;
        bh=Wo0rqqJfk2zBMXYOEoNqxy1AI9iRGPC/BxwzuJcTpFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RE6hglFb/fU6P6Cy0VAzZtLIhqXqrAjgYG//DyGXvAi7YRn9Evs+UdI4lcoK0sOwU
         v5jnzvyheAh0Ag+/6KKdgDm9EHj+c2x3XSNWbIGUCnw3E7YdDdq5PjlNmOQ6LA6BqP
         MWK8vSg6UuFNPuLvXO5+IBZleXsI5Ldrqcqr4l68=
Date:   Wed, 19 Aug 2020 14:40:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Add function declaration of simple_dname
Message-ID: <20200819114001.GU7555@unreal>
References: <20200819083259.919838-1-leon@kernel.org>
 <20200819113424.GA17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819113424.GA17456@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 12:34:24PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 19, 2020 at 11:32:59AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > The simple_dname() is declared in internal header file as extern
> > and this generates the following GCC warning.
>
> The fact that it's declared as extern doesn't matter.  You don't need
> the change to internal.h at all.  The use of 'extern' on a function
> declaration is purely decorative:
>
>   5 If the declaration of an identifier for a function has no
>   storage-class specifier, its linkage is determined exactly as if it
>   were declared with the storage-class specifier extern.

So why do we need to keep extern keyword if we use intenral.h directly?

>
> I'd drop the change to internal.h and fix the changelog.

Thanks

>
> > fs/d_path.c:311:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
> >   311 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
> >       |       ^~~~~~~~~~~~
> >
> > Instead of that extern, reuse the fact that internal.h file is internal to fs/* and
> > declare simple_dname() like any other function.
> >
> > Fixes: 7e5f7bb08b8c ("unexport simple_dname()")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  fs/d_path.c   | 2 ++
> >  fs/internal.h | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/d_path.c b/fs/d_path.c
> > index 0f1fc1743302..4b89448cc78e 100644
> > --- a/fs/d_path.c
> > +++ b/fs/d_path.c
> > @@ -8,6 +8,8 @@
> >  #include <linux/prefetch.h>
> >  #include "mount.h"
> >
> > +#include "internal.h"
> > +
> >  static int prepend(char **buffer, int *buflen, const char *str, int namelen)
> >  {
> >  	*buflen -= namelen;
> > diff --git a/fs/internal.h b/fs/internal.h
> > index 10517ece4516..2def264272f4 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -164,7 +164,7 @@ extern int d_set_mounted(struct dentry *dentry);
> >  extern long prune_dcache_sb(struct super_block *sb, struct shrink_control *sc);
> >  extern struct dentry *d_alloc_cursor(struct dentry *);
> >  extern struct dentry * d_alloc_pseudo(struct super_block *, const struct qstr *);
> > -extern char *simple_dname(struct dentry *, char *, int);
> > +char *simple_dname(struct dentry *d, char *buf, int len);
> >  extern void dput_to_list(struct dentry *, struct list_head *);
> >  extern void shrink_dentry_list(struct list_head *);
> >
> > --
> > 2.26.2
> >
