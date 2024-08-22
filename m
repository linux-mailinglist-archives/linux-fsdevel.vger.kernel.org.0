Return-Path: <linux-fsdevel+bounces-26615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263BC95A9BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48978288832
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA791BC46;
	Thu, 22 Aug 2024 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivuKgD4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C5AD31;
	Thu, 22 Aug 2024 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289562; cv=none; b=Id2hXCKg6pWs4cWM6RJqncw4H7M2ZQMfrjPBQV7Dc+tAn6COfF+O4RU5RdaYBw68wQORF0KKqmZ71db4DhnyzGAMcs264nhd7f9CNrWUvZ/RzCDCyGRQMM7ZgPcm+4NGXxMuqkyO2Ta2RNZgVEQ+3w8RvhP+PS3fFDLE05k0Jts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289562; c=relaxed/simple;
	bh=sM6ARMSzs2g0dbHkgGbbEwKAjUQqEhC4Xbb3feAOKmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sn+X8e6m8FJgQKzzLYfgFSCddVzeRWSn8FTmax1x3bw0JKn5aoiAXp/zUe8W2nMQ4oXEW7nSqk5J3NUclG6Pz0tPb/RaFB7cnL4mmiqN8qmALIlryyYLUOme/LWmNOlv9QePIJVf+rLfT1F546mJ7qe4gygV7QiA1kMCeytJQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivuKgD4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48B0C32781;
	Thu, 22 Aug 2024 01:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289561;
	bh=sM6ARMSzs2g0dbHkgGbbEwKAjUQqEhC4Xbb3feAOKmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ivuKgD4on+C7+YhBbtby4IvVq0RxF5/bBnr2MIUKiL3RfsjHRaLfUWjrd/hoOkypi
	 e5oVdrksEIE09GHZZ1grqgllXSGlEDPePmVsU7M80fXrCJvMLa+IOAqlM1+qRPyefT
	 NDUMeFDAHPBoXvktlWhOxdzO2rdFQlY178qnfUC3rm4Z+F/Utr6VLItE1zn9NpiWjM
	 tyFC+TuvGcYhcMAJweOwV0VqEtP1ItN5OzDAcmWealbnPLZYZTVCmu5TDgUX36j+xm
	 hBL+YaIBVHz4YB32atTfhUVZDEps5Lz+5jhEsIfqxzoZtgyLuLZph2EmpqaRb2tecw
	 P/DJmri42EczA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:19 +0100
Subject: [PATCH v11 16/39] arm64/idreg: Add overrride for GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-16-41b81947ecb5@kernel.org>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
In-Reply-To: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sM6ARMSzs2g0dbHkgGbbEwKAjUQqEhC4Xbb3feAOKmM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEwGtjAb+Lbq6W5IxNjQfUxybDiSmB4j0xd4UwH
 +MPuN7mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRMAAKCRAk1otyXVSH0OdpCA
 CEOwzdvcro2Y/zsVAkDS1Gh8cqiwIlyIDREbBn+Y1Fsz928BKFuNCbEKy7zALRTxwtRrlYxNM9ZJl8
 v6kBCKRDXGCRs98LRzPScxPU+FhtqEHbzd58yzE/ITWCObVM3dIfqSk1nd5rqSljitoRrI5Kx1XQYV
 reoDx/QxEVXfbj+YAbA297F3QOBTCghWQDCw4v4wkEH9Z7B/dOGjQVjJmxl9Wejbw9+9iT0x0PJDnN
 SwIXivwFaJ7YaXO7TSqvUYuVOOn7lmltxhmeimqnTp36IqnALj79krb8UmEeBQbeBn5DHxK5DgJzy6
 WY4Wviz9IEqS1ZQnNP7EKG/eX+Mm1s
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


