Return-Path: <linux-fsdevel+bounces-5111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E480834E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4433E1F2241A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C930CF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q8o2Ww2Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1140D137;
	Wed,  6 Dec 2023 23:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pcip+qcShfpKiIdrtbE2krVPBRD3cmZ1GZq0o0dnBeM=; b=q8o2Ww2Q2d2/00K/DKOgyxjzNg
	tz0Y3gxLAOGXDMeu51iRxWdMpnefWUvbebmCHeILVJJ7bUH/RZ6Q2GeqldiqXYJeVtXOcZ8C4Xaf/
	Owf7IrSBUhSGYfLPKuSs89YdFnroEx+G/aBUJY8muaqlIR1bcuXHBRYLV9AJn0QYzyfXjDaazUjQd
	j71vTIY4FC6O99RJdt8wCN3T4dkiH6nTK3bbhTXY3gFHEq911pDYhz/IR0F+sUN2XWVt97G56/Ete
	6TpepAl1PcPbM6iu26THTIY778QOYUzijyvjepzoeEM3XQBwFhBD8aFctJ8HKkESUMOchwAzZ8AhX
	iUqExRsg==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8mw-00C4wx-2I;
	Thu, 07 Dec 2023 07:27:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: map multiple blocks per ->map_blocks in iomap writeback
Date: Thu,  7 Dec 2023 08:26:56 +0100
Message-Id: <20231207072710.176093-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series overhaults a large chunk of the iomap writeback code with
the end result that ->map_blocks can now map multiple blocks at a time,
at least as long as they are all inside the same folio.

On a sufficiently large system (32 cores in my case) this significantly
reduces CPU usage for buffered write workloads on xfs, with a very minor
improvement in write bandwith that might be within the measurement
tolerance.

e.g. on a fio sequential write workload using io_uring I get these values
(median out of 5 runs):

before:
  cpu          : usr=5.26%, sys=4.81%, ctx=4009750, majf=0, minf=13
  WRITE: bw=1096MiB/s (1150MB/s), 1096MiB/s-1096MiB/s (1150MB/s-1150MB/s), io=970GiB (1042GB), run=906036-906036msec

with this series:
  cpu          : usr=4.95%, sys=2.72%, ctx=4084578, majf=0, minf=12
  WRITE: bw=1111MiB/s (1165MB/s), 1111MiB/s-1111MiB/s (1165MB/s-1165MB/s), io=980GiB (1052GB), run=903234-903234msec

On systems with a small number of cores the cpu usage reduction is much
lower and barely visible.

Changes since RFC:
 - various commit message typo fixes
 - minor formatting fixes
 - keep the PF_MEMALLOC check and move it to iomap_writepages
 - rename the offset argument to iomap_can_add_to_ioend to pos
 - fix missing error handling in an earlier patch (only required for
   bisection, no change to the end result)
 - remove a stray whitespace
 - refactor ifs_find_dirty_range a bit to make it more readable
 - add a patch to pass the dirty_len to the file system to make life for
   ext2 easier

Diffstat:
 block/fops.c           |    2 
 fs/gfs2/bmap.c         |    2 
 fs/iomap/buffered-io.c |  576 +++++++++++++++++++++++--------------------------
 fs/xfs/xfs_aops.c      |    9 
 fs/zonefs/file.c       |    3 
 include/linux/iomap.h  |   19 +
 6 files changed, 306 insertions(+), 305 deletions(-)

