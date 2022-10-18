Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD2760324D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJRSXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJRSWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:22:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B7882D28;
        Tue, 18 Oct 2022 11:22:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bj12so34295346ejb.13;
        Tue, 18 Oct 2022 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAI6zB9+0AGnJiVMY5vVZsK//rjwT955A9i61fTtXGs=;
        b=QpyJUiJgAOm6xg6LjQTb8ftXMa1W1PYjo23TdPFEyBv068T7+Acr5f0woWYvlW3VQS
         LEe/SLug4cxutjrfe/5mXjs/23BYU20l+thdslH3YYlr0Lf7YEcGykLg1I7qL+ggud+B
         HkCRzf7N7cCi8p9vvi4UqUaX/5upoosVRmtboIYbW+xLmPGxEczYlKSfPV7Q/EmHifQp
         yD97HqE4XDx9PStUiZ4fNwKdhnx7GIZ2N1SJb3wn8UPTyKENERJt1UTVzFkBTrz0ce6b
         /qYCLNPaecIvizPPIo3HR4B/ScSQgzWqGs8KRlESbzsCXpR9ziTG0QrXl1IvJFLte0/j
         BLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAI6zB9+0AGnJiVMY5vVZsK//rjwT955A9i61fTtXGs=;
        b=wojKI42B7bBauva0lJt+T0I/h3ObaMf1xwpNtqvsxwivsgiqeyXCaajESc6jmP7XXB
         bYg/gPWMqQCtBDJc1Fq8BoIBds0xFdF4ybWh6hpgaZ0Jm1QiTfDwzCjtno1qxeqVAWq9
         JgrQnbtvaEFBszc/gCd1uOTP2GMXa2dRlJq6CmCO0+987kocG8MSi34FxS6qYlN8Z2E/
         A1vP52y1v/HrJlwCBz6u+ZL5gE4FLOcNBdOV7iDa/S8Gk2/ihRFT+5NtB+FNa86DUgXm
         gO1ANbXnEpxysiwvHHdZlSdFOmFoDbBFKrbTZenbxNTI9pMQVHTR6zAydsWh89eultFc
         rhfA==
X-Gm-Message-State: ACrzQf0BQu4PPXBTBUtxDo7xltOj3gKNIlDs0RbJ5aJMjSUGr2VQ/KJ8
        aAGkTdjmBKNVYo62WiDUQt+auhE5Pew=
X-Google-Smtp-Source: AMsMyM5NFg89XvH3cwG50d0PpNs0qMzQZtInxphbecoM39pTWCJu6TxFQm5LKfaFO4Gs/CbHAxjDQQ==
X-Received: by 2002:a17:906:9b92:b0:791:9355:cb89 with SMTP id dd18-20020a1709069b9200b007919355cb89mr3476654ejc.498.1666117354785;
        Tue, 18 Oct 2022 11:22:34 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id i18-20020a0564020f1200b00458a03203b1sm9358395eda.31.2022.10.18.11.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:22:34 -0700 (PDT)
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
Subject: [PATCH v10 07/11] selftests/landlock: Locally define __maybe_unused
Date:   Tue, 18 Oct 2022 20:22:12 +0200
Message-Id: <20221018182216.301684-8-gnoack3000@gmail.com>
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

The checkpatch tool started to flag __attribute__(__unused__), which
we previously used. The header where this is normally defined is not
currently compatible with selftests.

This is the same approach as used in selftests/net/psock_lib.h.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/common.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 7ba18eb23783..7d34592471db 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -17,6 +17,10 @@
 
 #include "../kselftest_harness.h"
 
+#ifndef __maybe_unused
+#define __maybe_unused __attribute__((__unused__))
+#endif
+
 /*
  * TEST_F_FORK() is useful when a test drop privileges but the corresponding
  * FIXTURE_TEARDOWN() requires them (e.g. to remove files from a directory
@@ -140,14 +144,12 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 }
 
 /* We cannot put such helpers in a library because of kselftest_harness.h . */
-__attribute__((__unused__)) static void
-disable_caps(struct __test_metadata *const _metadata)
+static void __maybe_unused disable_caps(struct __test_metadata *const _metadata)
 {
 	_init_caps(_metadata, false);
 }
 
-__attribute__((__unused__)) static void
-drop_caps(struct __test_metadata *const _metadata)
+static void __maybe_unused drop_caps(struct __test_metadata *const _metadata)
 {
 	_init_caps(_metadata, true);
 }
@@ -176,14 +178,14 @@ static void _effective_cap(struct __test_metadata *const _metadata,
 	}
 }
 
-__attribute__((__unused__)) static void
-set_cap(struct __test_metadata *const _metadata, const cap_value_t caps)
+static void __maybe_unused set_cap(struct __test_metadata *const _metadata,
+				   const cap_value_t caps)
 {
 	_effective_cap(_metadata, caps, CAP_SET);
 }
 
-__attribute__((__unused__)) static void
-clear_cap(struct __test_metadata *const _metadata, const cap_value_t caps)
+static void __maybe_unused clear_cap(struct __test_metadata *const _metadata,
+				     const cap_value_t caps)
 {
 	_effective_cap(_metadata, caps, CAP_CLEAR);
 }
-- 
2.38.0

