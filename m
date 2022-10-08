Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955225F84BF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 12:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJHKKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 06:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJHKJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 06:09:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5941D12AE2;
        Sat,  8 Oct 2022 03:09:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o21so15857249ejm.11;
        Sat, 08 Oct 2022 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAI6zB9+0AGnJiVMY5vVZsK//rjwT955A9i61fTtXGs=;
        b=QftAXJ/bSX96aZ3IhSGRVx89o8TX04cVeOB8ESBghFFDTefGH43LzjrMFB90rh/Rq5
         jkjRGzYT1aPSdVmshXg2waKrr+Vjk24Mh6JC41aXzaABCS1go7myiC0Z6KsHAnCDKgRQ
         sORDquoNwEb15HsZQqrJDRWovRbhm5AmHqv3nNlgS5vlA/sAo80eKbdURE+lqx/IkoEu
         XcWT2Pdin9K4vzbFcB+HXRu7T4E6vXEjOBVvnWrKHFKu7sSjbqx44TIkPxq5SZlrsbNs
         g7PT9LUpXHZ4vj9sSn2VNGLy/ASqs+6wtQpSy7YJisAblui2+yNFA9pS7FbcnZDJVUQj
         wGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAI6zB9+0AGnJiVMY5vVZsK//rjwT955A9i61fTtXGs=;
        b=ZEqfyjXaOGIZ0ctnL2+TY19KDPmZu+TZyg+rMXAZLwKFDzLibr9Ekpnq2RutiZUohR
         RngkxHMMU7S2HI6k2Qi00dcV9BWF9PgelB6NdkxY+e3Y/+jiK1zurAY2dhvGxt2z192x
         z4R1PclhjPey965WweU8i20lo7DclqNphUkOCcJVedmOZEWLBSImxkYgpUgbCR1Ov5eZ
         0lVkwJXEAH+ivhVnyLrSME60DlLc9evR1j7/MUDKAksEuWKZQZ8z9rgJ0p6kXvuHpDAP
         /F1hnWzBRM5Xrn/Tl5XlT9wxzulZFiKUS6kcQx0asyz8uIfc6tMJXLAJYQME7hZYLEPM
         JPeg==
X-Gm-Message-State: ACrzQf0jC0zgnp7aAk6c/zbrTDvhja2SUbULS7HRHaR+iHaTl0lYxhJm
        niDowBHnJs3ok3OBtHwMggQzSK+KMnw=
X-Google-Smtp-Source: AMsMyM5bhFFLtoCoRv6/tY7vwE0LIBm1/6hF1jzrETVZWidS+D2h/ZlxksQ2CsICbSTJQbmAdMw8mw==
X-Received: by 2002:a17:906:5a4b:b0:78d:8790:d4a1 with SMTP id my11-20020a1709065a4b00b0078d8790d4a1mr4306387ejc.329.1665223784867;
        Sat, 08 Oct 2022 03:09:44 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e9-20020aa7d7c9000000b00452878cba5bsm3092012eds.97.2022.10.08.03.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 03:09:44 -0700 (PDT)
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
Subject: [PATCH v9 07/11] selftests/landlock: Locally define __maybe_unused
Date:   Sat,  8 Oct 2022 12:09:33 +0200
Message-Id: <20221008100935.73706-8-gnoack3000@gmail.com>
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

