Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0023B696C70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 19:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjBNSJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 13:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjBNSJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:09:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BD5B4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 10:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676398132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjcdhS05rmuEMZxa+twXLjmdNPlmuoeDRI4X82wtvAM=;
        b=K4ESRb592VTb8YDK8dg66eIs3B5+LrQ6hc3gj4YaN1qqO3s43Iz1/2nguqWVy7lUhDM+XF
        YFmvM490VxqxkaNxdlfPpRHnpz8xCpLbyMIipEWHoPNNV755KzZvladfrI/NdrHgCF7f3j
        W25EFgDsznDus2SdDp8VzqkrWiPXNNI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-509-sJx5vOeCMOijv6JAcKnESA-1; Tue, 14 Feb 2023 13:08:43 -0500
X-MC-Unique: sJx5vOeCMOijv6JAcKnESA-1
Received: by mail-qt1-f200.google.com with SMTP id c14-20020ac87d8e000000b003ba2d72f98aso9774895qtd.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 10:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjcdhS05rmuEMZxa+twXLjmdNPlmuoeDRI4X82wtvAM=;
        b=U5k6cIk7MobvInvH3j50BV6ZP/Io8QBCEC3T5B+gM9wDe5iqab7oR4beNqHkDY2w9Z
         8Wy+rNKOQdjqz/tNbyLA8BuNnAtZT3BDTxMsLJEBSITd8cKgJYvFgmtXfTXTacm05Fop
         B5n6yFNMjuj7feCCTNXQG+Hd+4eqijF5yQznAjTVdLbkwRRjsTzjkVjMgsCILV6vzYUD
         ydaM+MQ3yB9ZsUel8xeeqZYCYCHY2irzazdIKwKOUCgVq/mPZ0Xf+HNfm4dDhs5xdkmz
         uERmjMv8Y16NF6DHX4X5H8Y0HIF+B3aMixQZdHY+T9p1LT0UGUQ1GXjGEyz0cpmbuYpG
         paNQ==
X-Gm-Message-State: AO0yUKXRTFU0Ce2YNAbpn2z6ppsaYLntPBcA8xY5y/P6wvc+7Xwo1rTq
        xiO48BXZg/8OF6wog2OYiVJQF83mHQe4Io1Nc5A/e7jCMS7NU5NkrQgyQY8Lqo4we31dSReIKLt
        BfyiIqABlXfctMRLnk0ZH45hAyQ==
X-Received: by 2002:ac8:5dd2:0:b0:3b9:b1eb:ad38 with SMTP id e18-20020ac85dd2000000b003b9b1ebad38mr5889215qtx.50.1676398122642;
        Tue, 14 Feb 2023 10:08:42 -0800 (PST)
X-Google-Smtp-Source: AK7set+hu1302WvvlFrTLY6oqz7bo2akl5UzNLOR+/p83JKuA1hqt/vdRje9PboEcWz5bczHSoYPSQ==
X-Received: by 2002:ac8:5dd2:0:b0:3b9:b1eb:ad38 with SMTP id e18-20020ac85dd2000000b003b9b1ebad38mr5889165qtx.50.1676398122214;
        Tue, 14 Feb 2023 10:08:42 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id i9-20020ac80049000000b003b646123691sm11612681qtg.31.2023.02.14.10.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 10:08:41 -0800 (PST)
Date:   Tue, 14 Feb 2023 13:10:05 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs, iomap: ->discard_folio() is broken so remove it
Message-ID: <Y+vOfaxIWX1c/yy9@bfoster>
References: <20230214055114.4141947-1-david@fromorbit.com>
 <20230214055114.4141947-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214055114.4141947-4-david@fromorbit.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 04:51:14PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Ever since commit e9c3a8e820ed ("iomap: don't invalidate folios
> after writeback errors") XFS and iomap have been retaining dirty
> folios in memory after a writeback error. XFS no longer invalidates
> the folio, and iomap no longer clears the folio uptodate state.
> 
> However, iomap is still been calling ->discard_folio on error, and
> XFS is still punching the delayed allocation range backing the dirty
> folio.
> 
> This is incorrect behaviour. The folio remains dirty and up to date,
> meaning that another writeback will be attempted in the near future.
> THis means that XFS is still going to have to allocate space for it
> during writeback, and that means it still needs to have a delayed
> allocation reservation and extent backing the dirty folio.
> 

Hmm.. I don't think that is correct. It looks like the previous patch
removes the invalidation, but writeback clears the dirty bit before
calling into the fs and we're not doing anything to redirty the folio,
so there's no guarantee of subsequent writeback. As of that patch we
presumably leave around a !dirty,uptodate folio without backing storage
(due to the discard call as you've pointed out). I would hope/think the
!dirty state would mean a redirty reallocates delalloc for the folio,
but that's not immediately clear to me.

Regardless, I can see how this prevents this sort of error in the
scenario where writeback fails due to corruption, but I don't see how it
doesn't just break error handling of writeback failures not associated
with corruption. I.e., a delalloc folio is allocated/dirtied, writeback
fails due to some random/transient error, delalloc is left around on a
!dirty page (i.e. stale), and reclaim eventually comes around and
results in the usual block accounting corruption associated with stale
delalloc blocks. This is easy enough to test/reproduce (just tried it
via error injection to delalloc conversion) that I'm kind of surprised
fstests doesn't uncover it. :/

> Failure to retain the delalloc extent (because xfs_discard_folio()
> punched it out) means that the next writeback attempt does not find
> an extent over the range of the write in ->map_blocks(), and
> xfs_map_blocks() triggers a WARN_ON() because it should never land
> in a hole for a data fork writeback request. This looks like:
> 

I'm not sure this warning makes a lot of sense either given most of this
should occur around the folio lock. Looking back at the code and the
error report for this, the same error injection used above on a 5k write
to a bsize=1k fs actually shows the punch remove fsb offsets 0-5 on a
writeback failure, so it does appear to be punching too much out. The
cause appears to be that the end offset is calculated in
xfs_discard_folio() by rounding up the start offset to 4k (folio size).
If pos == 0, this results in passing end_fsb == 0 to the punch code,
which xfs_iext_lookup_extent_before() then changes to fsb == 5 because
that's the last block of the delalloc extent that covers fsb 0.

I've not reproduced the warning shown below, but I do see the side
effect of losing data at fsb 5 if the first page conversion fails. This
is silent because iomap now sees a hole and just skips the page. I
suspect the warning results from a combination of this problem and
racing writeback contexts as you've described in the commit log.

Brian

> [  647.356969] ------------[ cut here ]------------
> [  647.359277] WARNING: CPU: 14 PID: 21913 at fs/xfs/libxfs/xfs_bmap.c:4510 xfs_bmapi_convert_delalloc+0x221/0x4e0
> [  647.364551] Modules linked in:
> [  647.366294] CPU: 14 PID: 21913 Comm: test_delalloc_c Not tainted 6.2.0-rc7-dgc+ #1754
> [  647.370356] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> [  647.374781] RIP: 0010:xfs_bmapi_convert_delalloc+0x221/0x4e0
> [  647.377807] Code: e9 7d fe ff ff 80 bf 54 01 00 00 00 0f 84 68 fe ff ff 48 8d 47 70 48 89 04 24 e9 63 fe ff ff 83 fd 02 41 be f5 ff ff ff 74 a5 <0f> 0b eb a0
> [  647.387242] RSP: 0018:ffffc9000aa677a8 EFLAGS: 00010293
> [  647.389837] RAX: 0000000000000000 RBX: ffff88825bc4da00 RCX: 0000000000000000
> [  647.393371] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88825bc4da40
> [  647.396546] RBP: 0000000000000000 R08: ffffc9000aa67810 R09: ffffc9000aa67850
> [  647.400186] R10: ffff88825bc4da00 R11: ffff888800a9aaac R12: ffff888101707000
> [  647.403484] R13: ffffc9000aa677e0 R14: 00000000fffffff5 R15: 0000000000000004
> [  647.406251] FS:  00007ff35ec24640(0000) GS:ffff88883ed00000(0000) knlGS:0000000000000000
> [  647.410089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  647.413225] CR2: 00007f7292cbc5d0 CR3: 0000000807d0e004 CR4: 0000000000060ee0
> [  647.416917] Call Trace:
> [  647.418080]  <TASK>
> [  647.419291]  ? _raw_spin_unlock_irqrestore+0xe/0x30
> [  647.421400]  xfs_map_blocks+0x1b7/0x590
> [  647.422951]  iomap_do_writepage+0x1f1/0x7d0
> [  647.424607]  ? __mod_lruvec_page_state+0x93/0x140
> [  647.426419]  write_cache_pages+0x17b/0x4f0
> [  647.428079]  ? iomap_read_end_io+0x2c0/0x2c0
> [  647.429839]  iomap_writepages+0x1c/0x40
> [  647.431377]  xfs_vm_writepages+0x79/0xb0
> [  647.432826]  do_writepages+0xbd/0x1a0
> [  647.434207]  ? obj_cgroup_release+0x73/0xb0
> [  647.435769]  ? drain_obj_stock+0x130/0x290
> [  647.437273]  ? avc_has_perm+0x8a/0x1a0
> [  647.438746]  ? avc_has_perm_noaudit+0x8c/0x100
> [  647.440223]  __filemap_fdatawrite_range+0x8e/0xa0
> [  647.441960]  filemap_write_and_wait_range+0x3d/0xa0
> [  647.444258]  __iomap_dio_rw+0x181/0x790
> [  647.445960]  ? __schedule+0x385/0xa20
> [  647.447829]  iomap_dio_rw+0xe/0x30
> [  647.449284]  xfs_file_dio_write_aligned+0x97/0x150
> [  647.451332]  ? selinux_file_permission+0x107/0x150
> [  647.453299]  xfs_file_write_iter+0xd2/0x120
> [  647.455238]  vfs_write+0x20d/0x3d0
> [  647.456768]  ksys_write+0x69/0xf0
> [  647.458067]  do_syscall_64+0x34/0x80
> [  647.459488]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  647.461529] RIP: 0033:0x7ff3651406e9
> [  647.463119] Code: 48 8d 3d 2a a1 0c 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f8
> [  647.470563] RSP: 002b:00007ff35ec23df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  647.473465] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff3651406e9
> [  647.476278] RDX: 0000000000001400 RSI: 0000000020000000 RDI: 0000000000000005
> [  647.478895] RBP: 00007ff35ec23e20 R08: 0000000000000005 R09: 0000000000000000
> [  647.481568] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe533d8d4e
> [  647.483751] R13: 00007ffe533d8d4f R14: 0000000000000000 R15: 00007ff35ec24640
> [  647.486168]  </TASK>
> [  647.487142] ---[ end trace 0000000000000000 ]---
> 
> Punching delalloc extents out from under dirty cached pages is wrong
> and broken. We can't remove the delalloc extent until the page is
> either removed from memory (i.e. invaliated) or writeback succeeds
> in converting the delalloc extent to a real extent and writeback can
> clean the page.
> 
> Hence we remove xfs_discard_folio() because it is only punching
> delalloc blocks from under dirty pages now. With that removal,
> nothing else uses ->discard_folio(), so we remove that from the
> iomap infrastructure as well.
> 
> Reported-by: pengfei.xu@intel.com
> Fixes: e9c3a8e820ed ("iomap: don't invalidate folios after writeback errors")
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 16 +++-------------
>  fs/xfs/xfs_aops.c      | 35 -----------------------------------
>  include/linux/iomap.h  |  6 ------
>  3 files changed, 3 insertions(+), 54 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 356193e44cf0..502fa2d41097 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1635,19 +1635,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * completion to mark the error state of the pages under writeback
>  	 * appropriately.
>  	 */
> -	if (unlikely(error)) {
> -		/*
> -		 * Let the filesystem know what portion of the current page
> -		 * failed to map. If the page hasn't been added to ioend, it
> -		 * won't be affected by I/O completion and we must unlock it
> -		 * now.
> -		 */
> -		if (wpc->ops->discard_folio)
> -			wpc->ops->discard_folio(folio, pos);
> -		if (!count) {
> -			folio_unlock(folio);
> -			goto done;
> -		}
> +	if (unlikely(error && !count)) {
> +		folio_unlock(folio);
> +		goto done;
>  	}
>  
>  	folio_start_writeback(folio);
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 41734202796f..3f0dae5ca9c2 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -448,44 +448,9 @@ xfs_prepare_ioend(
>  	return status;
>  }
>  
> -/*
> - * If the page has delalloc blocks on it, we need to punch them out before we
> - * invalidate the page.  If we don't, we leave a stale delalloc mapping on the
> - * inode that can trip up a later direct I/O read operation on the same region.
> - *
> - * We prevent this by truncating away the delalloc regions on the page.  Because
> - * they are delalloc, we can do this without needing a transaction. Indeed - if
> - * we get ENOSPC errors, we have to be able to do this truncation without a
> - * transaction as there is no space left for block reservation (typically why we
> - * see a ENOSPC in writeback).
> - */
> -static void
> -xfs_discard_folio(
> -	struct folio		*folio,
> -	loff_t			pos)
> -{
> -	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
> -	struct xfs_mount	*mp = ip->i_mount;
> -	int			error;
> -
> -	if (xfs_is_shutdown(mp))
> -		return;
> -
> -	xfs_alert_ratelimited(mp,
> -		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
> -			folio, ip->i_ino, pos);
> -
> -	error = xfs_bmap_punch_delalloc_range(ip, pos,
> -			round_up(pos, folio_size(folio)));
> -
> -	if (error && !xfs_is_shutdown(mp))
> -		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
> -}
> -
>  static const struct iomap_writeback_ops xfs_writeback_ops = {
>  	.map_blocks		= xfs_map_blocks,
>  	.prepare_ioend		= xfs_prepare_ioend,
> -	.discard_folio		= xfs_discard_folio,
>  };
>  
>  STATIC int
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 0983dfc9a203..681e26a86791 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -310,12 +310,6 @@ struct iomap_writeback_ops {
>  	 * conversions.
>  	 */
>  	int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
> -
> -	/*
> -	 * Optional, allows the file system to discard state on a page where
> -	 * we failed to submit any I/O.
> -	 */
> -	void (*discard_folio)(struct folio *folio, loff_t pos);
>  };
>  
>  struct iomap_writepage_ctx {
> -- 
> 2.39.0
> 

