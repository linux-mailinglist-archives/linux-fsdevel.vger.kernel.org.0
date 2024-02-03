Return-Path: <linux-fsdevel+bounces-10160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E088485C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7781C21253
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58AC67C42;
	Sat,  3 Feb 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBzqHFbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD45EE84;
	Sat,  3 Feb 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963483; cv=none; b=nxeHi3KZbbUfDZWx6jFFNEtRw7FFTtoXaDSUH6MJWL76Hunyyu1l60e1HjCObiHCov6FOAW5mKPGR4xzqpIAbYH/7wO85lu5iadec5UD5OGk2a8yFmkZI7PLxHhL4lAKaUIDSyyVpm5cTxoThU5flFLJdAG+l1KbehPUU7AAAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963483; c=relaxed/simple;
	bh=SOryHjVIlgZ1JzHo1eglrB3GwKsbU4uOkVzAaVwK36o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTlFhRwWGdIjlnKHeD1KGcJr+E0MHLPqBnqJ/YaoLrTdkYKVgKxEWYbEmBEhiF2Fsf7XV3WPzzJD/Mho2fk1+hf915dvvVfL8P/4KYEXewuUoR81KVSHDHfV/iwWEBUUP1dt0LIQqkBHtjeyDoNJPFN7LYNwiLef0xKNBfMfF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBzqHFbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76763C43390;
	Sat,  3 Feb 2024 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963482;
	bh=SOryHjVIlgZ1JzHo1eglrB3GwKsbU4uOkVzAaVwK36o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LBzqHFbZSf4IojU2mYT5PdaKo3RqZ98lYCkCpHUmMGBQDlnrFqzgAhvm4yy4Osh/Z
	 2w/dLtyyR32j82cfU949TKIjVFY1mh3yO/UlyinHvXR9RRq/Dh/Yu+XcdUm6xEyULV
	 nllxHfO8Qun8oyPC60Q9rsJxl3U2/bYfqvpxHw6BCY8xTnFq4xbK5LAwuvogYh4yGk
	 au6CEmtQnhy/hpMlH6HjeylGql3e8pc9Ykdofk51Qi4ErIfq34VjGKV2TS270WI7d8
	 seMs+Q+/7N8R3iBTtgfjWVQqWMUhe3lRcMt3vbptXdF8k2l2aLntzUhJZbp7P1SYna
	 vu3XsnNmYM4cw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:41 +0000
Subject: [PATCH v8 15/38] arm64/idreg: Add overrride for GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-15-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SOryHjVIlgZ1JzHo1eglrB3GwKsbU4uOkVzAaVwK36o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDclBuniik/q4u/ervUzd+okMuWp5AjhSh39Lb9
 9Xsh3cmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w3AAKCRAk1otyXVSH0F5OB/
 4uqaKGanf69ot/yRkqmGZUZo+A1IPA+Hp6Hzc0E9LVUH+wkMK3HYompmNM4Gv59SoAyj0VHtXefAxY
 l2iQ/eNIjwYSbUBBMqUWCm95kwlHsnTjYGNRmOLBda027Hz3zGNo3cmmISaIWI+GCt4oCRUEX/0E/n
 TXPNIEy5QwDu+ZJxJ/22TMNVaWHl5P+fzxzp/BA00Gd3gWgLa2KlkNOihJ2gRLwsQMybU/O17hTzqL
 r0eLU4D++pmUwwqO+75ravav8mrgjy5ZQlEPZtpl7ym5vzIdSFxOOq+NlrU5H0uNRv95hz4w7R4hDP
 3zt3co1Euu5EtzjSu+2Ham+nO8Av6o
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Hook up an override for GCS, allowing it to be disabled from the command
line by specifying arm64.nogcs in case there are problems.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 arch/arm64/kernel/idreg-override.c              | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..e86160251d23 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -429,9 +429,15 @@
 	arm64.nobti	[ARM64] Unconditionally disable Branch Target
 			Identification support
 
+	arm64.nogcs	[ARM64] Unconditionally disable Guarded Control Stack
+			support
+
 	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
 			Set instructions support
 
+	arm64.nopauth	[ARM64] Unconditionally disable Pointer Authentication
+			support
+
 	arm64.nomte	[ARM64] Unconditionally disable Memory Tagging Extension
 			support
 
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index e30fd9e32ef3..00bcdad53ba9 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -110,6 +110,7 @@ static const struct ftr_set_desc pfr1 __prel64_initconst = {
 	.override	= &id_aa64pfr1_override,
 	.fields		= {
 		FIELD("bt", ID_AA64PFR1_EL1_BT_SHIFT, NULL ),
+		FIELD("gcs", ID_AA64PFR1_EL1_GCS_SHIFT, NULL),
 		FIELD("mte", ID_AA64PFR1_EL1_MTE_SHIFT, NULL),
 		FIELD("sme", ID_AA64PFR1_EL1_SME_SHIFT, pfr1_sme_filter),
 		{}
@@ -190,6 +191,7 @@ static const struct {
 	{ "arm64.nosve",		"id_aa64pfr0.sve=0" },
 	{ "arm64.nosme",		"id_aa64pfr1.sme=0" },
 	{ "arm64.nobti",		"id_aa64pfr1.bt=0" },
+	{ "arm64.nogcs",		"id_aa64pfr1.gcs=0" },
 	{ "arm64.nopauth",
 	  "id_aa64isar1.gpi=0 id_aa64isar1.gpa=0 "
 	  "id_aa64isar1.api=0 id_aa64isar1.apa=0 "

-- 
2.30.2


