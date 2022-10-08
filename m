Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC1B5F84F7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 13:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJHLSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 07:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJHLSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:18:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBB54B498;
        Sat,  8 Oct 2022 04:18:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s30so10136776eds.1;
        Sat, 08 Oct 2022 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihEjAwkgFK6TMTS0NNrc4Hr909XAXppfc/t74qtEVys=;
        b=GPrpv/4WhT392+kBXYlHojQjIwXTeUSwxv1MMUrHy5ZNl6WRUvCf6h18KseeyKHgOn
         HInuGl8BxdJS5xnni0Hv6bcN7kwPy0MnZh6v9VDEGiKiOpLK3u4SS2BNOFh2Q4ZrJFm7
         5zBUhmFK1HgBGkS0B5WV2rkZadLWnwRqIR6Oa/NefbNgwBvJmKg49hPU3r9aZSQyx6dn
         n6C1ycT1y9kzxJsF6X69i+cnBsIyfQO4BNAHamFG9rWKnerKa5QNCEejktVHqMsaNn93
         5qcyEhuvlpM/jsylma2H6RqOO4OLHx0MTRRFwFyIPnwaufwqGSXKgxLW8h9tBhvROytQ
         wrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihEjAwkgFK6TMTS0NNrc4Hr909XAXppfc/t74qtEVys=;
        b=dL5r0XvIXUf6zsXjWORw7lRjj+uixXANfM/ZXxXZwRIwaBdqf1dm9kqxFi9Ncd/xd1
         xOdNnerd9X7rqk4qI03vHP6uQjfGE0/qKmYWVuDqWv2NBekuAjX78OrBQAz5DG2oOyxX
         IHOrje769OlwSYzW3eqHPAeWS1nqmff3mYDfZxlh/y9qQffz9gzxg5HpBxIUJka9Glqq
         JwaInvu/6Do23kCcD/Z+xXhK/SlAYGo75sMGNKmA3OfDyCvnG3sd/PWbje/573wFS4w2
         Zcytv/znYI7NitDx1nrCr3A9ikZYL5uB7SpT3wBcP7oFrV99eXRRw32fhnoj53I0l5o+
         YfKg==
X-Gm-Message-State: ACrzQf0wqkvJYwqCpsgbi5LUhlBAly7HZThzCM/8RpjNwCtTOsATkmhs
        7RaRpffWROV+bcP1gm4o4fph86ShMF0=
X-Google-Smtp-Source: AMsMyM4KUdXAsoAv9B6DtS+n8R3y214lW0abameZoQGRDI929xMTP7rEgPBOhQ9cM8FN6vQxfJ2a3w==
X-Received: by 2002:a05:6402:ea0:b0:454:38bf:aa3d with SMTP id h32-20020a0564020ea000b0045438bfaa3dmr8494544eda.291.1665227901439;
        Sat, 08 Oct 2022 04:18:21 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b0073ddd36ba8csm2580136eju.145.2022.10.08.04.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 04:18:21 -0700 (PDT)
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
Date:   Sat,  8 Oct 2022 13:18:13 +0200
Message-Id: <20221008111814.75251-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221008100935.73706-1-gnoack3000@gmail.com>
References: <20221008100935.73706-1-gnoack3000@gmail.com>
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

