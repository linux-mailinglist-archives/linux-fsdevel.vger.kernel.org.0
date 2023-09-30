Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449237B3E37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjI3FCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjI3FBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B999CDA;
        Fri, 29 Sep 2023 22:01:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so133402195ad.1;
        Fri, 29 Sep 2023 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050100; x=1696654900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5KC1lIhnxi9Th80hMfT8J4dZJX49vz6ed13a2jWNxs=;
        b=W/Mx/brX96BBz3iv5W8RnOve62gxCGsJFCMkxVZIBCcF+8s8mwnw9Fzw4dQj3Z+6a8
         /P38+yDY5FyN2bsB+W801qr7Cc0r10DkTGb8SgaO3E+66gcDDGuh2tj16kMqeBYIbm1+
         cqk26NCOVq/QiqbMxqQW13Xdwi2gEmDgGywQJiNM4M6C365yP1hbk0ASC01V6NCuQrRb
         HqhrQuzl2CIs9wEr5vqxJAiXFwONh69tCFIJskEzy3/fjUON71C1MzGUEN+1YfQKPoz4
         1Q1vjP8YuL6OGpJ4g8xUup//KmljEwwbQ4YW5dFZztfODFJOo+ddXx4t0XMfCqkKwTKn
         D2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050100; x=1696654900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5KC1lIhnxi9Th80hMfT8J4dZJX49vz6ed13a2jWNxs=;
        b=dH6JRzOPVT6pgYYBI9p728CI0pV2VCWAF5uRtJAgVKlzqoxls5etg0+qquLx9kSrZC
         wyquDzR+zYV+4ZkTfpv6yG3nYyXPxFsFpfiuZbviqne2RawMCsDwpxrVmM3/slvXb113
         Zkt3E3uBeuUcOQPDkJs8W31POBhzqPmELpucVpKtvJoLljuKi5gy4VIxCHOcow5yQcrw
         A8iHTXIV5areoPmCajz1MksRHNb+HZT1MqFDhZj6318UJzDcWlqrCwthU6R6wMchHrVk
         axVOFI27Ptc/LXTvgnznIOZi9gukllgIoOUpKLJARb5vJxfUQ/thJ0TodoAbvxObTkIv
         NKGw==
X-Gm-Message-State: AOJu0YxigxQdTSezfUFSus6ldF/EQeLLM7AypiIot+hgGjd4E7g2AV10
        VzzOY6jBTWhz89hB/zVSxmQ=
X-Google-Smtp-Source: AGHT+IH3xhOqtE2B4V9CXIR3Olklma3NHoEaLWaChB9GI0Entae1AuFOIneKa/xgyxWIMsJXBVbCcg==
X-Received: by 2002:a17:903:2348:b0:1c7:2661:91e1 with SMTP id c8-20020a170903234800b001c7266191e1mr7489101plh.15.1696050100397;
        Fri, 29 Sep 2023 22:01:40 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:40 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 13/29] hfs: move hfs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:17 -0300
Message-Id: <20230930050033.41174-14-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This makes it harder for accidental or malicious changes to
hfs_xattr_handlers at runtime.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/hfs/attr.c   | 2 +-
 fs/hfs/hfs_fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c
index 6341bb248247..f8395cdd1adf 100644
--- a/fs/hfs/attr.c
+++ b/fs/hfs/attr.c
@@ -146,7 +146,7 @@ static const struct xattr_handler hfs_type_handler = {
 	.set = hfs_xattr_set,
 };
 
-const struct xattr_handler *hfs_xattr_handlers[] = {
+const struct xattr_handler * const hfs_xattr_handlers[] = {
 	&hfs_creator_handler,
 	&hfs_type_handler,
 	NULL
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 49d02524e667..b5a6ad5df357 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -215,7 +215,7 @@ extern void hfs_evict_inode(struct inode *);
 extern void hfs_delete_inode(struct inode *);
 
 /* attr.c */
-extern const struct xattr_handler *hfs_xattr_handlers[];
+extern const struct xattr_handler * const hfs_xattr_handlers[];
 
 /* mdb.c */
 extern int hfs_mdb_get(struct super_block *);
-- 
2.34.1

