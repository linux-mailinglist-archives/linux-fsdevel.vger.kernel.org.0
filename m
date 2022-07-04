Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E2564F9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiGDITO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 04:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiGDITM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:19:12 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CC6C1162;
        Mon,  4 Jul 2022 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Annf+
        CpGtxX7J5YiGisq08DgMf6VciPGfyVKNVzY0eM=; b=aWBFwJl+YjL2aI3O18HP0
        uZTDhOo4jgMeV5EZM4nI+10hTqfWA74jHCK50nhs/Bn6G74biWLtfKr397VBrRgZ
        GB3FteUdzgpMhWSsnWCOlytW4goRNJdZ5CwnpKZRamDCwpA+ANV8HXjlhEAaJ3x1
        Me1+xECR1mAooIBidD81yA=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp5 (Coremail) with SMTP id HdxpCgD3_QpgosJiXllzMQ--.46554S4;
        Mon, 04 Jul 2022 16:18:53 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v2] proc/vmcore: fix potential memory leak in vmcore_init()
Date:   Mon,  4 Jul 2022 16:18:39 +0800
Message-Id: <20220704081839.2232996-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgD3_QpgosJiXllzMQ--.46554S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrKrWUtFyDCr1xAr1rCryUJrb_yoW8JryxpF
        WxJw48Cr95Wrn7ur48Jws8ur1kAa1UXay0qryUuF4ayrnxWw1vvrWSkFWF9Fn0vr10ga98
        XFWkuw43AFZ8Xw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRDku3UUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiMg00jFWBzzIEVgAAs8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
predefined value. If parse_crash_elf_headers() occurs some error and
returns a negetive value, the elfcorehdr_addr should be released with
elfcorehdr_free().

We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
fails.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 fs/proc/vmcore.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4eaeb645e759..86887bd90263 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
 	rc = parse_crash_elf_headers();
 	if (rc) {
 		pr_warn("Kdump: vmcore not initialized\n");
-		return rc;
+		goto fail;
 	}
 	elfcorehdr_free(elfcorehdr_addr);
 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
@@ -1577,6 +1577,9 @@ static int __init vmcore_init(void)
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
+
+fail:
+	elfcorehdr_free(elfcorehdr_addr);
 	return 0;
 }
 fs_initcall(vmcore_init);
-- 
2.25.1

