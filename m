Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421692B18AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 10:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgKMJ5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 04:57:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8081 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMJ5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:57:51 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CXYmZ04sBzLt9q;
        Fri, 13 Nov 2020 17:57:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 17:57:42 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <akinobu.mita@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH v2] libfs: fix error cast of negative value in simple_attr_write()
Date:   Fri, 13 Nov 2020 17:56:09 +0800
Message-ID: <1605261369-551-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The attr->set() receive a value of u64, but simple_strtoll() is used
for doing the conversion. It will lead to the error cast if user inputs
a negative value.

Use kstrtoull() instead of simple_strtoll() to convert a string got
from the user to an unsigned value. The former will return '-EINVAL' if
it gets a negetive value, but the latter can't handle the situation
correctly.

Fixes: f7b88631a897 ("fs/libfs.c: fix simple_attr_write() on 32bit machines")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- address the compile warning for non-64 bit platform

 fs/libfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index fc34361..3a0d99c 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -977,7 +977,9 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 		goto out;
 
 	attr->set_buf[size] = '\0';
-	val = simple_strtoll(attr->set_buf, NULL, 0);
+	ret = kstrtoull(attr->set_buf, 0, (unsigned long long *)&val);
+	if (ret)
+		goto out;
 	ret = attr->set(attr->data, val);
 	if (ret == 0)
 		ret = len; /* on success, claim we got the whole input */
-- 
2.8.1

