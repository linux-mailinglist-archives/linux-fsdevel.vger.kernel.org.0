Return-Path: <linux-fsdevel+bounces-58299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC9FB2C4F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 15:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EF82408A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA70341ABE;
	Tue, 19 Aug 2025 13:08:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865233EAF8;
	Tue, 19 Aug 2025 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608916; cv=none; b=nR6qBTyQni7FpiBVKgWvHhg5tRHWHgp1oaAso9DVtSftAf0WCKNXXLkGhnHndmhVASPiw+64z55O2LwUSlGJdZazua2Wqqo8a5rQQPs07gFCwNNlN8VqFItWlJSrxOmwGlQi98sOFhyNtYR5JhRHzsv+MroS6RId86vsYOVmPiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608916; c=relaxed/simple;
	bh=strLwNtKyz0kdeUbzsO6mGNHWBdF7ZMPqPbgwjytXLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scQCi6WsVOY2oLcMTCV3y8xxQPkzc2IXn96H9PJRhIEUfa210L/TJs21xR1ccIx08jhECNlywoUVAUPijyWZ3/iUsFwiJ6uaAdtiNL3iyx2IvAL3q/XNtE9eZM+0UNlzEfxHttTISysQlvY9Zff/CCwJ18nUBh3YHsbiWi3VUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fe378b5e;
	Tue, 19 Aug 2025 21:08:19 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH] fuse: Replace hardcoded 4096 with PAGE_SIZE
Date: Tue, 19 Aug 2025 21:08:17 +0800
Message-ID: <20250819130817.845-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98c271e0d903a2kunm31ee7cf03fd8e2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTkwaVkoaSBlKGBpCHk1OQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhPWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++

Replace hardcoded 4096 values with PAGE_SIZE macro in FUSE
filesystem for better portability across different architectures.

This improves code maintainability and ensures proper alignment with
the system's page size, which may vary on different architectures
(e.g., 4KB on x86, 64KB on some ARM64 systems).

The functionality remains unchanged on systems with 4KB pages while
providing better compatibility for systems with different page sizes.

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 fs/fuse/cuse.c  | 4 ++--
 fs/fuse/inode.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index b39844d75a80..f4770ad627a8 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -337,8 +337,8 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 		goto err;
 
 	fc->minor = arg->minor;
-	fc->max_read = max_t(unsigned, arg->max_read, 4096);
-	fc->max_write = max_t(unsigned, arg->max_write, 4096);
+	fc->max_read = max_t(unsigned int, arg->max_read, PAGE_SIZE);
+	fc->max_write = max_t(unsigned int, arg->max_write, PAGE_SIZE);
 
 	/* parse init reply */
 	cc->unrestricted_ioctl = arg->flags & CUSE_UNRESTRICTED_IOCTL;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ecb869e895ab..8de2e969924e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1454,8 +1454,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
-		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
-		fc->max_write = max_t(unsigned, 4096, fc->max_write);
+		fc->max_write = arg->minor < 5 ? PAGE_SIZE : arg->max_write;
+		fc->max_write = max_t(unsigned int, PAGE_SIZE, fc->max_write);
 		fc->conn_init = 1;
 	}
 	kfree(ia);
@@ -1847,7 +1847,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->user_id = ctx->user_id;
 	fc->group_id = ctx->group_id;
 	fc->legacy_opts_show = ctx->legacy_opts_show;
-	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
+	fc->max_read = max_t(unsigned int, PAGE_SIZE, ctx->max_read);
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
-- 
2.43.0


