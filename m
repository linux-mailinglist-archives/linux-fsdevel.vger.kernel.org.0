Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05A1249BDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHSLei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHSLea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:34:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5DC061757;
        Wed, 19 Aug 2020 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7yVfV8jmwfeaLjZjiHvvFJk+lpL/q6/SRgz1/vjVSa8=; b=W8u29Do1kwEZJ7t63grpX5Jg5F
        kFBInhhDX0kCur8w1uTzPJ7dpwPfh/zkqz93CTWOBGnDUK+msXqyR8uNd9ikxOCtk/LdA4P7bkrEX
        8NkomztzxzlAZ1X6lbvqdyK5GVCuyudCvdryQmomsemLbgy0bf1ieqmssFm6YYUzNJoU6imzVShKJ
        Jt0F+xJ6+Nuqb13Jvd9SHVw3QnWRtZ/21M3FYeQwLMrUerQzpmlM0EjxzpjzCjxuAZbn3T9wond7r
        P9NslT3QBeadiwJEFrrPA9G4w+jtIZlC5cyjYEpXPQT0V3f4E4i6mPxbtPu8fr3gERarcuPN+lAwP
        CXzurXmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8MMK-00020G-TN; Wed, 19 Aug 2020 11:34:25 +0000
Date:   Wed, 19 Aug 2020 12:34:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Add function declaration of simple_dname
Message-ID: <20200819113424.GA17456@casper.infradead.org>
References: <20200819083259.919838-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819083259.919838-1-leon@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:32:59AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The simple_dname() is declared in internal header file as extern
> and this generates the following GCC warning.

The fact that it's declared as extern doesn't matter.  You don't need
the change to internal.h at all.  The use of 'extern' on a function
declaration is purely decorative:

  5 If the declaration of an identifier for a function has no
  storage-class specifier, its linkage is determined exactly as if it
  were declared with the storage-class specifier extern.

I'd drop the change to internal.h and fix the changelog.

> fs/d_path.c:311:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
>   311 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
>       |       ^~~~~~~~~~~~
> 
> Instead of that extern, reuse the fact that internal.h file is internal to fs/* and
> declare simple_dname() like any other function.
> 
> Fixes: 7e5f7bb08b8c ("unexport simple_dname()")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  fs/d_path.c   | 2 ++
>  fs/internal.h | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 0f1fc1743302..4b89448cc78e 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -8,6 +8,8 @@
>  #include <linux/prefetch.h>
>  #include "mount.h"
> 
> +#include "internal.h"
> +
>  static int prepend(char **buffer, int *buflen, const char *str, int namelen)
>  {
>  	*buflen -= namelen;
> diff --git a/fs/internal.h b/fs/internal.h
> index 10517ece4516..2def264272f4 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -164,7 +164,7 @@ extern int d_set_mounted(struct dentry *dentry);
>  extern long prune_dcache_sb(struct super_block *sb, struct shrink_control *sc);
>  extern struct dentry *d_alloc_cursor(struct dentry *);
>  extern struct dentry * d_alloc_pseudo(struct super_block *, const struct qstr *);
> -extern char *simple_dname(struct dentry *, char *, int);
> +char *simple_dname(struct dentry *d, char *buf, int len);
>  extern void dput_to_list(struct dentry *, struct list_head *);
>  extern void shrink_dentry_list(struct list_head *);
> 
> --
> 2.26.2
> 
