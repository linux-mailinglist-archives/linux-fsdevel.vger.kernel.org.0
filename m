Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2C7ED75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 02:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfD3AAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 20:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbfD3AAc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:00:32 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 372F421655;
        Tue, 30 Apr 2019 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556582430;
        bh=6aSKDR1uKVKH7OuvG9FmFXPziiMX8kv+4PyT8PGgWtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v6TBNIArS5hw3/PahnC1A1h6StmNSpYjrmU+VMSsRvM61l+/2oSOeD3i+tIsYaaPw
         VXJZJPKFZPzm3iaxMIfnf8exD3VrclcC1Bu9re+gpqo2Ek28fxQx+iRvayf9TCg0bh
         zQ6Pgx4Q+qqcJRb6+k9lQhs85t/VqK4tWuWXBXOc=
Date:   Mon, 29 Apr 2019 17:00:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V2 02/13] Consolidate "read callbacks" into a new file
Message-ID: <20190430000027.GB251866@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190428043121.30925-3-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428043121.30925-3-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chandan,

On Sun, Apr 28, 2019 at 10:01:10AM +0530, Chandan Rajendra wrote:
> The "read callbacks" code is used by both Ext4 and F2FS. Hence to
> remove duplicity, this commit moves the code into
> include/linux/read_callbacks.h and fs/read_callbacks.c.
> 
> The corresponding decrypt and verity "work" functions have been moved
> inside fscrypt and fsverity sources. With these in place, the read
> callbacks code now has to just invoke enqueue functions provided by
> fscrypt and fsverity.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/Kconfig                     |   4 +
>  fs/Makefile                    |   4 +
>  fs/crypto/Kconfig              |   1 +
>  fs/crypto/bio.c                |  23 ++---
>  fs/crypto/crypto.c             |  17 +--
>  fs/crypto/fscrypt_private.h    |   3 +
>  fs/ext4/ext4.h                 |   2 -
>  fs/ext4/readpage.c             | 183 +++++----------------------------
>  fs/ext4/super.c                |   9 +-
>  fs/f2fs/data.c                 | 148 ++++----------------------
>  fs/f2fs/super.c                |   9 +-
>  fs/read_callbacks.c            | 136 ++++++++++++++++++++++++
>  fs/verity/Kconfig              |   1 +
>  fs/verity/verify.c             |  12 +++
>  include/linux/fscrypt.h        |  20 +---
>  include/linux/read_callbacks.h |  21 ++++
>  16 files changed, 251 insertions(+), 342 deletions(-)
>  create mode 100644 fs/read_callbacks.c
>  create mode 100644 include/linux/read_callbacks.h
> 

For easier review, can you split this into multiple patches?  Ideally the ext4
and f2fs patches would be separate, but if that's truly not possible due to
interdependencies it seems you could at least do:

1. Introduce the read_callbacks.
2. Convert encryption to use the read_callbacks.
3. Remove union from struct fscrypt_context.

Also: just FYI, fs-verity isn't upstream yet, and in the past few months I
haven't had much time to work on it.  So you might consider arranging your
series so that initially just fscrypt is supported.  That will be useful on its
own, for block_size < PAGE_SIZE support.  Then fsverity can be added later.

> diff --git a/fs/Kconfig b/fs/Kconfig
> index 97f9eb8df713..03084f2dbeaf 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -308,6 +308,10 @@ config NFS_COMMON
>  	depends on NFSD || NFS_FS || LOCKD
>  	default y
>  
> +config FS_READ_CALLBACKS
> +       bool
> +       default n

'default n' is unnecesary, since 'n' is already the default.

> +
>  source "net/sunrpc/Kconfig"
>  source "fs/ceph/Kconfig"
>  source "fs/cifs/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index 9dd2186e74b5..e0c0fce8cf40 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -21,6 +21,10 @@ else
>  obj-y +=	no-block.o
>  endif
>  
> +ifeq ($(CONFIG_FS_READ_CALLBACKS),y)
> +obj-y +=	read_callbacks.o
> +endif
> +

This can be simplified to:

obj-$(CONFIG_FS_READ_CALLBACKS) += read_callbacks.o

> diff --git a/fs/read_callbacks.c b/fs/read_callbacks.c
> new file mode 100644
> index 000000000000..b6d5b95e67d7
> --- /dev/null
> +++ b/fs/read_callbacks.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file tracks the state machine that needs to be executed after reading
> + * data from files that are encrypted and/or have verity metadata associated
> + * with them.
> + */
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/pagemap.h>
> +#include <linux/bio.h>
> +#include <linux/fscrypt.h>
> +#include <linux/fsverity.h>
> +#include <linux/read_callbacks.h>
> +
> +#define NUM_PREALLOC_POST_READ_CTXS	128
> +
> +static struct kmem_cache *read_callbacks_ctx_cache;
> +static mempool_t *read_callbacks_ctx_pool;
> +
> +/* Read callback state machine steps */
> +enum read_callbacks_step {
> +	STEP_INITIAL = 0,
> +	STEP_DECRYPT,
> +	STEP_VERITY,
> +};
> +
> +void end_read_callbacks(struct bio *bio)
> +{
> +	struct page *page;
> +	struct bio_vec *bv;
> +	int i;
> +	struct bvec_iter_all iter_all;
> +
> +	bio_for_each_segment_all(bv, bio, i, iter_all) {
> +		page = bv->bv_page;
> +
> +		BUG_ON(bio->bi_status);
> +
> +		if (!PageError(page))
> +			SetPageUptodate(page);
> +
> +		unlock_page(page);
> +	}
> +	if (bio->bi_private)
> +		put_read_callbacks_ctx(bio->bi_private);
> +	bio_put(bio);
> +}
> +EXPORT_SYMBOL(end_read_callbacks);

end_read_callbacks() is only called by read_callbacks() just below, so it should
be 'static'.

> +
> +struct read_callbacks_ctx *get_read_callbacks_ctx(struct inode *inode,
> +						struct bio *bio,
> +						pgoff_t index)
> +{
> +	unsigned int read_callbacks_steps = 0;

Rename 'read_callbacks_steps' => 'enabled_steps', since it's clear from context.

> +	struct read_callbacks_ctx *ctx = NULL;
> +
> +	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
> +		read_callbacks_steps |= 1 << STEP_DECRYPT;
> +#ifdef CONFIG_FS_VERITY
> +	if (inode->i_verity_info != NULL &&
> +		(index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
> +		read_callbacks_steps |= 1 << STEP_VERITY;
> +#endif

To avoid the #ifdef, this should probably be made a function in fsverity.h.

> +	if (read_callbacks_steps) {
> +		ctx = mempool_alloc(read_callbacks_ctx_pool, GFP_NOFS);
> +		if (!ctx)
> +			return ERR_PTR(-ENOMEM);
> +		ctx->bio = bio;
> +		ctx->inode = inode;
> +		ctx->enabled_steps = read_callbacks_steps;
> +		ctx->cur_step = STEP_INITIAL;
> +		bio->bi_private = ctx;
> +	}
> +	return ctx;
> +}
> +EXPORT_SYMBOL(get_read_callbacks_ctx);

The callers don't actually use the returned read_callbacks_ctx.  Instead, they
rely on this function storing it in ->bi_private.  So, this function should just
return an error code, and it should be renamed.  Perhaps:

	int read_callbacks_setup_bio(struct inode *inode, struct bio *bio,
				     pgoff_t first_pgoff);

Please rename 'index' to 'first_pgoff' to make it clearer what it is, given that
a bio can contain many pages.

Please add kerneldoc for this function.

- Eric
