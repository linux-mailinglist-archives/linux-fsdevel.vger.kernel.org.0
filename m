Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F835B274F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 21:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiIHT7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 15:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiIHT65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:58:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64A8114A45;
        Thu,  8 Sep 2022 12:58:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b17so14642883wrq.3;
        Thu, 08 Sep 2022 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=98FGazg/gj0QUvoyFacHOBPUOa+vPrLf+ppcBewd70Y=;
        b=agSYvr++xJOiDpjl0/QYv419PaTU4e8lsz6BSiq2FbIw+NGXc/aXm5EjmOEFzWn2EX
         XRfl+LeipulpMrRoJjTtU7Y7KxlHcEikOjc5dvIAWdpyF1GUk0XiYvwvJVdPipvCgxJo
         VO83f3pzy4Dl3c27t2JLwbyi9kTi2tk/WwqaFDBCwUWDXywyMQqaW2Bu36gQhekylFLA
         ZKLHkrguwTbKWpxy77idC4uo0KRQ0kwb/DiQ7hZofTy/Hpz5MvXGQhTyDZ78D2cNz6jX
         +uy8aKsoGqwmQxzpuZEE4NyQBcyFKDRWcHRr/wSDBaQp0/rf9R2vpqzdqm5EZB7m0+E/
         RIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=98FGazg/gj0QUvoyFacHOBPUOa+vPrLf+ppcBewd70Y=;
        b=tn+x4e8FE7ntuYnmkxKgoSOwn9UEn3q8IMleVmD5OnpZosbLu8SF8PWxjDDf9FNZiJ
         0WhlDRXA705xvsXzcLbZFvdz9wKRvuY1mLdV2rIxM3fwsV1Ce8L/4fKXOpijrdd3pHAu
         Ao9i1b0rxkLyk69PMlZYdPviaLxqWCkOqSuKG2+WbtxVwc25brSqiUvYxDhzfc61SYb+
         oPS2oAlnXytF+OVhe4tfzqMF48MqNXOyAekgsq8OIlsAJh8VhphLEYVd12NecKDVcBzj
         JNzqnmciLWY+OQ8Tx3aeUC/w4MEsLAM++SzoU3ZS+vo+tRqkcj+z6xMzHx0NJM/e/6AA
         zJbQ==
X-Gm-Message-State: ACgBeo0Rm0q7XmHs+jcFH5Zt9dYpHhI8kNUt5eNmZOW3IC+bT6dFaATP
        u92WSFFLrFAQ83fStqI5aPA+QXLQAO4=
X-Google-Smtp-Source: AA6agR6Xek2Lo64utNaRTTAMQV4Y4Zegpo+snrGEbR8RXCIOodiTx3y8Q1ija8OWoUWcU1iCiODNJg==
X-Received: by 2002:a5d:6f14:0:b0:228:e3c6:fa2 with SMTP id ay20-20020a5d6f14000000b00228e3c60fa2mr5652663wrb.516.1662667094140;
        Thu, 08 Sep 2022 12:58:14 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c2d5600b003a541d893desm3360682wmg.38.2022.09.08.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 12:58:13 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v6 4/5] samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
Date:   Thu,  8 Sep 2022 21:58:04 +0200
Message-Id: <20220908195805.128252-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908195805.128252-1-gnoack3000@gmail.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
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
2.37.3

