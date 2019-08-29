Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90258A15E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 12:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfH2KYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 06:24:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfH2KYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uzKJKYZqh5cldXspEq4aviAtZz0ZMSP0fdY/FxrxRb8=; b=pvLXSzikK4jCyckorJkttc/nk
        E0m9v2p9AQEptN/i/zCuaWhA9JEKbgpZZcHl/w2YReY2IjGzciU3M43LLVZLZL+wuaZXGsgZ37FY4
        d3qeURL1WsVXbwNN8lYRTR398q3SBQLzAWCBIA2rzk4sSsbnQPCLUNyr5JVUyt5yXYxxV/Cjxzy+N
        nJDvZ16fAoVnoCHpt/1S6uDBh63+nOxa6Kv8j18kex/JOrbl5zkgMpcfdcLDTPYSewrdK0tXF4/SF
        ArtQBRVU0RsnX0bg8H4Y2DNilmS45BAJFRoVqKwJlqVgW4/DYDBIXaoRO7bqN9s0xgJCQhlldLI/n
        9DJlZoDjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3HbO-00077V-LK; Thu, 29 Aug 2019 10:24:26 +0000
Date:   Thu, 29 Aug 2019 03:24:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190829102426.GE20598@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802125347.166018-6-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:53:28PM +0800, Gao Xiang wrote:
> This adds core functions to get, read an inode.
> It adds statx support as well.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  fs/erofs/inode.c | 291 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 291 insertions(+)
>  create mode 100644 fs/erofs/inode.c
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> new file mode 100644
> index 000000000000..b6ea997bc4ae
> --- /dev/null
> +++ b/fs/erofs/inode.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * linux/fs/erofs/inode.c
> + *
> + * Copyright (C) 2017-2018 HUAWEI, Inc.
> + *             http://www.huawei.com/
> + * Created by Gao Xiang <gaoxiang25@huawei.com>
> + */
> +#include "internal.h"
> +
> +#include <trace/events/erofs.h>
> +
> +/* no locking */
> +static int read_inode(struct inode *inode, void *data)
> +{
> +	struct erofs_vnode *vi = EROFS_V(inode);
> +	struct erofs_inode_v1 *v1 = data;
> +	const unsigned int advise = le16_to_cpu(v1->i_advise);
> +	erofs_blk_t nblks = 0;
> +
> +	vi->datamode = __inode_data_mapping(advise);

What is the deal with these magic underscores here and various
other similar helpers?

> +	/* fast symlink (following ext4) */

This actually originates in FFS.  But it is so common that the comment
seems a little pointless.

> +	if (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) {
> +		char *lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);

Please just use plain kmalloc everywhere and let the normal kernel
error injection code take care of injeting any errors.

> +		/* inline symlink data shouldn't across page boundary as well */

... should not cross ..

> +		if (unlikely(m_pofs + inode->i_size > PAGE_SIZE)) {
> +			DBG_BUGON(1);
> +			kfree(lnk);
> +			return -EIO;
> +		}
> +
> +		/* get in-page inline data */

s/get/copy/, but the comment seems rather pointless.

> +		memcpy(lnk, data + m_pofs, inode->i_size);
> +		lnk[inode->i_size] = '\0';
> +
> +		inode->i_link = lnk;
> +		set_inode_fast_symlink(inode);

Please just set the ops directly instead of obsfucating that in a single
caller, single line inline function.  And please set it instead of the
normal symlink iops in the same place where you also set those.:w

> +	err = read_inode(inode, data + ofs);
> +	if (!err) {

	if (err)
		goto out_unlock;

.. and save one level of indentation.

> +		if (is_inode_layout_compression(inode)) {

The name of this helper is a little odd.  But I think just
opencoding it seems generally cleaner anyway.


> +			err = -ENOTSUPP;
> +			goto out_unlock;
> +		}
> +
> +		inode->i_mapping->a_ops = &erofs_raw_access_aops;
> +
> +		/* fill last page if inline data is available */
> +		err = fill_inline_data(inode, data, ofs);

Well, I think you should move the is_inode_flat_inline and
(S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) checks from that
helper here, as otherwise you make everyone wonder why you'd always
fill out the inline data.

> +static inline struct inode *erofs_iget_locked(struct super_block *sb,
> +					      erofs_nid_t nid)
> +{
> +	const unsigned long hashval = erofs_inode_hash(nid);
> +
> +#if BITS_PER_LONG >= 64
> +	/* it is safe to use iget_locked for >= 64-bit platform */
> +	return iget_locked(sb, hashval);
> +#else
> +	return iget5_locked(sb, hashval, erofs_ilookup_test_actor,
> +		erofs_iget_set_actor, &nid);
> +#endif

Just use the slightly more complicated 32-bit version everywhere so that
you have a single actually tested code path.  And then remove this
helper.
