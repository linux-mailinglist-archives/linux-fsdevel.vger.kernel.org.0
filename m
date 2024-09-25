Return-Path: <linux-fsdevel+bounces-30025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA0D9850D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 04:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3BA1C22ADB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56D148302;
	Wed, 25 Sep 2024 02:05:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9A2907;
	Wed, 25 Sep 2024 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229955; cv=none; b=drJnwf4UKKPsVKF6/lnQ6xA8rbwFV8TWNfpsCBZOJ/ex62a09l/RcnK0D1lY5FP3V/tpq4A4o3ki64aLIoC6Pcw+wBQCpG40fzTgX8+ibuZAkz1KopUxO83qXB9TtdT+3RU879N6jJYTqW4oKBR6I/lxuKjtAW/Gd8O8R5TV5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229955; c=relaxed/simple;
	bh=EOdHBDON93KXcxlVMFpt+6DKT4ay08+zlogdHf7Vm8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qu0ATCFvZ9cTD9DVhGVCypKbRQV7ZkDalDhJQtYsSGTpCqsPnHNvPbxW6GGqDnwBWVc44ZTc1TMo53yk2Miw2NK8bC9ZdQ0h3ilv9pkY/l5bJVue9+eQZyh/dnmkiZbQYGvpVgKBYkXwgeTUDMk3GDaasdqPAx0lyPQtg29Ye0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XD0173hgQz1SBgv;
	Wed, 25 Sep 2024 09:45:31 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id EF6EF180019;
	Wed, 25 Sep 2024 09:46:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 09:46:18 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>, <chris.zjh@huawei.com>
Subject: [PATCH v2] fs: ext4: support relative path for `journal_path` in mount option.
Date: Wed, 25 Sep 2024 09:56:24 +0800
Message-ID: <20240925015624.3817878-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The `fs_lookup_param` did not consider the relative path for
block device. When we mount ext4 with `journal_path` option using
relative path, `param->dirfd` was not set which will cause mounting
error.

This can be reproduced easily like this:

mke2fs -F -O journal_dev $JOURNAL_DEV -b 4096 100M
mkfs.ext4 -F -J device=$JOURNAL_DEV -b 4096 $FS_DEV
cd /dev; mount -t ext4 -o journal_path=`basename $JOURNAL_DEV` $FS_DEV $MNT

Fixes: 461c3af045d3 ("ext4: Change handle_mount_opt() to use fs_parameter")
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
v2:
  - Change the journal_path parameter as string not bdev, and
    determine the relative path situation inside fs_lookup_param.
  - Add Suggested-by.

v1: https://lore.kernel.org/all/20240527-mahlen-packung-3fe035ab390d@brauner/
---
 fs/ext4/super.c | 4 ++--
 fs/fs_parser.c  | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16a4ce704460..cd23536ce46e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1744,7 +1744,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_u32	("min_batch_time",	Opt_min_batch_time),
 	fsparam_u32	("max_batch_time",	Opt_max_batch_time),
 	fsparam_u32	("journal_dev",		Opt_journal_dev),
-	fsparam_bdev	("journal_path",	Opt_journal_path),
+	fsparam_string	("journal_path",	Opt_journal_path),
 	fsparam_flag	("journal_checksum",	Opt_journal_checksum),
 	fsparam_flag	("nojournal_checksum",	Opt_nojournal_checksum),
 	fsparam_flag	("journal_async_commit",Opt_journal_async_commit),
@@ -2301,7 +2301,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 
-		error = fs_lookup_param(fc, param, 1, LOOKUP_FOLLOW, &path);
+		error = fs_lookup_param(fc, param, true, LOOKUP_FOLLOW, &path);
 		if (error) {
 			ext4_msg(NULL, KERN_ERR, "error: could not find "
 				 "journal device path");
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 24727ec34e5a..2ae296764b69 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -156,6 +156,9 @@ int fs_lookup_param(struct fs_context *fc,
 		f = getname_kernel(param->string);
 		if (IS_ERR(f))
 			return PTR_ERR(f);
+		/* for relative path */
+		if (f->name[0] != '/')
+			param->dirfd = AT_FDCWD;
 		put_f = true;
 		break;
 	case fs_value_is_filename:
-- 
2.34.1


