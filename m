Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9984C8D07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 14:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiCAN4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 08:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiCAN4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:56:17 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B54E8D684;
        Tue,  1 Mar 2022 05:55:36 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bg10so31663663ejb.4;
        Tue, 01 Mar 2022 05:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/9T1huoYjFiDqtcNJauOodI/6xx/bBNHxHqAjTy+6E=;
        b=JFACJZpQQZU0JE8sw3SHG5rjevA8wOm7xi4vnw+bfXN3poe/QFYS10ZFCjHuil6r0K
         wQCrNGcM8HftxNW0bonv2MSevDq04rtg265dT3b+HOw/0EVJ9memo4JRqXs4e8NcNjp3
         fhlu/XHMAlarYxZXoXtPe9tLcs/rMeaeVSv7jnZLSI+pp+auG2pdqy5v6XVxEq47C4w+
         nBhuv05Za1nRsTGtYo42JgGZbW2lold7TJRTNFMfLzaaF8xfyXbp0XXls04rMBwZrju4
         YdAg3Tn6zz6kntleWbbXHm2i47doM/ZaA/DadvIMidnjXtdTZoUvt5vHnuBRAWCiJZqO
         QWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/9T1huoYjFiDqtcNJauOodI/6xx/bBNHxHqAjTy+6E=;
        b=eT8in5bo8vn43F4tFTXOPWEKOCHinhVgYIdTSt4OBKVvsd01jSDTuTDc8a8C9h+ztA
         hoHe9EIAA4rIoW0cxayZG9rUme4uHTD84H9Rjaw2FRmkDwOelwSh5hXTK+ASMEMqum3t
         xOT6bFf9MB+ARELKakUKWnkX2F+sKu56yQXAICL/u8XJ64TlVXwtVNnAOAI2olRfCZtL
         BHVRJXDT7RaYKzttAMbT31CekrCnnAOQzX7HF/W4RIgnXC58xgXqA9aFK7yKFuEcSi1v
         C1Yz9zz5DIhEfTPTH7MUGMyVFsIt/2vrSi64TnlWymklHyt54VH4VJ/V3YtRB/uz+oHB
         Uvqw==
X-Gm-Message-State: AOAM530w9lLNFEiLlia8Xu75B9ZlroOSyfnkHBkaFF+ZErUEUFYqGkX7
        bmi9etS6pvbm6JAvErqc4yI=
X-Google-Smtp-Source: ABdhPJydRWeQpk3jXWl6ROPATxujJ8IWoFpZ9DNUqTkIo1y4ybgQwkR0KVLPnfTWn94ktj9xj21aLQ==
X-Received: by 2002:a17:906:bc8d:b0:6cf:6b41:e48e with SMTP id lv13-20020a170906bc8d00b006cf6b41e48emr18960056ejb.372.1646142934837;
        Tue, 01 Mar 2022 05:55:34 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f15d2000000000000000fd2.dip0.t-ipconnect.de. [2003:dc:6f15:d200::fd2])
        by smtp.gmail.com with ESMTPSA id u1-20020aa7d0c1000000b004132c0a9ee3sm7281675edo.84.2022.03.01.05.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 05:55:34 -0800 (PST)
From:   Max Kellermann <max.kellermann@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Max Kellermann <max.kellermann@gmail.com>
Subject: [PATCH] drivers/char/mem: implement splice() for /dev/zero, /dev/full
Date:   Tue,  1 Mar 2022 14:55:21 +0100
Message-Id: <20220301135521.2889274-1-max.kellermann@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows splicing zeroed pages into a pipe, and allows discarding
pages from a pipe by splicing them to /dev/zero.  Writing to /dev/zero
should have the same effect as writing to /dev/null, and a
"splice_write" implementation exists only for /dev/null.

To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@gmail.com>
---
 drivers/char/mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cc296f0823bd..6c504f92c986 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -642,6 +642,7 @@ static int open_port(struct inode *inode, struct file *filp)
 #define full_lseek      null_lseek
 #define write_zero	write_null
 #define write_iter_zero	write_iter_null
+#define splice_write_zero	splice_write_null
 #define open_mem	open_port
 
 static const struct file_operations __maybe_unused mem_fops = {
@@ -678,6 +679,8 @@ static const struct file_operations zero_fops = {
 	.read_iter	= read_iter_zero,
 	.read		= read_zero,
 	.write_iter	= write_iter_zero,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= splice_write_zero,
 	.mmap		= mmap_zero,
 	.get_unmapped_area = get_unmapped_area_zero,
 #ifndef CONFIG_MMU
@@ -689,6 +692,7 @@ static const struct file_operations full_fops = {
 	.llseek		= full_lseek,
 	.read_iter	= read_iter_zero,
 	.write		= write_full,
+	.splice_read	= generic_file_splice_read,
 };
 
 static const struct memdev {
-- 
2.34.0

