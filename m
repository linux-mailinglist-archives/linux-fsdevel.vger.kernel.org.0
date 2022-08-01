Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4447586668
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 10:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiHAIeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 04:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiHAIea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:34:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AA026D6;
        Mon,  1 Aug 2022 01:34:29 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LxBGH2LZDzGpHj;
        Mon,  1 Aug 2022 16:33:11 +0800 (CST)
Received: from huawei.com (10.67.174.191) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 1 Aug
 2022 16:34:26 +0800
From:   Li Hua <hucool.lihua@huawei.com>
To:     <akpm@linux-foundation.org>, <mail@christoph.anton.mitterer.name>,
        <hannes@cmpxchg.org>, <kaleshsingh@google.com>,
        <shy828301@gmail.com>, <rppt@kernel.org>,
        <paul.gortmaker@windriver.co>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH -next] Documentation/filesystems/proc.rst: Change the document about cputime
Date:   Tue, 2 Aug 2022 06:30:46 +0800
Message-ID: <20220801223046.35178-1-hucool.lihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because the values of utime, stime, and delta are temporarily
written to cpustat in kcpustat_cpu_fetch_vtime. Therefore, there are two
problems read from /proc/stat:
1. The value read the second time may be less than the first time.
2. When there are many tasks, the statistics are not imprecise when utime
and stime do not exceed one tick.

Signed-off-by: Li Hua <hucool.lihua@huawei.com>
---
 Documentation/filesystems/proc.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 47e95dbc820d..b6625e83c994 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1459,6 +1459,10 @@ second).  The meanings of the columns are as follows, from left to right:
 - user: normal processes executing in user mode
 - nice: niced processes executing in user mode
 - system: processes executing in kernel mode
+  The amount of time reading from /proc/stat is not reliable, because the value
+  of utime, stime, and delta are temporarily written to cpustat in
+  kcpustat_cpu_fetch_vtime().
+
 - idle: twiddling thumbs
 - iowait: In a word, iowait stands for waiting for I/O to complete. But there
   are several problems:
-- 
2.17.1

