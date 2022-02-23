Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599CF4C1F84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 00:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbiBWXS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 18:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244783AbiBWXS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:18:27 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D854190;
        Wed, 23 Feb 2022 15:17:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nh8-20020a17090b364800b001bc023c6f34so4075764pjb.3;
        Wed, 23 Feb 2022 15:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4Hc3H6C7uhRqzAyT0iw9Lo49T1Lu66SQ9hcyKWnV4o=;
        b=qYlvMCjBaD2BuPwXnC5wsAO5zGYaLTug/Sxsrj6VSV0cOPcWfwBG3BlcdvowvjRAkk
         W9RqhXM1NX0rPUgMTjTpNKijxEs/colOSmZ9ENaSk4KJUaROd93sai4xGcyovWU4obTV
         iuP2kQJfIDxIe0HdIPxycOiMWG6qtWsHEKeurldznNwob6CMyDxFavzEIu4VS/ClG4Yc
         DAqMCpt7YNumPzpcEt5V+Taj8hhdr8VUtIgGSyhfmAfena+AUcI1DWCR8xAeQlSSzXkV
         iKyVC6CvCUe0xcRY+Eayd4cx9yNT0gSuitv3dfYBW2M+PW012K0PZuSSzeiCZc95bSd/
         Ggsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4Hc3H6C7uhRqzAyT0iw9Lo49T1Lu66SQ9hcyKWnV4o=;
        b=GrwS8XGljl+BPf9bmcZxfw5KrFoEbdqcDIRhEK3lXWonUtT3WtqYKRgCIGCBA0vfpC
         e6ZlH38I57+pTr8MgO8Nowew7ActMRnNoG541UoYUe+JWfo9AZj+99pfGKAOJSm+7Y7e
         6WlGWpQhdVfOQZ059+ae+BUkv2s41LELB+f8ry5TijWV2AxRZUl+GgyPzh3cJnztOeyk
         5fINkjmV99tBB08Q02b2lF4r/SBkadajJ8kHw75o3P6rq9IVcnoGg1VGm7y6sTAKleqO
         sJuoKjUjoFqPUCgGUwrN0cOFYGBDf+TSrh0GEkD1YDpuJ9Vvc1NVeY6h0xbPvf1lLRbD
         Wixw==
X-Gm-Message-State: AOAM532DM4CVGMK8FIJtC+x7ExrI4orwgfiUeSVTBd6SyGHTr4EiDGv4
        kbP1DFFB1bL3cRAayMqj6KCPsHbwlK8sPg==
X-Google-Smtp-Source: ABdhPJyoy5coDRQfUY9K5shvH1Tf8ZSDzoEUYocrjA/1PHekvfuJT3S81cM5jXWZ8f+HBez0BbgXsg==
X-Received: by 2002:a17:90a:4306:b0:1b9:80b3:7a3d with SMTP id q6-20020a17090a430600b001b980b37a3dmr11387497pjg.66.1645658278439;
        Wed, 23 Feb 2022 15:17:58 -0800 (PST)
Received: from localhost.localdomain ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090ad68300b001b8bcd47c35sm4056074pju.6.2022.02.23.15.17.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Feb 2022 15:17:58 -0800 (PST)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     keescook@chromium.org, ebiederm@xmission.com,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] fs/exec.c: Avoid a race in formats
Date:   Thu, 24 Feb 2022 08:17:52 +0900
Message-Id: <20220223231752.52241-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Suppose a module registers its own binfmt (custom) and formats is like:

+---------+    +----------+    +---------+
| custom  | -> |  format1 | -> | format2 |
+---------+    +----------+    +---------+

and try to call unregister_binfmt with custom NOT in __exit stage.

In that situation, below race scenario can happen.

CPU 0						CPU1
search_binary_handler				...
	read_lock				unregister_binfmt(custom)
	list_for_each_entry			< wait >
	(get custom binfmt)			...
	read_unlock				...
	...					list_del
	custom binfmt return -ENOEXEC
	get next fmt entry (LIST_POISON1)

Because CPU1 set the fmt->lh.next as LIST_POISON1,
CPU 0 get next binfmt as LIST_POISON1.
In that situation, CPU0 try to dereference LIST_POISON1 address and
makes PANIC.

To avoid this situation, check the fmt is valid.
And if it isn't valid, return -EAGAIN.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 fs/exec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..2042a1232656 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1720,6 +1720,12 @@ static int search_binary_handler(struct linux_binprm *bprm)
  retry:
 	read_lock(&binfmt_lock);
 	list_for_each_entry(fmt, &formats, lh) {
+		if (fmt == LIST_POISON1) {
+			read_unlock(&binfmt_lock);
+			retval = -EAGAIN;
+			break;
+		}
+
 		if (!try_module_get(fmt->module))
 			continue;
 		read_unlock(&binfmt_lock);
-- 
2.34.1

