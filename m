Return-Path: <linux-fsdevel+bounces-37872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F789F8321
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA85C1886AEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEF01A0B05;
	Thu, 19 Dec 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnLQzB+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AA19CD1E;
	Thu, 19 Dec 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632433; cv=none; b=YdUd8BP2dsAvk6h90HNj3mXNeKo9xdKb3HkaqnyIVUYSJGyBsKjU7x86yJFqpN+snA4H+I/KkAJPJtt5DgftBr2e6tNzkxSbVL7GXkajLO5fZo3snd3e3i9AmAZg+5wPBxOkCQGB+6trl9yJZikL1oCaKDQOye8d93Szejv765o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632433; c=relaxed/simple;
	bh=4707J7vFyNwLwoM+xdo2BDcpOtHkno4rauLpQEqO62E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9sqP8WHz95JYaqyz/2MEIS8RnhgJlEKK69TWZbELgXH1d2WbRwqyaO/69jYk2n0T2ZRKAw78Fp8aMN4We1OAipWTSJPBlhIBAQesD9vXzeDitbuNOgAsC301ERpOMHUbLuVuCqKokJluS7Ke/DwETCXmayiLpOP7G2plQKCK8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnLQzB+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF7BC4CECE;
	Thu, 19 Dec 2024 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734632432;
	bh=4707J7vFyNwLwoM+xdo2BDcpOtHkno4rauLpQEqO62E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnLQzB+sSQW1r6fIgydrpgmc+B1Ix0/1uOLhhdqmz9PYmQhQsoW4oGpHC+im2eAXA
	 LkTsFu4ANVGUw1mwseiFo3c4C1xH1eXLoCLQka3B79UaqAefvOdqXmNipVE21ZLIZ8
	 VdDXB89btTyXQHNqeOwll7TTKBA/VRJDtUfIhTP6WSi3pzazwxuqSrD7yt2/lUJdXP
	 3zonaVBdm1J8n29TK27I4cXjwFLGYbIeS4W/NdJjIHPbo90ynVICl8EwagI3wg3yN8
	 V2aJOJSxBNHsdvXEVqXaX20Mnrc+UdnePZAVHvL7lu5KAQOnl4jCmA7OPwnWu9QasG
	 y76TeJ/JwRTMQ==
Date: Thu, 19 Dec 2024 10:20:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/10] iomap: move common ioend code to ioend.c
Message-ID: <20241219182031.GE6156@frogsfrogsfrogs>
References: <20241219173954.22546-1-hch@lst.de>
 <20241219173954.22546-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219173954.22546-6-hch@lst.de>

On Thu, Dec 19, 2024 at 05:39:10PM +0000, Christoph Hellwig wrote:
> This code will be reused for direct I/O soon, so split it out of
> buffered-io.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This appears to be a straight rearranagement, so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 135 +----------------------------------------
>  fs/iomap/internal.h    |   9 +++
>  fs/iomap/ioend.c       | 127 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+), 133 deletions(-)
>  create mode 100644 fs/iomap/internal.h
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0b68c9584a7f..06b90d859d74 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -12,17 +12,15 @@
>  #include <linux/buffer_head.h>
>  #include <linux/dax.h>
>  #include <linux/writeback.h>
> -#include <linux/list_sort.h>
>  #include <linux/swap.h>
>  #include <linux/bio.h>
>  #include <linux/sched/signal.h>
>  #include <linux/migrate.h>
> +#include "internal.h"
>  #include "trace.h"
>  
>  #include "../internal.h"
>  
> -#define IOEND_BATCH_SIZE	4096
> -
>  /*
>   * Structure allocated for each folio to track per-block uptodate, dirty state
>   * and I/O completions.
> @@ -40,9 +38,6 @@ struct iomap_folio_state {
>  	unsigned long		state[];
>  };
>  
> -struct bio_set iomap_ioend_bioset;
> -EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
> -
>  static inline bool ifs_is_fully_uptodate(struct folio *folio,
>  		struct iomap_folio_state *ifs)
>  {
> @@ -1539,8 +1534,7 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>   * state, release holds on bios, and finally free up memory.  Do not use the
>   * ioend after this.
>   */
> -static u32
> -iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
> +u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
>  {
>  	struct inode *inode = ioend->io_inode;
>  	struct bio *bio = &ioend->io_bio;
> @@ -1567,123 +1561,6 @@ iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
>  	return folio_count;
>  }
>  
> -static u32
> -iomap_finish_ioend(struct iomap_ioend *ioend, int error)
> -{
> -	if (ioend->io_parent) {
> -		struct bio *bio = &ioend->io_bio;
> -
> -		ioend = ioend->io_parent;
> -		bio_put(bio);
> -	}
> -
> -	if (error)
> -		cmpxchg(&ioend->io_error, 0, error);
> -
> -	if (!atomic_dec_and_test(&ioend->io_remaining))
> -		return 0;
> -	return iomap_finish_ioend_buffered(ioend);
> -}
> -
> -/*
> - * Ioend completion routine for merged bios. This can only be called from task
> - * contexts as merged ioends can be of unbound length. Hence we have to break up
> - * the writeback completions into manageable chunks to avoid long scheduler
> - * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
> - * good batch processing throughput without creating adverse scheduler latency
> - * conditions.
> - */
> -void
> -iomap_finish_ioends(struct iomap_ioend *ioend, int error)
> -{
> -	struct list_head tmp;
> -	u32 completions;
> -
> -	might_sleep();
> -
> -	list_replace_init(&ioend->io_list, &tmp);
> -	completions = iomap_finish_ioend(ioend, error);
> -
> -	while (!list_empty(&tmp)) {
> -		if (completions > IOEND_BATCH_SIZE * 8) {
> -			cond_resched();
> -			completions = 0;
> -		}
> -		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
> -		list_del_init(&ioend->io_list);
> -		completions += iomap_finish_ioend(ioend, error);
> -	}
> -}
> -EXPORT_SYMBOL_GPL(iomap_finish_ioends);
> -
> -/*
> - * We can merge two adjacent ioends if they have the same set of work to do.
> - */
> -static bool
> -iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
> -{
> -	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
> -		return false;
> -	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
> -		return false;
> -	if ((ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> -	    (next->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
> -		return false;
> -	if (ioend->io_offset + ioend->io_size != next->io_offset)
> -		return false;
> -	/*
> -	 * Do not merge physically discontiguous ioends. The filesystem
> -	 * completion functions will have to iterate the physical
> -	 * discontiguities even if we merge the ioends at a logical level, so
> -	 * we don't gain anything by merging physical discontiguities here.
> -	 *
> -	 * We cannot use bio->bi_iter.bi_sector here as it is modified during
> -	 * submission so does not point to the start sector of the bio at
> -	 * completion.
> -	 */
> -	if (ioend->io_sector + (ioend->io_size >> 9) != next->io_sector)
> -		return false;
> -	return true;
> -}
> -
> -void
> -iomap_ioend_try_merge(struct iomap_ioend *ioend, struct list_head *more_ioends)
> -{
> -	struct iomap_ioend *next;
> -
> -	INIT_LIST_HEAD(&ioend->io_list);
> -
> -	while ((next = list_first_entry_or_null(more_ioends, struct iomap_ioend,
> -			io_list))) {
> -		if (!iomap_ioend_can_merge(ioend, next))
> -			break;
> -		list_move_tail(&next->io_list, &ioend->io_list);
> -		ioend->io_size += next->io_size;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
> -
> -static int
> -iomap_ioend_compare(void *priv, const struct list_head *a,
> -		const struct list_head *b)
> -{
> -	struct iomap_ioend *ia = container_of(a, struct iomap_ioend, io_list);
> -	struct iomap_ioend *ib = container_of(b, struct iomap_ioend, io_list);
> -
> -	if (ia->io_offset < ib->io_offset)
> -		return -1;
> -	if (ia->io_offset > ib->io_offset)
> -		return 1;
> -	return 0;
> -}
> -
> -void
> -iomap_sort_ioends(struct list_head *ioend_list)
> -{
> -	list_sort(NULL, ioend_list, iomap_ioend_compare);
> -}
> -EXPORT_SYMBOL_GPL(iomap_sort_ioends);
> -
>  static void iomap_writepage_end_bio(struct bio *bio)
>  {
>  	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
> @@ -2033,11 +1910,3 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  	return iomap_submit_ioend(wpc, error);
>  }
>  EXPORT_SYMBOL_GPL(iomap_writepages);
> -
> -static int __init iomap_buffered_init(void)
> -{
> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> -			   offsetof(struct iomap_ioend, io_bio),
> -			   BIOSET_NEED_BVECS);
> -}
> -fs_initcall(iomap_buffered_init);
> diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
> new file mode 100644
> index 000000000000..36d5c56e073e
> --- /dev/null
> +++ b/fs/iomap/internal.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _IOMAP_INTERNAL_H
> +#define _IOMAP_INTERNAL_H 1
> +
> +#define IOEND_BATCH_SIZE	4096
> +
> +u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
> +
> +#endif /* _IOMAP_INTERNAL_H */
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 1b032323ee4e..b4f6dd9e319a 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -3,6 +3,11 @@
>   * Copyright (c) 2024 Christoph Hellwig.
>   */
>  #include <linux/iomap.h>
> +#include <linux/list_sort.h>
> +#include "internal.h"
> +
> +struct bio_set iomap_ioend_bioset;
> +EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
>  
>  struct iomap_ioend *iomap_init_ioend(struct inode *inode,
>  		struct bio *bio, loff_t file_offset, u16 ioend_flags)
> @@ -22,6 +27,120 @@ struct iomap_ioend *iomap_init_ioend(struct inode *inode,
>  }
>  EXPORT_SYMBOL_GPL(iomap_init_ioend);
>  
> +static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
> +{
> +	if (ioend->io_parent) {
> +		struct bio *bio = &ioend->io_bio;
> +
> +		ioend = ioend->io_parent;
> +		bio_put(bio);
> +	}
> +
> +	if (error)
> +		cmpxchg(&ioend->io_error, 0, error);
> +
> +	if (!atomic_dec_and_test(&ioend->io_remaining))
> +		return 0;
> +	return iomap_finish_ioend_buffered(ioend);
> +}
> +
> +/*
> + * Ioend completion routine for merged bios. This can only be called from task
> + * contexts as merged ioends can be of unbound length. Hence we have to break up
> + * the writeback completions into manageable chunks to avoid long scheduler
> + * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
> + * good batch processing throughput without creating adverse scheduler latency
> + * conditions.
> + */
> +void iomap_finish_ioends(struct iomap_ioend *ioend, int error)
> +{
> +	struct list_head tmp;
> +	u32 completions;
> +
> +	might_sleep();
> +
> +	list_replace_init(&ioend->io_list, &tmp);
> +	completions = iomap_finish_ioend(ioend, error);
> +
> +	while (!list_empty(&tmp)) {
> +		if (completions > IOEND_BATCH_SIZE * 8) {
> +			cond_resched();
> +			completions = 0;
> +		}
> +		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
> +		list_del_init(&ioend->io_list);
> +		completions += iomap_finish_ioend(ioend, error);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(iomap_finish_ioends);
> +
> +/*
> + * We can merge two adjacent ioends if they have the same set of work to do.
> + */
> +static bool iomap_ioend_can_merge(struct iomap_ioend *ioend,
> +		struct iomap_ioend *next)
> +{
> +	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
> +		return false;
> +	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
> +		return false;
> +	if ((ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> +	    (next->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
> +		return false;
> +	if (ioend->io_offset + ioend->io_size != next->io_offset)
> +		return false;
> +	/*
> +	 * Do not merge physically discontiguous ioends. The filesystem
> +	 * completion functions will have to iterate the physical
> +	 * discontiguities even if we merge the ioends at a logical level, so
> +	 * we don't gain anything by merging physical discontiguities here.
> +	 *
> +	 * We cannot use bio->bi_iter.bi_sector here as it is modified during
> +	 * submission so does not point to the start sector of the bio at
> +	 * completion.
> +	 */
> +	if (ioend->io_sector + (ioend->io_size >> SECTOR_SHIFT) !=
> +	    next->io_sector)
> +		return false;
> +	return true;
> +}
> +
> +void iomap_ioend_try_merge(struct iomap_ioend *ioend,
> +		struct list_head *more_ioends)
> +{
> +	struct iomap_ioend *next;
> +
> +	INIT_LIST_HEAD(&ioend->io_list);
> +
> +	while ((next = list_first_entry_or_null(more_ioends, struct iomap_ioend,
> +			io_list))) {
> +		if (!iomap_ioend_can_merge(ioend, next))
> +			break;
> +		list_move_tail(&next->io_list, &ioend->io_list);
> +		ioend->io_size += next->io_size;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
> +
> +static int iomap_ioend_compare(void *priv, const struct list_head *a,
> +		const struct list_head *b)
> +{
> +	struct iomap_ioend *ia = container_of(a, struct iomap_ioend, io_list);
> +	struct iomap_ioend *ib = container_of(b, struct iomap_ioend, io_list);
> +
> +	if (ia->io_offset < ib->io_offset)
> +		return -1;
> +	if (ia->io_offset > ib->io_offset)
> +		return 1;
> +	return 0;
> +}
> +
> +void iomap_sort_ioends(struct list_head *ioend_list)
> +{
> +	list_sort(NULL, ioend_list, iomap_ioend_compare);
> +}
> +EXPORT_SYMBOL_GPL(iomap_sort_ioends);
> +
>  /*
>   * Split up to the first @max_len bytes from @ioend if the ioend covers more
>   * than @max_len bytes.
> @@ -84,3 +203,11 @@ struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
>  	return split_ioend;
>  }
>  EXPORT_SYMBOL_GPL(iomap_split_ioend);
> +
> +static int __init iomap_ioend_init(void)
> +{
> +	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> +			   offsetof(struct iomap_ioend, io_bio),
> +			   BIOSET_NEED_BVECS);
> +}
> +fs_initcall(iomap_ioend_init);
> -- 
> 2.45.2
> 
> 

