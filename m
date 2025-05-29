Return-Path: <linux-fsdevel+bounces-50051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8A1AC7D23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0254E6415
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEDF28EA7B;
	Thu, 29 May 2025 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IWzvH78S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5BE291141
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518411; cv=none; b=behHV1EPtob3ZQ/HFlCQrVt4S9d4BMkEinNzY/zFIka0PFRREmDUUNrckTnIkk1Kx0/21zaCAlnU9mKXMLLbRTHZ7U5ExyzaCuxTenhue05LVq4J3dbkDxlOvb7thdDimb6dh6vDvMKPTTx7RBono1vulCStvP0bk49uPqAuR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518411; c=relaxed/simple;
	bh=r+7cLvWLpKwkyBVq0RA1W7mlNmI4XwvEjQKFwRuxUAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=berMvmsUQEuO1TteKIsIYHbuJcxPm//UrX1VBLCA2CscY05i21SDNB+BmTnAZVr6ZzFBArw9SbJmqJO5Ly3fagvwp9tuiasDIeO6bh7QOHzdJpeynW9NRiyfKoms8+19bvk7pSKWZo5ZiVaZGWpk9G05yBc+qdia0l6qvgtYnUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IWzvH78S; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250529113326epoutp0174be516f5f41de5d78a6517b9c4f845f~D-Dn5iG_n2841028410epoutp01P
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:33:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250529113326epoutp0174be516f5f41de5d78a6517b9c4f845f~D-Dn5iG_n2841028410epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518406;
	bh=0BBOPh/1Je3me0LukkKrHkNdCa1/chw529Mw+ILY7AM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IWzvH78SF7qzQn/pWr7KEbtYNBmiy9GCBm4F1TQntNi3tDSGz1/QFS7nZLrLipOpN
	 gJkLbItfAm9glffjxkV/yI0O5X7sKV5fD6n4e2lbrAbO8TMKBdDC+lC0H/0aLaAAx2
	 chuMjm3PlDX4QuNwpszIJBdLE8HxNmyoqGAonJu4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250529113325epcas5p3830c2f39e388a74a690d47b523499383~D-Dm0q5r70040000400epcas5p3P;
	Thu, 29 May 2025 11:33:25 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.182]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4b7PPv4tyMz2SSKX; Thu, 29 May
	2025 11:33:23 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113215epcas5p2edd67e7b129621f386be005fdba53378~D-Cl_h9Q22517425174epcas5p2v;
	Thu, 29 May 2025 11:32:15 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529113215epsmtrp24d38e9c495ac3d242ed907100353fa8f~D-Cl8Jy3Y3146431464epsmtrp2c;
	Thu, 29 May 2025 11:32:15 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-e5-683845bf1925
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.41.07818.FB548386; Thu, 29 May 2025 20:32:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113211epsmtip2df4f1dfd18c671ff59a420a522ae4244~D-CiJOJGk2207922079epsmtip2Z;
	Thu, 29 May 2025 11:32:11 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [PATCH 00/13] Parallelizing filesystem writeback
Date: Thu, 29 May 2025 16:44:51 +0530
Message-Id: <20250529111504.89912-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSvO5+V4sMg2WbRCy2rdvNbjFn/Ro2
	iwvrVjNatO78z2Kx+m4/m8Xrw58YLU5PPctkseWSvcX7y9uYLFbfXMNoseXYPUaLy0/4LHZP
	/8dqcfPATiaLlauPMlnMnt7MZPFk/Sxmi61fvrJaXFrkbrFn70kWi3tr/rNaXDhwmtXixoSn
	jBbPdm9ktvi8tIXd4uCpDnaLT3OBhpz/e5zV4vePOWwOsh6nFkl47Jx1l91j8wotj8tnSz02
	repk89j0aRK7x4kZv1k8Xmyeyeixe8FnJo/dNxvYPM5drPB4v+8qm0ffllWMHlNn13ucWXCE
	3WPFtItMAUJRXDYpqTmZZalF+nYJXBnH+/ayFNxSreh8uIq5gXGpbBcjB4eEgInErBOKXYxc
	HEICuxklJk6Yxd7FyAkUl5HYfXcnK4QtLLHy33N2iKKPjBLfn+xjAWlmE9CV+NEUChIXEbjJ
	LHHu7BlWEIdZ4CajxJzNq8EmCQtYSkxc8BpsEouAqsTbL69YQGxeAVuJBS+OMUNskJeYeek7
	O0RcUOLkzCdgNcxA8eats5knMPLNQpKahSS1gJFpFaNkakFxbnpusmGBYV5quV5xYm5xaV66
	XnJ+7iZGcIxraexgfPetSf8QIxMH4yFGCQ5mJRHeJnuzDCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8Kw0j0oUE0hNLUrNTUwtSi2CyTBycUg1MPSVnXuydV7xnYaZRrR/b/N9OS/jErxavbJy6
	iXOe0TWriZU5hQzi0l9kdhk4JPF7Xag8u/HlbwMXbk3fzQFf/0u8u2VTY1C9guMig37EvMzG
	E9sPHrsqsJZRWfqkQYTxrsV/Lj+Y2ffu6xyJhQKRq08GrK2/rZXO+LBjd8YUj0LndfeeuAkE
	iG3UviXQes2H30x0khvXgzrDzfc5S22PSSktnvpw6Z3ZT3j55SLXmorN2RVzOf6Zi45k2L+l
	b6qVDO6sym5co6C1R+KMxWEHp+22NglPhO40lGT9cQi8+mvFinuWZ1dadFiGGdnWPD4X5134
	Oy6lfPVuP+kZnd47Tx8/tWKCdNUd5pOBZwr8lViKMxINtZiLihMBvytCF2ADAAA=
X-CMS-MailID: 20250529113215epcas5p2edd67e7b129621f386be005fdba53378
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113215epcas5p2edd67e7b129621f386be005fdba53378
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>

Currently, pagecache writeback is performed by a single thread. Inodes
are added to a dirty list, and delayed writeback is triggered. The single
writeback thread then iterates through the dirty inode list, and executes
the writeback.

This series parallelizes the writeback by allowing multiple writeback
contexts per backing device (bdi). These writebacks contexts are executed
as separate, independent threads, improving overall parallelism.

Would love to hear feedback in-order to move this effort forward.

Design Overview
================
Following Jan Kara's suggestion [1], we have introduced a new bdi
writeback context within the backing_dev_info structure. Specifically,
we have created a new structure, bdi_writeback_context, which contains
its own set of members for each writeback context.

struct bdi_writeback_ctx {
        struct bdi_writeback wb;
        struct list_head wb_list; /* list of all wbs */
        struct radix_tree_root cgwb_tree;
        struct rw_semaphore wb_switch_rwsem;
        wait_queue_head_t wb_waitq;
};

There can be multiple writeback contexts in a bdi, which helps in
achieving writeback parallelism.

struct backing_dev_info {
...
        int nr_wb_ctx;
        struct bdi_writeback_ctx **wb_ctx_arr;
...
};

FS geometry and filesystem fragmentation
========================================
The community was concerned that parallelizing writeback would impact
delayed allocation and increase filesystem fragmentation.
Our analysis of XFS delayed allocation behavior showed that merging of
extents occurs within a specific inode. Earlier experiments with multiple
writeback contexts [2] resulted in increased fragmentation due to the
same inode being processed by different threads.

To address this, we now affine an inode to a specific writeback context
ensuring that delayed allocation works effectively.

Number of writeback contexts
===========================
The plan is to keep the nr_wb_ctx as 1, ensuring default single threaded
behavior. However, we set the number of writeback contexts equal to
number of CPUs in the current version. Later we will make it configurable
using a mount option, allowing filesystems to choose the optimal number
of writeback contexts.

IOPS and throughput
===================
We see significant improvement in IOPS across several filesystem on both
PMEM and NVMe devices.

Performance gains:
  - On PMEM:
	Base XFS		: 544 MiB/s
	Parallel Writeback XFS	: 1015 MiB/s  (+86%)
	Base EXT4		: 536 MiB/s
	Parallel Writeback EXT4	: 1047 MiB/s  (+95%)

  - On NVMe:
	Base XFS		: 651 MiB/s
	Parallel Writeback XFS	: 808 MiB/s  (+24%)
	Base EXT4		: 494 MiB/s
	Parallel Writeback EXT4	: 797 MiB/s  (+61%)

We also see that there is no increase in filesystem fragmentation
# of extents:
  - On XFS (on PMEM):
	Base XFS		: 1964
	Parallel Writeback XFS	: 1384

  - On EXT4 (on PMEM):
	Base EXT4		: 21
	Parallel Writeback EXT4	: 11

[1] Jan Kara suggestion :
https://lore.kernel.org/all/gamxtewl5yzg4xwu7lpp7obhp44xh344swvvf7tmbiknvbd3ww@jowphz4h4zmb/
[2] Writeback using unaffined N (# of CPUs) threads :
https://lore.kernel.org/all/20250414102824.9901-1-kundan.kumar@samsung.com/

Kundan Kumar (13):
  writeback: add infra for parallel writeback
  writeback: add support to initialize and free multiple writeback ctxs
  writeback: link bdi_writeback to its corresponding bdi_writeback_ctx
  writeback: affine inode to a writeback ctx within a bdi
  writeback: modify bdi_writeback search logic to search across all wb
    ctxs
  writeback: invoke all writeback contexts for flusher and dirtytime
    writeback
  writeback: modify sync related functions to iterate over all writeback
    contexts
  writeback: add support to collect stats for all writeback ctxs
  f2fs: add support in f2fs to handle multiple writeback contexts
  fuse: add support for multiple writeback contexts in fuse
  gfs2: add support in gfs2 to handle multiple writeback contexts
  nfs: add support in nfs to handle multiple writeback contexts
  writeback: set the num of writeback contexts to number of online cpus

 fs/f2fs/node.c                   |  11 +-
 fs/f2fs/segment.h                |   7 +-
 fs/fs-writeback.c                | 146 +++++++++++++-------
 fs/fuse/file.c                   |   9 +-
 fs/gfs2/super.c                  |  11 +-
 fs/nfs/internal.h                |   4 +-
 fs/nfs/write.c                   |   5 +-
 include/linux/backing-dev-defs.h |  32 +++--
 include/linux/backing-dev.h      |  45 +++++--
 include/linux/fs.h               |   1 -
 mm/backing-dev.c                 | 225 ++++++++++++++++++++-----------
 mm/page-writeback.c              |   5 +-
 12 files changed, 333 insertions(+), 168 deletions(-)

-- 
2.25.1


