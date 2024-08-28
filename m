Return-Path: <linux-fsdevel+bounces-27702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2E9963632
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A81C24015
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F191BA873;
	Wed, 28 Aug 2024 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0sYEOxH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531411B3753;
	Wed, 28 Aug 2024 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888001; cv=none; b=eG2L/ILcc0KS/5Vw32krbseolRx0++pmnjhryEySi3a6TMXuEQRStrWScVb7/VC9rIqGUv+MW7ppjfi90hZDsQSVNchhAbvabP0nnv0clj5DxXp3gwhjhVeSqFI6BxXNpJrA/1t7nsTriTOwV8n3oPcaG43HHjGK4ll1DXxTUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888001; c=relaxed/simple;
	bh=W5oN69xYg0RDvkVAq7OBhN9me4eHC7ENTR8wdYTObEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grovtN906gy/yMAL30ZdhkDqTHYet6AbROAYoxAZIMqFBDxKQK56B4/qop1VYCKHlpeegr3hLtucRM/YPfFysmlnhZExI0x5GtcINxnxXMOIM4oipf8K3ogRz8msZqE6YRQhKNtTmF05/VpcA+CYoGHgvCrH5zNNiOC45OLoc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0sYEOxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D82C4CEC4;
	Wed, 28 Aug 2024 23:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724888001;
	bh=W5oN69xYg0RDvkVAq7OBhN9me4eHC7ENTR8wdYTObEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T0sYEOxHjFOttsTVvHr8nAQOQ8BUsl9RMPHqa31RJTgSFSQ3TIGLapA1WgRy3jLo0
	 JeODpovNuVdL80WVrYGVso4DyrRRO1DhF7kWisH1cqnFSCydDl13yVhb0nu6HT2C9z
	 pD4UgF4Dwo5Y9nuYKXJogdufMhh4W7BZO62+McXl5vR8L6zMt1WUITjQLRzWcA7u25
	 SPgM+2tb0JJ+WBn06AztAPJ7FrM5sNRzveVcG0IubW9dGdUc/PlsWeypUq2fHpf0Gp
	 pQfD/DxG1p/Tg1tfKVfxa1CicV/MXc1Phv0Iyv5PVg3YGY/+kSdolqCbHw0513h6ea
	 haeI2WZc6MlWg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:55 +0100
Subject: [PATCH v12 39/39] KVM: selftests: arm64: Add GCS registers to
 get-reg-list
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-39-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2418; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W5oN69xYg0RDvkVAq7OBhN9me4eHC7ENTR8wdYTObEg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KW23WvfTKbuTefeFx8re+CMzCUi4CC3I85X0Hw
 F+Tp6t6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+ylgAKCRAk1otyXVSH0AynB/
 4zJS/fNzXaknnr7WJBxyXZVPJNEDNBY8rJlOhiRC7JR4N1wpHshMVJS7B5HyeOhJWMAuD3mR2CrV1d
 r4v28SEGzfR4d+ILf+hgZkeIgrDji+0MV4VUdT+tsjQyzfTjj8tJ3F2CqTPAP3N3Uny4OsuqLSWzBp
 hlN40ZxT2iqDEbKvGfaT1sz62nwxmh3r34dtmQBwKzh0I3Y2nYIK5zGYUsoMINt5Gtov3e79ziMDIT
 AOI9DcGFA7X0dQUOWVXPLJxkZnXLGhBCT60jSVl0d8qabxjn+iAigD30fNz+DZi1Y79Ar5nZoztoG7
 adadSZsjbnTs20zCvlACDXAlp/hVa5
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


