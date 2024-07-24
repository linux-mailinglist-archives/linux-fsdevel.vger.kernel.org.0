Return-Path: <linux-fsdevel+bounces-24173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAA893AB4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 04:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC341C22F95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 02:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60031CAA1;
	Wed, 24 Jul 2024 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hIL7ROVi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099C1C693;
	Wed, 24 Jul 2024 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788946; cv=none; b=JCa/CkO9gpP4B2IQTF0q7JM0cYN8B+DGvBmWlUHfOPnU963v3mRixOV1FDdGsU+YNFvsmyi34qNvWau5IQGJPRwc8DU76y5cccNcUpRdyq1JwkM56BsazN7n/JGnLcDYHJdFvwywt5vn6TMyW77o3+LEWRujLpmPmSr+ExruPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788946; c=relaxed/simple;
	bh=yNvMSyoNBzhV4cV7OJ5U9bGs1Z4iV7tBim6uaer3UbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e++cEULBwlyUkef7MsSHmfhDpFjQSZ15dv9Pdxa+vMAWPsGHZGH9MT1nT/9GXbxeR0HPirEOPgefNNocIMWF5EZgWc+AUxvhcWekCnp8/n0r4HFMya7M53aVcPcuKtrP+gfXGkVlpzUiqPc8UvwQWAMiZvdfvGaxkH/FKAJkF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hIL7ROVi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JiDuGWepnTN0n5fOJFOEWm8213iD+rPD3GF635ET/sc=; b=hIL7ROVi5AnmZcVmdQRUZmuHtq
	YVU8jb+yGoZVKxE+oZcvlwLZqzcO2LBCBjaXWj3l/PXXXn5YqZkdMXasU923zdj/Nb1haFF4usofX
	ZIPG60eC1sFCmXiBHxjuFVulX/jkJWbQaN+727yqLDIrYgB9G3UgdpRARzPXRPiMoA+PgrAuj/q9v
	pZQcvppPlZb5ILdzXJQxFvTfv+Ke+8wXW3ejlylZyy+vECisfyUKFUeVywb8FjmiFR4LvHnfMLIs+
	Dhf4UVXUGlNnIFFqPlCryS2PxCkKFCzDBwENRrxQuYH7Ck8fQ1nw48NOlu3rDHOtEtwmwEX/P4q7g
	7uhve9mA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWRxM-00000007R8m-00FS;
	Wed, 24 Jul 2024 02:42:20 +0000
Date: Wed, 24 Jul 2024 03:42:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>,
	netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <ZqBqCwuUtD1guNsC@casper.infradead.org>
References: <2136178.1721725194@warthog.procyon.org.uk>
 <20240723104533.mznf3svde36w6izp@quack3>
 <ZqBaQS7IUTsU3ePs@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqBaQS7IUTsU3ePs@dread.disaster.area>

On Wed, Jul 24, 2024 at 11:34:57AM +1000, Dave Chinner wrote:
> This is to prevent the deadlocks on upper->lower->upper and
> lower->upper->lower filesystem recursion via GFP_KERNEL memory
> allocation and reclaim recursing between the two filesystems. This
> is especially relevant for filesystems with ->writepage methods that
> can be called from direct reclaim. Hence allocations in this path
> need to be at least NOFS to prevent recursion back into the upper
> filesystem from writeback into the lower filesystem.

FYI, we're making good progress on removing ->writepage.

$ git grep '\.writepage\>.*='
fs/ceph/addr.c: .writepage = ceph_writepage,
fs/ecryptfs/mmap.c:     .writepage = ecryptfs_writepage,
fs/f2fs/checkpoint.c:   .writepage      = f2fs_write_meta_page,
fs/f2fs/data.c: .writepage      = f2fs_write_data_page,
fs/f2fs/node.c: .writepage      = f2fs_write_node_page,
fs/gfs2/aops.c: .writepage = gfs2_jdata_writepage,
fs/gfs2/meta_io.c:      .writepage = gfs2_aspace_writepage,
fs/gfs2/meta_io.c:      .writepage = gfs2_aspace_writepage,
fs/hostfs/hostfs_kern.c:        .writepage      = hostfs_writepage,
fs/nilfs2/inode.c:      .writepage              = nilfs_writepage,
fs/nilfs2/mdt.c:        .writepage              = nilfs_mdt_write_page,
fs/orangefs/inode.c:    .writepage = orangefs_writepage,
fs/vboxsf/file.c:       .writepage = vboxsf_writepage,
mm/shmem.c:     .writepage      = shmem_writepage,
mm/swap_state.c:        .writepage      = swap_writepage,

so mostly just the usual stragglers.  I sent a series to fix up gfs2
earlier this week:
https://lore.kernel.org/linux-fsdevel/20240719175105.788253-1-willy@infradead.org/

