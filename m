Return-Path: <linux-fsdevel+bounces-73887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB8D22C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B0BB309C69C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9DE3271F2;
	Thu, 15 Jan 2026 07:20:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C001E5207;
	Thu, 15 Jan 2026 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461646; cv=none; b=S0VcewOg9S/h9URbgOafCF/gkh/cfOrjwcBAoPLf+lmGULceraHqTs5IehkVFXLGqCRuNOMrRgrzCCLGAqlVOHCy0Y8wUHoPU9RHBWi53lJ7Te3mlQQeBpEEwLLT/HTyujJmO8StBtvstA1vCa4DwkrzMFMvAi4OEbNR1+l+EN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461646; c=relaxed/simple;
	bh=A3POR2C4pf7sBfSMytnqXup+tQOJMuHa2YhXWem+rpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ue1gjOQ1rQ8jHN0V+Xd94RhRhU8iwY8vuTkOlQErfswdaH7mC+YtSBaoden+TKFRMkiC7aIugadSywQamTqdmeoUgIxdWW8SVmbmMm2BZfoyacxOAw0JK3Wk6n0KgWG5hCImhKmKM7pIYLMJqP8UNvuj/4+0uevsCQMQRJHehgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.37])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30be6f31a;
	Thu, 15 Jan 2026 15:20:33 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [RFC 0/2] fuse/passthrough: simplify daemon crash recovery
Date: Thu, 15 Jan 2026 15:20:29 +0800
Message-ID: <20260115072032.402-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc08707a903a2kunm2d1f6437210641
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ00aVhlKSBhKGRhLGR9MGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhMWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++

To simplify FUSE daemon crash recovery and reduce performance overhead,
passthrough backing_id information is not persisted. However, this
approach introduces two challenges after daemon restart:

1. Non-persistent backing_ids prevent proper resource cleanup, leading
   to resource leaks.
2. New backing_ids allocated for the same FUSE file cause -EIO errors
   due to strict fuse_backing validation in
   fuse_inode_uncached_io_start(), even when accessing the same
   backing file. This persists until all previously opened files are
   closed.

There are common scenarios where reusing the cached fuse_inode->fb is
safe:

Scenario 1: The same backing file (with identical inode) is
            re-registered after recovery.
Scenario 2: In a read-only FUSE filesystem, the backing file may be
            cleaned up and re-downloaded (resulting in a different
            inode, but identical content).

Proposed Solution:

1. Enhance fuse_dev_ioctl_backing_close() to support closing all
   backing_ids at once, enabling comprehensive resource cleanup after
   restart.

2. Introduce the FOPEN_PASSTHROUGH_INODE_CACHE flag. When set during
   fuse_open(), the kernel prioritizes reusing the existing
   fuse_backing cached in fuse_inode, falling back to the
   backing_id-associated fb only if the cache is empty.

I'd appreciate any feedback on whether there are better approaches or
potential improvements to this solution.

Thanks.
---
Chunsheng Luo (2):
  fuse: add close all in passthrough backing close for crash recovery
  fuse: Add new flag to reuse the backing file of fuse_inode

 fs/fuse/backing.c         | 14 ++++++++++++++
 fs/fuse/dev.c             |  5 +++++
 fs/fuse/fuse_i.h          |  1 +
 fs/fuse/iomode.c          |  2 +-
 fs/fuse/passthrough.c     | 11 +++++++++++
 include/uapi/linux/fuse.h |  2 ++
 6 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.43.0


