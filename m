Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05F56C0B35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 08:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCTHOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 03:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCTHOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:14:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42D1E5D8;
        Mon, 20 Mar 2023 00:14:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t15so9296680wrz.7;
        Mon, 20 Mar 2023 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679296489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfkxMOxAGfgWPUNtNItdws/lAov0WMT4Tn6jUy/fV/w=;
        b=GjiILlTCr5jfQ1cyHmMIYapJx0INf4D0wivvzByi6ZopCTgn/AEn2+rbNfguJgkRp6
         S6vEh49Mmbr7nsPSYfd7V5dapTpUPjmeioLBRNzEoo+Jdeef1NOwW5qtU/Ip0HcvhTOa
         B35E5BpyCMILEG/AI7JYr8AMbTZ75lrrtRukiDiDrwvg8F8cmJE9/r/xdAlkEJQqHcKn
         2dJBMLeWrwcX7jpnqQmsjwKp94DeSeTxAhg3NhOW6Tct5nWBAKucie0tjKrI0zE/l1uK
         HaW83YzF5zdsgfMS0wDWDTa3yqC8x6WNd1aobB1sVxUzZwX8nxNHK4cwCQAlEjR6Nudr
         FMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679296489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfkxMOxAGfgWPUNtNItdws/lAov0WMT4Tn6jUy/fV/w=;
        b=vbdaUXzT9pfXHPw9PSM0MQckNJ/9ae1KyRg8tPaEICVSQpA8YVFAoh9HvaCiaQRJmu
         vn4WDc5EHbctNmKfucyUilPVjkqivP31S7nIVaa7EGr+sqbSfdP7ASalfHMme+RklYJX
         OSStj+jrbP5VFr0am6kVwvdHzg0SEmj38apuZ6zb1bgS5iX852OPUqMlo4hRHTl96Gbg
         nMEgWCEcO8mSS52RaMGDlBzeTruocj15RsLVDB0+w3mgRTgiYwVby3HxWOoNnrEeXkbk
         qGiN9hpnUOV7bqyTaZpA+GRTXWUKATiSxcRsk4dCXkugogsR/JIIAbHSVx7seBACK4W7
         g2oA==
X-Gm-Message-State: AO0yUKWA5klA6l0J1FsSBUoDl/jVewfyH/t4HFjuUVkumUeSaotrdOnl
        GKKQNdtfJRPDK2hbYY/7S4g=
X-Google-Smtp-Source: AK7set9LxTlNs2eaxMX/lSXB7TNtIlMeLJWZMAm6UaDw2gJuFl/i5cmOyIMVsa/Gk5Nl3nEH1O5jHQ==
X-Received: by 2002:a5d:4046:0:b0:2ce:ac70:5113 with SMTP id w6-20020a5d4046000000b002ceac705113mr12797192wrp.41.1679296489069;
        Mon, 20 Mar 2023 00:14:49 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:8a0:7280:5801:9441:3dce:686c:bfc7])
        by smtp.gmail.com with ESMTPSA id e23-20020a5d5957000000b002cfefa50a8esm8092442wri.98.2023.03.20.00.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 00:14:48 -0700 (PDT)
From:   Pedro Falcato <pedro.falcato@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
Date:   Mon, 20 Mar 2023 07:14:42 +0000
Message-Id: <20230320071442.172228-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Linux, open(O_DIRECTORY | O_CREAT) has historically meant "open
directory or create a regular file". This has remained mostly true,
except open(O_DIR | O_CREAT) has started returning an error *while
creating the file*. Restore the old behavior.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
I did not explicitly add a Fixes: tag because I was unable to bisect this locally,
but it seems to me that this was introduced in the path walking refactoring done in early 2020.
Al, if you have a rough idea of what may have added this bug, feel free to add a Fixes.

This should also probably get CC'd to stable, but I'll leave this to your criteria.
 fs/namei.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index edfedfbccae..7b26db2f0f8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3540,8 +3540,18 @@ static int do_open(struct nameidata *nd,
 		if (unlikely(error))
 			return error;
 	}
-	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
-		return -ENOTDIR;
+
+	if ((open_flag & (O_DIRECTORY | O_CREAT)) != (O_DIRECTORY | O_CREAT) ||
+	    !(file->f_mode & FMODE_CREATED)) {
+		/* O_DIRECTORY | O_CREAT has the strange property of being the
+		 * only open(O_DIRECTORY) lookup that can create and return a
+		 * regular file *if we indeed did create*. Because of this,
+		 * only return -ENOTDIR if we're not O_DIR | O_CREAT or if we
+		 * did not create a file.
+		 */
+		if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
+			return -ENOTDIR;
+	}
 
 	do_truncate = false;
 	acc_mode = op->acc_mode;
-- 
2.39.2

