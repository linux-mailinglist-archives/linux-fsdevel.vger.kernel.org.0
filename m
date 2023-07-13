Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B537522AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjGMNEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjGMNEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:04:06 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE0B1BC9;
        Thu, 13 Jul 2023 06:04:02 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so1250986b3a.0;
        Thu, 13 Jul 2023 06:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253441; x=1691845441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrzJ8y0Z/nZGB4mQadBasiJCOVx3s6y7Fu8bLg3JcC8=;
        b=gCMS4unnzh9VCmxl2sOxfaitatLIL39NXP0FzcKD6hRelDAwlfoJIx2bAElQEEnv1R
         Xkd9NmWKR0eRlvK2C/fj9Ed9eXPTaKuT31xGl4T00NlJFr6EAEWiRWxyEbi45izrabHD
         RQriKB7mVZFPvLgNcd1yZxWnnNhdLnffnD30kApsiSZXKuwVRBZ24EIJvjUPr+RDhrAn
         FcE5yXkf8WFH74uI8ZN+d5kxLBa5hPxNXCaRAlbIywMkQoQVA2g2o3B1ju3sVODEXpA1
         r2Hwj49EjwBGOcWa6wqsIX1SL3jbmdVx+eoEuvRrPx++VyFz04mxtIqvhVVp2DGOWOlJ
         5Cdw==
X-Gm-Message-State: ABy/qLZPgUwHx9T71tbA8DSUZu6B8OD32Q0lZ2wYWmQ2/I+XkIzedsBD
        s9KuJkdjLFYJ/sKt2cgsDzZMVothh6g=
X-Google-Smtp-Source: APBJJlGUAFdm1TSIoS4CnMB2eMVGv3hy+Xo0nkQMI+xfJ0ENoK4osOiXnh1dBQ/+HLcr27gPjamp/Q==
X-Received: by 2002:a17:902:d50b:b0:1b8:865e:44e7 with SMTP id b11-20020a170902d50b00b001b8865e44e7mr6788390plg.20.1689253441284;
        Thu, 13 Jul 2023 06:04:01 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b0026356c056cbsm5445497pjb.34.2023.07.13.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 06:03:59 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>, stable@vger.kernel.org,
        Yuezhang Mo <Yuezhang.Mo@sony.com>,
        Maxim Suhanov <dfirblog@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH] exfat: check if filename entries exceeds max filename length
Date:   Thu, 13 Jul 2023 22:03:10 +0900
Message-Id: <20230713130310.8445-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

exfat_extract_uni_name copies characters from a given file name entry into
the 'uniname' variable. This variable is actually defined on the stack of
the exfat_readdir() function. According to the definition of
the 'exfat_uni_name' type, the file name should be limited 255 characters
(+ null teminator space), but the exfat_get_uniname_from_ext_entry()
function can write more characters because there is no check if filename
entries exceeds max filename length. This patch add the check not to copy
filename characters when exceeding max filename length.

Cc: stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reported-by: Maxim Suhanov <dfirblog@gmail.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 957574180a5e..bc48f3329921 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -34,6 +34,7 @@ static int exfat_get_uniname_from_ext_entry(struct super_block *sb,
 {
 	int i, err;
 	struct exfat_entry_set_cache es;
+	unsigned int uni_len = 0, len;
 
 	err = exfat_get_dentry_set(&es, sb, p_dir, entry, ES_ALL_ENTRIES);
 	if (err)
@@ -52,7 +53,10 @@ static int exfat_get_uniname_from_ext_entry(struct super_block *sb,
 		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
 			break;
 
-		exfat_extract_uni_name(ep, uniname);
+		len = exfat_extract_uni_name(ep, uniname);
+		uni_len += len;
+		if (len != EXFAT_FILE_NAME_LEN || uni_len >= MAX_NAME_LENGTH)
+			break;
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
@@ -1079,7 +1083,8 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			if (entry_type == TYPE_EXTEND) {
 				unsigned short entry_uniname[16], unichar;
 
-				if (step != DIRENT_STEP_NAME) {
+				if (step != DIRENT_STEP_NAME ||
+				    name_len >= MAX_NAME_LENGTH) {
 					step = DIRENT_STEP_FILE;
 					continue;
 				}
-- 
2.25.1

