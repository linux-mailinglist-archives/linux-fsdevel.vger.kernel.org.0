Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE52AD272
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 10:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgKJJ1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 04:27:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7165 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgKJJ1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:27:04 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CVjDY4x5fz15RXC;
        Tue, 10 Nov 2020 17:26:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Nov 2020 17:26:54 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <akinobu.mita@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>
Subject: [RESEND PATCH] libfs: fix error cast of negative value in simple_attr_write()
Date:   Tue, 10 Nov 2020 17:25:24 +0800
Message-ID: <1605000324-7428-1-git-send-email-yangyicong@hisilicon.com>
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
 fs/libfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index fc34361..2dcf40e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
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

