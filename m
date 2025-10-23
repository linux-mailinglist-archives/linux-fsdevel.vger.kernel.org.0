Return-Path: <linux-fsdevel+bounces-65380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C2AC032EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 21:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E4B1A65D9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ACC34BA57;
	Thu, 23 Oct 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+92uYm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CDE2BE036
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247816; cv=none; b=nCsDgk1xpqlCKX3qtYK2gcC+n+m4hZ+hNqR9wEy9XJjaSkRfk94/tJzIlKZVAZOXg+r0XuGtqBJZaLxSph6+1i0nAKYRLdhZy79zajNfTBfo3doqY6k+LAHnk5QKxfwr1PzOB+aptn8XfaCFGvawny+3ipUE3l+/Um5eYOCF1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247816; c=relaxed/simple;
	bh=vqsheNeYfahjh24ulsA4y8pzCWmedUOmXU6VdEqLlcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUcsYRzuJwAyKIWH2CzZCTF1i0yPGBpd0yroXSaICYrUjSVYNiu/141YvbGl67ixyqK2+Q1aOcMzpL3cfAThp3bRyV0L2AAgaH149eWSW3e7dmCQyfWEy4uOT+raYbtHdL1dctrzrSWDVmm2Xf0opbFlmzhqatHZk0jSt/m3Ns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+92uYm5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761247813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJO+XRD2i+F/gyWfgm3P7eI43LJ5KyVADgPitJjDTp4=;
	b=X+92uYm5JmQ0a8cOySkQbN7iRCzAmtQHdJLecEdrtLY1UXMvzOL7RiM5Mtuk4ua3cbgWSF
	SuzUfdXmk+ETHjfawYIOY4xrsHUuJajGyrYgqRt7sD/YnOoM1xpGxCHUQsydO1S7drfGu5
	CiKBwZ9oR3ZHf2H7N1i6hAJxos/4hxQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-xuj3Hdu1N6qj8hKcwQYhBw-1; Thu,
 23 Oct 2025 15:30:09 -0400
X-MC-Unique: xuj3Hdu1N6qj8hKcwQYhBw-1
X-Mimecast-MFC-AGG-ID: xuj3Hdu1N6qj8hKcwQYhBw_1761247807
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FED21801377;
	Thu, 23 Oct 2025 19:30:06 +0000 (UTC)
Received: from bfoster (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE402195398C;
	Thu, 23 Oct 2025 19:30:03 +0000 (UTC)
Date: Thu, 23 Oct 2025 15:34:22 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org,
	hch@infradead.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
Message-ID: <aPqDPjnIaR3EF5Lt@bfoster>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926002609.1302233-8-joannelkoong@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Sep 25, 2025 at 05:26:02PM -0700, Joanne Koong wrote:
> Instead of incrementing read_bytes_pending for every folio range read in
> (which requires acquiring the spinlock to do so), set read_bytes_pending
> to the folio size when the first range is asynchronously read in, keep
> track of how many bytes total are asynchronously read in, and adjust
> read_bytes_pending accordingly after issuing requests to read in all the
> necessary ranges.
> 
> iomap_read_folio_ctx->cur_folio_in_bio can be removed since a non-zero
> value for pending bytes necessarily indicates the folio is in the bio.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Hi Joanne,

I was throwing some extra testing at the vfs-6.19.iomap branch since the
little merge conflict thing with iomap_iter_advance(). I end up hitting
what appears to be a lockup on XFS with 1k FSB (-bsize=1k) running
generic/051. It reproduces fairly reliably within a few iterations or so
and seems to always stall during a read for a dedupe operation:

task:fsstress        state:D stack:0     pid:12094 tgid:12094 ppid:12091  task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 __schedule+0x2fc/0x7a0
 schedule+0x27/0x80
 io_schedule+0x46/0x70
 folio_wait_bit_common+0x12b/0x310
 ? __pfx_wake_page_function+0x10/0x10
 ? __pfx_xfs_vm_read_folio+0x10/0x10 [xfs]
 filemap_read_folio+0x85/0xd0
 ? __pfx_xfs_vm_read_folio+0x10/0x10 [xfs]
 do_read_cache_folio+0x7c/0x1b0
 vfs_dedupe_file_range_compare.constprop.0+0xaf/0x2d0
 __generic_remap_file_range_prep+0x276/0x2a0
 generic_remap_file_range_prep+0x10/0x20
 xfs_reflink_remap_prep+0x22c/0x300 [xfs]
 xfs_file_remap_range+0x84/0x360 [xfs]
 vfs_dedupe_file_range_one+0x1b2/0x1d0
 ? remap_verify_area+0x46/0x140
 vfs_dedupe_file_range+0x162/0x220
 do_vfs_ioctl+0x4d1/0x940
 __x64_sys_ioctl+0x75/0xe0
 do_syscall_64+0x84/0x800
 ? do_syscall_64+0xbb/0x800
 ? avc_has_perm_noaudit+0x6b/0xf0
 ? _copy_to_user+0x31/0x40
 ? cp_new_stat+0x130/0x170
 ? __do_sys_newfstat+0x44/0x70
 ? do_syscall_64+0xbb/0x800
 ? do_syscall_64+0xbb/0x800
 ? clear_bhb_loop+0x30/0x80
 ? clear_bhb_loop+0x30/0x80
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fe6bbd9a14d
RSP: 002b:00007ffde72cd4e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000068 RCX: 00007fe6bbd9a14d
RDX: 000000000a1394b0 RSI: 00000000c0189436 RDI: 0000000000000004
RBP: 00007ffde72cd530 R08: 0000000000001000 R09: 000000000a11a3fc
R10: 000000000001d6c0 R11: 0000000000000246 R12: 000000000a12cfb0
R13: 000000000a12ba10 R14: 000000000a14e610 R15: 0000000000019000
 </TASK>

It wasn't immediately clear to me what the issue was so I bisected and
it landed on this patch. It kind of looks like we're failing to unlock a
folio at some point and then tripping over it later..? I can kill the
fsstress process but then the umount ultimately gets stuck tossing
pagecache [1], so the mount still ends up stuck indefinitely. Anyways,
I'll poke at it some more but I figure you might be able to make sense
of this faster than I can.

Brian

[1] umount stack trace: 

task:umount          state:D stack:0     pid:12216 tgid:12216 ppid:2514   task_flags:0x400100 flags:0x00080001
Call Trace:
 <TASK>
 __schedule+0x2fc/0x7a0
 schedule+0x27/0x80
 io_schedule+0x46/0x70
 folio_wait_bit_common+0x12b/0x310
 ? __pfx_wake_page_function+0x10/0x10
 truncate_inode_pages_range+0x42a/0x4d0
 xfs_fs_evict_inode+0x1f/0x30 [xfs]
 evict+0x112/0x290
 evict_inodes+0x209/0x230
 generic_shutdown_super+0x42/0x100
 kill_block_super+0x1a/0x40
 xfs_kill_sb+0x12/0x20 [xfs]
 deactivate_locked_super+0x33/0xb0
 cleanup_mnt+0xba/0x150
 task_work_run+0x5c/0x90
 exit_to_user_mode_loop+0x12f/0x170
 do_syscall_64+0x1af/0x800
 ? vfs_statx+0x80/0x160
 ? do_statx+0x62/0xa0
 ? __x64_sys_statx+0xaf/0x100
 ? do_syscall_64+0xbb/0x800
 ? __x64_sys_statx+0xaf/0x100
 ? do_syscall_64+0xbb/0x800
 ? count_memcg_events+0xdd/0x1b0
 ? handle_mm_fault+0x220/0x340
 ? do_user_addr_fault+0x2c3/0x7f0
 ? clear_bhb_loop+0x30/0x80
 ? clear_bhb_loop+0x30/0x80
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fdd641ed5ab
RSP: 002b:00007ffd671182e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000559b3e2056b0 RCX: 00007fdd641ed5ab
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000559b3e205ac0
RBP: 00007ffd671183c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000103 R11: 0000000000000246 R12: 0000559b3e2057b8
R13: 0000000000000000 R14: 0000559b3e205ac0 R15: 0000000000000000
 </TASK>

>  fs/iomap/buffered-io.c | 87 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 66 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 09e65771a947..4e6258fdb915 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -362,7 +362,6 @@ static void iomap_read_end_io(struct bio *bio)
>  
>  struct iomap_read_folio_ctx {
>  	struct folio		*cur_folio;
> -	bool			cur_folio_in_bio;
>  	void			*read_ctx;
>  	struct readahead_control *rac;
>  };
> @@ -380,19 +379,11 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  {
>  	struct folio *folio = ctx->cur_folio;
>  	const struct iomap *iomap = &iter->iomap;
> -	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
>  	loff_t length = iomap_length(iter);
>  	sector_t sector;
>  	struct bio *bio = ctx->read_ctx;
>  
> -	ctx->cur_folio_in_bio = true;
> -	if (ifs) {
> -		spin_lock_irq(&ifs->state_lock);
> -		ifs->read_bytes_pending += plen;
> -		spin_unlock_irq(&ifs->state_lock);
> -	}
> -
>  	sector = iomap_sector(iomap, pos);
>  	if (!bio || bio_end_sector(bio) != sector ||
>  	    !bio_add_folio(bio, folio, plen, poff)) {
> @@ -422,8 +413,57 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  	}
>  }
>  
> +static void iomap_read_init(struct folio *folio)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +
> +	if (ifs) {
> +		size_t len = folio_size(folio);
> +
> +		spin_lock_irq(&ifs->state_lock);
> +		ifs->read_bytes_pending += len;
> +		spin_unlock_irq(&ifs->state_lock);
> +	}
> +}
> +
> +static void iomap_read_end(struct folio *folio, size_t bytes_pending)
> +{
> +	struct iomap_folio_state *ifs;
> +
> +	/*
> +	 * If there are no bytes pending, this means we are responsible for
> +	 * unlocking the folio here, since no IO helper has taken ownership of
> +	 * it.
> +	 */
> +	if (!bytes_pending) {
> +		folio_unlock(folio);
> +		return;
> +	}
> +
> +	ifs = folio->private;
> +	if (ifs) {
> +		bool end_read, uptodate;
> +		size_t bytes_accounted = folio_size(folio) - bytes_pending;
> +
> +		spin_lock_irq(&ifs->state_lock);
> +		ifs->read_bytes_pending -= bytes_accounted;
> +		/*
> +		 * If !ifs->read_bytes_pending, this means all pending reads
> +		 * by the IO helper have already completed, which means we need
> +		 * to end the folio read here. If ifs->read_bytes_pending != 0,
> +		 * the IO helper will end the folio read.
> +		 */
> +		end_read = !ifs->read_bytes_pending;
> +		if (end_read)
> +			uptodate = ifs_is_fully_uptodate(folio, ifs);
> +		spin_unlock_irq(&ifs->state_lock);
> +		if (end_read)
> +			folio_end_read(folio, uptodate);
> +	}
> +}
> +
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, size_t *bytes_pending)
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	loff_t pos = iter->pos;
> @@ -460,6 +500,9 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  			folio_zero_range(folio, poff, plen);
>  			iomap_set_range_uptodate(folio, poff, plen);
>  		} else {
> +			if (!*bytes_pending)
> +				iomap_read_init(folio);
> +			*bytes_pending += plen;
>  			iomap_bio_read_folio_range(iter, ctx, pos, plen);
>  		}
>  
> @@ -482,17 +525,18 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	struct iomap_read_folio_ctx ctx = {
>  		.cur_folio	= folio,
>  	};
> +	size_t bytes_pending = 0;
>  	int ret;
>  
>  	trace_iomap_readpage(iter.inode, 1);
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.status = iomap_read_folio_iter(&iter, &ctx);
> +		iter.status = iomap_read_folio_iter(&iter, &ctx,
> +				&bytes_pending);
>  
>  	iomap_bio_submit_read(&ctx);
>  
> -	if (!ctx.cur_folio_in_bio)
> -		folio_unlock(folio);
> +	iomap_read_end(folio, bytes_pending);
>  
>  	/*
>  	 * Just like mpage_readahead and block_read_full_folio, we always
> @@ -504,24 +548,23 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>  
>  static int iomap_readahead_iter(struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, size_t *cur_bytes_pending)
>  {
>  	int ret;
>  
>  	while (iomap_length(iter)) {
>  		if (ctx->cur_folio &&
>  		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
> -			if (!ctx->cur_folio_in_bio)
> -				folio_unlock(ctx->cur_folio);
> +			iomap_read_end(ctx->cur_folio, *cur_bytes_pending);
>  			ctx->cur_folio = NULL;
>  		}
>  		if (!ctx->cur_folio) {
>  			ctx->cur_folio = readahead_folio(ctx->rac);
>  			if (WARN_ON_ONCE(!ctx->cur_folio))
>  				return -EINVAL;
> -			ctx->cur_folio_in_bio = false;
> +			*cur_bytes_pending = 0;
>  		}
> -		ret = iomap_read_folio_iter(iter, ctx);
> +		ret = iomap_read_folio_iter(iter, ctx, cur_bytes_pending);
>  		if (ret)
>  			return ret;
>  	}
> @@ -554,16 +597,18 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  	struct iomap_read_folio_ctx ctx = {
>  		.rac	= rac,
>  	};
> +	size_t cur_bytes_pending;
>  
>  	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
>  
>  	while (iomap_iter(&iter, ops) > 0)
> -		iter.status = iomap_readahead_iter(&iter, &ctx);
> +		iter.status = iomap_readahead_iter(&iter, &ctx,
> +					&cur_bytes_pending);
>  
>  	iomap_bio_submit_read(&ctx);
>  
> -	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
> -		folio_unlock(ctx.cur_folio);
> +	if (ctx.cur_folio)
> +		iomap_read_end(ctx.cur_folio, cur_bytes_pending);
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> -- 
> 2.47.3
> 
> 


