Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1E72A47C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2019 14:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfEYMyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 May 2019 08:54:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfEYMyQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 May 2019 08:54:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 33796C97306223C53443;
        Sat, 25 May 2019 20:54:13 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 20:54:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] binfmt_flat: remove set but not used variable 'inode'
Date:   Sat, 25 May 2019 20:53:41 +0800
Message-ID: <20190525125341.9844-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/binfmt_flat.c: In function load_flat_file:
fs/binfmt_flat.c:419:16: warning: variable inode set but not used [-Wunused-but-set-variable]

It's never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/binfmt_flat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 82a48e830018..2eea4b68c331 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -416,7 +416,6 @@ static int load_flat_file(struct linux_binprm *bprm,
 	u32 text_len, data_len, bss_len, stack_len, full_data, flags;
 	unsigned long len, memp, memp_size, extra, rlim;
 	u32 __user *reloc, *rp;
-	struct inode *inode;
 	int i, rev, relocs;
 	loff_t fpos;
 	unsigned long start_code, end_code;
@@ -424,7 +423,6 @@ static int load_flat_file(struct linux_binprm *bprm,
 	int ret;
 
 	hdr = ((struct flat_hdr *) bprm->buf);		/* exec-header */
-	inode = file_inode(bprm->file);
 
 	text_len  = ntohl(hdr->data_start);
 	data_len  = ntohl(hdr->data_end) - ntohl(hdr->data_start);
-- 
2.17.1


