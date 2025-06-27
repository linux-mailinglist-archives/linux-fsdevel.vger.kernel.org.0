Return-Path: <linux-fsdevel+bounces-53196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB24AEBB6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 17:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788411C25563
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB292E92DD;
	Fri, 27 Jun 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOJzTE2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271D2E92C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037104; cv=none; b=MMgo5M8uUAOk40XNr33VrYKOe+4FoVaVf+3otXVYdQdXcEZZtfgLTKpALLQQyX8utVoF9Lf/6Jzgrh3e1XbK8N7xoBL2OIVRN58ea5CnBT/vSWLoNLI6AGO9D90MwLqhN8ahO3W5ZKWrA2Dzr2MC8YMj8/Z4gtbuPwUa3pE7S20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037104; c=relaxed/simple;
	bh=MSR1rZ6axrEW/nag1GsZtrsc2NYT0HlHk8EAzHpGXpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oc23fQAuEf5QXqPzNnp6kjer/JEMc99sAVSf76dq1qrwFse/D0qvi7/cedycWm93Uy//3jVlb07c5lTMq/xUbqpW1jXHCR0aMOWxw3lOjOKDKJbA1FVG3P4Tj0g+3GlNc2qx63LndmJN72c5jId6nzMrRuw6IW3e4F6fVi0yEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOJzTE2e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751037101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H5x/w8e+UV/VFoG6Hnar4e49cwam42RN12S0+F3Q+Qg=;
	b=eOJzTE2ektPXDy44kiqB2Hp/Ye5X03tWq/ILNuThYOqpgATEBxd2qXojKgM2/Ho2jE4j55
	V9AD6a9poBhRKQOlAoaAV6OC/gEU8BpYsNftLTZR5wBzsf+GLD8DG1dBMFODIn0cf1TNLe
	PGvZquDcNstU6a+aTnoatxPH0EZaP/M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-8o15-kfDNtOKXa3iBiaWfQ-1; Fri,
 27 Jun 2025 11:11:40 -0400
X-MC-Unique: 8o15-kfDNtOKXa3iBiaWfQ-1
X-Mimecast-MFC-AGG-ID: 8o15-kfDNtOKXa3iBiaWfQ_1751037098
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7D101809C9C;
	Fri, 27 Jun 2025 15:11:38 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.142])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9B1019560A7;
	Fri, 27 Jun 2025 15:11:36 +0000 (UTC)
Date: Fri, 27 Jun 2025 11:15:14 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 06/12] iomap: move all ioend handling to ioend.c
Message-ID: <aF61grplkxy7RXie@bfoster>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-7-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jun 27, 2025 at 09:02:39AM +0200, Christoph Hellwig wrote:
> Now that the writeback code has the proper abstractions, all the ioend
> code can be self-contained in ioend.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 215 ----------------------------------------
>  fs/iomap/internal.h    |   1 -
>  fs/iomap/ioend.c       | 220 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 219 insertions(+), 217 deletions(-)
> 
...
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 18894ebba6db..ce0a4c13d008 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -1,10 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2024-2025 Christoph Hellwig.
> + * Copyright (c) 2016-2025 Christoph Hellwig.
>   */
>  #include <linux/iomap.h>
>  #include <linux/list_sort.h>
> +#include <linux/pagemap.h>
> +#include <linux/writeback.h>
>  #include "internal.h"
> +#include "trace.h"

Can any of these now be dropped from buffered-io.c?

Otherwise LGTM:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  
>  struct bio_set iomap_ioend_bioset;
>  EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
> @@ -28,6 +31,221 @@ struct iomap_ioend *iomap_init_ioend(struct inode *inode,
>  }
>  EXPORT_SYMBOL_GPL(iomap_init_ioend);
>  
> +/*
> + * We're now finished for good with this ioend structure.  Update the folio
> + * state, release holds on bios, and finally free up memory.  Do not use the
> + * ioend after this.
> + */
> +static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
> +{
> +	struct inode *inode = ioend->io_inode;
> +	struct bio *bio = &ioend->io_bio;
> +	struct folio_iter fi;
> +	u32 folio_count = 0;
> +
> +	if (ioend->io_error) {
> +		mapping_set_error(inode->i_mapping, ioend->io_error);
> +		if (!bio_flagged(bio, BIO_QUIET)) {
> +			pr_err_ratelimited(
> +"%s: writeback error on inode %lu, offset %lld, sector %llu",
> +				inode->i_sb->s_id, inode->i_ino,
> +				ioend->io_offset, ioend->io_sector);
> +		}
> +	}
> +
> +	/* walk all folios in bio, ending page IO on them */
> +	bio_for_each_folio_all(fi, bio) {
> +		iomap_finish_folio_write(inode, fi.folio, fi.length);
> +		folio_count++;
> +	}
> +
> +	bio_put(bio);	/* frees the ioend */
> +	return folio_count;
> +}
> +
> +static void ioend_writeback_end_bio(struct bio *bio)
> +{
> +	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
> +
> +	ioend->io_error = blk_status_to_errno(bio->bi_status);
> +	iomap_finish_ioend_buffered(ioend);
> +}
> +
> +/*
> + * We cannot cancel the ioend directly in case of an error, so call the bio end
> + * I/O handler with the error status here to run the normal I/O completion
> + * handler.
> + */
> +int ioend_writeback_submit(struct iomap_writeback_ctx *wpc, int error)
> +{
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
> +
> +	if (!ioend->io_bio.bi_end_io)
> +		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
> +
> +	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
> +		error = -EIO;
> +
> +	if (error) {
> +		ioend->io_bio.bi_status = errno_to_blk_status(error);
> +		bio_endio(&ioend->io_bio);
> +		return error;
> +	}
> +
> +	submit_bio(&ioend->io_bio);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ioend_writeback_submit);
> +
> +static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writeback_ctx *wpc,
> +		loff_t pos, u16 ioend_flags)
> +{
> +	struct bio *bio;
> +
> +	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
> +			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
> +			       GFP_NOFS, &iomap_ioend_bioset);
> +	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
> +	bio->bi_write_hint = wpc->inode->i_write_hint;
> +	wbc_init_bio(wpc->wbc, bio);
> +	wpc->nr_folios = 0;
> +	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
> +}
> +
> +static bool iomap_can_add_to_ioend(struct iomap_writeback_ctx *wpc, loff_t pos,
> +		u16 ioend_flags)
> +{
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
> +
> +	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
> +		return false;
> +	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> +	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
> +		return false;
> +	if (pos != ioend->io_offset + ioend->io_size)
> +		return false;
> +	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
> +	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
> +		return false;
> +	/*
> +	 * Limit ioend bio chain lengths to minimise IO completion latency. This
> +	 * also prevents long tight loops ending page writeback on all the
> +	 * folios in the ioend.
> +	 */
> +	if (wpc->nr_folios >= IOEND_BATCH_SIZE)
> +		return false;
> +	return true;
> +}
> +
> +/*
> + * Test to see if we have an existing ioend structure that we could append to
> + * first; otherwise finish off the current ioend and start another.
> + *
> + * If a new ioend is created and cached, the old ioend is submitted to the block
> + * layer instantly.  Batching optimisations are provided by higher level block
> + * plugging.
> + *
> + * At the end of a writeback pass, there will be a cached ioend remaining on the
> + * writepage context that the caller will need to submit.
> + */
> +ssize_t iomap_add_to_ioend(struct iomap_writeback_ctx *wpc, struct folio *folio,
> +		loff_t pos, loff_t end_pos, unsigned int dirty_len)
> +{
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
> +	size_t poff = offset_in_folio(folio, pos);
> +	unsigned int ioend_flags = 0;
> +	unsigned int map_len = min_t(u64, dirty_len,
> +		wpc->iomap.offset + wpc->iomap.length - pos);
> +	int error;
> +
> +	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
> +
> +	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> +
> +	switch (wpc->iomap.type) {
> +	case IOMAP_INLINE:
> +		WARN_ON_ONCE(1);
> +		return -EIO;
> +	case IOMAP_HOLE:
> +		return map_len;
> +	default:
> +		break;
> +	}
> +
> +	if (wpc->iomap.type == IOMAP_UNWRITTEN)
> +		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
> +	if (wpc->iomap.flags & IOMAP_F_SHARED)
> +		ioend_flags |= IOMAP_IOEND_SHARED;
> +	if (folio_test_dropbehind(folio))
> +		ioend_flags |= IOMAP_IOEND_DONTCACHE;
> +	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
> +		ioend_flags |= IOMAP_IOEND_BOUNDARY;
> +
> +	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
> +new_ioend:
> +		if (ioend) {
> +			error = wpc->ops->writeback_submit(wpc, 0);
> +			if (error)
> +				return error;
> +		}
> +		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
> +	}
> +
> +	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
> +		goto new_ioend;
> +
> +	iomap_start_folio_write(wpc->inode, folio, map_len);
> +
> +	/*
> +	 * Clamp io_offset and io_size to the incore EOF so that ondisk
> +	 * file size updates in the ioend completion are byte-accurate.
> +	 * This avoids recovering files with zeroed tail regions when
> +	 * writeback races with appending writes:
> +	 *
> +	 *    Thread 1:                  Thread 2:
> +	 *    ------------               -----------
> +	 *    write [A, A+B]
> +	 *    update inode size to A+B
> +	 *    submit I/O [A, A+BS]
> +	 *                               write [A+B, A+B+C]
> +	 *                               update inode size to A+B+C
> +	 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
> +	 *    <power failure>
> +	 *
> +	 *  After reboot:
> +	 *    1) with A+B+C < A+BS, the file has zero padding in range
> +	 *       [A+B, A+B+C]
> +	 *
> +	 *    |<     Block Size (BS)   >|
> +	 *    |DDDDDDDDDDDD0000000000000|
> +	 *    ^           ^        ^
> +	 *    A          A+B     A+B+C
> +	 *                       (EOF)
> +	 *
> +	 *    2) with A+B+C > A+BS, the file has zero padding in range
> +	 *       [A+B, A+BS]
> +	 *
> +	 *    |<     Block Size (BS)   >|<     Block Size (BS)    >|
> +	 *    |DDDDDDDDDDDD0000000000000|00000000000000000000000000|
> +	 *    ^           ^             ^           ^
> +	 *    A          A+B           A+BS       A+B+C
> +	 *                             (EOF)
> +	 *
> +	 *    D = Valid Data
> +	 *    0 = Zero Padding
> +	 *
> +	 * Note that this defeats the ability to chain the ioends of
> +	 * appending writes.
> +	 */
> +	ioend->io_size += map_len;
> +	if (ioend->io_offset + ioend->io_size > end_pos)
> +		ioend->io_size = end_pos - ioend->io_offset;
> +
> +	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
> +	return map_len;
> +}
> +EXPORT_SYMBOL_GPL(iomap_add_to_ioend);
> +
>  static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  {
>  	if (ioend->io_parent) {
> -- 
> 2.47.2
> 
> 


