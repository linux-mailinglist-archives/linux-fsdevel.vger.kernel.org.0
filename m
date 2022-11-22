Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807476331B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 01:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiKVA6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 19:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiKVA6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:58:23 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401568C4E;
        Mon, 21 Nov 2022 16:58:19 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NGQqG0KGfz4xVnf;
        Tue, 22 Nov 2022 08:58:18 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 2AM0wDIn085676;
        Tue, 22 Nov 2022 08:58:13 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 22 Nov 2022 08:58:13 +0800 (CST)
Date:   Tue, 22 Nov 2022 08:58:13 +0800 (CST)
X-Zmail-TransId: 2b04637c1ea5ffffffff854dfe8c
X-Mailer: Zmail v1.0
Message-ID: <202211220858139474929@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <hdegoede@redhat.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHZib3hmczogdXNlIHN0cnNjcHkoKSBpcyBtb3JlIHJvYnVzdCBhbmQgc2FmZXI=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AM0wDIn085676
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 637C1EAA.000 by FangMail milter!
X-FangMail-Envelope: 1669078698/4NGQqG0KGfz4xVnf/637C1EAA.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637C1EAA.000/4NGQqG0KGfz4xVnf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 fs/vboxsf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index d2f6df69f611..1fb8f4df60cb 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -176,7 +176,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	folder_name->size = size;
 	folder_name->length = size - 1;
-	strlcpy(folder_name->string.utf8, fc->source, size);
+	strscpy(folder_name->string.utf8, fc->source, size);
 	err = vboxsf_map_folder(folder_name, &sbi->root);
 	kfree(folder_name);
 	if (err) {
-- 
2.15.2
