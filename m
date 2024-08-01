Return-Path: <linux-fsdevel+bounces-24764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEB1944C2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3291C2603A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5348C1A99F3;
	Thu,  1 Aug 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsWmVmR9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999AE1A3BAC;
	Thu,  1 Aug 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517142; cv=none; b=lLe9zwWMtceJk9+RWVVGM5wVnt1e1NKAQcNYDoBbJm3ol2E4ESLXzW/9xWjhkThaVXKhhbB2iTa5q9znJ0kOtMy/m2XWkljq2KwG4c3AeR4gtGiCU/0UPi4bhy6efPh1QC252oc8ZieIzZPgFUtIVvVzyc9lqOVHgQ5NdattE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517142; c=relaxed/simple;
	bh=sqqkmEeL7tv5Wag3oPKgOfTAFLsGU8mgkKcr3MnXRIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogNeK2kcATN7jYIfap9kwDQxin9VXXVbw1LFcrrFbmOx6sjQ5cTD8mIKxytveUGoiF6d5o5a4Ka8RY9QCmC6BbmDdJObCXLPsp0ikFas+3alI6uSqUCGtE6wTf2phjLpkMd48GHJzfZ/lZoLjaIQlznezhbAmBXgoOzaV/AY6XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsWmVmR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1867CC4AF10;
	Thu,  1 Aug 2024 12:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517142;
	bh=sqqkmEeL7tv5Wag3oPKgOfTAFLsGU8mgkKcr3MnXRIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lsWmVmR9E2WgjWn+RgLL3PyZr6vGUhI7FHJzl1VUx+yXtAGp0+vgrsnRfEzxQPGF8
	 JEge+ccT2xkgSqTTKc43BQibLAN2Ff4RkJ4PJoSfiiHq36EdVEfRfqOICFTDHlyr8x
	 GcgGDskfrMLd5JenB5QNSNHYQDdI7ih7Buhel8JcvWw7f6aINoluBytmA5D0QRg93r
	 M4g7QjLRiu/6424aiBNTfRGzdx1eRsiBF6rKOsqNcy6Q0Pje228gBVVj5rtCSH76mR
	 etppI/EaBZzCpoQY+V/GiPYFFQi1152aNx0npfmoX6t233KMZBi0w0WeQw939JZ31j
	 Qp0K++dBcU8nA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:42 +0100
Subject: [PATCH v10 15/40] arm64/idreg: Add overrride for GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-15-699e2bd2190b@kernel.org>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
In-Reply-To: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sqqkmEeL7tv5Wag3oPKgOfTAFLsGU8mgkKcr3MnXRIM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YRVVwOZRbiJRdOh866tHwB9fWzGXz1GHzjC2YM
 YZxFiIaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGEQAKCRAk1otyXVSH0Ct1B/
 4i8fM2n38TeqWSOYLe9SGZf9V0EGaItvppKspC2O9Iz6LH2Ki3Uhm1aT8Y/219upgO0Pj+lApVwGQW
 NJoYZbJheeyUYExsZxy/tPp8NHS5vzITfA2Uauqqqc+Le+nX15+BzBtpIlqEe7FaW868OZNMz7+cUE
 NY5EGIt/Rkcvg5lO6Zh5mhBk+ERk9BTebzF7n2p4U6EdNmoBKBDo0Dc99B9jLdaalcDyZomv2B9i4f
 cUzrB3doruk6EOc7m8qoe84G8yflvsOjTcQ4weBKJmDitZfwE3twjnQBhTvlIrzzN2Ne4Xg4t040jI
 8Txlbbf0NgH23Nmed0MqnbBcOo6gIH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Hook up an override for GCS, allowing it to be disabled from the command
line by specifying arm64.nogcs in case there are problems.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/pi/idreg-override.c           | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1384c7b59c9..3006c1bd1af0 100644
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


