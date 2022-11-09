Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC54262365C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 23:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiKIWLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 17:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiKIWLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:11:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69D3123B
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 14:11:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso6483wmp.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Nov 2022 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zjcx5nGJ4+e6voi0gTPzKp2DtAjaGHPzOo3aFzn/OZg=;
        b=P8/bnQTjV4nzCnwXorntM1WchaIivdzE2Yt/R7IiG7Ii2vT3PYvJc2avGc1K2y3O+u
         s0iNoA/aO1/YAFG4W/mqfXudotsG6MV49UwT8SEcx+9rx/sAJZojZH/AnvMi7C1s2ooR
         vJRuiOjcaHcxSr/SjDVnK1Nj26gR4nOJCHs+KBIUY4IpxIt7X3e/dcziuNJ3pg2i2651
         4vh+fe12F9GQ5FvV6yMDjyiC3Pzv8l4Woi/JQNVuxGTX6z5uKb/+4DNXSRVPigX60efB
         7aGEfW1PDuXw8ojKxTj8SwEhGyrWjARHK5sBmVhrw1xFbwqDXkRXA4I75qCfkIGrZMbt
         +lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjcx5nGJ4+e6voi0gTPzKp2DtAjaGHPzOo3aFzn/OZg=;
        b=BPSDh5R/VP4oWbhTmgsnl1cVtjwIx9zYO1dc0dOimT6RuifBRc8ijBuAiDUpCBdTnG
         C19ETTNkKuthu+Ju6IVQZDXr7ZCWPkbYVDZBr7qAixLOQN/Xn+zAEh4flwnwjLBDJywp
         yopPIvNusRCQIeZ2iari3IhNl6qmGngXDN+LM42AnF6ljbM1s9qHp10lvrjZVJnPiRxN
         V5Xx7PHqLUwwvZzU9tscGEKn9vMIO/ebzmvfZKQdsByPMfuA7lx0A1uPhgS8UiH+EiPA
         61BhJ6VML/b/+/y+XQxZIUuuHbIGQxzVmfoqD0NT9hkL0CI/8+ZGLnN/LBaIY2HvieRD
         brnQ==
X-Gm-Message-State: ACrzQf12E2xaBgh7OvgpTavGCRigKSy5sOyC+kPKWfp9/dOBJa5zke4i
        BQPyVAelGOZd4SB0fd9C3UYw5w==
X-Google-Smtp-Source: AMsMyM7HW/8xiglV2nGZzAJasS+2C/g1HhdvY80U1kVvgsIaPUHX5JXuLGJXrDKB7IEWVOlP++hbaw==
X-Received: by 2002:a7b:ca52:0:b0:3cf:5c22:cbee with SMTP id m18-20020a7bca52000000b003cf5c22cbeemr41336461wml.97.1668031879712;
        Wed, 09 Nov 2022 14:11:19 -0800 (PST)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id bn23-20020a056000061700b002305cfb9f3dsm14292893wrb.89.2022.11.09.14.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:11:19 -0800 (PST)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v2 2/2] selftests: proc: Mark proc-pid-vm as x86_64 only
Date:   Wed,  9 Nov 2022 22:11:04 +0000
Message-Id: <20221109221104.1797802-2-punit.agrawal@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
References: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
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

The proc-pid-vm test does not have support for architectures other
than x86_64. Mark it as such in the Makefile and in the process remove
the special casing in the test itself.

Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
---
 tools/testing/selftests/proc/Makefile      | 2 +-
 tools/testing/selftests/proc/proc-pid-vm.c | 9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index 743aaa0cdd52..db953c014bf8 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -11,7 +11,6 @@ TEST_GEN_PROGS += fd-001-lookup
 TEST_GEN_PROGS += fd-002-posix-eq
 TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-loadavg-001
-TEST_GEN_PROGS += proc-pid-vm
 TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
 TEST_GEN_PROGS += proc-self-syscall
@@ -29,6 +28,7 @@ TEST_GEN_PROGS += proc-multiple-procfs
 TEST_GEN_PROGS += proc-fsconfig-hidepid
 
 TEST_GEN_PROGS_x86_64 += proc-empty-vm
+TEST_GEN_PROGS_x86_64 += proc-pid-vm
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH))
 
diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 69551bfa215c..6b0cb772b688 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -105,7 +105,6 @@ struct elf64_phdr {
 	uint64_t p_align;
 };
 
-#ifdef __x86_64__
 #define PAGE_SIZE 4096
 #define VADDR (1UL << 32)
 #define MAPS_OFFSET 73
@@ -209,7 +208,6 @@ static int make_exe(const uint8_t *payload, size_t len)
 
 	return fd1;
 }
-#endif
 
 /*
  * 0: vsyscall VMA doesn't exist	vsyscall=none
@@ -225,7 +223,6 @@ static const char str_vsyscall_1[] =
 static const char str_vsyscall_2[] =
 "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
 
-#ifdef __x86_64__
 static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
 {
 	_exit(g_vsyscall);
@@ -493,9 +490,3 @@ int main(void)
 
 	return 0;
 }
-#else
-int main(void)
-{
-	return 4;
-}
-#endif
-- 
2.35.1

