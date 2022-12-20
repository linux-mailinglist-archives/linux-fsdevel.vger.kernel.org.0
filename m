Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D616519BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 04:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLTDoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 22:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTDow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:44:52 -0500
X-Greylist: delayed 1826 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Dec 2022 19:44:51 PST
Received: from m126.mail.126.com (m126.mail.126.com [123.126.96.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 674C813F74
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Dec 2022 19:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=a8f9j
        HLGSU6GKTT+G2bdn7m6o60FMwWFVpWddddotCE=; b=bTf4iaYN89uImjp8zUr0y
        nCgxb29B7C0cyKnp9OIwWuAZtGkhNyo/KvMVlrLZPf5PHp1RBeFH9/6mH8hTuuQT
        0oIDj6SDpGn2gVgyGtiiZTC+SpCihiInyC7a09b4Re7UVI/00cIxrZZSYB90s0cI
        rz5y8fSN0yCRrh3BAIrZCI=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp14 (Coremail) with SMTP id fuRpCgC3uKCMKKFjcunkAg--.7130S2;
        Tue, 20 Dec 2022 11:14:21 +0800 (CST)
From:   lingfuyi <lingfuyi@126.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lingfuyi <lingfuyi@126.com>
Subject: [PATCH] fs: add macro when api not used
Date:   Tue, 20 Dec 2022 11:14:16 +0800
Message-Id: <20221220031416.4067392-1-lingfuyi@126.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: fuRpCgC3uKCMKKFjcunkAg--.7130S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyfKF18Wr1xXw4kuFWUtwb_yoWDJFg_ur
        1Iva1rCr4kuF1Sqw4UW3sFv34UWr1DJrs3Cws5KwnYyFWDJay7Ar4DAFyrJw1kWwnF934U
        Ca4ktayrJF1j9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRmPfGJUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: polqwwxx1lqiyswou0bp/1tbiJATZR1pEGeYV6gACsi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

when CONFIG_ELF_CORE not defined but dump_emit_page only used in
dump_user_range(),will case some error like this:

fs/coredump.c:841:12: error: ‘dump_emit_page’ defined but not used
[-Werror=unused-function]
static int dump_emit_page(struct coredump_params *cprm, struct page *page)

Signed-off-by: lingfuyi <lingfuyi@126.com>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991b..95390a73b912 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -838,6 +838,7 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	}
 }
 
+#ifdef CONFIG_ELF_CORE
 static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
 	struct bio_vec bvec = {
@@ -870,6 +871,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 
 	return 1;
 }
+#endif
 
 int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 {
-- 
2.20.1

