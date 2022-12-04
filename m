Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E842E641D8C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Dec 2022 16:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLDPAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Dec 2022 10:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLDPAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Dec 2022 10:00:24 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560721006E;
        Sun,  4 Dec 2022 07:00:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id h33so8346734pgm.9;
        Sun, 04 Dec 2022 07:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGbY0S1sNC2gjzY8/cxpSd6ihQDdO8NWLhql9cHREQI=;
        b=R5qfUmJNGXBvTBKrXjhbTL9EUgWsjHPMbRQU0ZF9nal12sfWEKHl5lGcF3HmRm8Fr5
         xUWJFWqJdf0pSbK4mH7StCUPKDcB8uiavmzTeVMCC1oTiaFWXEfwv4hnZuTRhf9IYpC4
         VUi4Rx9MeARNjPfyCMPT9mFum+G2UgPo3haGQXL4+N71TuqXnOXSJeLtk0MoKl6w3exe
         kBaPbxWq0vCB8ST9aW/LnJayeMhTcyL13xrekBkYP1tfOny9rQfU7BJQGadcaVHDGNRI
         AmvK/HHtT8RfjlGqdcXnz4+pnCEd1HrrVwQpoGGvr3JEmO+rWyxAkoR6BkjKbA7MH9CW
         TFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGbY0S1sNC2gjzY8/cxpSd6ihQDdO8NWLhql9cHREQI=;
        b=65u8eHXEPcNMcNBNkt1XZdFTrzsPWgdBNS+wegr12PJCPAOZ9CqWiu18yvNAF98fEQ
         bNs1KIYQfY/47l7RR2GCdK7gj4f0PG0wr24Az6N5Qk7aYC49Kx7mx3zrnvgDV+nwaQAI
         n2EZ99sd7PCg4fA7wZ2xb5TNRCvY3pOiE9OTYwa+V/6PIVnaf91xa4p0QdPfisLMKLM9
         OHJyVdSZsoco5vEeDQPsN3+c/ZHmbjVPp797F6BLptHC+AsY36uNyz7061qqtnWZNlh1
         nFory/8XlIg+NoERUxGAYVmo9QLQiP2U/emF+LnzKZQ35oEP0BaE5GFSq9WiNhIyojLs
         W/dw==
X-Gm-Message-State: ANoB5pkSbvzByIAVvv6+qn+2M39vgHpeUh5cGy/TWfotJJxMvKON3BtK
        sp3MxiHReD5GQNiIRHDNTtA=
X-Google-Smtp-Source: AA0mqf7+zdMTyNLL5SSR7sjWLYZALFZ14vk8c/LQg7OExiH+Sic7Z06CszNHYRMyD4PLidvlV9RWpg==
X-Received: by 2002:aa7:9ecb:0:b0:576:fa16:80e0 with SMTP id r11-20020aa79ecb000000b00576fa1680e0mr489416pfq.64.1670166022774;
        Sun, 04 Dec 2022 07:00:22 -0800 (PST)
Received: from localhost.localdomain ([47.242.114.172])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b0017a032d7ae4sm8849399pls.104.2022.12.04.07.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 07:00:22 -0800 (PST)
From:   Chuang Wang <nashuiliang@gmail.com>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mount: rebuild error handling in do_new_mount
Date:   Sun,  4 Dec 2022 23:00:05 +0800
Message-Id: <20221204150006.753148-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a function execution error is detected in do_new_mount, it should
return immediately. Using this can make the code easier to understand.

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
 fs/namespace.c | 53 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab467ee58341..a544e814b326 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3116,36 +3116,51 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (!type)
 		return -ENODEV;
 
+	fc = fs_context_for_mount(type, sb_flags);
+	put_filesystem(type);
+	if (IS_ERR(fc))
+		return PTR_ERR(fc);
+
+	/* subtype */
 	if (type->fs_flags & FS_HAS_SUBTYPE) {
 		subtype = strchr(fstype, '.');
 		if (subtype) {
 			subtype++;
 			if (!*subtype) {
-				put_filesystem(type);
-				return -EINVAL;
+				err = -EINVAL;
+				goto err_fc;
 			}
+
+			err = vfs_parse_fs_string(fc, "subtype",
+						  subtype, strlen(subtype));
+			if (err)
+				goto err_fc;
 		}
 	}
 
-	fc = fs_context_for_mount(type, sb_flags);
-	put_filesystem(type);
-	if (IS_ERR(fc))
-		return PTR_ERR(fc);
-
-	if (subtype)
-		err = vfs_parse_fs_string(fc, "subtype",
-					  subtype, strlen(subtype));
-	if (!err && name)
+	/* source */
+	if (name) {
 		err = vfs_parse_fs_string(fc, "source", name, strlen(name));
-	if (!err)
-		err = parse_monolithic_mount_data(fc, data);
-	if (!err && !mount_capable(fc))
-		err = -EPERM;
-	if (!err)
-		err = vfs_get_tree(fc);
-	if (!err)
-		err = do_new_mount_fc(fc, path, mnt_flags);
+		if (err)
+			goto err_fc;
+	}
+
+	/* monolithic data */
+	err = parse_monolithic_mount_data(fc, data);
+	if (err)
+		goto err_fc;
+
+	err = -EPERM;
+	if (!mount_capable(fc))
+		goto err_fc;
+
+	err = vfs_get_tree(fc);
+	if (err)
+		goto err_fc;
+
+	err = do_new_mount_fc(fc, path, mnt_flags);
 
+err_fc:
 	put_fs_context(fc);
 	return err;
 }
-- 
2.37.2

