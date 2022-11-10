Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA40B623A36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 04:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiKJDLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 22:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiKJDLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:11:35 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024F1D64D;
        Wed,  9 Nov 2022 19:11:33 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N76L25jtpzHvZ2;
        Thu, 10 Nov 2022 11:11:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:11:32 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:11:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] fs: Clear a UBSAN shift-out-of-bounds warning
Date:   Thu, 10 Nov 2022 11:10:24 +0800
Message-ID: <20221110031024.204-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

UBSAN: shift-out-of-bounds in fs/locks.c:2572:16
left shift of 1 by 63 places cannot be represented in type 'long long int'

Switch the calculation method to ((quarter - 1) * 2 + 1) can help us
eliminate this false positive.

On the other hand, the old implementation has problems with char and
short types, although not currently involved.
printf("%d: %x\n", sizeof(char),  INT_LIMIT(char));
printf("%d: %x\n", sizeof(short), INT_LIMIT(short));
1: ffffff7f
2: ffff7fff

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f16512c1..88d42e2daed9f6c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1131,7 +1131,7 @@ struct file_lock_context {
 
 /* The following constant reflects the upper bound of the file/locking space */
 #ifndef OFFSET_MAX
-#define INT_LIMIT(x)	(~((x)1 << (sizeof(x)*8 - 1)))
+#define INT_LIMIT(x)	((((x)1 << (sizeof(x) * 8 - 2)) - 1) * 2  + 1)
 #define OFFSET_MAX	INT_LIMIT(loff_t)
 #define OFFT_OFFSET_MAX	INT_LIMIT(off_t)
 #endif
-- 
2.25.1

