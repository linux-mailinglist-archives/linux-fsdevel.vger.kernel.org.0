Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF25F0F89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiI3QC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiI3QCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:02:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA0C1B3A45;
        Fri, 30 Sep 2022 09:02:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nb11so9974317ejc.5;
        Fri, 30 Sep 2022 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=C+GyJq5HgV0Z7OWkJYmIbswU12VCmy8zCOP8Qkw/Jxk=;
        b=CCRGRJOufx+mg2aoyxpmDIdQ9ZbPwRbNqH7uNo9Ul+rzcw89FssJZfByRUozRyKGBf
         Ks7JXx3H5xjIzBh8gj1369ysjCcFlxeoAvLs9Pd8LjLHMELF2wr+0vppKbJZzjoJ6Twe
         kzLAnpaAd1w/D1exrxeK35/OJEFJKs5Tof0kOjn6Wkm+VFtE9zH1MEzISk7fKt8SG0QH
         PI2TVHUdTwwDJtCzK9Mq/C95m/gk2exYhEXo/qiVqoVbUL1neOBw/BUSU5JCstHSyFUS
         udiLj+8y7aC38LhL8wKiFlsRbREbAKwH1EPvUFK6VoMRcIhJN9XRTp4WhV97+LA4L5pt
         CSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=C+GyJq5HgV0Z7OWkJYmIbswU12VCmy8zCOP8Qkw/Jxk=;
        b=54aVk462zhl7m9c6MB4e6MA413mfrrdOh1C+7ylFqPiqS5DGVGP5920MmxKJVqcRwL
         F91bKz6kGLSnOWZwyYDoO1KxLBEckNJDOr03K4mcbb1XWr/Cst2+HWUPuHcylgpEaGJE
         itJngoXaBP8wpb8C0yvSOEhAMIphpUO1qlFK+gI82DHUoZmY4BX5Cqzeqd/2zj+0AoKC
         oLpM7hJKumVbH+Ed8xzTXyHWpF9qNcl7Bsug0guUfJyQW/jan4nglUI73ru/3ciCILFW
         jJryMou1CVjybAFdvu824FUUiBy5s47tH1WNWFElkJcaiPUiAVQMAfjww6LVFMwQVokI
         fLqg==
X-Gm-Message-State: ACrzQf3BnFErVER+6RqWDAW8c8UI8SD84rg9gkbH4wOmZfuogbCouzI3
        EXCHEf9nuMKBmV3p6RpfPCdMTvc6pkk=
X-Google-Smtp-Source: AMsMyM7029mwtxLlTXW+vuLatElzrzmMciDXtOc+5zIDzcDsh9BJqoNohMfrWA6In0YfUlUz4BNktg==
X-Received: by 2002:a17:906:9b8b:b0:782:20fd:8597 with SMTP id dd11-20020a1709069b8b00b0078220fd8597mr6849275ejc.423.1664553734640;
        Fri, 30 Sep 2022 09:02:14 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id f18-20020a05640214d200b004588ef795easm927583edx.34.2022.09.30.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:02:14 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v7 6/7] samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
Date:   Fri, 30 Sep 2022 18:01:43 +0200
Message-Id: <20220930160144.141504-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930160144.141504-1-gnoack3000@gmail.com>
References: <20220930160144.141504-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the sandboxer sample to restrict truncate actions. This is
automatically enabled by default if the running kernel supports
LANDLOCK_ACCESS_FS_TRUNCATE, except for the paths listed in the
LL_FS_RW environment variable.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 3e404e51ec64..771b6b10d519 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -76,7 +76,8 @@ static int parse_path(char *env_path, const char ***const path_list)
 #define ACCESS_FILE ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
-	LANDLOCK_ACCESS_FS_READ_FILE)
+	LANDLOCK_ACCESS_FS_READ_FILE | \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
 
 /* clang-format on */
 
@@ -160,10 +161,8 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
-	LANDLOCK_ACCESS_FS_REFER)
-
-#define ACCESS_ABI_2 ( \
-	LANDLOCK_ACCESS_FS_REFER)
+	LANDLOCK_ACCESS_FS_REFER | \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
 
 /* clang-format on */
 
@@ -226,11 +225,17 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 	/* Best-effort security. */
-	if (abi < 2) {
-		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
-		access_fs_ro &= ~ACCESS_ABI_2;
-		access_fs_rw &= ~ACCESS_ABI_2;
+	switch (abi) {
+	case 1:
+		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
+		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+		__attribute__((fallthrough));
+	case 2:
+		/* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
+		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
 	}
+	access_fs_ro &= ruleset_attr.handled_access_fs;
+	access_fs_rw &= ruleset_attr.handled_access_fs;
 
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-- 
2.37.3

