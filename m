Return-Path: <linux-fsdevel+bounces-25856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ADA95126D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41212842B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5620B0F;
	Wed, 14 Aug 2024 02:32:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1546156CE
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602762; cv=none; b=OrIASe/BcayidgjYLyzp0xwWfnlipS1nLfUgSYlKL0kSceEexjqgXLaEEgWNzJFDv//kHMGsBUWHYHHKuXg2zbeTb6uEkxfAKxW0FTA4UO9liaVdUiZFxuu7xjoOdgHOdN9AA9FwV/iCCWDgvGzm/HXKNt1UWcpxp5ia+Kusa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602762; c=relaxed/simple;
	bh=hz5iJhL3kfmEpVoGfvjP7LG1O7fJbVANfGb03LnCdik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/VbMk1VO2txhjwT8RBuWtSgZjsEZZ3G/jJ0/CRvvogDUuOqSy7xr+1XvxeJrOB3hUK9aEwnNhYi3nY8p7kZ1Y9iJ82jHdsVv7fEl0j2wv97cTfX3txVp06/AOuN23uI4OuWsCOLhsIA4XS9gtt8trFQGXbOOQWdQmYtV0rm710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WkBxd4PHDz20lcQ;
	Wed, 14 Aug 2024 10:28:05 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 3622914037B;
	Wed, 14 Aug 2024 10:32:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 10:32:38 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <brauner@kernel.org>,
	<lczerner@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH 3/9] f2fs: move option validation into a separate helper
Date: Wed, 14 Aug 2024 10:39:06 +0800
Message-ID: <20240814023912.3959299-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814023912.3959299-1-lihongbo22@huawei.com>
References: <20240814023912.3959299-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Just move option validation out of parse_options(), and the
validation logic is enclosed within f2fs_validate_options.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/f2fs/super.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 013b1078653f..8c8cd06a6d9c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -41,6 +41,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/f2fs.h>
 
+static int f2fs_validate_options(struct super_block *sb);
+
 static struct kmem_cache *f2fs_inode_cachep;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -1418,7 +1420,15 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return ret;
 		}
 	}
+
 default_check:
+	return f2fs_validate_options(sb);
+}
+
+static int f2fs_validate_options(struct super_block *sb)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
 #ifdef CONFIG_QUOTA
 	if (f2fs_check_quota_options(sbi))
 		return -EINVAL;
@@ -1432,13 +1442,13 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 #endif
-
-	if (!IS_ENABLED(CONFIG_UNICODE) && f2fs_sb_has_casefold(sbi)) {
+#if !IS_ENABLED(CONFIG_UNICODE)
+	if (f2fs_sb_has_casefold(sbi)) {
 		f2fs_err(sbi,
 			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
 		return -EINVAL;
 	}
-
+#endif
 	/*
 	 * The BLKZONED feature indicates that the drive was formatted with
 	 * zone alignment optimization. This is optional for host-aware
@@ -1458,10 +1468,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			return -EINVAL;
 		}
 #else
-		f2fs_err(sbi, "Zoned block device support is not enabled");
-		return -EINVAL;
+			f2fs_err(sbi, "Zoned block device support is not enabled");
+			return -EINVAL;
 #endif
-	}
+		}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_test_compress_extension(sbi)) {
-- 
2.34.1


