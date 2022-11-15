Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DCA6290DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 04:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbiKODfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 22:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiKODfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:35:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BE57653;
        Mon, 14 Nov 2022 19:35:12 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBBY81HTBzqSPh;
        Tue, 15 Nov 2022 11:31:24 +0800 (CST)
Received: from huawei.com (10.67.174.191) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 11:35:10 +0800
From:   Li Hua <hucool.lihua@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>, <yusongping@huawei.com>,
        <hucool.lihua@huawei.com>
Subject: [PATCH] =?UTF-8?q?coredump:=20Fix=20build=20error=20for=20?= =?UTF-8?q?=E2=80=98dump=5Femit=5Fpage=E2=80=99=20defined=20but=20not=20us?= =?UTF-8?q?ed?=
Date:   Tue, 15 Nov 2022 12:04:00 +0800
Message-ID: <20221115040400.53712-1-hucool.lihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If CONFIG_ELF_CORE is not set:
    fs/coredump.c:834:12: error: ‘dump_emit_page’ defined but not used [-Werror=unused-function]
    static int dump_emit_page(struct coredump_params *cprm, struct page *page)
            ^~~~~~~~~~~~~~

Fix this by adding the missing CONFIG_ELF_CORE for dump_emit_page.

Fixes: 06bbaa6dc53c ("[coredump] don't use __kernel_write() on kmap_local_page()")
Signed-off-by: Li Hua <hucool.lihua@huawei.com>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7bad7785e8e6..8663042ebe9c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -831,6 +831,7 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	}
 }
 
+#ifdef CONFIG_ELF_CORE
 static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
 	struct bio_vec bvec = {
@@ -863,6 +864,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 
 	return 1;
 }
+#endif
 
 int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 {
-- 
2.17.1

