Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F421F6FE5FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 23:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjEJVMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 17:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbjEJVMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 17:12:43 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB531FD9;
        Wed, 10 May 2023 14:12:42 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33131d7a26eso54588065ab.0;
        Wed, 10 May 2023 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683753161; x=1686345161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoxYWqBDKCkglae/wVRmkD/Q+O27CAC7GMcB4xk3Kxc=;
        b=QAFvSr5wgoMG5tPGtXxtetTgQVI82X+nCX6TetzodfLfHHCbN/Ct2WkWTE/jcMtZbz
         2pJJDoZfD23LMQnNw9eWr02eGSsSd3fLYlhiyGP40cuNXWBCgk3wgDDTl2A7GnOTMLHO
         tfJgn/VPTpWfMUafx7ocr/uKB+NzoiIkLg4piINxXmk3mUpSMtILiKbCSywAejLoMhbz
         pNr7LxEGa3M3tITk6YulFVrknOkp4eEanXq7fOx65YsFbHy8JaSgYYe0OE7r7vDfpiGd
         X+kv1QyaXfFTTPXLM4ITWgYRTGsda6Bo9tubMf+u/H2tPShwM2zAg9J+hMctnPCgZglJ
         UHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683753161; x=1686345161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoxYWqBDKCkglae/wVRmkD/Q+O27CAC7GMcB4xk3Kxc=;
        b=P3f0K7FcEJ4BHknABK1a+1/XPF+PsvJ7+Tg7pGOto23e3g1z9ZkLJyj1bAi2PMcYoh
         3Td7n8fWAtTtz0a04TJ+l3dapQq6OUxc6OA1HgRWrzsxVSu0Ko7ksRLtgOQQrt7UNCWZ
         Wxn+ANcxiaMJZ4WDrNJWoXAJjqjrzQ8Cp5QzMfIon4CWgCY5tUJRGg8Y0od2WeTx+z/R
         5TJEaXyrQPyutsSGQFlVNmTp7Q5GNJH8/134gLwCeYMMSsaniMXexypYcWaW4lqIUuUs
         TcVqP9mmDHb+6aH7Ri6W813akVFwxK5EndnXVNVDERMTDQakzkU78Chplb2NUwIlC0LX
         ErBw==
X-Gm-Message-State: AC+VfDxzHL1hm0MDIa7ZOa00Nt3rqDx4fJploa1DCy79XwnaYppv32+I
        MMjH0KjjEqFnTH0TCTY7Kx0=
X-Google-Smtp-Source: ACHHUZ5R80iF86gE5SK9iFOJkeCmUMYFel4HyH5pXtuboP3zjhhvdIK2nlQTAilh9hcAs2SxmSYM6g==
X-Received: by 2002:a92:d4ca:0:b0:331:96e5:678d with SMTP id o10-20020a92d4ca000000b0033196e5678dmr13353290ilm.21.1683753160952;
        Wed, 10 May 2023 14:12:40 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id h4-20020a92c084000000b003317ebbc426sm1869030ile.47.2023.05.10.14.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:12:40 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vboxsf: Replace all non-returning strlcpy with strscpy
Date:   Wed, 10 May 2023 21:11:46 +0000
Message-ID: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 fs/vboxsf/super.c |    2 +-
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
2.40.1.521.gf1e218fcd8-goog


