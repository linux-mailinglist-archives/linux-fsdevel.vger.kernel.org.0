Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F125A3F2239
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 23:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhHSV0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 17:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhHSV0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:26:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC3C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 14:26:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m26so6719580pff.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+4vlEEAudVfYKUxZZmR1avsO58lGkEG6r6/9NuzjB0=;
        b=GcootYiu+qyxArUabMdyG4IqWavV54aowLk08BBPIEnlK8+EEnyz2Bs9Qnyj904R1y
         CDw1eNTKzCN1HRYVOZcRLRkEzYQJvTk8BVLomrVdsGdzpC/6+mu2O7s0aw9t0HSNz/Vk
         dNCZGdNuQGrc6TFoTfjjgkoo5o3Rksm1CsPDr9M+sHd39KqY4ienvwG+7Dy0+/0y2afH
         Ac2F+zF07AdKz98cxb6pEDDT0S8m7FnHMVdaL5pqJ6Upe/xwN5twWY1e+3bhwdKLEf5m
         8J7hqUFL0m9NzK3HDH0h6NFjdtBiEPOB9C7CAMh0xZXBrF9hxNS4/fEF9TG/n6LeGNnT
         N6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+4vlEEAudVfYKUxZZmR1avsO58lGkEG6r6/9NuzjB0=;
        b=qStKUTVhnboMwvXg9K3beG1UwWsAMVMkk/PunmdtoLaDV5gK9kE8k6f8At6iqxenUz
         j5Tri0uhIPMex/1T0SqPaQdLRDH/u4J3zOiCGaBDIqY1yeEhq4W9LOjG6j7a7KatC4cp
         IjyPE48TFFC8FxGWqaJdho7IYi8IZl40qZYQ5841HHlzbeMq8iAMMqmEc0f5cIRQRjZ/
         /WWo4pfUhrImPQE3JwE49HCvPFDsS9V7dW4LpIWCDAAoZVeibIGZHei4ZI0b/Rh0Uri2
         2bYafqLWYQmTm0wfwKVAy2Cq20N/lxQl+t7Ln3YWQGBxMhzBgASNWwGRvEtWaMYU9Vqe
         JyzQ==
X-Gm-Message-State: AOAM531JJqxVP8LX6+sOePj7247QH8o7MXmFEHQsw2IBjXoMIoqfex0+
        cEL2IZ05yEqsJ+a3a91yXgqoZdu6vcr5IJiR/XbG0w==
X-Google-Smtp-Source: ABdhPJzKZYtlwFa7VXvyk4oUfNnz7UdFBAgEuwiVTYzP34GSZ6p0NdAO9joIfVAHSnYYO/DjZcvseW3kcO9yjw3n+I0=
X-Received: by 2002:a63:311:: with SMTP id 17mr15597460pgd.450.1629408363613;
 Thu, 19 Aug 2021 14:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210809061244.1196573-1-hch@lst.de> <20210809061244.1196573-12-hch@lst.de>
In-Reply-To: <20210809061244.1196573-12-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 19 Aug 2021 14:25:52 -0700
Message-ID: <CAPcyv4hbSYnOC6Pdi1QShRxGjBAteig7nN1h-5cEvsFDX9SuAQ@mail.gmail.com>
Subject: Re: [PATCH 11/30] iomap: add the new iomap_iter model
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 8, 2021 at 11:23 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The iomap_iter struct provides a convenient way to package up and
> maintain all the arguments to the various mapping and operation
> functions.  It is operated on using the iomap_iter() function that
> is called in loop until the whole range has been processed.  Compared
> to the existing iomap_apply() function this avoid an indirect call
> for each iteration.
>
> For now iomap_iter() calls back into the existing ->iomap_begin and
> ->iomap_end methods, but in the future this could be further optimized
> to avoid indirect calls entirely.
>
> Based on an earlier patch from Matthew Wilcox <willy@infradead.org>.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/Makefile     |  1 +
>  fs/iomap/core.c       | 79 +++++++++++++++++++++++++++++++++++++++++++
>  fs/iomap/trace.h      | 37 +++++++++++++++++++-
>  include/linux/iomap.h | 56 ++++++++++++++++++++++++++++++
>  4 files changed, 172 insertions(+), 1 deletion(-)
>  create mode 100644 fs/iomap/core.c
>
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index eef2722d93a183..6b56b10ded347a 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_FS_IOMAP)                += iomap.o
>
>  iomap-y                                += trace.o \
>                                    apply.o \
> +                                  core.o \
>                                    buffered-io.o \
>                                    direct-io.o \
>                                    fiemap.o \
> diff --git a/fs/iomap/core.c b/fs/iomap/core.c
> new file mode 100644
> index 00000000000000..89a87a1654e8e6
> --- /dev/null
> +++ b/fs/iomap/core.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Christoph Hellwig.
> + */
> +#include <linux/fs.h>
> +#include <linux/iomap.h>
> +#include "trace.h"
> +
> +static inline int iomap_iter_advance(struct iomap_iter *iter)
> +{
> +       /* handle the previous iteration (if any) */
> +       if (iter->iomap.length) {
> +               if (iter->processed <= 0)
> +                       return iter->processed;
> +               if (WARN_ON_ONCE(iter->processed > iomap_length(iter)))
> +                       return -EIO;
> +               iter->pos += iter->processed;
> +               iter->len -= iter->processed;
> +               if (!iter->len)
> +                       return 0;
> +       }
> +
> +       /* clear the state for the next iteration */
> +       iter->processed = 0;
> +       memset(&iter->iomap, 0, sizeof(iter->iomap));
> +       memset(&iter->srcmap, 0, sizeof(iter->srcmap));
> +       return 1;
> +}
> +
> +static inline void iomap_iter_done(struct iomap_iter *iter)
> +{
> +       WARN_ON_ONCE(iter->iomap.offset > iter->pos);
> +       WARN_ON_ONCE(iter->iomap.length == 0);
> +       WARN_ON_ONCE(iter->iomap.offset + iter->iomap.length <= iter->pos);
> +
> +       trace_iomap_iter_dstmap(iter->inode, &iter->iomap);
> +       if (iter->srcmap.type != IOMAP_HOLE)
> +               trace_iomap_iter_srcmap(iter->inode, &iter->srcmap);

Given most of the iomap_iter users don't care about srcmap, i.e. are
not COW cases, they are leaving srcmap zero initialized. Should the
IOMAP types be incremented by one so that there is no IOMAP_HOLE
confusion? In other words, fold something like this?

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 479c1da3e221..b9c62d0909b0 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -21,14 +21,23 @@ struct page;
 struct vm_area_struct;
 struct vm_fault;

-/*
- * Types of block ranges for iomap mappings:
+/**
+ * enum iomap_type - Types of block ranges for iomap mappings
+ * @IOMAP_NONE: invalid iomap
+ * @IOMAP_HOLE: no blocks allocated, need allocation
+ * @IOMAP_DELALLOC: delayed allocation blocks
+ * @IOMAP_MAPPED: blocks allocated at @addr
+ * @IOMAP_UNWRITTEN: blocks allocated at @addr in unwritten state
+ * @IOMAP_INLINE: data inline in the inode
  */
-#define IOMAP_HOLE     0       /* no blocks allocated, need allocation */
-#define IOMAP_DELALLOC 1       /* delayed allocation blocks */
-#define IOMAP_MAPPED   2       /* blocks allocated at @addr */
-#define IOMAP_UNWRITTEN        3       /* blocks allocated at @addr
in unwritten state */
-#define IOMAP_INLINE   4       /* data inline in the inode */
+enum iomap_type {
+       IOMAP_NONE = 0,
+       IOMAP_HOLE,
+       IOMAP_DELALLOC
+       IOMAP_MAPPED,
+       IOMAP_UNWRITTEN,
+       IOMAP_INLINE,
+};

 /*
  * Flags reported by the file system from iomap_begin:


> +}
> +
> +/**
> + * iomap_iter - iterate over a ranges in a file
> + * @iter: iteration structue

s/structue/structure/

Other than the minor stuff above, looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
