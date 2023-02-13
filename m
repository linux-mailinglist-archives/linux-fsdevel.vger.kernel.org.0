Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E334A693D95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 05:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBMEyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Feb 2023 23:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjBMEyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81C4113E0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:12 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so9653591pjk.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP4wZ0K6nVayFSsIwI2M/qbAeCayW2BZaB6BdNSazd0=;
        b=kQCkDlkhAa4XVmRG1hxXFbpWGlXPMBYAGXgy0L0uPsR9g5pVZDofnEGhHEJYmp4t70
         GThKDRHlZLQeCmf3sShq+tYAdJikORjaEoHzhV8XPsEC3fuBeKmrypEuXS7bnM4Hr1Mu
         ejAuWJdj4rylP7L48un2eYEoyEM3T/HgHUJ+XVCnMOro/vM0ja9j4XcrCb2wVTAb2ykU
         VVkETKJNdrlyLnPFCjstqmRxjQbAorY6hbHg6u7JiS4XZd2HNWZ+rc/s5B7cfxPqGP5E
         y7sCTgg87DvCTzj8NBBDe3V2Zk1icq2em5kbBEcbVFNjlxLiW6d6zxFc1ZAJ17l5bZV5
         /rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP4wZ0K6nVayFSsIwI2M/qbAeCayW2BZaB6BdNSazd0=;
        b=q3K76FaOKUYcc8OYQsEt1zjKYHm9URKbTM6SrsFkVIcehtK1CZXnfiYf95b96HK1Lt
         ewWsejKnLFFWm5598LyJ05ioRtEDOSxe3u1IUiFvbb9f2lkbiQhr9NlAb08XV76KcUgC
         4kY18RViC8nStPveNTVRa07vw5kjV1WzYDcfzSrOwgWYVUjI9N9GO3AhakWr9LggKqaB
         OnOiz/To7+/oOQgJ7Yqfq7FV0mpiK0nuBxwQHJFvpTfoISxFix+YvPckIMVq+BaZ5S8z
         hAddTAQzXpk1oDYMjqKQS3XVjXDPaxcWpQ6pwZlnCI0tAKeuoF/Vb13ubeRFY0UfBN7i
         n5Aw==
X-Gm-Message-State: AO0yUKVJE3uWZG3uR2GAElBqikvkM71V8Ky5VBB8/PXGfRTnvbcX2tJb
        Ie61U+utJ8rkLKY60Fxeoy18XQ==
X-Google-Smtp-Source: AK7set/Y/udvpjSPyiRHvzVVe58rgU9SM3O2saFl6KwR15sjL2H2TEzdTJbI8CgO0QDxGQ+4+3WsRQ==
X-Received: by 2002:a17:902:ce86:b0:19a:9580:750 with SMTP id f6-20020a170902ce8600b0019a95800750mr5863992plg.16.1676264052424;
        Sun, 12 Feb 2023 20:54:12 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:12 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 RFC Zisslpcfi 07/20] elf: ELF header parsing in GNU property for cfi state
Date:   Sun, 12 Feb 2023 20:53:36 -0800
Message-Id: <20230213045351.3945824-8-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
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

Binaries enabled with support for control-flow integrity will have new
instructions that may fault on cpus which dont implement cfi mechanisms.
This change adds

 - stub for setting up cfi state when loading a binary. Architecture
   specific implementation can choose to implement this stub and setup
   cfi state for program.
 - define riscv ELF flag marker for forward cfi and backward cfi in
   uapi/linux/elf.h

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 fs/binfmt_elf.c          | 5 +++++
 include/linux/elf.h      | 8 ++++++++
 include/uapi/linux/elf.h | 6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 9a780fafc539..bb431052eb01 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1277,6 +1277,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	set_binfmt(&elf_format);
 
+#if defined(CONFIG_USER_SHADOW_STACK) || defined(CONFIG_USER_INDIRECT_BR_LP)
+	retval = arch_elf_setup_cfi_state(&arch_state);
+	if (retval < 0)
+		goto out;
+#endif
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	retval = ARCH_SETUP_ADDITIONAL_PAGES(bprm, elf_ex, !!interpreter);
 	if (retval < 0)
diff --git a/include/linux/elf.h b/include/linux/elf.h
index c9a46c4e183b..106d28f065aa 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -109,4 +109,12 @@ static inline int arch_elf_adjust_prot(int prot,
 }
 #endif
 
+#if defined(CONFIG_USER_SHADOW_STACK) || defined(CONFIG_USER_INDIRECT_BR_LP)
+extern int arch_elf_setup_cfi_state(const struct arch_elf_state *state);
+#else
+static inline int arch_elf_setup_cfi_state(const struct arch_elf_state *state)
+{
+	return 0;
+}
+#endif
 #endif /* _LINUX_ELF_H */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 4c6a8fa5e7ed..1cbd332061dc 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -468,4 +468,10 @@ typedef struct elf64_note {
 /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
 #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
 
+/* .note.gnu.property types for RISCV: */
+/* Bits for GNU_PROPERTY_RISCV_FEATURE_1_FCFI/BCFI */
+#define GNU_PROPERTY_RISCV_FEATURE_1_AND  0xc0000000
+#define GNU_PROPERTY_RISCV_FEATURE_1_FCFI (1u << 0)
+#define GNU_PROPERTY_RISCV_FEATURE_1_BCFI (1u << 1)
+
 #endif /* _UAPI_LINUX_ELF_H */
-- 
2.25.1

