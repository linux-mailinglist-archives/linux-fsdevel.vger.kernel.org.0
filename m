Return-Path: <linux-fsdevel+bounces-20208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C758CFAB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 09:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A151F22C46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B5E383BD;
	Mon, 27 May 2024 07:58:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3355E49;
	Mon, 27 May 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796699; cv=none; b=P0w3g3czsecgYxAq50lobGJ7Xa9a/sW3VNOSWaDS9zKpw30ELyL8dTkf0Iu+r/gKgA7t8ADrydC++48xLW1TwgIPI14OoDexxCBAQn/yUxxxqZF+7J9xyWd8fA7zNBpe2gxQ4IH85mfpHg77fuMxI2GbBD6McsGa0MZIQoOcKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796699; c=relaxed/simple;
	bh=fozoJ0jk0ztAqhByvuP6+GzV7jYHHfG4g+v9p6kdQwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpD3dbKh9BfFqJ3cUZWFFht9EG9z4yJktqhcJIVYJiEf/slv70zvMJk66RhJXl/3T4QYuH0JSxYowkL6IEnuxoXehbb/OelRXoIWzPN2aaTWxUNEVFt0gjqyyT216T+SF9x9UZhBWubcXKfEgxw/fFgFZaeDwefx8RqO1ndA8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vnnwh0D0szxQ5d;
	Mon, 27 May 2024 15:54:28 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id CD3B114037D;
	Mon, 27 May 2024 15:58:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 27 May
 2024 15:58:14 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lczerner@redhat.com>, <cmaiolino@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yi.zhang@huawei.com>, <lihongbo22@huawei.com>
Subject: [PATCH v2 3/4] fs: ext4: support relative path for `journal_path` in mount option.
Date: Mon, 27 May 2024 15:58:53 +0800
Message-ID: <20240527075854.1260981-4-lihongbo22@huawei.com>
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

After `fs_param_is_blockdev` is implemented(in fs: add blockdev parser
for filesystem mount option.), `journal_devnum` can be obtained from
`result.uint_32` directly.

Additionally, the `fs_lookup_param` did not consider the relative path
for block device. When we mount ext4 with `journal_path` option using
relative path, `param->dirfd` was not set which will cause mounting
error.

This can be reproduced easily like this:

mke2fs -F -O journal_dev $JOURNAL_DEV -b 4096 100M
mkfs.ext4 -F -J device=$JOURNAL_DEV -b 4096 $FS_DEV
cd /dev; mount -t ext4 -o journal_path=`basename $JOURNAL_DEV` $FS_DEV $MNT

Fixes: 461c3af045d3 ("ext4: Change handle_mount_opt() to use fs_parameter")
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/ext4/super.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c682fb927b64..94b39bcae99d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2290,39 +2290,15 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->spec |= EXT4_SPEC_s_resgid;
 		return 0;
 	case Opt_journal_dev:
-		if (is_remount) {
-			ext4_msg(NULL, KERN_ERR,
-				 "Cannot specify journal on remount");
-			return -EINVAL;
-		}
-		ctx->journal_devnum = result.uint_32;
-		ctx->spec |= EXT4_SPEC_JOURNAL_DEV;
-		return 0;
 	case Opt_journal_path:
-	{
-		struct inode *journal_inode;
-		struct path path;
-		int error;
-
 		if (is_remount) {
 			ext4_msg(NULL, KERN_ERR,
 				 "Cannot specify journal on remount");
 			return -EINVAL;
 		}
-
-		error = fs_lookup_param(fc, param, 1, LOOKUP_FOLLOW, &path);
-		if (error) {
-			ext4_msg(NULL, KERN_ERR, "error: could not find "
-				 "journal device path");
-			return -EINVAL;
-		}
-
-		journal_inode = d_inode(path.dentry);
-		ctx->journal_devnum = new_encode_dev(journal_inode->i_rdev);
+		ctx->journal_devnum = result.uint_32;
 		ctx->spec |= EXT4_SPEC_JOURNAL_DEV;
-		path_put(&path);
 		return 0;
-	}
 	case Opt_journal_ioprio:
 		if (result.uint_32 > 7) {
 			ext4_msg(NULL, KERN_ERR, "Invalid journal IO priority"
-- 
2.34.1


