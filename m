Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38872783C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 11:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgIYJQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 05:16:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14281 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgIYJQc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:16:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C67FD8637E0A273CBC53;
        Fri, 25 Sep 2020 17:16:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 25 Sep 2020 17:16:21 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <viro@zeniv.linux.org.uk>, <akinobu.mita@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH] libfs: fix error cast of negative value in simple_attr_write()
Date:   Fri, 25 Sep 2020 17:15:08 +0800
Message-ID: <1601025308-28704-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The attr->set() receive a value of u64, but we use simple_strtoll()
for doing the conversion. It will lead to the error cast if user inputs
a negative value.

Use kstrtoull() instead to resolve this issue, -EINVAL will be returned
if a negative value is input.

Fixes: f7b88631a897 ("fs/libfs.c: fix simple_attr_write() on 32bit machines")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 fs/libfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index e0d42e9..803c439 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -975,7 +975,9 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 		goto out;

 	attr->set_buf[size] = '\0';
-	val = simple_strtoll(attr->set_buf, NULL, 0);
+	ret = kstrtoull(attr->set_buf, 0, &val);
+	if (ret)
+		goto out;
 	ret = attr->set(attr->data, val);
 	if (ret == 0)
 		ret = len; /* on success, claim we got the whole input */
--
2.8.1

