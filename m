Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7455622999
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 12:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiKILGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 06:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiKILGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:06:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7449F22B36
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 03:06:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso1003490wme.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Nov 2022 03:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkxuXtDed4rc7dbRvY9+2yDzxFpGHl/JP9vCeNecjEQ=;
        b=6DFmQR5sbsez/Ge+WY3V6ty840AoV8XrukBvGEINyWwWIa5Atsx6UQyioeb3ThYd1s
         87Edyh3XI17NuhV9Xv1ikEJTOvzAwntA2hRBdcY1OQVe1wcWysR5z8K8257HmINhRMkF
         +Ss0VI9GYh4W35My1qvSx8d9WAtR3C6MBL/8gaXeXMJIiBoSaZZvSInCKIktQmFb7wMb
         JvW7wN/vhoLc0Tuik/alsqmt5DnR8guLjwad/Sd1H55rYZq4+J0qLGKO4zf2qCrKFnfJ
         cbOxYBOTaoeSFMza9dYvOTuQ1glAgXey9AnoloQzoCu0IePxDHqlmajTlF7PGlacKPJP
         bP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkxuXtDed4rc7dbRvY9+2yDzxFpGHl/JP9vCeNecjEQ=;
        b=DJtScNL0+VGXf8LbCCPTlo/E8zccFMS5+Yh8NJKDeEcMZ29/3Z/E33C65vvafoqJO9
         Wi54ShkIdoC/DohLzFknvjOzmzxQfgsI2zlc656SBhdiEFQvd8gXM8514avj0H8ynpG4
         dI7KrQWV/nXvQ81aLYYihGqLZES5PG36H5Affimc6m0LGNbYUwQUNdtvJXHPxrAECRpY
         1bwvGhEm64xEyq4HRJExw6goAeYhdy6aFkef/gNubq3cV5WHyh5d2LIvDZshkoQhgmy6
         Vm7uxD98kQctfhMKQhTLucA/DCoblJC227vdjMRr6dfJFCiNY4BdH1FhMzDFH2g12oie
         N/Cg==
X-Gm-Message-State: ACrzQf2ANm8Fq2+kL6f8skdSMvJfXeyOpkevoJV/04xRJAowVogyl1Bd
        /3jzPi1MxZRd+O+nGqrrk1Phtty/rQk2Wn3S
X-Google-Smtp-Source: AMsMyM5BvadxqH6GX2b2GSNjxZbt+RfSbJqqVZaOmo19Ouk7XqKsVYC0osO0pMhoMvRYcjnFslHO4Q==
X-Received: by 2002:a05:600c:2e46:b0:3cf:8a34:2e98 with SMTP id q6-20020a05600c2e4600b003cf8a342e98mr23430198wmf.30.1667991989984;
        Wed, 09 Nov 2022 03:06:29 -0800 (PST)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id r2-20020adfdc82000000b0022ae401e9e0sm12999034wrj.78.2022.11.09.03.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:06:29 -0800 (PST)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH] selftests: proc: Fix proc-empty-vm build error on non x86_64
Date:   Wed,  9 Nov 2022 11:06:21 +0000
Message-Id: <20221109110621.1791999-1-punit.agrawal@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The proc-empty-vm test is implemented for x86_64 and fails to build
for other architectures. Rather then emitting a compiler error it
would be preferable to only build the test on supported architectures.

Mark proc-empty-vm as a test for x86_64 and customise to the Makefile
to build it only when building for this target architecture.

Fixes: 5bc73bb3451b ("proc: test how it holds up with mapping'less process")
Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
---
 tools/testing/selftests/proc/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..6b31439902af 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,14 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+# When ARCH not overridden for crosscompiling, lookup machine
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
-TEST_GEN_PROGS :=
+TEST_GEN_PROGS_x86_64 += proc-empty-vm
+
 TEST_GEN_PROGS += fd-001-lookup
 TEST_GEN_PROGS += fd-002-posix-eq
 TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-loadavg-001
-TEST_GEN_PROGS += proc-empty-vm
 TEST_GEN_PROGS += proc-pid-vm
 TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
-- 
2.30.2

