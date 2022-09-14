Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20A45B7E53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 03:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiINBdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 21:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiINBdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:33:39 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD6056B8DF;
        Tue, 13 Sep 2022 18:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KqodM
        YrOFpEVlmPN5U59wZd+Mb7IJb+e/Mld+L/PKCU=; b=CPZrAAyhnjpBuCstJMvKh
        ZWhHoSdrtYuYC0g6TuPzYYyQUsQ1YKD2qcroJOZJm2tIrpIh+IbeAbDipJzDSblJ
        DVeRAG88NcK0/hEtbhRUFKjmG+Bg3soE576TdBTIlXBKoZxfFiNj5mqHayfwqJfr
        7mzrcEbwn97/q2ym+oqxME=
Received: from localhost.localdomain (unknown [36.112.3.106])
        by smtp1 (Coremail) with SMTP id GdxpCgDnUuVXLyFjD05gcg--.57701S4;
        Wed, 14 Sep 2022 09:33:25 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v2] proc/vmcore: fix potential memory leak in vmcore_init()
Date:   Wed, 14 Sep 2022 09:33:10 +0800
Message-Id: <20220914013310.6386-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDnUuVXLyFjD05gcg--.57701S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUtFW5Gw4xXFWfXr17Awb_yoWfZwb_Aa
        18tF4xXw4rJan3GrWUKFy5tw4akr1j9rs8XF1fGF9rGFyrtwsxW3s7ZrZ3Ar97XrsYvry5
        uwsakFy2934rGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_sqWUUUUUU==
X-Originating-IP: [36.112.3.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFQZ8jF5mMjllDAAAs5
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
 fs/proc/vmcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index f2aa86c421f2..74747571d58e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1567,6 +1567,7 @@ static int __init vmcore_init(void)
 		return rc;
 	rc = parse_crash_elf_headers();
 	if (rc) {
+		elfcorehdr_free(elfcorehdr_addr);
 		pr_warn("Kdump: vmcore not initialized\n");
 		return rc;
 	}
-- 
2.25.1

