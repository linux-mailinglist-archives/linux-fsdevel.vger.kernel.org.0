Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA290597804
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbiHQUaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbiHQUaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:30:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22DA98E7;
        Wed, 17 Aug 2022 13:30:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dc19so26487855ejb.12;
        Wed, 17 Aug 2022 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Rlx98mKeZrGekLkjWi04LgDVSnb7ZLX9tMW7Nnpkucs=;
        b=fBzsTG/HVJYlGBtuOCgK4wvrKWpw4GnDf8+18w+zwtLYXtSUXfnFxCCMxnGhVSvBdK
         T0kCu0n4KN+nRRU+muszMHajXqUn1dpvS7ujumSuHSB0JtJherp5lFzDOfl6RqLcQyoq
         QaF7qsPbE4mIVPlHAxtPNsSclsLh0pl5co5+PK/G5FDH7pbBKLVSIdU2Haqhfbkl7pqC
         7aViL+vqHHpKaQFWbr/wzIqnsdB0B6VGcTwOYbhAtbfY5A4eH3OUq1GrFjZZA3yjTjip
         5KLExmPf6hawfGcDkJ1cn2sVK4oGLwUv8FIX7a/5Bltx07ZlIsHM+81FP+mTmECLMZYL
         qYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Rlx98mKeZrGekLkjWi04LgDVSnb7ZLX9tMW7Nnpkucs=;
        b=jLfZH+jAZL+VgWesMB05JzYrCZEVqYmOGlvZzbwR0oLUzWIes8uBq+ei3JjCQHR4Go
         JEBFvd8BZbsyu9qGPN/5OZjgqXWsr78rmitmtuxNwhaQHgwvkgk2RVgVPQa5EXv4kpAT
         kdskN9tMWLTMJV854d8+u5JfyW7XzZdhLkuxIDGpgyHKz9JrXAOSPFFMDE7NNZWhXXTU
         UPPCcYOtGQzElG/E2JRjluzDORes+30MdOZNeRSu4wFtPfHYCR40qPkCCs6cEPGr7HXL
         c16LbEdGCSz9VSh+FxqqBFhvKnuAIN8BBWKPjIFtiAQMgfqFTzs20JjecMN6KAupzuTO
         ei0g==
X-Gm-Message-State: ACgBeo1HIeCGIjX4T1Npv9zib/EwVCfWfy76kPjLnTF3QZquwb1ifOIN
        WuWjbCLmUwn7MrGQ5P4vU0VnGyaQxKk=
X-Google-Smtp-Source: AA6agR76P7ljL82374pY6SaCPthq3ww8Yo/+4KUwJxaLWpM4R/Xoad6i3bb/pbTwQmL73ezjnwRHOA==
X-Received: by 2002:a17:907:9808:b0:731:5835:4ac7 with SMTP id ji8-20020a170907980800b0073158354ac7mr17608927ejc.125.1660768221796;
        Wed, 17 Aug 2022 13:30:21 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090653c700b0073b0c2d420dsm512042ejo.217.2022.08.17.13.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:30:21 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v5 3/4] samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
Date:   Wed, 17 Aug 2022 22:30:05 +0200
Message-Id: <20220817203006.21769-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817203006.21769-1-gnoack3000@gmail.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update the sandboxer sample to restrict truncate actions. This is
automatically enabled by default if the running kernel supports
LANDLOCK_ACCESS_FS_TRUNCATE, expect for the paths listed in the
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
2.37.2

