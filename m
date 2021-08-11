Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6693E9050
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 14:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhHKMR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 08:17:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8010 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhHKMRz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:17:55 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gl82g017LzYjSZ;
        Wed, 11 Aug 2021 20:17:15 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 20:17:30 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 11 Aug 2021 20:17:29 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <yangerkun@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] ramfs: fix mount source show for ramfs
Date:   Wed, 11 Aug 2021 20:28:11 +0800
Message-ID: <20210811122811.2288041-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ramfs_parse_param does not parse key "source", and will convert
-ENOPARAM to 0. This will skip vfs_parse_fs_param_source in
vfs_parse_fs_param, which lead always "none" mount source for ramfs. Fix
it by parse "source" in ramfs_parse_param.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ramfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 65e7e56005b8..0d7f5f655fd8 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -202,6 +202,10 @@ static int ramfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct ramfs_fs_info *fsi = fc->s_fs_info;
 	int opt;
 
+	opt = vfs_parse_fs_param_source(fc, param);
+	if (opt != -ENOPARAM)
+		return opt;
+
 	opt = fs_parse(fc, ramfs_fs_parameters, param, &result);
 	if (opt < 0) {
 		/*
-- 
2.31.1

