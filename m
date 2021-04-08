Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6517C358FC8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 00:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhDHW05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 18:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232265AbhDHW04 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:26:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56B10610F7;
        Thu,  8 Apr 2021 22:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617920804;
        bh=0aS821BgGrwNDh6ecXyzgYTlL3k88Djp+rVvaNME4BQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9La33FljbUwnmdkKj5jf638xxBAXTcHtSzenNjnGrO7ykJBf8dr4YW6nlu49SXxP
         KZ69pOfYcbg2KEEYPDjLlHhNjJli8GseaqyCskOlg/D078E6iE23ozhq/owWp8EXvp
         xPTuRGJ7ofhN9i8BwP5ukG5LJehy7VQc8HuY6+ePSxoaQcwmc6VZPmdkrjPl+LMvFd
         r5iD7PfBfsjP0Ucc74KfmA942ZEXxW7NBSFKk9WL7l2S1e4QHVFFd8LfWE0T3mydBj
         vlJJd4NtxhRCDM4AFjpkw6CwP/Go3F2SvRmnIvioQb6gayA/X9m4QgbGIgGyPCblmS
         W5L/9x/natMmA==
Date:   Thu, 8 Apr 2021 15:26:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de
Subject: Re: [PATCH v4 4/7] iomap: Introduce iomap_apply2() for operations on
 two files
Message-ID: <20210408222643.GA3957620@magnolia>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
 <20210408120432.1063608-5-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408120432.1063608-5-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:04:29PM +0800, Shiyang Ruan wrote:
> Some operations, such as comparing a range of data in two files under
> fsdax mode, requires nested iomap_open()/iomap_end() on two file.  Thus,
> we introduce iomap_apply2() to accept arguments from two files and
> iomap_actor2_t for actions on two files.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Kinda wish we weren't propagating even more indirect call usage, but oh
well.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/apply.c      | 52 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iomap.h |  7 +++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 26ab6563181f..0493da5286ad 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -97,3 +97,55 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  
>  	return written ? written : ret;
>  }
> +
> +loff_t
> +iomap_apply2(struct inode *ino1, loff_t pos1, struct inode *ino2, loff_t pos2,
> +		loff_t length, unsigned int flags, const struct iomap_ops *ops,
> +		void *data, iomap_actor2_t actor)
> +{
> +	struct iomap smap = { .type = IOMAP_HOLE };
> +	struct iomap dmap = { .type = IOMAP_HOLE };
> +	loff_t written = 0, ret, ret2 = 0;
> +	loff_t len1 = length, len2, min_len;
> +
> +	ret = ops->iomap_begin(ino1, pos1, len1, flags, &smap, NULL);
> +	if (ret)
> +		goto out;
> +	if (WARN_ON(smap.offset > pos1)) {
> +		written = -EIO;
> +		goto out_src;
> +	}
> +	if (WARN_ON(smap.length == 0)) {
> +		written = -EIO;
> +		goto out_src;
> +	}
> +	len2 = min_t(loff_t, len1, smap.length);
> +
> +	ret = ops->iomap_begin(ino2, pos2, len2, flags, &dmap, NULL);
> +	if (ret)
> +		goto out_src;
> +	if (WARN_ON(dmap.offset > pos2)) {
> +		written = -EIO;
> +		goto out_dest;
> +	}
> +	if (WARN_ON(dmap.length == 0)) {
> +		written = -EIO;
> +		goto out_dest;
> +	}
> +	min_len = min_t(loff_t, len2, dmap.length);
> +
> +	written = actor(ino1, pos1, ino2, pos2, min_len, data, &smap, &dmap);
> +
> +out_dest:
> +	if (ops->iomap_end)
> +		ret2 = ops->iomap_end(ino2, pos2, len2,
> +				      written > 0 ? written : 0, flags, &dmap);
> +out_src:
> +	if (ops->iomap_end)
> +		ret = ops->iomap_end(ino1, pos1, len1,
> +				     written > 0 ? written : 0, flags, &smap);
> +out:
> +	if (written)
> +		return written;
> +	return ret ?: ret2;
> +}
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index d202fd2d0f91..9493c48bcc9c 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -150,10 +150,15 @@ struct iomap_ops {
>   */
>  typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
>  		void *data, struct iomap *iomap, struct iomap *srcmap);
> -
> +typedef loff_t (*iomap_actor2_t)(struct inode *ino1, loff_t pos1,
> +		struct inode *ino2, loff_t pos2, loff_t len, void *data,
> +		struct iomap *smap, struct iomap *dmap);
>  loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
>  		unsigned flags, const struct iomap_ops *ops, void *data,
>  		iomap_actor_t actor);
> +loff_t iomap_apply2(struct inode *ino1, loff_t pos1, struct inode *ino2,
> +		loff_t pos2, loff_t length, unsigned int flags,
> +		const struct iomap_ops *ops, void *data, iomap_actor2_t actor);
>  
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops);
> -- 
> 2.31.0
> 
> 
> 
