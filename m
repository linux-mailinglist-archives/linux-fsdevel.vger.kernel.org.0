Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551DB784329
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjHVOGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 10:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjHVOGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD9E56;
        Tue, 22 Aug 2023 07:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3067649B4;
        Tue, 22 Aug 2023 14:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D3CC433C7;
        Tue, 22 Aug 2023 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713132;
        bh=oHAoMyZjF9g9W2qKAKfFFNVap7j750I1wK7h+SBfGKM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uV47zMyNVSy8lZoEqOFp/weZrgIWcrdmMRDiveKCVZQndjxELzRXvFwV375l1ULG9
         NxC3UN1CfZIPv5jxt4Yn3UCNv5ohrIrEOq5Z9gwKZh/QfoP73v897TbKjGTJPLgp7e
         knqzGb80zdsUBmK3q30iN5QCO6C2OTdqNzZ6ieAIywu7McPLWfzHcjwSmQGVyAfZRe
         Pr0rEM9wgopdS2QkbGgRAPKdLOLVILjY2Q77kdpU7LHBveB4MIPH8WUvBK939vwhG3
         HtsC3PqrX9/PbfRXyQfq778E5ISQZLmyoz/F7g6t2LCYJ+BnjUJDqf13NCgHDNRfaP
         yJFQ/8TejBicw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 22 Aug 2023 14:56:57 +0100
Subject: [PATCH v5 24/37] arm64/signal: Expose GCS state in signal frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-arm64-gcs-v5-24-9ef181dd6324@kernel.org>
References: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
In-Reply-To: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5977; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oHAoMyZjF9g9W2qKAKfFFNVap7j750I1wK7h+SBfGKM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk5MACn9EM8kDg4Zd3ABXmAqIDrZFZKjm8ByzT0FPn
 wa1aYZ2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZOTAAgAKCRAk1otyXVSH0GpaB/
 9Q9EST0r4US0yp6YSqWBa/X5sqL9DzJGuN65ghuYKH6I/9GnJA9X05tAFD18Y8pVaTr5eqVhd8kdLR
 GS1gSb0sAZyxgOHjScDx2UIHcqBnAdRbAsRtx7osjPHuZocaqeYe2dstvM5jS75++IU1WiCgdSLhXr
 RY6FsHcS+WW6Sw/Euai/4J/VSJmkpdlnE1lkUB1PDIJeo22GfNCFB0dFM1vaqs5WYqF46KY4Ha/AWF
 m82DuyoKwhlI7woW+z61J3H9MqYAJFOfjW2JYzBU/+JAsG4NADaHMZ/7VOiTmhYhD2bULjHLdaOO9B
 u3vDP0dEBlB9/4zoY62abIFNV8i05P
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a context for the GCS state and include it in the signal context when
running on a system that supports GCS. We reuse the same flags that the
prctl() uses to specify which GCS features are enabled and also provide the
current GCS pointer.

We do not support enabling GCS via signal return, there is a conflict
between specifying GCSPR_EL0 and allocation of a new GCS and this is not
an ancticipated use case.  We also enforce GCS configuration locking on
signal return.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/sigcontext.h |   9 +++
 arch/arm64/kernel/signal.c               | 107 +++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index f23c1dc3f002..7b66d245f2d2 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -168,6 +168,15 @@ struct zt_context {
 	__u16 __reserved[3];
 };
 
+#define GCS_MAGIC	0x47435300
+
+struct gcs_context {
+	struct _aarch64_ctx head;
+	__u64 gcspr;
+	__u64 features_enabled;
+	__u64 reserved;
+};
+
 #endif /* !__ASSEMBLY__ */
 
 #include <asm/sve_context.h>
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 97004c52aea3..78370cf9576a 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -87,6 +87,7 @@ struct rt_sigframe_user_layout {
 
 	unsigned long fpsimd_offset;
 	unsigned long esr_offset;
+	unsigned long gcs_offset;
 	unsigned long sve_offset;
 	unsigned long tpidr2_offset;
 	unsigned long za_offset;
@@ -213,6 +214,8 @@ struct user_ctxs {
 	u32 za_size;
 	struct zt_context __user *zt;
 	u32 zt_size;
+	struct gcs_context __user *gcs;
+	u32 gcs_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -605,6 +608,82 @@ extern int restore_zt_context(struct user_ctxs *user);
 
 #endif /* ! CONFIG_ARM64_SME */
 
+#ifdef CONFIG_ARM64_GCS
+
+static int preserve_gcs_context(struct gcs_context __user *ctx)
+{
+	int err = 0;
+	u64 gcspr;
+
+	/*
+	 * We will add a cap token to the frame, include it in the
+	 * GCSPR_EL0 we report to support stack switching via
+	 * sigreturn.
+	 */
+	gcs_preserve_current_state();
+	gcspr = current->thread.gcspr_el0;
+	if (task_gcs_el0_enabled(current))
+		gcspr -= 8;
+
+	__put_user_error(GCS_MAGIC, &ctx->head.magic, err);
+	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
+	__put_user_error(gcspr, &ctx->gcspr, err);
+	__put_user_error(current->thread.gcs_el0_mode,
+			 &ctx->features_enabled, err);
+
+	return err;
+}
+
+static int restore_gcs_context(struct user_ctxs *user)
+{
+	u64 gcspr, enabled;
+	int err = 0;
+
+	if (user->gcs_size != sizeof(*user->gcs))
+		return -EINVAL;
+
+	__get_user_error(gcspr, &user->gcs->gcspr, err);
+	__get_user_error(enabled, &user->gcs->features_enabled, err);
+	if (err)
+		return err;
+
+	/* Don't allow unknown modes */
+	if (enabled & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
+		return -EINVAL;
+
+	err = gcs_check_locked(current, enabled);
+	if (err != 0)
+		return err;
+
+	/* Don't allow enabling */
+	if (!task_gcs_el0_enabled(current) &&
+	    (enabled & PR_SHADOW_STACK_ENABLE))
+		return -EINVAL;
+
+	/* If we are disabling disable everything */
+	if (!(enabled & PR_SHADOW_STACK_ENABLE))
+		enabled = 0;
+
+	current->thread.gcs_el0_mode = enabled;
+
+	/*
+	 * We let userspace set GCSPR_EL0 to anything here, we will
+	 * validate later in gcs_restore_signal().
+	 */
+	current->thread.gcspr_el0 = gcspr;
+	write_sysreg_s(current->thread.gcspr_el0, SYS_GCSPR_EL0);
+
+	return 0;
+}
+
+#else /* ! CONFIG_ARM64_GCS */
+
+/* Turn any non-optimised out attempts to use these into a link error: */
+extern int preserve_gcs_context(void __user *ctx);
+extern int restore_gcs_context(struct user_ctxs *user);
+
+#endif /* ! CONFIG_ARM64_GCS */
+
 static int parse_user_sigframe(struct user_ctxs *user,
 			       struct rt_sigframe __user *sf)
 {
@@ -621,6 +700,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->tpidr2 = NULL;
 	user->za = NULL;
 	user->zt = NULL;
+	user->gcs = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -715,6 +795,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			user->zt_size = size;
 			break;
 
+		case GCS_MAGIC:
+			if (!system_supports_gcs())
+				goto invalid;
+
+			if (user->gcs)
+				goto invalid;
+
+			user->gcs = (struct gcs_context __user *)head;
+			user->gcs_size = size;
+			break;
+
 		case EXTRA_MAGIC:
 			if (have_extra_context)
 				goto invalid;
@@ -834,6 +925,9 @@ static int restore_sigframe(struct pt_regs *regs,
 			err = restore_fpsimd_context(&user);
 	}
 
+	if (err == 0 && system_supports_gcs() && user.gcs)
+		err = restore_gcs_context(&user);
+
 	if (err == 0 && system_supports_tpidr2() && user.tpidr2)
 		err = restore_tpidr2_context(&user);
 
@@ -948,6 +1042,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 			return err;
 	}
 
+	if (system_supports_gcs()) {
+		err = sigframe_alloc(user, &user->gcs_offset,
+				     sizeof(struct gcs_context));
+		if (err)
+			return err;
+	}
+
 	if (system_supports_sve() || system_supports_sme()) {
 		unsigned int vq = 0;
 
@@ -1041,6 +1142,12 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
 	}
 
+	if (system_supports_gcs() && err == 0 && user->gcs_offset) {
+		struct gcs_context __user *gcs_ctx =
+			apply_user_offset(user, user->gcs_offset);
+		err |= preserve_gcs_context(gcs_ctx);
+	}
+
 	/* Scalable Vector Extension state (including streaming), if present */
 	if ((system_supports_sve() || system_supports_sme()) &&
 	    err == 0 && user->sve_offset) {

-- 
2.30.2

