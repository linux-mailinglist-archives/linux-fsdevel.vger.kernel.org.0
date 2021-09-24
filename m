Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3077F416E83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 11:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbhIXJJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 05:09:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9765 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245117AbhIXJJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:09:50 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HG5kw0bPjzW70H;
        Fri, 24 Sep 2021 17:07:04 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 17:08:16 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 24 Sep 2021 17:08:16 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2] ramfs: fix mount source show for ramfs
Date:   Fri, 24 Sep 2021 17:17:56 +0800
Message-ID: <20210924091756.1906118-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ramfs_parse_param does not parse key "source", and will convert
-ENOPARAM to 0. This will skip vfs_parse_fs_param_source in
vfs_parse_fs_param, which lead always "none" mount source for ramfs. Fix
it by parse "source" in ramfs_parse_param like cgroup1_parse_param has
do.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ramfs/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 65e7e56005b8..df4515d39cd4 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -203,17 +203,20 @@ static int ramfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	int opt;
 
 	opt = fs_parse(fc, ramfs_fs_parameters, param, &result);
-	if (opt < 0) {
+	if (opt == -ENOPARAM) {
+		opt = vfs_parse_fs_param_source(fc, param);
+		if (opt != -ENOPARAM)
+			return opt;
 		/*
 		 * We might like to report bad mount options here;
 		 * but traditionally ramfs has ignored all mount options,
 		 * and as it is used as a !CONFIG_SHMEM simple substitute
 		 * for tmpfs, better continue to ignore other mount options.
 		 */
-		if (opt == -ENOPARAM)
-			opt = 0;
-		return opt;
+		return 0;
 	}
+	if (opt < 0)
+		return opt;
 
 	switch (opt) {
 	case Opt_mode:
-- 
2.31.1

