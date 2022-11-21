Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27E96318A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 03:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKUCol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 21:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKUCoj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:44:39 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D087420366;
        Sun, 20 Nov 2022 18:44:38 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NFsCt4tM0zRpNN;
        Mon, 21 Nov 2022 10:44:10 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 10:44:37 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 10:44:36 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/2] btrfs: replace INT_LIMIT(loff_t) with OFFSET_MAX
Date:   Mon, 21 Nov 2022 10:44:17 +0800
Message-ID: <20221121024418.1800-2-thunder.leizhen@huawei.com>
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

OFFSET_MAX is self-annotated and more readable.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/btrfs/ordered-data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e54f8280031fa14..100d9f4836b177d 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -761,11 +761,11 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
 	struct btrfs_ordered_extent *ordered;
 
 	if (start + len < start) {
-		orig_end = INT_LIMIT(loff_t);
+		orig_end = OFFSET_MAX;
 	} else {
 		orig_end = start + len - 1;
-		if (orig_end > INT_LIMIT(loff_t))
-			orig_end = INT_LIMIT(loff_t);
+		if (orig_end > OFFSET_MAX)
+			orig_end = OFFSET_MAX;
 	}
 
 	/* start IO across the range first to instantiate any delalloc
-- 
2.25.1

