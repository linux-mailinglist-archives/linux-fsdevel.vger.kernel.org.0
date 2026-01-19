Return-Path: <linux-fsdevel+bounces-74410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34659D3A1CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 300B83067DEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A42340273;
	Mon, 19 Jan 2026 08:38:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623033F381;
	Mon, 19 Jan 2026 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811890; cv=none; b=mVoD5dVaEAaJ1VjaIUuZ5etuIy3de0x/zUGbs8P+j5V8wrT/+ijNSoGlea4DmWrwg157NePJsUX3J5r73m1tfAgBd3BVWP7+slFra3yoE/4b/CrsOdPViCeYhx/2S2VeHS9gxKBZe3SLbqk73sJ+wXKaN1dHikZfkqfbjKKG2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811890; c=relaxed/simple;
	bh=3O0uvXVCpH0kR9gS/o1cg/4+SeKIChwC+ouP2bpetXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDPxElDFz3g73OFMeH2zn6GqzFTP8rEzAanWcL973LJaI6vF68GxAk8iNQ6ugRRH+zia/4FnUiac+vbzCR5j3WwO5M2Ce33GOgkpU+XAVO7FIFN5bxXLAZ4Pc23kb1LFL7mHn2ou6rQb2ATc80JYqsMu33nByVHSYYFrNTUvaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.37])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3122c8151;
	Mon, 19 Jan 2026 16:38:04 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH v3 0/2] fuse: improve crash recovery for backing files
Date: Mon, 19 Jan 2026 16:37:47 +0800
Message-ID: <20260119083750.2055-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd567707503a2kunm63169f29316253
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSklDVk8ZGUpISRlPGUoaQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhMWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++

Hello maintainers and community,

This v3 series addresses crash recovery issues for FUSE daemons
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

2. New backing_ids allocated for the same backing file trigger -EBUSY
   errors due to strict pointer validation in
   fuse_inode_uncached_io_start(), even though the backing inodes
   are identical.

Changes from v2
===============
Based on Amir Goldstein's review feedback, this v3 series updates:

Patch 1/2: "fuse: add ioctl to cleanup all backing files"
  - Changed backing_files_map to RCU-protected pointer for safe concurrent
    access, using rcu_replace_pointer() instead of swap().
  - Added synchronize_rcu() to prevent use-after-free with in-flight lookups.
  - Made fuse_backing_files_init() return int to handle allocation failures.

Patch 2/2: "fuse: Relax backing file validation to compare backing inodes"
  - No changes from v2.

Changes from RFC v1 [2]
=======================
v2 series implemented:
  - Replaced magic -1 value with dedicated FUSE_DEV_IOC_BACKING_CLOSE_ALL
    ioctl for comprehensive cleanup during daemon restart.
  - Dropped FOPEN_PASSTHROUGH_INODE_CACHE flag approach.
  - Modified fuse_inode_uncached_io_start() to compare backing inodes
    instead of fuse_backing pointers, allowing safe reuse of identical
    backing files after recovery.

Testing
=======
The patches have been tested with FUSE daemon crash and recovery
scenarios on kernel 6.19.0-rc4, successfully resolving the -EIO
errors and backing file resource leaks.

This approach maintains the simplicity of non-persistent backing_ids
while ensuring proper recovery semantics and thread safety.

Thank you for your review and guidance.

[1] https://lore.kernel.org/linux-fsdevel/20260115072032.402-1-luochunsheng@ustc.edu/
[2] https://lore.kernel.org/linux-fsdevel/20260116142845.422-1-luochunsheng@ustc.edu/T/#t

Chunsheng Luo (2):
  fuse: add ioctl to cleanup all backing files
  fuse: Relax backing file validation to compare backing inodes

 fs/fuse/backing.c         | 76 +++++++++++++++++++++++++++++++++++----
 fs/fuse/dev.c             | 16 +++++++++
 fs/fuse/fuse_i.h          |  5 +--
 fs/fuse/inode.c           | 11 +++---
 fs/fuse/iomode.c          |  2 +-
 include/uapi/linux/fuse.h |  1 +
 6 files changed, 95 insertions(+), 16 deletions(-)

-- 
2.41.0


