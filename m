Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889D310DC0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 02:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfK3BlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 20:41:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727230AbfK3BlR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 20:41:17 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6C92941332E05518ED29;
        Sat, 30 Nov 2019 09:41:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 09:41:07 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH V2 1/3] dcache: add a new enum type for 'dentry_d_lock_class'
Date:   Sat, 30 Nov 2019 10:02:23 +0800
Message-ID: <20191130020225.20239-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191130020225.20239-1-yukuai3@huawei.com>
References: <20191130020225.20239-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

'dentry_d_lock_class' can be used for spin_lock_nested in case lockdep
confused about two different dentry take the 'd_lock'.

However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
two dentry are involed. So, add in 'DENTRY_D_LOCK_NESTED_TWICE'.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 include/linux/dcache.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 10090f11ab95..830405b401ce 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -129,7 +129,16 @@ struct dentry {
 enum dentry_d_lock_class
 {
 	DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
-	DENTRY_D_LOCK_NESTED
+	/* 
+	 * used by spin_lock_nested when two d_lock need to be taken
+	 * at the same time
+	 */
+	DENTRY_D_LOCK_NESTED,
+	/*
+	 * used by spin_lock_nested when three d_lock need to be taken
+	 * at the same time
+	 */
+	DENTRY_D_LOCK_NESTED_TWICE
 };
 
 struct dentry_operations {
-- 
2.17.2

