Return-Path: <linux-fsdevel+bounces-27679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB9C9635BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740C51F21719
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671661B3F29;
	Wed, 28 Aug 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIbQQA5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38291ABECB;
	Wed, 28 Aug 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887830; cv=none; b=uFksgH8Jw0ITsHiJMZnX7F9vXWBOEBJ13HWJuRCz3oRfc3sgD1hDpytjXpo84cikxVdWaeuz6tMr9RA8qBck9poH9HC6+muerNbn8DV6dYPpVN1Bee+979NS6AxKa78fi/dmqiHq9EYgntgg0fiByfFTiqe66YGNBh9SWOn2pIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887830; c=relaxed/simple;
	bh=wjYe9ivwzmH2HU5Bu/krsN+hRENYTgl1ATQJfRBTR9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKCuF75+DD8FlRi8LjQrMYoNqdUaMf4RF11mNIdp5LAhNv9mSSE1/AsN2qo72+ysz8V2six8QX0aE/YCJrb1MHckKwc7F+HcMamY6bEm9i3d+QCAc3O3KdAFwDdrAvIF3NeB/dodugHxi77y4lqM7HCk3rylYBE1lUjHkMaA1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIbQQA5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F90C4CEC0;
	Wed, 28 Aug 2024 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887830;
	bh=wjYe9ivwzmH2HU5Bu/krsN+hRENYTgl1ATQJfRBTR9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lIbQQA5yebhqqE70nAuqgNR3tkh/f6rCrVtESiHZp3rzWZDkpq3TMxRtFLJisJc1C
	 k6syrHZlg6DrCc8Kvoj9sUEy6VMLQxh3OceDdWlqMvMCkWUD7d982XWSa+OdUKB5ph
	 fo+PchcSBoAEfB2IV7/rwPqOZNO0NGwQDZesbLUksruMraMqOYSnj+4h2qRlstYDiY
	 JKAH2z9UL1KiSR/Cm+TDjnG2GJFsfLSQ0Lc8OzLdkf+5Gtb52gCQF+mMwJglnD0hoo
	 ucodW81ooVhwrTweu90KLRFMCJaY2t/RWXgFbuFVDhg1GgbqC3wMbr5+fnT8TvTJQf
	 TWBIiD9D8gnwQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:32 +0100
Subject: [PATCH v12 16/39] arm64/idreg: Add overrride for GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-16-42fec947436a@kernel.org>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
In-Reply-To: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wjYe9ivwzmH2HU5Bu/krsN+hRENYTgl1ATQJfRBTR9I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KFAReHbuS7RCcLtps3x4CwuXAzGuonS9h0Xm8V
 n2UpW62JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yhQAKCRAk1otyXVSH0KO9B/
 9/OcoGpxSpHi/K8N7HKdwcDjo5X0BCdJlr1zjFK6/Mc0oZ7PGJDmIQFdUqBaGdjfltp6Rwmt4m7RZ+
 9F8TvVKqgOkl2sPrIUZ69dfurycmVlEC+1l6FOrv52pOxuegJf/x/bkpQMRN48IJN4OxdmB2AsxWpt
 5S8vVLmYFF+kWZ7YBF7R1m4n5Ui67OpPO52vXgtVJfoZ+XvmKvVChxUzTWZSjHLOY46+WVKOGb74a1
 BN1pGHzu4cCCWTuG76JTbxEiK3PS51OmZPqnaXiGZTJaJDfd9k+wa2I/7UGGyXb1S6wndNiTyZvHqq
 i4rZ0mp4l/YuxFW0rfR7UbAsU3IVzO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Hook up an override for GCS, allowing it to be disabled from the command
line by specifying arm64.nogcs in case there are problems.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/pi/idreg-override.c           | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..e6413bb8e6e1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -441,6 +441,9 @@
 	arm64.nobti	[ARM64] Unconditionally disable Branch Target
 			Identification support
 
+	arm64.nogcs	[ARM64] Unconditionally disable Guarded Control Stack
+			support
+
 	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
 			Set instructions support
 
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index 29d4b6244a6f..2bb709d78405 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -133,6 +133,7 @@ static const struct ftr_set_desc pfr1 __prel64_initconst = {
 	.override	= &id_aa64pfr1_override,
 	.fields		= {
 		FIELD("bt", ID_AA64PFR1_EL1_BT_SHIFT, NULL ),
+		FIELD("gcs", ID_AA64PFR1_EL1_GCS_SHIFT, NULL),
 		FIELD("mte", ID_AA64PFR1_EL1_MTE_SHIFT, NULL),
 		FIELD("sme", ID_AA64PFR1_EL1_SME_SHIFT, pfr1_sme_filter),
 		{}
@@ -215,6 +216,7 @@ static const struct {
 	{ "arm64.nosve",		"id_aa64pfr0.sve=0" },
 	{ "arm64.nosme",		"id_aa64pfr1.sme=0" },
 	{ "arm64.nobti",		"id_aa64pfr1.bt=0" },
+	{ "arm64.nogcs",		"id_aa64pfr1.gcs=0" },
 	{ "arm64.nopauth",
 	  "id_aa64isar1.gpi=0 id_aa64isar1.gpa=0 "
 	  "id_aa64isar1.api=0 id_aa64isar1.apa=0 "

-- 
2.39.2


