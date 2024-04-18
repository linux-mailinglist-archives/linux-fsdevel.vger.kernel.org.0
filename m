Return-Path: <linux-fsdevel+bounces-17248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59AD8A9B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 15:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C952B1C22EAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3815FD16;
	Thu, 18 Apr 2024 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pG34Xm1m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7C47E56C;
	Thu, 18 Apr 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447068; cv=none; b=AorL3vfhhnz8vCtqkz7QAc5FOV1szryb9B9vUYbXv4HtgZqdttUUfqA2SKmYzSIwSHrzidONAZiXBW/YJaxBO3zrd9AzlgjmQ/vdkrONjqr4oBtUeV8lJuS6Atc+8enlgQpaokrwm4hyIET/yqljCf2vxEwMeJLhjvkKKfoyNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447068; c=relaxed/simple;
	bh=3j2rz2dbI2fkH5QHoUTV7PpGZBloSPbbrcpGku/DmFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmRhcK26aLJZFNWv6ibQ4bMc6gmGUEfGjN7C+yw1BOHFwXDvYkQE2YqNagcxGdQr7L+c4J6TMU6EUzHGNl5C+pSZpM+cQ0XUA1YsMOpKf8/lXHdkCt+e3XDY1UM4aRiIbUhwRMugwQw5wiVm40uEmKbfwuqS2IdWRET+OJHJQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pG34Xm1m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fnGoDCR4iCyVOVXnpcrF/UTwU56hAzv+QpuJiLDXQlY=; b=pG34Xm1mx0NiIYrVKyXftfANoq
	vsEd3i6d3wpkxJlzoUKk8zpwKXazQbeksdDfiS8vYRmWAQmXEV1AAg/dA0g4JW/Gu29K8ODltT97C
	1t6IQpuJ+1qaAd6jY6w38W8IX8Dd9/RtOXlZKMuOIeM747cebc+ksWfFpquOC9/+AnYa/helqm+cB
	nGZg3RhNNYa7Ax4grnwh7GwQ9zwaD/mxN2ETKcFvLgdDZ6KL56nUhfI0H5GfWj6tYSyo7MOxJHmfq
	KuldwSJMz3oeiuFtqAw04ihniz0Gx9tcdrzdjymXdDPNeSPFyhK78bqvZHfz34tGIfi3itRZBXhOp
	NyfjzGBA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxRqq-00000005Pmu-3Iiy;
	Thu, 18 Apr 2024 13:30:56 +0000
Date: Thu, 18 Apr 2024 14:30:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, kdevops@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, david@redhat.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de
Subject: Re: [PATCH] fstests: add fsstress + compaction test
Message-ID: <ZiEgkExEZ3By2wD0@casper.infradead.org>
References: <20240418001356.95857-1-mcgrof@kernel.org>
 <ZiB5x-EKrmb1ZPuf@casper.infradead.org>
 <ZiDA1Lokzwxd3d-v@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiDA1Lokzwxd3d-v@bombadil.infradead.org>

On Wed, Apr 17, 2024 at 11:42:28PM -0700, Luis Chamberlain wrote:
> > > Today I find that v6.9-rc4 is also hitting an unrecoverable hung task
> > > between compaction and fsstress while running generic/476 on the
> > > following kdevops test sections [2]:
> > > 
> > >   * xfs_nocrc
> > >   * xfs_nocrc_2k
> > >   * xfs_nocrc_4k
> > > 
> > > Analyzing the trace I see the guest uses loopback block devices for the
> > > fstests TEST_DEV, the loopback file uses sparsefiles on a btrfs
> > > partition. The contention based on traces [3] [4] seems to be that we
> > > have somehow have fsstress + compaction race on folio_wait_bit_common().
> > 
> > What do you mean by "race"?  Here's what I see:
> 
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: migrate_pages_batch (./include/linux/pagemap.h:1048 mm/migrate.c:1486 mm/migrate.c:1700) 

That's folio_lock().

> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task kworker/u38:8:807213 blocked for more than 120 seconds.
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: extent_write_cache_pages (fs/btrfs/extent_io.c:2130) btrfs

folio_lock().

> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task kworker/u34:9:1268436 blocked for more than 120 seconds.
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: btrfs_folio_start_writer_lock (./include/linux/pagemap.h:1048 fs/btrfs/subpage.c:394) btrfs

folio_lock().

> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task xfsaild/loop5:1377891 blocked for more than 120 seconds.
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: rq_qos_wait (block/blk-rq-qos.c:284 (discriminator 4)) 

I'm not familiar with this code.

> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: wbt_wait (block/blk-wbt.c:660) 
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __rq_qos_throttle (block/blk-rq-qos.c:66) 
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: blk_mq_submit_bio (block/blk-mq.c:2880 block/blk-mq.c:2984) 
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: submit_bio_noacct_nocheck (./include/linux/bio.h:639 block/blk-core.c:701 block/blk-core.c:729) 
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: _xfs_buf_ioapply (fs/xfs/xfs_buf.c:1584 fs/xfs/xfs_buf.c:1671) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __xfs_buf_submit (./arch/x86/include/asm/atomic.h:67 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 fs/xfs/xfs_buf.c:1762) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_buf_delwri_submit_buffers (fs/xfs/xfs_buf.c:2280 (discriminator 2)) xfs

... but it's submitting a write.

> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfsaild (fs/xfs/xfs_trans_ail.c:560 (discriminator 1) fs/xfs/xfs_trans_ail.c:671 (discriminator 1)) xfs

> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task fsstress:1377894 blocked for more than 120 seconds.
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_buf_iowait (fs/xfs/xfs_buf.c:1691) xfs

Waiting for an I/O completion

> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __xfs_buf_submit (fs/xfs/xfs_buf.c:1770) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_buf_read_map (fs/xfs/xfs_buf.c:870) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_trans_read_buf_map (fs/xfs/xfs_trans_buf.c:289 (discriminator 1)) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_btree_read_buf_block (./fs/xfs/xfs_trans.h:210 fs/xfs/libxfs/xfs_btree.c:1432) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_btree_lookup_get_block (fs/xfs/libxfs/xfs_btree.c:1934) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_btree_lookup (fs/xfs/libxfs/xfs_btree.c:2045) xfs

but a read, not a write.

> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task fsstress:1377895 blocked for more than 120 seconds.
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_buf_iowait (fs/xfs/xfs_buf.c:1691) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __xfs_buf_submit (fs/xfs/xfs_buf.c:1770) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_buf_read_map (fs/xfs/xfs_buf.c:870) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_trans_read_buf_map (fs/xfs/xfs_trans_buf.c:289 (discriminator 1)) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_da_read_buf (fs/xfs/libxfs/xfs_da_btree.c:2676) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_attr3_leaf_read (fs/xfs/libxfs/xfs_attr_leaf.c:458) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_attr_leaf_hasname (fs/xfs/libxfs/xfs_attr.c:1206) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_attr_leaf_get (fs/xfs/libxfs/xfs_attr.c:1275) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_attr_get (fs/xfs/libxfs/xfs_attr.c:276) xfs
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_xattr_get (fs/xfs/xfs_xattr.c:143) xfs

A different read.

I'm not seeing a _race_ here.  I'm seeing tasks _stuck_, but on what?
A missing wakeup?

