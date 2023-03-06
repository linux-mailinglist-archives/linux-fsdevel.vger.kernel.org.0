Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509326ABE36
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 12:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCFLdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 06:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCFLdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:33:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF435593;
        Mon,  6 Mar 2023 03:33:29 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PVbxg06k5zKq0x;
        Mon,  6 Mar 2023 19:31:19 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 19:33:21 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mawupeng1@huawei.com>
Subject: [PATCH] mm: Return early in truncate_pagecache if newsize overflows
Date:   Mon, 6 Mar 2023 19:33:17 +0800
Message-ID: <20230306113317.2295343-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Our own test reports a UBSAN in truncate_pagecache:

UBSAN: Undefined behaviour in mm/truncate.c:788:9
signed integer overflow:
9223372036854775807 + 1 cannot be represented in type 'long long int'

Call Trace:
  truncate_pagecache+0xd4/0xe0
  truncate_setsize+0x70/0x88
  simple_setattr+0xdc/0x100
  notify_change+0x654/0xb00
  do_truncate+0x108/0x1a8
  do_sys_ftruncate+0x2ec/0x4a0
  __arm64_sys_ftruncate+0x5c/0x80

For huge file which pass LONG_MAX to ftruncate, truncate_pagecache() will
be called to truncate with newsize be LONG_MAX which will lead to
overflow for holebegin:

  loff_t holebegin = round_up(newsize, PAGE_SIZE);

Since there is no meaning to truncate a file to LONG_MAX, return here
to avoid burn a bunch of cpu cycles.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/truncate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/truncate.c b/mm/truncate.c
index 7b4ea4c4a46b..99b6ce2d669b 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -730,6 +730,9 @@ void truncate_pagecache(struct inode *inode, loff_t newsize)
 	struct address_space *mapping = inode->i_mapping;
 	loff_t holebegin = round_up(newsize, PAGE_SIZE);
 
+	if (holebegin < 0)
+		return;
+
 	/*
 	 * unmap_mapping_range is called twice, first simply for
 	 * efficiency so that truncate_inode_pages does fewer
-- 
2.25.1

