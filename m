Return-Path: <linux-fsdevel+bounces-43398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB97A55D70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 03:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1BE188EB66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 02:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5A713632B;
	Fri,  7 Mar 2025 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LeHaJJ/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9717C79;
	Fri,  7 Mar 2025 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313050; cv=none; b=jKiCLvYKeC4t33KPx0dncZdUlzLHI/Hmw5HrUjTC822nwrrQHr5f5HBFbqFMVfyHqU/wk+j/bXFt69Wy8AeyZes+scNsWHNv9Mea8jYyXxs82mshdPL31P2Dg06tXDM1Xk7Gpk4pN/Vlq/Kniwkjit1UswPHt+ehLJEn0+/1zGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313050; c=relaxed/simple;
	bh=cr7Dzt7Hw34kjsvbIUeW64CYscBt9e/HbfQjuRP60Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xfca8je086tG4/YZTqnRISaftomvkGeqNNnhezUEJayRTOPhudH5hz5mmZhhndbu/JyexaoOTSy/P8cv+O6/YhqNLaQf3z2NYpMV6uAKaQVJtzDaUb8Ni3/NmvaLIdmcTVZwmYRH1uIviLKXjUlV+lIzC76nwThezIMWvY4P/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LeHaJJ/X; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UaiBU33PUTsBZDQAkAELInILFfqTyK4n24U7tVjZbxY=; b=LeHaJJ/XH1mRLxzujq3yrEIqnY
	pKmduERHDtSv6QgQ4HRpT/sTEMCAZkq77kE/LoXrbA3tL2o4cBztJJmcq2fHjZI4tBIIrtBC49Rns
	Q9IfXyIszT9JCkowo1qR6RiFPW3ANs9rxls3r/oB7pr1DrI5jLeAdp3+XuCqXyuhCQO0dj3ywnbHn
	conIKltuL2Anp4kAxgyHueTyMQGaUH/QVT95ImU1A1cknTqg2xdSQP7xUZeouxAE6EqtoGTiRd60T
	4c/ohv2sggoetwAr01SEonZ7ffLO0FgBw0DbSjTD0iIH63HNh7I6XZLwRBzKKYsIsWtaIqHAst0ko
	DATrWeNg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqN4G-0000000CsHB-1E2s;
	Fri, 07 Mar 2025 02:04:04 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	hare@suse.de,
	willy@infradead.org,
	david@fromorbit.com,
	djwong@kernel.org
Cc: kbusch@kernel.org,
	john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2] bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()
Date: Thu,  6 Mar 2025 18:04:03 -0800
Message-ID: <20250307020403.3068567-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The commit titled "block/bdev: lift block size restrictions to 64k"
lifted the block layer's max supported block size to 64k inside the
helper blk_validate_block_size() now that we support large folios.
However in lifting the block size we also removed the silly use
cases many filesystems have to use sb_set_blocksize() to *verify*
that the block size <= PAGE_SIZE. The call to sb_set_blocksize() was
used to check the block size <= PAGE_SIZE since historically we've
always supported userspace to create for example 64k block size
filesystems even on 4k page size systems, but what we didn't allow
was mounting them. Older filesystems have been using the check with
sb_set_blocksize() for years.

While, we could argue that such checks should be filesystem specific,
there are much more users of sb_set_blocksize() than LBS enabled
filesystem on upstream, so just do the easier thing and bring back
the PAGE_SIZE check for sb_set_blocksize() users and only skip it
for LBS enabled filesystems.

This will ensure that tests such as generic/466 when run in a loop
against say, ext4, won't try to try to actually mount a filesystem with
a block size larger than your filesystem supports given your PAGE_SIZE
and in the worst case crash.

Cc: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c       | 2 ++
 fs/bcachefs/fs.c   | 2 +-
 fs/xfs/xfs_super.c | 3 ++-
 include/linux/fs.h | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 3bd948e6438d..4844d1e27b6f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -181,6 +181,8 @@ EXPORT_SYMBOL(set_blocksize);
 
 int sb_set_blocksize(struct super_block *sb, int size)
 {
+	if (!(sb->s_type->fs_flags & FS_LBS) && size > PAGE_SIZE)
+		return 0;
 	if (set_blocksize(sb->s_bdev_file, size))
 		return 0;
 	/* If we get here, we know size is validated */
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 8b3be33a1f7a..8624b3b1601f 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -2414,7 +2414,7 @@ static struct file_system_type bcache_fs_type = {
 	.name			= "bcachefs",
 	.init_fs_context	= bch2_init_fs_context,
 	.kill_sb		= bch2_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_LBS,
 };
 
 MODULE_ALIAS_FS("bcachefs");
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 37898f89b3ea..54a353f52ffb 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2134,7 +2134,8 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= xfs_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
+				  FS_LBS,
 };
 MODULE_ALIAS_FS("xfs");
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 110d95d04299..62440a9383dc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2614,6 +2614,7 @@ struct file_system_type {
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
 #define FS_MGTIME		64	/* FS uses multigrain timestamps */
+#define FS_LBS			128	/* FS supports LBS */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
-- 
2.47.2


