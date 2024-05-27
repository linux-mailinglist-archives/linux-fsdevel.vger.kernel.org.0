Return-Path: <linux-fsdevel+bounces-20210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC08CFABA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 09:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A591F22DAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 07:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8433D3AC;
	Mon, 27 May 2024 07:58:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A65787B;
	Mon, 27 May 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796700; cv=none; b=mvqZPHaapw/HcOhJ6Iy0teJGJa4rTxxcY72yuoMDmd3IDGJiTWpWUkAmGvfpskd0653suUDA5OygK1PSFtG3b4LYuB7MqV6sIIjlZwMhE82YoVirJVsbjgN7ctRGsg+sAMTN4BDrKHIHOU3F5ict6tcc+AS91IZgA8phOWnLO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796700; c=relaxed/simple;
	bh=1V35Xtl9Gabc3cCpj/uZzgPUaqJp0QIJ5zZaPmom+dA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0hA0pkWDUqTHV48QQ/iXYVKaEGJagBwXyYRuziP9JvSFSXDIgS9pVMTJ4om20Us5EAo7+RR8BhNY5Lmnqueoxxfc+SmdcIjftf7mObmxEh2YnofCy9edxbO94SBjaEE2c+LX8kPQInX/NpgY6CztuWV3YakVZkckVDEYUX71dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VnnzW28rFz1wwV7;
	Mon, 27 May 2024 15:56:55 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 70B741400FD;
	Mon, 27 May 2024 15:58:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 27 May
 2024 15:58:11 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lczerner@redhat.com>, <cmaiolino@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yi.zhang@huawei.com>, <lihongbo22@huawei.com>
Subject: [PATCH v2 1/4] fs: add blockdev parser for filesystem mount option.
Date: Mon, 27 May 2024 15:58:51 +0800
Message-ID: <20240527075854.1260981-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527075854.1260981-1-lihongbo22@huawei.com>
References: <20240527075854.1260981-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

`fsparam_bdev` uses `fs_param_is_blockdev` to parse the option, but it
is currently empty. Filesystems like ext4 use the `fsparam_bdev` to
parse `journal_path` into the block device. This general logic should
be moved to the vfs layer, not the specific filesystem. Therefore, we
implement block device parser in `fs_param_is_blockdev`. And the logic
is similar with `fs_lookup_param`.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/fs_parser.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index a4d6ca0b8971..2aa208cf2027 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -311,7 +311,56 @@ EXPORT_SYMBOL(fs_param_is_fd);
 int fs_param_is_blockdev(struct p_log *log, const struct fs_parameter_spec *p,
 		  struct fs_parameter *param, struct fs_parse_result *result)
 {
-	return 0;
+	int ret;
+	int dfd;
+	struct filename *f;
+	struct inode *dev_inode;
+	struct path path;
+	bool put_f;
+
+	switch (param->type) {
+	case fs_value_is_string:
+		if (!*param->string) {
+			if (p->flags & fs_param_can_be_empty)
+				return 0;
+			return fs_param_bad_value(log, param);
+		}
+		f = getname_kernel(param->string);
+		if (IS_ERR(f))
+			return fs_param_bad_value(log, param);
+		dfd = AT_FDCWD;
+		put_f = true;
+		break;
+	case fs_value_is_filename:
+		f = param->name;
+		dfd = param->dirfd;
+		put_f = false;
+		break;
+	default:
+		return fs_param_bad_value(log, param);
+	}
+
+	ret = filename_lookup(dfd, f, LOOKUP_FOLLOW, &path, NULL);
+	if (ret < 0) {
+		error_plog(log, "%s: Lookup failure for '%s'", param->key, f->name);
+		goto out_putname;
+	}
+
+	dev_inode = d_backing_inode(path.dentry);
+	if (!S_ISBLK(dev_inode->i_mode)) {
+		error_plog(log, "%s: Non-blockdev passed as '%s'", param->key, f->name);
+		ret = -1;
+		goto out_putpath;
+	}
+	result->uint_32 = new_encode_dev(dev_inode->i_rdev);
+
+out_putpath:
+	path_put(&path);
+out_putname:
+	if (put_f)
+		putname(f);
+
+	return (ret < 0) ? fs_param_bad_value(log, param) : 0;
 }
 EXPORT_SYMBOL(fs_param_is_blockdev);
 
-- 
2.34.1


