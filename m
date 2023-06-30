Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90827744261
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 20:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjF3SgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 14:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjF3SfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:35:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C9F49F9
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 11:34:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992acf67388so236807866b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688150093; x=1690742093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qg1w3CBffWio5WR/vw/6assSDA081651kK3qApcQZKM=;
        b=nt/LvfQtKL58p6ZqTKA2wRGxWgTRkYxiIr1H4orWSv0hObf/iC/0d0himU40z3qFKm
         R9y40TGEKLi7aipEjZDFG23BPiACgXSGjj8ltdCPhLt7ArRcaujAadI2LKyHl3U5NvbS
         AUUVe/+nzO8wfmP5zmBRME07QGbft+6bTNrzhJv7FuNvBBW7rjdd+5oabKVJANkspweA
         4CaUr98GiquaS7oMlvH2Cnl40w+vnuzd4HxJ35Krb5inqIeJftcjNjQwzertpjTDi0zi
         mzkSBEolvZkqhDqhTCjVaoDTlUsgHRl7VPtQgRqsTLHv0teWfztEES+pzkrBIPOxWwWJ
         AdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688150093; x=1690742093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qg1w3CBffWio5WR/vw/6assSDA081651kK3qApcQZKM=;
        b=XUOTux9THeMOQLViLDaUbmMNpnSp6XDlKUWCfOEF/lmP8mpZwhdjbpEFQp/Q09lZFP
         RBkkE8yGIQp2WZZ84X13szaVDgjawpzuzVLVaxjlWXpkhs7BV+nNfy0GgUArVNaQlLTo
         GSUx0SQGNwsaFwU6VbLXxImBmIOQmE9dAwCMu6CXHGqsaYKMRnFcDRL48VNhRtp9967j
         tXorC4RudTy47AsJI9lY4yBjuMeU6gp3DQq8yrwbrtLAQiRFE3cQm0OolwOpTnIMfj28
         mNPuDlrWcMZ04XgTWeX736lSQQVYL0YEe8cnrTgyFzVsFlBPdVL6udHIKWfsV7jEK0JK
         AChQ==
X-Gm-Message-State: ABy/qLb7Vh3wjwkWgyI011yBppC2lCw4Nkaiu2jqw2DJaw4BTQ7MrRoa
        0WCXIwK2CScahJfE9Iy61g==
X-Google-Smtp-Source: APBJJlEDMU35rSKZgdBu3w0lrumbOYGPkw8d6Tr+EiWoZQqN0+ffiPei2e0qkzLJqmErMaJOuJjpsA==
X-Received: by 2002:a17:906:d14a:b0:991:f427:2fe7 with SMTP id br10-20020a170906d14a00b00991f4272fe7mr2426901ejb.62.1688150092854;
        Fri, 30 Jun 2023 11:34:52 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.113])
        by smtp.gmail.com with ESMTPSA id lr3-20020a170906fb8300b00973f1cd586fsm8361827ejb.1.2023.06.30.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:34:52 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, bjorn@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] proc: support proc-empty-vm test on i386
Date:   Fri, 30 Jun 2023 21:34:33 +0300
Message-Id: <20230630183434.17434-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unmap everything starting from 4GB length until it unmaps, otherwise
test has to detect which virtual memory split kernel is using.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 7588428b8fcd..3aea36c57800 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -37,6 +37,10 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#ifdef __amd64__
+#define TEST_VSYSCALL
+#endif
+
 /*
  * 0: vsyscall VMA doesn't exist	vsyscall=none
  * 1: vsyscall VMA is --xp		vsyscall=xonly
@@ -119,6 +123,7 @@ static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
 	_exit(EXIT_FAILURE);
 }
 
+#ifdef TEST_VSYSCALL
 static void sigaction_SIGSEGV_vsyscall(int _, siginfo_t *__, void *___)
 {
 	_exit(g_vsyscall);
@@ -170,6 +175,7 @@ static void vsyscall(void)
 		exit(1);
 	}
 }
+#endif
 
 static int test_proc_pid_maps(pid_t pid)
 {
@@ -299,7 +305,9 @@ int main(void)
 {
 	int rv = EXIT_SUCCESS;
 
+#ifdef TEST_VSYSCALL
 	vsyscall();
+#endif
 
 	switch (g_vsyscall) {
 	case 0:
@@ -346,6 +354,14 @@ int main(void)
 
 #ifdef __amd64__
 		munmap(NULL, ((size_t)1 << 47) - 4096);
+#elif defined __i386__
+		{
+			size_t len;
+
+			for (len = -4096;; len -= 4096) {
+				munmap(NULL, len);
+			}
+		}
 #else
 #error "implement 'unmap everything'"
 #endif
-- 
2.40.1

