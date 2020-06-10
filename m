Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F861F5568
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgFJNKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 09:10:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728844AbgFJNKI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:10:08 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 183B73717472DD83013D;
        Wed, 10 Jun 2020 21:10:06 +0800 (CST)
Received: from huawei.com (10.175.101.78) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 10 Jun 2020
 21:09:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <slava@dubeyko.com>
CC:     <yangyingliang@huawei.com>
Subject: [PATCH] hfsplus: fix null-ptr-deref in hfs_find_init()
Date:   Wed, 10 Jun 2020 21:43:35 +0800
Message-ID: <1591796615-96336-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.78]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It may lead a null-ptr-deref in hfs_find_init() by
mounting a crafted hfs filesystem. So We need check
tree in hfs_find_init().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/hfsplus/bfind.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c..85bef3e 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 {
 	void *ptr;
 
+	if (!tree)
+		return -EINVAL;
+
 	fd->tree = tree;
 	fd->bnode = NULL;
 	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
-- 
1.8.3

