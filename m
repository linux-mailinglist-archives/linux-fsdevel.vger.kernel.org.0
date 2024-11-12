Return-Path: <linux-fsdevel+bounces-34481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161089C6267
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2A3B434E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AEC2309BF;
	Tue, 12 Nov 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZonWo7C6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831920694A
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429295; cv=none; b=ODE3S5y9ibfN4o8dnvQJ8+YtTJqJPybMdnRqtOj5HcD5mERN9zaMyc0b/Pfphr439sxHpzMwneIHb7Xfz1ZEtMkswT1g+T/Mo2ZVNImwuTB+6dVrfRy8g9+Mo3tB7fOeqGaON3sLFciOE8/fafVAOiR2h/rD7FxdjUbinE+YwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429295; c=relaxed/simple;
	bh=maejiSruHV87Y+aXMuzBMKh+5AM/W/xMedlQ3gYipAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovMEgsqhedFaaR76Oijy4iuduVSSQL7eIdxv9NeRxIeBbHKe0Z1bb5xLsS0Cg2x8hJOUmDwYVMmdWb2Wl4cMfuAKDTaZkHvIi8sXjSzaQIKtoMzon9s3xGMC9n7UjqRE1rqCxQIwh96KsxbqB8EmlEbspa6vuEQD1G+NDl2xwqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZonWo7C6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731429293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKB5Z1lLpeLT0LZ+NAjLFKIK23L71bpb9LtJKKAzd7w=;
	b=ZonWo7C6h+jUpGYzpH+ZTegK102nQI2Zx/tVlh3/wWm+hvsKx23IFICcZ+PqqqBiJDNOjL
	6JtFoGZgeJo+Na4gMoGAOTKiKifaJiBCMcsH0vXDh1dXGQugJfggFfXYIaT+lQflhwkAEv
	em129YKwgetzH+MusIz/79qqMKpBSjI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-gwL-hOU5MVeY31HFqQOAlA-1; Tue,
 12 Nov 2024 11:34:47 -0500
X-MC-Unique: gwL-hOU5MVeY31HFqQOAlA-1
X-Mimecast-MFC-AGG-ID: gwL-hOU5MVeY31HFqQOAlA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABAB61956096;
	Tue, 12 Nov 2024 16:34:44 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28C6330000DF;
	Tue, 12 Nov 2024 16:34:41 +0000 (UTC)
Date: Tue, 12 Nov 2024 11:36:14 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/16] ext4: add RWF_UNCACHED write support
Message-ID: <ZzOD_qV5tpv9nbw7@bfoster>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-13-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111234842.2024180-13-axboe@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Nov 11, 2024 at 04:37:39PM -0700, Jens Axboe wrote:
> IOCB_UNCACHED IO needs to prune writeback regions on IO completion,
> and hence need the worker punt that ext4 also does for unwritten
> extents. Add an io_end flag to manage that.
> 
> If foliop is set to foliop_uncached in ext4_write_begin(), then set
> FGP_UNCACHED so that __filemap_get_folio() will mark newly created
> folios as uncached. That in turn will make writeback completion drop
> these ranges from the page cache.
> 
> Now that ext4 supports both uncached reads and writes, add the fop_flag
> FOP_UNCACHED to enable it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/ext4/ext4.h    |  1 +
>  fs/ext4/file.c    |  2 +-
>  fs/ext4/inline.c  |  7 ++++++-
>  fs/ext4/inode.c   | 18 ++++++++++++++++--
>  fs/ext4/page-io.c | 28 ++++++++++++++++------------
>  5 files changed, 40 insertions(+), 16 deletions(-)
> 
...
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 54bdd4884fe6..afae3ab64c9e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1138,6 +1138,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  	int ret, needed_blocks;
>  	handle_t *handle;
>  	int retries = 0;
> +	fgf_t fgp_flags;
>  	struct folio *folio;
>  	pgoff_t index;
>  	unsigned from, to;
> @@ -1164,6 +1165,15 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  			return 0;
>  	}
>  
> +	/*
> +	 * Set FGP_WRITEBEGIN, and FGP_UNCACHED if foliop contains
> +	 * foliop_uncached. That's how generic_perform_write() informs us
> +	 * that this is an uncached write.
> +	 */
> +	fgp_flags = FGP_WRITEBEGIN;
> +	if (*foliop == foliop_uncached)
> +		fgp_flags |= FGP_UNCACHED;
> +
>  	/*
>  	 * __filemap_get_folio() can take a long time if the
>  	 * system is thrashing due to memory pressure, or if the folio
> @@ -1172,7 +1182,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  	 * the folio (if needed) without using GFP_NOFS.
>  	 */
>  retry_grab:
> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> +	folio = __filemap_get_folio(mapping, index, fgp_flags,
>  					mapping_gfp_mask(mapping));
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);

JFYI, I notice that ext4 cycles the folio lock here in this path and
thus follows up with a couple checks presumably to accommodate that. One
is whether i_mapping has changed, which I assume means uncached state
would have been handled/cleared externally somewhere..? I.e., if an
uncached folio is somehow truncated/freed without ever having been
written back?

The next is a folio_wait_stable() call "in case writeback began ..."
It's not immediately clear to me if that is possible here, but taking
that at face value, is it an issue if we were to create an uncached
folio, drop the folio lock, then have some other task dirty and
writeback the folio (due to a sync write or something), then have
writeback completion invalidate the folio before we relock it here?

Brian

> @@ -2903,6 +2913,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  	struct folio *folio;
>  	pgoff_t index;
>  	struct inode *inode = mapping->host;
> +	fgf_t fgp_flags;
>  
>  	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
>  		return -EIO;
> @@ -2926,8 +2937,11 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  			return 0;
>  	}
>  
> +	fgp_flags = FGP_WRITEBEGIN;
> +	if (*foliop == foliop_uncached)
> +		fgp_flags |= FGP_UNCACHED;
>  retry:
> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> +	folio = __filemap_get_folio(mapping, index, fgp_flags,
>  			mapping_gfp_mask(mapping));
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index ad5543866d21..10447c3c4ff1 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -226,8 +226,6 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
>  	unsigned long flags;
>  
>  	/* Only reserved conversions from writeback should enter here */
> -	WARN_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
> -	WARN_ON(!io_end->handle && sbi->s_journal);
>  	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
>  	wq = sbi->rsv_conversion_wq;
>  	if (list_empty(&ei->i_rsv_conversion_list))
> @@ -252,7 +250,7 @@ static int ext4_do_flush_completed_IO(struct inode *inode,
>  
>  	while (!list_empty(&unwritten)) {
>  		io_end = list_entry(unwritten.next, ext4_io_end_t, list);
> -		BUG_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
> +		BUG_ON(!(io_end->flag & (EXT4_IO_END_UNWRITTEN|EXT4_IO_UNCACHED)));
>  		list_del_init(&io_end->list);
>  
>  		err = ext4_end_io_end(io_end);
> @@ -287,14 +285,15 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
>  
>  void ext4_put_io_end_defer(ext4_io_end_t *io_end)
>  {
> -	if (refcount_dec_and_test(&io_end->count)) {
> -		if (!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
> -				list_empty(&io_end->list_vec)) {
> -			ext4_release_io_end(io_end);
> -			return;
> -		}
> -		ext4_add_complete_io(io_end);
> +	if (!refcount_dec_and_test(&io_end->count))
> +		return;
> +	if ((!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
> +	    list_empty(&io_end->list_vec)) &&
> +	    !(io_end->flag & EXT4_IO_UNCACHED)) {
> +		ext4_release_io_end(io_end);
> +		return;
>  	}
> +	ext4_add_complete_io(io_end);
>  }
>  
>  int ext4_put_io_end(ext4_io_end_t *io_end)
> @@ -348,7 +347,7 @@ static void ext4_end_bio(struct bio *bio)
>  				blk_status_to_errno(bio->bi_status));
>  	}
>  
> -	if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
> +	if (io_end->flag & (EXT4_IO_END_UNWRITTEN|EXT4_IO_UNCACHED)) {
>  		/*
>  		 * Link bio into list hanging from io_end. We have to do it
>  		 * atomically as bio completions can be racing against each
> @@ -417,8 +416,13 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
>  submit_and_retry:
>  		ext4_io_submit(io);
>  	}
> -	if (io->io_bio == NULL)
> +	if (io->io_bio == NULL) {
>  		io_submit_init_bio(io, bh);
> +		if (folio_test_uncached(folio)) {
> +			ext4_io_end_t *io_end = io->io_bio->bi_private;
> +			io_end->flag |= EXT4_IO_UNCACHED;
> +		}
> +	}
>  	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
>  		goto submit_and_retry;
>  	wbc_account_cgroup_owner(io->io_wbc, &folio->page, bh->b_size);
> -- 
> 2.45.2
> 
> 


