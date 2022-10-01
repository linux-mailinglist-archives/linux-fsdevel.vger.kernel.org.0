Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F65F1D4C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 17:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJAPtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 11:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJAPta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:49:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE156BA4;
        Sat,  1 Oct 2022 08:49:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id rk17so14588632ejb.1;
        Sat, 01 Oct 2022 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=t+LW9SvGEoa4775Dg0uR7hcqlks6S31AbmnXtFe1Ups=;
        b=XH9rQP2tQJSAmPzeoxwRigHRvZPqGBiYnX8Bhne76JGWRdMlr0USrFa96aNUArbKbS
         6jzy0XnVwHnSv0qkVv7bPMxu/Qql+Gi4tcUVL+S75D/qL9EpIg7npnkEXnUWiaEagBMQ
         1pdbjyzUbHGGsZxrT/kIzeGhjTbJv3mPKGkMaxmPy2sa630+vnyfqkxEiEevOoids+93
         uQF8kB1Kj5uWZxYtcdmPDeI60jWoNHTqMg3HSOEJv1YSnflvc99Ng40zuPrwOdV1ibco
         vHCG6sGMozBsAaFuiv+Cl2B+u52jAnvcnAfCWuT0nuM14MG4PKYy7CS9Eqd4gCLLtHFX
         9HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=t+LW9SvGEoa4775Dg0uR7hcqlks6S31AbmnXtFe1Ups=;
        b=Lzu9KLNxv/zbyCBxAEdOhLXxSQjw4AMU7RANLcbQe5R7UHtFc8/JaVDXuh9otqZKr0
         eTrRUFvQbNB55EK0DWQfiDF1E4Jvmbn0CrcKbaPZxkwjS+C+hV4aRrOR6JGkjSyKWC0L
         89WqstbKfF2VoXzbvq92AQTes0i6qL+caEGiF3lHiJLPW+iiR6Au2aOHYMDY1G6xQh0o
         50KAMLolFDsMep7pfGF6MHYuVeiCx3ynF10RSBijCXe/o55Tv0gokzdhu/QyTfhbWFqj
         Nb2qX7RlqvaqBQLuYp28QgcsSivE0ZI5Uu35QDXMmO2OOV68h8MzGc98PF7/ogo3uRfn
         9nZg==
X-Gm-Message-State: ACrzQf2niyo1X52iP08aKc1a5yWA3CxJTJ80tYgMgxg8KQi8Kekxck1K
        FB6Dm7O5vrX9YGVE+CjS0ZLCB6z+0SY=
X-Google-Smtp-Source: AMsMyM7uN29bHQOaCvlpcBZNWr4lGchKv5My0pRr7u4pejCte11KscPZYg2hcgrt9dBdnjCU0PqMBg==
X-Received: by 2002:a17:907:74e:b0:74f:83d4:cf58 with SMTP id xc14-20020a170907074e00b0074f83d4cf58mr10151291ejb.178.1664639368016;
        Sat, 01 Oct 2022 08:49:28 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7d69a000000b00458cc5f802asm617151edr.73.2022.10.01.08.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 08:49:26 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v8 2/9] selftests/landlock: Locally define __maybe_unused
Date:   Sat,  1 Oct 2022 17:49:01 +0200
Message-Id: <20221001154908.49665-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001154908.49665-1-gnoack3000@gmail.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
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
2.37.3

