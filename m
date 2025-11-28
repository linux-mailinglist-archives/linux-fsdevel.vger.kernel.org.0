Return-Path: <linux-fsdevel+bounces-70127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E29DC918F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 11:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFAF934CA1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18279308F0F;
	Fri, 28 Nov 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Gr8jzOnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [211.125.139.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749762FD684
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764324173; cv=none; b=pVNNkX0bmdkuv5mUfWebOhFkyJCAk34JVlqVj43Jsc1cPdyDlELMPRubXUxUv3ZFZiHog5+8ki29UcCNt23vR7HMto/vLRMHZNsRBUUNfCa+2ULH22VigM37na9vd3pW7jqaJP6YxpBRCWUMDx6YyZ5/MU/xWlemzmlh4UoUmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764324173; c=relaxed/simple;
	bh=Iu5gGbQWcNAu6FalDnqUIA9i6GivM224Yn6vVNxmkZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwUwhc9SRZBsCOqaGR/dlczwrAkAX7UoTDzpJwWLfUu3DP/824Nw6Sd7Pl1PFukKewaY0VBayEt6o4QXNJrrGbogpI13ZAvh3EM1TpAkea9VsT/dWRfHtq8MbFp59qoSPFTsLMNTe9CmRKkGNK5fJnyuc3XxB++563A24GM73D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Gr8jzOnZ; arc=none smtp.client-ip=211.125.139.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1764324170; x=1795860170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=alXLHYehYCqTiY3lAmQA3KjWtUAF9I66bS6hQJxunI4=;
  b=Gr8jzOnZJ+uXxdh9QYqtzNPHex60hGYP2CDx/cxDm5WxursYuPGgPWcz
   grYHWL0n2XGVDua8dAIFwRx/EBJ0ftSFhUqd07uogJzPumSCqoa1ZRfft
   VyJY8jO3nMebdt/S95U/t8YKx8Rt8vtObbMxpRZ4Vc4gEisHPA7L7r0Qu
   2gbZG5riihj9RHCsE25ufIn6N/NAPeLMLbdW8zwnuop3ydP/16zGHxD8U
   TFYy8tKqHGrst00bH/7zaXgWs03PaLFNKJjWD6/YQZHI5RtLzFSra4mjs
   0qNFN5umAD0nSUdfuJiA7cpvL/Z/SgtMtn1XkIpnHAn/BQcq2Q89/7UET
   Q==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 18:52:40 +0900
X-IronPort-AV: E=Sophos;i="6.20,227,1758553200"; 
   d="scan'208";a="60293414"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 28 Nov 2025 18:52:40 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] exfat: fix remount failure in different process environments
Date: Fri, 28 Nov 2025 17:51:10 +0800
Message-ID: <20251128095109.686100-2-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel test robot reported that the exFAT remount operation
failed. The reason for the failure was that the process's umask
is different betweem mount and remount, causing fs_fmask and
fs_dmask are changed.

Potentially, both gid and uid may also be changed. Therefore, when
initializing fs_context for remount, inherit these mount options
from the options used during mount.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202511251637.81670f5c-lkp@intel.com
---
 fs/exfat/super.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7f9592856bf78..4dcbd889f8b2c 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -810,10 +810,21 @@ static int exfat_init_fs_context(struct fs_context *fc)
 	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
 			DEFAULT_RATELIMIT_BURST);
 
-	sbi->options.fs_uid = current_uid();
-	sbi->options.fs_gid = current_gid();
-	sbi->options.fs_fmask = current->fs->umask;
-	sbi->options.fs_dmask = current->fs->umask;
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && fc->root) {
+		struct super_block *sb = fc->root->d_sb;
+		struct exfat_mount_options *cur_opts = &EXFAT_SB(sb)->options;
+
+		sbi->options.fs_uid = cur_opts->fs_uid;
+		sbi->options.fs_gid = cur_opts->fs_gid;
+		sbi->options.fs_fmask = cur_opts->fs_fmask;
+		sbi->options.fs_dmask = cur_opts->fs_dmask;
+	} else {
+		sbi->options.fs_uid = current_uid();
+		sbi->options.fs_gid = current_gid();
+		sbi->options.fs_fmask = current->fs->umask;
+		sbi->options.fs_dmask = current->fs->umask;
+	}
+
 	sbi->options.allow_utime = -1;
 	sbi->options.errors = EXFAT_ERRORS_RO;
 	exfat_set_iocharset(&sbi->options, exfat_default_iocharset);
-- 
2.43.0


