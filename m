Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DD7A5EEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 03:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfICBrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 21:47:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfICBrj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 21:47:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 72512E25CEEF72EB3E32
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 09:47:36 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 09:47:29 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <amir73il@gmail.com>, <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] fanotify: remove always false comparison in copy_fid_to_user
Date:   Tue, 3 Sep 2019 09:54:14 +0800
Message-ID: <1567475654-6133-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes gcc warning:

fs/notify/fanotify/fanotify_user.c:252:19: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8508ab5..e15547d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -249,7 +249,7 @@ static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
 	/* Pad with 0's */
 	buf += fh_len;
 	len -= fh_len;
-	WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
+	WARN_ON_ONCE(len >= FANOTIFY_EVENT_ALIGN);
 	if (len > 0 && clear_user(buf, len))
 		return -EFAULT;

--
2.7.4

