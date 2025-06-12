Return-Path: <linux-fsdevel+bounces-51470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BFFAD71D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9124417C688
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408024A07A;
	Thu, 12 Jun 2025 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGxXX7cT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF324A04D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734749; cv=none; b=FszNNxaFUsSX9HfHkJAfurvCuT1a+AkeQ0YgVxWXv4MzWQMLBLklh+YILqIRok/7zVBKHWitflNXvoi93m6m9y75iViwBPO0iQfHcSklpKDHSnoPhSN1XqIAjAnsRld0xrIYXPd6OKshq+/xmIz0TpBadPZfR/Swh7MBGaUzjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734749; c=relaxed/simple;
	bh=9mD9ktHuhYtmeJULYmDwuXaXXwezoRFa6vIRDPucgno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K32FdXRIrqOamlEqY4U34XNH5mhXQN2MLVUyLiHppBH8hZnoO1C9G5ptChRuTdQDofos6L9BbzsGSMJK+qoN7EDc3SRM/95C97KF81TVeB4bprYK589f7egA0iwn7+FS9PaQiV3vSMG5DvxEYH8LxELmtWxHFShZH8HVSSoPBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGxXX7cT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F1EC4CEF1;
	Thu, 12 Jun 2025 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734748;
	bh=9mD9ktHuhYtmeJULYmDwuXaXXwezoRFa6vIRDPucgno=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rGxXX7cTKL2RghzI8A+ojah77xAYARGPwi8Y5fWf7/nLVH9gFaoy61rXf+xjYIPYe
	 zPOi7QYvrThifjyiV5tfHCiOGH1KxuaB++vuSdC89tEkGBYNGamBRYS0hNYFCuaEJC
	 vGeHqhXgxWKxLOU+HbZiu93dv16uzEUdQiB3/lVZae6O0jn+9RMnEbJRIFNlMzuBDK
	 a14fKaIfDIWiUTh9NHYsnaWX3z7cniY8gvsTfwT8kRE8dyZLTWPtffAchZpXvi4JL0
	 OdjmtSnzH8jkkuDjqwlvuP6hmp0KG6xuFiNleS74Jl1iSUK2SwaaAzF3JDALMhtVF/
	 rJ3AmX+NHxD8w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:23 +0200
Subject: [PATCH 09/24] coredump: rename do_coredump() to vfs_coredump()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250612-work-coredump-massage-v1-9-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=3469; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9mD9ktHuhYtmeJULYmDwuXaXXwezoRFa6vIRDPucgno=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXXvk//E4rpvjefdL0k/Nv0Pz7j/y/S54oHs45eb1
 qocX3BXuKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiK/MYGe4dO3xNZNuFNZGK
 mm2zgpp+O7AseyJQu+BohmCfc5RyXBQjw/Kbb3flXDRe4dVk/kRKQMby/s9lmmX7+oP2fLtjwjf
 nOSMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Align the naming with the rest of our helpers exposed
outside of core vfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/security/credentials.rst                    | 2 +-
 Documentation/translations/zh_CN/security/credentials.rst | 2 +-
 fs/coredump.c                                             | 2 +-
 include/linux/coredump.h                                  | 4 ++--
 kernel/signal.c                                           | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
index 2aa0791bcefe..d0191c8b8060 100644
--- a/Documentation/security/credentials.rst
+++ b/Documentation/security/credentials.rst
@@ -555,5 +555,5 @@ the VFS, and that can be done by calling into such as ``vfs_mkdir()`` with a
 different set of credentials.  This is done in the following places:
 
  * ``sys_faccessat()``.
- * ``do_coredump()``.
+ * ``vfs_coredump()``.
  * nfs4recover.c.
diff --git a/Documentation/translations/zh_CN/security/credentials.rst b/Documentation/translations/zh_CN/security/credentials.rst
index 91c353dfb622..88fcd9152ffe 100644
--- a/Documentation/translations/zh_CN/security/credentials.rst
+++ b/Documentation/translations/zh_CN/security/credentials.rst
@@ -475,5 +475,5 @@ const指针上操作，因此不需要进行类型转换，但需要临时放弃
 如 ``vfs_mkdir()`` 来实现。以下是一些进行此操作的位置:
 
  * ``sys_faccessat()``.
- * ``do_coredump()``.
+ * ``vfs_coredump()``.
  * nfs4recover.c.
diff --git a/fs/coredump.c b/fs/coredump.c
index 52efd1b34261..8a401eeee940 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -865,7 +865,7 @@ static inline void coredump_sock_wait(struct file *file) { }
 static inline void coredump_sock_shutdown(struct file *file) { }
 #endif
 
-void do_coredump(const kernel_siginfo_t *siginfo)
+void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
 	struct core_name cn;
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 76e41805b92d..96e8a66da133 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -43,7 +43,7 @@ extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
 extern int dump_align(struct coredump_params *cprm, int align);
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len);
-extern void do_coredump(const kernel_siginfo_t *siginfo);
+extern void vfs_coredump(const kernel_siginfo_t *siginfo);
 
 /*
  * Logging for the coredump code, ratelimited.
@@ -63,7 +63,7 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
 #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
 
 #else
-static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
+static inline void vfs_coredump(const kernel_siginfo_t *siginfo) {}
 
 #define coredump_report(...)
 #define coredump_report_failure(...)
diff --git a/kernel/signal.c b/kernel/signal.c
index 148082db9a55..e2c928de7d2c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3016,7 +3016,7 @@ bool get_signal(struct ksignal *ksig)
 			 * first and our do_group_exit call below will use
 			 * that value and ignore the one we pass it.
 			 */
-			do_coredump(&ksig->info);
+			vfs_coredump(&ksig->info);
 		}
 
 		/*

-- 
2.47.2


