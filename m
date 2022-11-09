Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD962365A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 23:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiKIWLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 17:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiKIWLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:11:21 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4730F42
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 14:11:20 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z14so27940778wrn.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Nov 2022 14:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ3GKuVP0imx2POuBXkubXthFsDTUZ2cFaQOvp4RnX4=;
        b=8F6WoDkV30FemhBYOzo7/gw3yLnKcBlPDpi4cbnyhJkCjDl1OHXNEsIJfEOZjt0z6E
         kGCOjdGdNzYPQiMgn0DM2+3CS61G4LSzruznyEmDHiWHSmb8PJ6g1bcB6hX8R5WIZpdn
         /Gunw0Qd09fKmgQ7K8DWwVXcNOlk84THBdxrF1ubpWKUd6O3PdkB2j+a5YEWmOjmr3NX
         0HRM8cvQWiilsDenpJraXTB3A5pOdw1CKxBgRhCsSpjnVsvdYAfpcFuSZPPPTBQ5EO+a
         3deGsyMhlypOzCzIt/n1nXlJJugA0ZNKfVjK3oW0V4ojgqSv1NnREmeTbAs2s8O8JGNG
         WVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJ3GKuVP0imx2POuBXkubXthFsDTUZ2cFaQOvp4RnX4=;
        b=MiIYE/+tLvB6/REaxHw5R6BxEXWoAPZJd3xLQh6ij+nGhFikOPeXahDBggy09R+5wQ
         W4nKGNMWmfsdN/2EbbXC13dZqXOpXq75JfQ5sNASSl7lcxPaJg8M5NCwtx49dQ8xTxMd
         9TlKOPH8uJEWstoDxUK+vaf0l/j/UY1+ipI6xOkR4eLtXvcNGyBdw9fc2xJq4CabZb7E
         uLLnuNcslnuvuX1pADJ8KI5Xa7yCX5XTHfzMmuHMSiYfW8jPjGmvalt5rOemISu/bd4T
         yM6lV0hfAiGbnbdHW5cEixtQ/el4OQGxBMPKYWVG9VyDLASN8h+BKkHPzdJJm25WDM4D
         bo6Q==
X-Gm-Message-State: ACrzQf037Wm1SR9JNe74gZvMy2tDKiYH0M1VUIgXFRgDy8s6FyIjqyOZ
        4Zuqc8H0NjVbnZLBRRGNvs/MHQ==
X-Google-Smtp-Source: AMsMyM5Ls91XrzX31Fh5/LlArYy6wfxqLqtNzvMjtExOap0AZndiItsV9y3Rf+Hx6UPliQgt6FqPMw==
X-Received: by 2002:a5d:4441:0:b0:236:6c3e:efb4 with SMTP id x1-20020a5d4441000000b002366c3eefb4mr39347938wrr.539.1668031878566;
        Wed, 09 Nov 2022 14:11:18 -0800 (PST)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id s25-20020adfa299000000b00236b2804d79sm14626583wra.2.2022.11.09.14.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:11:18 -0800 (PST)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v2 1/2] selftests: proc: Fix proc-empty-vm build error on non x86_64
Date:   Wed,  9 Nov 2022 22:11:03 +0000
Message-Id: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The proc-empty-vm test is implemented for x86_64 and fails to build
for other architectures. Rather then emitting a compiler error it
would be preferable to only build the test on supported architectures.

Mark proc-empty-vm as a test for x86_64 and customise the Makefile to
build it only when building for this target architecture.

Fixes: 5bc73bb3451b ("proc: test how it holds up with mapping'less process")
Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
---
v1 -> v2
* Fixed missing compilation on x86_64

Previous version
* https://lore.kernel.org/all/20221109110621.1791999-1-punit.agrawal@bytedance.com/

tools/testing/selftests/proc/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..743aaa0cdd52 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,14 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+# When ARCH not overridden for crosscompiling, lookup machine
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
-TEST_GEN_PROGS :=
 TEST_GEN_PROGS += fd-001-lookup
 TEST_GEN_PROGS += fd-002-posix-eq
 TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-loadavg-001
-TEST_GEN_PROGS += proc-empty-vm
 TEST_GEN_PROGS += proc-pid-vm
 TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
@@ -26,4 +28,8 @@ TEST_GEN_PROGS += thread-self
 TEST_GEN_PROGS += proc-multiple-procfs
 TEST_GEN_PROGS += proc-fsconfig-hidepid
 
+TEST_GEN_PROGS_x86_64 += proc-empty-vm
+
+TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH))
+
 include ../lib.mk
-- 
2.35.1

