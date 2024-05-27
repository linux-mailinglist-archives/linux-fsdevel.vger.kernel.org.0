Return-Path: <linux-fsdevel+bounces-20198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E138CF751
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 03:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72070281C23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 01:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9374C96;
	Mon, 27 May 2024 01:46:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBCB64D;
	Mon, 27 May 2024 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716774404; cv=none; b=ZfpotLIyvTXSA/9+4mSatommSjw/li85id6oJjvz9mAFcD85urLPdn3SE1GST3s65RSkqYkflknBWBCE4XY/PwX1ze+HUoguWUnlqAgrmXXRWST8kZqr1vUnsz+b3dbv2MnicDJUjMZPpBigLu3pkbwVhCGsDYK+xTVZc2gbn7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716774404; c=relaxed/simple;
	bh=rZ02V84bO2V3r6G6Q2s6m8OYBKD5fTAE2I5AuDt9Vwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbbRtapkiqD8u/d0El6UIiN1XwhzjaayHKLbbegQohTmAu0uToDu5OTkg/ha4staK2oLcereBvYJd0o+MBNnXLuvW0pjQiLeBexzAf3SsRADHWqGjWWm2sE7NY7iZC+6J6Z+jL/dbhDpsmLeLyGHYYsaPWvc7nHzpb5Kd1G6td4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VndkR0mHDz1HC3Y;
	Mon, 27 May 2024 09:45:03 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 36D6B1402C7;
	Mon, 27 May 2024 09:46:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 27 May
 2024 09:46:39 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lczerner@redhat.com>, <cmaiolino@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yi.zhang@huawei.com>, <lihongbo22@huawei.com>
Subject: [PATCH 1/4] fs: add blockdev parser for filesystem mount option.
Date: Mon, 27 May 2024 09:47:14 +0800
Message-ID: <20240527014717.690140-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527014717.690140-1-lihongbo22@huawei.com>
References: <20240527014717.690140-1-lihongbo22@huawei.com>
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
index a4d6ca0b8971..48f60ecfcca0 100644
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
+			break;
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


