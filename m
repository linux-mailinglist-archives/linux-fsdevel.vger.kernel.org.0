Return-Path: <linux-fsdevel+bounces-57383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2231B2102E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FAB7A7FCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C252E2F03;
	Mon, 11 Aug 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MOIkM5pS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942F27450
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925694; cv=none; b=iQZY4vhEw9cR29dABXVrEusl8vacRMyqB1SjOb7ebe4Ye/DOGHhSUBCf6CKB+Wayxc3bt3DGTNQ11KNM8CqNN1IKRa02hzNvAh5bRzbXEAbfaW7JY/fhlKUikE1kfVYF8ehbPz+ggVbrJIL8FSH3o+mn4PH7/TRITDpLhWURICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925694; c=relaxed/simple;
	bh=KoaCKpRcz2pcuzclB7c8T4G2Aqry0TNOxpFWFQmBoJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBIvyGuR5e/COHdLP6u1/yKXHHkOD98P3evKkab5pfkQgkDnV20SqJsWcbL2eFOuHPIM4L2N/VRRCkGUuVH0Nq2Jvawx7+CpWluhUs8rGKLZATE/R+sAYY7axrkfe0Y/PKBjr4jEoEBYQv9DogDKpGu4IIQQfhDMBsvE4tf2LZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MOIkM5pS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uNhW/Qj4AiEzXsHrZkbmlvnudfJwvnnC5E4PbuwrLU4=; b=MOIkM5pSMGXteg/sk7lNTd6KVu
	ovXi4boULEEdGPWFIuFSbF8snBcNe6ymdwz+vLvgst/6gBezVOPNXAe3x+gZHqeFhTpaL3xHMP6fN
	HocTtKOfxKYSD/P1xTDZtIAwJHlEaE+D5Dxo/+idHP64kCHMDyxo9oszuj0hm3cjspZnzYljCg3a7
	xfDoRlwi8sibt9FnreZHrTrf+g1lQ7L/Ql2rYSMhjfGd6hojRFRP3gXUq4CEshORzv42vHyS4gMUp
	r/5wyFyYs5AGlBbdH9/JzPjLMd2Hi17r/bKH5HkAMakHLee+u/uxDKk9B6XA+v2DKfgd8AQ/txJ7l
	X51R9GPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulUL0-00000006tKr-3FXm;
	Mon, 11 Aug 2025 15:21:27 +0000
Date: Mon, 11 Aug 2025 16:21:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH RFC] fs/buffer: fix use-after-free when call bh_read()
 helper
Message-ID: <aJoKdtFcqcG8Y48U@casper.infradead.org>
References: <20250811141830.343774-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811141830.343774-1-yebin@huaweicloud.com>

On Mon, Aug 11, 2025 at 10:18:30PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
> BUG: KASAN: stack-out-of-bounds in end_buffer_read_sync+0xe3/0x110
> Read of size 8 at addr ffffc9000168f7f8 by task swapper/3/0
> CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.16.0-862.14.0.6.x86_64
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x55/0x70
>  print_address_description.constprop.0+0x2c/0x390
>  print_report+0xb4/0x270
>  kasan_report+0xb8/0xf0
>  end_buffer_read_sync+0xe3/0x110
>  end_bio_bh_io_sync+0x56/0x80
>  blk_update_request+0x30a/0x720
>  scsi_end_request+0x51/0x2b0
>  scsi_io_completion+0xe3/0x480
>  ? scsi_device_unbusy+0x11e/0x160
>  blk_complete_reqs+0x7b/0x90
>  handle_softirqs+0xef/0x370
>  irq_exit_rcu+0xa5/0xd0
>  sysvec_apic_timer_interrupt+0x6e/0x90
>  </IRQ>
> 
>  Above issue happens when do ntfs3 filesystem mount, issue may happens
>  as follows:
>            mount                            IRQ
> ntfs_fill_super
>   read_cache_page
>     do_read_cache_folio
>       filemap_read_folio
>         mpage_read_folio
> 	 do_mpage_readpage
> 	  ntfs_get_block_vbo
> 	   bh_read
> 	     submit_bh
> 	     wait_on_buffer(bh);
> 	                            blk_complete_reqs
> 				     scsi_io_completion
> 				      scsi_end_request
> 				       blk_update_request
> 				        end_bio_bh_io_sync
> 					 end_buffer_read_sync
> 					  __end_buffer_read_notouch
> 					   unlock_buffer
> 
>             wait_on_buffer(bh);--> return will return to caller
> 
> 					  put_bh
> 					    --> trigger stack-out-of-bounds
> In the mpage_read_folio() function, the stack variable 'map_bh' is
> passed to ntfs_get_block_vbo(). Once unlock_buffer() unlocks and
> wait_on_buffer() returns to continue processing, the stack variable
> is likely to be reclaimed. Consequently, during the end_buffer_read_sync()
> process, calling put_bh() may result in stack overrun.

All good to here.

> If it is not a stack variable, since the reference count of the
> buffer_head is released after unlocking, it cannot be released during
> drop_buffers. This poses a risk of buffer_head leakage.
> To solve above issue first call put_bh() before unlock_buffer. This
> should be safe because during the release, discard_buffer() will call
> lock_buffer().

I find this part of the explanation hard to follow and I thought there
was a mistake here.  However after tracing through what would happen in
gfs2_metapath_ra() and __ext4_sb_bread_gfp(), I don't see a problem.

So here's a replacement paragraph:

If the bh is not allocated on the stack, it belongs to a folio.  Freeing a
buffer head which belongs to a folio is done by drop_buffers() which
will fail to free buffers which are still locked.  So it is safe to call
put_bh() before __end_buffer_read_notouch().

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I'll also note that we have a bunch of weird corruptions with ntfs3
and this might explain them.  Also this isn't really an ntfs3 bug,
but ntfs3 might be the only in-tree filesystem which happens to use
map_bh like this.  It's bad for performance to do it this way, but
if all you're trying to do is get a working filesystem, this is a
simple way to do things.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ead4dc85debd..6a8752f7bbed 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -157,8 +157,8 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
>   */
>  void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
>  {
> -	__end_buffer_read_notouch(bh, uptodate);
>  	put_bh(bh);
> +	__end_buffer_read_notouch(bh, uptodate);
>  }
>  EXPORT_SYMBOL(end_buffer_read_sync);
>  
> -- 
> 2.34.1
> 
> 

