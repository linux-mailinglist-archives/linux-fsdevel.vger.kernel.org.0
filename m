Return-Path: <linux-fsdevel+bounces-74123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC34D32A20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92907313DB39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C8337102;
	Fri, 16 Jan 2026 14:28:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD426ED5C;
	Fri, 16 Jan 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573734; cv=none; b=TUybL26bGIy0zrfoNeKYV0lPlknvoBYf0Xzxf5Xs7a+drGjX5BQ115Iz83M/zKVib/AFNqAUpft4E2ajAne2diZKRcAY8QLkNOpSTSN0lS4Q5ijaJxmIUq6i4NnMhKvfKv429gLUYT0VX4EKnFdfrafxN98wAo6La+U5wDPokRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573734; c=relaxed/simple;
	bh=iBp+Csg4urO7MvJHansFOYm9CRMUmeqJFzro/LTg3BU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=quxW+IB/0b0TqqnLYkRVOUOAJQ0QZ+rxEjY8JcLMNfpJeNKt1lyklGAiw/rz3fyBbbQiVZNrBDtmNTcm8iz9RRgnW1VvdgdIPP290ngvEnYLWwyzG6sjmyfWDEbn33l+Hf5dJFKQXKGTLEcy0NxH65ipd1wzjc7aitdbKuVwtLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.35])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30ef1dc9c;
	Fri, 16 Jan 2026 22:28:47 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH v2 0/2] fuse/passthrough: simplify daemon crash recovery
Date: Fri, 16 Jan 2026 22:28:43 +0800
Message-ID: <20260116142845.422-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc735717003a2kunm91c7907a268fe0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQhpOVh1MGEJJQ0lOSEwZQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhOWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++

Hello maintainers and community,

This patch series addresses crash recovery issues for FUSE daemons
with passthrough support, following up on the previous RFC
discussion [1].

Problem Summary
===============
To simplify FUSE daemon crash recovery and reduce performance
overhead, passthrough backing_id information is not persisted.
However, this design choice introduces two issues when the daemon
restarts:

1. Non-persistent backing_ids prevent proper resource cleanup during
   daemon restart, potentially causing resource leaks.

2. New backing_ids allocated for the same backing file trigger -EIO
   errors due to strict pointer validation in
   fuse_inode_uncached_io_start(), even though the backing inodes
   are identical.

Changes from RFC v1
===================
Based on Amir Goldstein's suggestion, this v2 series implements:

Patch 1/2: "fuse: introduce close-all ioctl for passthrough backing
           cleanup"
  - Replaces the magic -1 value with a dedicated
    FUSE_DEV_IOC_BACKING_CLOSE_ALL ioctl for comprehensive cleanup
    during daemon restart.

Patch 2/2: "fuse: relax backing inode validation for crash recovery"
  - Drops the FOPEN_PASSTHROUGH_INODE_CACHE flag approach.
  - Modifies fuse_inode_uncached_io_start() to compare backing
    inodes instead of fuse_backing pointers, allowing safe reuse
    of identical backing files after recovery.

Testing
=======
The patches have been tested with FUSE daemon crash and recovery
scenarios on kernel 6.19-rc4, successfully resolving the -EIO
errors and backing file resource leaks.

This approach maintains the simplicity of non-persistent backing_ids
while ensuring proper recovery semantics.

Thank you for your review and previous guidance.

[1] https://lore.kernel.org/linux-fsdevel/20260115072032.402-1-luochunsheng@ustc.edu/
---
Chunsheng Luo (2):
  fuse: add ioctl to cleanup all backing files
  fuse: Relax backing file validation to compare backing inodes

 fs/fuse/backing.c         | 19 +++++++++++++++++++
 fs/fuse/dev.c             | 16 ++++++++++++++++
 fs/fuse/fuse_i.h          |  1 +
 fs/fuse/iomode.c          |  2 +-
 include/uapi/linux/fuse.h |  1 +
 5 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.43.0


