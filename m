Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE585629008
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 03:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiKOCvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 21:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiKOCvj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:51:39 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061AC16590
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 18:51:37 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NB9fd3fgGzHvvQ;
        Tue, 15 Nov 2022 10:51:05 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 10:51:34 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <yzaikin@google.com>, <mcgrof@kernel.org>, <keescook@chromium.org>
CC:     <linux-fsdevel@vger.kernel.org>, <zengheng4@huawei.com>,
        <liwei391@huawei.com>
Subject: [PATCH] proc: sysctl: remove unnecessary jump label in __register_sysctl_table()
Date:   Tue, 15 Nov 2022 10:47:34 +0800
Message-ID: <20221115024734.3734391-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The processing path that handles error return value of insert_header(),
can reuse part of normal processing path. So remove the unnecessary
jump label named fail_put_dir_locked.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/proc/proc_sysctl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 48f2d60bd78a..cae23f9ba98e 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1329,7 +1329,7 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_dir *dir;
 	struct ctl_table *entry;
 	struct ctl_node *node;
-	int nr_entries = 0;
+	int err, nr_entries = 0;
 
 	list_for_each_table_entry(entry, table)
 		nr_entries++;
@@ -1369,17 +1369,16 @@ struct ctl_table_header *__register_sysctl_table(
 	}
 
 	spin_lock(&sysctl_lock);
-	if (insert_header(dir, header))
-		goto fail_put_dir_locked;
+	err = insert_header(dir, header);
 
 	drop_sysctl_table(&dir->header);
 	spin_unlock(&sysctl_lock);
 
+	if (err)
+		goto fail;
+
 	return header;
 
-fail_put_dir_locked:
-	drop_sysctl_table(&dir->header);
-	spin_unlock(&sysctl_lock);
 fail:
 	kfree(header);
 	dump_stack();
-- 
2.25.1

