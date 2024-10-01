Return-Path: <linux-fsdevel+bounces-30602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2AF98C91A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF69C1C24184
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95ED2207A;
	Tue,  1 Oct 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJXPg19K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A21CF7CE;
	Tue,  1 Oct 2024 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823922; cv=none; b=NziIi2JSo06/DVNoKA6f8Grl/K3ig402TFAbWm8wpKcIppG/k3czNRO5+s/NvklildKjJEdiAykKifliOegPkX8uWdboGLidsifBcwRKSqq2iSILcKCp8HWerxJoDqO9XmAAszotVfxAdMIDoWA1tLKNhjv4dqXpX6ERhDSg4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823922; c=relaxed/simple;
	bh=GLmI6hHYoj5JZxZG0yzjYcX6pFmL0ulwYTdiG1C9KyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAW98zZT/vTuHmzlY6hboqIU0C86BsNdd2G/uwT9numD+SxA5Ho3DaTSKciX8MIUbCxLMJYwiToVGUdBX2UUB3E6g/LcpbkQoHpjLMqiF9Pj3TR5ZkqBwE0Ybliz6uzG+hCI2bTUSYCuD4WHzb4Fv43GkdGjrPKMFht7pe3+9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJXPg19K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAA8C4CECD;
	Tue,  1 Oct 2024 23:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823921;
	bh=GLmI6hHYoj5JZxZG0yzjYcX6pFmL0ulwYTdiG1C9KyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uJXPg19KQ4tuAtY+0FftA0aaVagRDKUP20/lvTlKZqQNQbewcQSTrzzRjoEKtm7nC
	 n2gnfGJgNbPJyhuX549Sf61XlHumAKixbFpVzyS0gAlTSOu2rOnV1rMKQCIr0OtWJd
	 I1AK5W+WInFWvg2NnDZUXd1vn4u/Dsgt+pJ/0MjdgWn+6w7MuOpry4WuIcg7X/n2yE
	 YQdkhFe/WEsOi4KYSlH3gv7VkD5L4j+ugX1LlJl/z65lw6o99jyLOVA/XqHs+nYczF
	 V7AZSwEA8Q+34VDDyEn/3lQnLrPQ6NzYFY6CrlnYSTnKIpVdC21YseK5tgwYCXHyWY
	 yRYWEbR10J9qQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:08 +0100
Subject: [PATCH v13 29/40] kselftest/arm64: Verify the GCS hwcap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-29-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GLmI6hHYoj5JZxZG0yzjYcX6pFmL0ulwYTdiG1C9KyE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7aBg3m0n8js+N3r2y9s0x83zZGeJav6qRQG+DB
 SlM8+uyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+2gAKCRAk1otyXVSH0N8jB/
 9NrJV4u3pB6B+x7xy0q+Ych1nU+TZ7sIKyruiwgrncB9J5+7CklyjjjmcPn3gOVQEtoA+/W9aZ4lEZ
 NN4iZrw584yNtE+jBySXR0AMtH/u8xnbsfg7FJ9I0Cj5hS/wV7mYGSJhslLHzjeZZ5pOKEI3ZktG0f
 rH7Ob41i25UTAnvjwOautvPOk+SBOSZU6l7PcfCJteHFeR+WWAq4qJu+Hf9SLx6YXmk3DvKSlJbLp+
 2UcwdwWpPxRIlDKjTI0I4B5yTh6lvfjpP3yw9D6OkVVwcJPuOZdwL+tuHc9v9FubA3/dyFTCAqvs8a
 VimlYJHj8X/waleY1JeJKtP3jXoEnJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage of the GCS hwcap to the hwcap selftest, using a read of
GCSPR_EL0 to generate SIGILL without having to worry about enabling GCS.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index f2d6007a2b98..1f07772ae578 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -98,6 +98,17 @@ static void fpmr_sigill(void)
 	asm volatile("mrs x0, S3_3_C4_C4_2" : : : "x0");
 }
 
+static void gcs_sigill(void)
+{
+	unsigned long *gcspr;
+
+	asm volatile(
+		"mrs	%0, S3_3_C2_C5_1"
+	: "=r" (gcspr)
+	:
+	: "cc");
+}
+
 static void ilrcpc_sigill(void)
 {
 	/* LDAPUR W0, [SP, #8] */
@@ -534,6 +545,14 @@ static const struct hwcap_data {
 		.sigill_fn = fpmr_sigill,
 		.sigill_reliable = true,
 	},
+	{
+		.name = "GCS",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_GCS,
+		.cpuinfo = "gcs",
+		.sigill_fn = gcs_sigill,
+		.sigill_reliable = true,
+	},
 	{
 		.name = "JSCVT",
 		.at_hwcap = AT_HWCAP,

-- 
2.39.2


