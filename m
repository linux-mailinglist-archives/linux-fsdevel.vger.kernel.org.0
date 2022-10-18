Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE96603253
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiJRSXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJRSWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:22:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0FD82849;
        Tue, 18 Oct 2022 11:22:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u21so21747208edi.9;
        Tue, 18 Oct 2022 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihEjAwkgFK6TMTS0NNrc4Hr909XAXppfc/t74qtEVys=;
        b=hm5SalgVJtJmHnDHWw7DNtxG5TjZGfWiRzk/SyjKR3zw3yE1D4HSdfixYfRt3/dENO
         JN+ENtEe1pHIIkJRb+v/19xLRt+s58gvM+PLXPiOGykMke3+kwKHcdIJbfYMjFl2xhHq
         zcWgNuYHyJV3UOCC/+78HkcHxaO5YW8UsOGyi5tSzdxYN2i20ki/O+oDbOepshAalyVJ
         rZiNmKN7oIUvOfZ20uDjqET13wggCBxRUP7Zi8tMpoCgSPyNPJgY/O97LNgILXqf9dhi
         L16apGRjzhKSzCFQaXF7XEuz9t8RecW448eYP/R+/ZRQfB9YnJcYrSw22sW+SsBz4/Ot
         qNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihEjAwkgFK6TMTS0NNrc4Hr909XAXppfc/t74qtEVys=;
        b=jTqg+NV0qp4QAvlH/Bo+GaCiWEhEEbzO8mAQgY3ApwUOW++N+oc3AaHAXHWOnUe2o0
         iBrV4CtqxwaZdsBCu1XFUghlFlr17a7TfL4zFabFJ8F3z2e0uwS6nWE8pvwka0LpQ7bt
         0LPubL5vYJu2XE23ZSEKQyj83XdNomVI5YSb8AuwBpdJzGW6pubkVTteYURMqbFi3HSm
         7GWINrzar9XMyyjzVFJy19czJNdP1JZgr/DY9Lrh2JYLi2tgadfrC8DnAuhgwRMnbfgf
         90Gep9GK6Q0Mg6pnrBO9j3KJwdshy5r/ORjaP7nIvm3CrJSBrcXRN9sN2VszCCz5ILBA
         WaHg==
X-Gm-Message-State: ACrzQf0NRiDJIJlf/+su5+hQptA1DwASmuKU2sJpqC/a1FpHfg0HBHMW
        g3M5sv5IGxqee0HghAKqzMJsnUWzBUg=
X-Google-Smtp-Source: AMsMyM4HYpmSv8b3sH3Y33hT1hxyRrc9VzF5B8y4LPkHenO3SUFJEdx/TBmJW9+voJE28xkNCTbXOA==
X-Received: by 2002:a05:6402:42c7:b0:45c:a6f1:c0af with SMTP id i7-20020a05640242c700b0045ca6f1c0afmr3764963edc.75.1666117356946;
        Tue, 18 Oct 2022 11:22:36 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id i18-20020a0564020f1200b00458a03203b1sm9358395eda.31.2022.10.18.11.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:22:36 -0700 (PDT)
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
Subject: [PATCH v10 10/11] samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
Date:   Tue, 18 Oct 2022 20:22:15 +0200
Message-Id: <20221018182216.301684-11-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018182216.301684-1-gnoack3000@gmail.com>
References: <20221018182216.301684-1-gnoack3000@gmail.com>
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

