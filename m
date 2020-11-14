Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1A72B2C0D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 09:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKNILM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 03:11:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7899 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgKNILM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 03:11:12 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CY7Lt2sNFz761H;
        Sat, 14 Nov 2020 16:10:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 14 Nov 2020 16:10:48 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
        <David.Laight@ACULAB.COM>, <linux-fsdevel@vger.kernel.org>
CC:     <akinobu.mita@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH v3] libfs: fix error cast of negative value in simple_attr_write()
Date:   Sat, 14 Nov 2020 16:09:16 +0800
Message-ID: <1605341356-11872-1-git-send-email-yangyicong@hisilicon.com>
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
correctly. Make 'val' unsigned long long as what kstrtoull() takes, this
will eliminate the compile warning on no 64-bit architectures.

Fixes: f7b88631a897 ("fs/libfs.c: fix simple_attr_write() on 32bit machines")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- address the compile warning for non-64 bit platform.
Change since v2:
Link: https://lore.kernel.org/linux-fsdevel/1605000324-7428-1-git-send-email-yangyicong@hisilicon.com/
- make 'val' unsigned long long and mentioned in the commit
Link: https://lore.kernel.org/linux-fsdevel/1605261369-551-1-git-send-email-yangyicong@hisilicon.com/

 fs/libfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index fc34361..7124c2e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -959,7 +959,7 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 			  size_t len, loff_t *ppos)
 {
 	struct simple_attr *attr;
-	u64 val;
+	unsigned long long val;
 	size_t size;
 	ssize_t ret;
 
@@ -977,7 +977,9 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
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

