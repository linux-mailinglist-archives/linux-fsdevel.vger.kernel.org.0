Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57C56D6E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 09:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiGKHfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 03:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiGKHfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:35:13 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87A7F1BEAF;
        Mon, 11 Jul 2022 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Cj/Rb
        6wa9GFxUQqhUdh2NDMpVy+s4rRoTrJKhdx+R5k=; b=Kaw7MUWjV/9FhP0wKMv1y
        J7FdyTKnUHsOOrQAx6FUpGNRz9Vjljp4Pv0tL27WOa6KrI3fZLMZXmPVt2FGnHx2
        dH5fGdkzMSMBedQRUdSovOj83dy9CVuPSmhSBFA2k7aJeBH2q05IVTFhGAn1ZfPh
        Hyb8IkgCJ3TmrSIojgPr3o=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp1 (Coremail) with SMTP id GdxpCgDnPZGa0stioLW2Ng--.8571S4;
        Mon, 11 Jul 2022 15:34:58 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v3] proc/vmcore: fix potential memory leak in vmcore_init()
Date:   Mon, 11 Jul 2022 15:34:49 +0800
Message-Id: <20220711073449.2319585-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDnPZGa0stioLW2Ng--.8571S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUtFyDCr1xAr1rCryUJrb_yoWkurb_uF
        4UKr4xX3yrGa1fGr4UKryrJw42kr1j9rs8Xr1xCF9rJa4rKwsxWrZ7urZ3Ar9xJrsY9345
        uw4FkFy29ry5KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREWrW3UUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiQwg7jFc7ajRQVQAAsL
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
index 4eaeb645e759..125efe63f281 100644
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
@@ -1578,6 +1578,9 @@ static int __init vmcore_init(void)
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
 	return 0;
+fail:
+	elfcorehdr_free(elfcorehdr_addr);
+	return rc;
 }
 fs_initcall(vmcore_init);
 
-- 
2.25.1

