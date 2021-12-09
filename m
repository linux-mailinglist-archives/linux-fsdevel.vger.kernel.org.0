Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C896546E47E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 09:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhLIIsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 03:48:16 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15712 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhLIIsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:48:15 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J8nZj21D8zZdZM;
        Thu,  9 Dec 2021 16:41:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 9 Dec
 2021 16:44:40 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <libaokun1@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] sysctl: returns -EINVAL when a negative value is passed to proc_doulongvec_minmax
Date:   Thu, 9 Dec 2021 16:56:35 +0800
Message-ID: <20211209085635.1288737-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we pass a negative value to the proc_doulongvec_minmax() function,
the function returns 0, but the corresponding interface value does not
change.

we can easily reproduce this problem with the following commands:
    `cd /proc/sys/fs/epoll`
    `echo -1 > max_user_watches; echo $?; cat max_user_watches`

This function requires a non-negative number to be passed in, so when
a negative number is passed in, -EINVAL is returned.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/sysctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7f07b058b180..537d2f75faa0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1149,10 +1149,9 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
 					     sizeof(proc_wspace_sep), NULL);
 			if (err)
 				break;
-			if (neg)
-				continue;
+
 			val = convmul * val / convdiv;
-			if ((min && val < *min) || (max && val > *max)) {
+			if (neg || (min && val < *min) || (max && val > *max)) {
 				err = -EINVAL;
 				break;
 			}
-- 
2.31.1

