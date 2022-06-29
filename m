Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC635606FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiF2RIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 13:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiF2RIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:08:22 -0400
X-Greylist: delayed 914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 10:08:20 PDT
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B33D033F;
        Wed, 29 Jun 2022 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sIJYq
        5d+vRuThuyqpYx/yGoalBNWWFzuL2MWoKkFzuk=; b=YKJW9lVEl+e8aqht/cwCx
        xJQbBBLQ4sj7Ya6xlB1USLu/0VaKAP6XuHws+pxYDSnap+7XSvH7EKCDFBQyw+a8
        fLaDQ2QHktF9zbDEYyLv9KFEXpuHeHQpLZMv48kdulW5HAaPe+ACT+eAXH28soXW
        TD09sp2SnlHos6T4ltLa68=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp2 (Coremail) with SMTP id GtxpCgAHhSJCg7xi3UbaMQ--.64981S4;
        Thu, 30 Jun 2022 00:52:30 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] proc/vmcore: fix potential memory leak in vmcore_init()
Date:   Thu, 30 Jun 2022 00:52:16 +0800
Message-Id: <20220629165216.2161430-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgAHhSJCg7xi3UbaMQ--.64981S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUtFyDCr1xAr1rCryUJrb_yoWfWwc_Aa
        18tF4xXw4rJan3Gr4UKFy5tw429rn09rs8Zr1xCF9rGa4rtwsxWr929rZ3Ar97JrsY93y5
        uw4SkFy7u34rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRE7PEPUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBOQ4vjF-POPBaDAAAsa
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
 fs/proc/vmcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4eaeb645e759..7e028cd1e59d 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1568,6 +1568,7 @@ static int __init vmcore_init(void)
 		return rc;
 	rc = parse_crash_elf_headers();
 	if (rc) {
+		elfcorehdr_free(elfcorehdr_addr);
 		pr_warn("Kdump: vmcore not initialized\n");
 		return rc;
 	}
-- 
2.25.1

