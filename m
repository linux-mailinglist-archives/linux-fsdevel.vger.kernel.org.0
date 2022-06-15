Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7AF54C1EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 08:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353549AbiFOGbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 02:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353370AbiFOGbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:31:43 -0400
X-Greylist: delayed 126 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 23:31:42 PDT
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FC63B00B
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 23:31:42 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id JCS00031;
        Wed, 15 Jun 2022 14:29:31 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2308.27; Wed, 15 Jun 2022 14:29:31 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <hdegoede@redhat.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] vboxsf: Directly use ida_alloc()/free()
Date:   Wed, 15 Jun 2022 02:29:30 -0400
Message-ID: <20220615062930.2893-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   202261514293185abce0012280ac64402f98ebb9bce42
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use ida_alloc()/ida_free() instead of
ida_simple_get()/ida_simple_remove().
The latter is deprecated and more verbose.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/vboxsf/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index d2f6df69f611..24ef7ddecf89 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -155,7 +155,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	}
 
-	sbi->bdi_id = ida_simple_get(&vboxsf_bdi_ida, 0, 0, GFP_KERNEL);
+	sbi->bdi_id = ida_alloc(&vboxsf_bdi_ida, GFP_KERNEL);
 	if (sbi->bdi_id < 0) {
 		err = sbi->bdi_id;
 		goto fail_free;
@@ -221,7 +221,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	vboxsf_unmap_folder(sbi->root);
 fail_free:
 	if (sbi->bdi_id >= 0)
-		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
+		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
 	idr_destroy(&sbi->ino_idr);
@@ -268,7 +268,7 @@ static void vboxsf_put_super(struct super_block *sb)
 
 	vboxsf_unmap_folder(sbi->root);
 	if (sbi->bdi_id >= 0)
-		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
+		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
 
-- 
2.27.0

