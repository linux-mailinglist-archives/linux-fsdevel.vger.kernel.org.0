Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD62F5B67E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 08:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIMGZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 02:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIMGZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:25:40 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACD6846D88;
        Mon, 12 Sep 2022 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dUKqH
        1exOk0lpXq/SvhuwXEQkuHHI1k0zmxmjV1BOdc=; b=IpzwCIgHxLNhDNGMlaSp2
        QTStWigvTg7MrDACTCpH7HDS8v14HLeL5/Go8rYzk4duPiGvLYEdZutCIvbpTU2C
        tjpHpd7eV4XtXAC/xzxd8LCpsjFotx1IXL97zS8Cnsd6eFhyjHKd4aIfYcnpK+QB
        0IEM2uBcG93YA2Kvkr+32I=
Received: from localhost.localdomain (unknown [36.112.3.164])
        by smtp4 (Coremail) with SMTP id HNxpCgBHzLU_IiBjHTGQcg--.34490S4;
        Tue, 13 Sep 2022 14:25:11 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] proc/vmcore: fix potential memory leak in vmcore_init()
Date:   Tue, 13 Sep 2022 14:25:01 +0800
Message-Id: <20220913062501.82546-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgBHzLU_IiBjHTGQcg--.34490S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrKrWUtFW5Gw4xXFWfXr17Awb_yoW8Jry5pF
        18Gw48CrykWrn7ur48Jw47Zrn5Aa1UXayjqry7CF4ayrnxWw4vyrWYkFWF9F1Yvr10ga98
        XFWkua13Aa98WaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0PfJUUUUU=
X-Originating-IP: [36.112.3.164]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiPgd7jFxBuB+RyAAAst
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
predefined value. If parse_crash_elf_headers() gets some error and
returns a negetive value, the elfcorehdr_addr should be released with
elfcorehdr_free().

Fix it by calling elfcorehdr_free() when parse_crash_elf_headers() fails.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 fs/proc/vmcore.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index f2aa86c421f2..163cb266f5fd 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1568,15 +1568,17 @@ static int __init vmcore_init(void)
 	rc = parse_crash_elf_headers();
 	if (rc) {
 		pr_warn("Kdump: vmcore not initialized\n");
-		return rc;
+		goto fail;
 	}
-	elfcorehdr_free(elfcorehdr_addr);
 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
 
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
-	return 0;
+
+fail:
+	elfcorehdr_free(elfcorehdr_addr);
+	return rc;
 }
 fs_initcall(vmcore_init);
 
-- 
2.25.1

