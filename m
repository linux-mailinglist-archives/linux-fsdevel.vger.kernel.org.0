Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A016318AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 03:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKUCon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 21:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiKUCok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:44:40 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B02036B;
        Sun, 20 Nov 2022 18:44:39 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NFsCv2NvtzRpNr;
        Mon, 21 Nov 2022 10:44:11 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 10:44:37 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 10:44:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 2/2] fs: clear a UBSAN shift-out-of-bounds warning
Date:   Mon, 21 Nov 2022 10:44:18 +0800
Message-ID: <20221121024418.1800-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221121024418.1800-1-thunder.leizhen@huawei.com>
References: <20221121024418.1800-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Switch the calculation method to type_max() can help us eliminate this
false positive.

On the other hand, the old implementation has problems with char and
short types, although not currently involved.
printf("%d: %x\n", sizeof(char),  INT_LIMIT(char));
printf("%d: %x\n", sizeof(short), INT_LIMIT(short));
1: ffffff7f
2: ffff7fff

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/fs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f16512c1..a384741b1449457 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1131,9 +1131,8 @@ struct file_lock_context {
 
 /* The following constant reflects the upper bound of the file/locking space */
 #ifndef OFFSET_MAX
-#define INT_LIMIT(x)	(~((x)1 << (sizeof(x)*8 - 1)))
-#define OFFSET_MAX	INT_LIMIT(loff_t)
-#define OFFT_OFFSET_MAX	INT_LIMIT(off_t)
+#define OFFSET_MAX	type_max(loff_t)
+#define OFFT_OFFSET_MAX	type_max(off_t)
 #endif
 
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
-- 
2.25.1

