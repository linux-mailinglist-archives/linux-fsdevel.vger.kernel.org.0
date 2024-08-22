Return-Path: <linux-fsdevel+bounces-26638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D516895AA31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BC91F214AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164BA200AE;
	Thu, 22 Aug 2024 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEBEIs5j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582536B11;
	Thu, 22 Aug 2024 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289844; cv=none; b=oFnsEIGeHhiqqqkNeCDRyR0eT2+pQIsPkfCN0xrtfXByWrklNdqT63wLl8eqsCFgLKNm5Wq9EQigg3c6LpXRN49qqS57r3BlX59ti6A6eLtYcoQ14UqoYy63Aa4Smu4U0mP0nMNONb/QOGIxlvo9GdbkeYl9o7pMGy/OaPXerO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289844; c=relaxed/simple;
	bh=W5oN69xYg0RDvkVAq7OBhN9me4eHC7ENTR8wdYTObEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cLM05Qpn12w1dHTyyDzPWnb0P1CrLhNE7OXsbmLfun8ifjyhyVbIKd+4487W+LRZKcIvzEuWL5B6wcczPiveH9hswAmF5PEQCypTOwbgHKlAWmcMQQUPzFb94tYw0CdHxv3e6nFup/fLeHljjbLnUPNgpdNjVZSNeiMU4Kg4V3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEBEIs5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B08CC32781;
	Thu, 22 Aug 2024 01:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289844;
	bh=W5oN69xYg0RDvkVAq7OBhN9me4eHC7ENTR8wdYTObEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iEBEIs5j4ESOyOuAI+C1WdLslac5LfFf4kq+lkNdmDRnyIC5yWmiqWDSMJJspLip0
	 ml9uTFJFpjA0iZB8kpDqcRdUVrEAN3rgae1b0KWClRy/Dt5K3C0ScTk7Y4SWdSQ+0J
	 J9ynhy9+9DciCFx1xbPMettqUNcK0C/8oPiqZYnE2aLmN//nbDx9gRXLGbrz6FOC9N
	 QJZK6dQb2Eneww26LRoFWKUpXmLr8bA0krMzkGL40Umad43ef518YlBAcLdGrQ/xva
	 UmXJOYn+WGgW0hN/+th9qactP+9HaSOVf/vKYQVY8GyrjynJ7JP8i2m+nC2YGho1yB
	 C5cIrr/0/qsMQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:42 +0100
Subject: [PATCH v11 39/39] KVM: selftests: arm64: Add GCS registers to
 get-reg-list
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-39-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2418; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W5oN69xYg0RDvkVAq7OBhN9me4eHC7ENTR8wdYTObEg=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrRjE52aWuqWJvl43G370Cb14vXG7leGPtlWHj9eFSeamTBo
 X9LqZDRiYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAu0sP+veD2HY0mXtEA/3Nzfa4Jyf
 PZBDNMzlaYvXxd9UdPmQeKau5R/7pmxk1bVJ80KV7nZ/iJg4lH3l6T79aqUAtX1T7NdHV6wdU22f2z
 DoV6ifrOnBJdf1xGTvvHPIXgYzx+IXyfDnGuTNt9Jn1zzH2fmQqTrCclRJxxLr+9bOLp1XfPyQj6yc
 /iSVB6KvkueNHaLp8L5yP/BqR1nWaqPGK77aHK4sT4ptQ/SlOm5x6/HTXHf7th4Q1tZn217NVH7xju
 0hSU+cvxlVlNNSErf+uMqFO19qckeCd42zv9/LSrXmn+w9OaR+uVBaI+iD31MpvczNFmEhmVLF5/wT
 fTwpAtSN7+ZuDJ9Z9Es+4WMQIA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

GCS adds new registers GCSCR_EL1, GCSCRE0_EL1, GCSPR_EL1 and GCSPR_EL0. Add
these to those validated by get-reg-list.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 709d7d721760..9785f41e6042 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -29,6 +29,24 @@ static struct feature_id_reg feat_id_regs[] = {
 		0,
 		1
 	},
+	{
+		ARM64_SYS_REG(3, 0, 2, 5, 0),	/* GCSCR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		44,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 0, 2, 5, 1),	/* GCSPR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		44,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 0, 2, 5, 2),	/* GCSCRE0_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		44,
+		1
+	},
 	{
 		ARM64_SYS_REG(3, 0, 10, 2, 2),	/* PIRE0_EL1 */
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
@@ -40,6 +58,12 @@ static struct feature_id_reg feat_id_regs[] = {
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
 		4,
 		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 2, 5, 1),	/* GCSPR_EL0 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		44,
+		1
 	}
 };
 
@@ -460,6 +484,9 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 2, 0, 1),	/* TTBR1_EL1 */
 	ARM64_SYS_REG(3, 0, 2, 0, 2),	/* TCR_EL1 */
 	ARM64_SYS_REG(3, 0, 2, 0, 3),	/* TCR2_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 5, 0),	/* GCSCR_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 5, 1),	/* GCSPR_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 5, 2),	/* GCSCRE0_EL1 */
 	ARM64_SYS_REG(3, 0, 5, 1, 0),	/* AFSR0_EL1 */
 	ARM64_SYS_REG(3, 0, 5, 1, 1),	/* AFSR1_EL1 */
 	ARM64_SYS_REG(3, 0, 5, 2, 0),	/* ESR_EL1 */
@@ -475,6 +502,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 13, 0, 4),	/* TPIDR_EL1 */
 	ARM64_SYS_REG(3, 0, 14, 1, 0),	/* CNTKCTL_EL1 */
 	ARM64_SYS_REG(3, 2, 0, 0, 0),	/* CSSELR_EL1 */
+	ARM64_SYS_REG(3, 3, 2, 5, 1),	/* GCSPR_EL0 */
 	ARM64_SYS_REG(3, 3, 13, 0, 2),	/* TPIDR_EL0 */
 	ARM64_SYS_REG(3, 3, 13, 0, 3),	/* TPIDRRO_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 0, 1),	/* CNTPCT_EL0 */

-- 
2.39.2


