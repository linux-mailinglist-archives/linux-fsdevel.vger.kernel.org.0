Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053B45F84EC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJHLNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 07:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJHLNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:13:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AE050F9C;
        Sat,  8 Oct 2022 04:13:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sc25so9990408ejc.12;
        Sat, 08 Oct 2022 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihEjAwkgFK6TMTS0NNrc4Hr909XAXppfc/t74qtEVys=;
        b=f2HrepYiLnsiyurPsv8FfJmNKnyEObBrKn9ZmsuFKHTBOK7v+jCNGMfhikSi2o38S4
         6trakx72A5xPrYPkw9+Xl8nsWzF77FHEJw4fN6G3YnlVnos93/TYRCHTedRXuVZZw++z
         yhwwqTJqtUv9FQw1BAzFfexJrsSIqZy+Vaqed9ycd+6s+lHom+6ZWuVRT7qHY84iZ2MT
         nIug5TWcZKX3iT1GQV71KUrADQ0hSAz2beQK6SEGI6O/Bzd0Ny574fjLd/wPLWskjhW3
         9KhFeYaXUGid5gXXd6vqBVaImfj/FfA4CFRFWT9bwU97Z/CFUETYMuFa+RuavHJHV9IQ
         UaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihEjAwkgFK6TMTS0NNrc4Hr909XAXppfc/t74qtEVys=;
        b=b+MQwSJbomuPf5kl6ja7xKHhzbTbS/zFG0V2Q/1HNxGqeHU8UxDYaFTLf9L168MBLR
         R3qmLEszMNGVi/HBZB2gG9+h0I/REwaMrw2Eg0r8NNYqqd/TVASXnLDoxdY/xjuNmEEa
         PESCTQShiiCQk/bNKIMWaNNSrRNVReUv1pGYkfYDtzOyFPprV81quP+02XBwIUolhimw
         c6oZXB2QljN7GRYN5tzaiuWpCxmQ7xmGvWjTYmUL1HBT0hZ1blIjMJS04REQ66UZrQZq
         iXGa8k59JC+G5/XYQ9Xpc8Pd8+AMmNMQSArFPvf20UJt/QE26LLZUZlJZEc2HwSZd/It
         eWnA==
X-Gm-Message-State: ACrzQf1paQdtxtyFRJh1k937nZtPnj5yVgogFXpL0qsO1wOO0yYpxqMG
        P3XTu1O11jfon0FPPmzo/3up1uTlY4A=
X-Google-Smtp-Source: AMsMyM5FLfV/bK2bwe6T/on3YEKYaemvoo3hE1d8d+4VvD0Z4vGcWdt6BytOfV2Z/x8+kpsYt7nDDg==
X-Received: by 2002:a17:907:e93:b0:78d:46ae:cf61 with SMTP id ho19-20020a1709070e9300b0078d46aecf61mr7343327ejc.579.1665227618860;
        Sat, 08 Oct 2022 04:13:38 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id kt25-20020a1709079d1900b0078d886c871bsm1740312ejc.70.2022.10.08.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 04:13:38 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v9 10/11] samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
Date:   Sat,  8 Oct 2022 13:13:35 +0200
Message-Id: <20221008111336.74806-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
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
 samples/landlock/sandboxer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index f29bb3c72230..fd4237c64fb2 100644
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
 
@@ -160,11 +161,12 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
-	LANDLOCK_ACCESS_FS_REFER)
+	LANDLOCK_ACCESS_FS_REFER | \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 2
+#define LANDLOCK_ABI_LAST 3
 
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -234,6 +236,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	case 1:
 		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
 		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+		__attribute__((fallthrough));
+	case 2:
+		/* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
+		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
 
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
-- 
2.38.0

