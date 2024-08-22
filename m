Return-Path: <linux-fsdevel+bounces-26627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973295A9F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C521F21980
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36CD43165;
	Thu, 22 Aug 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2jJ8j7y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B613B285;
	Thu, 22 Aug 2024 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289708; cv=none; b=EiVOfAeNjHGNNYmCdsGQlLslQANLhyBpxn77y/8A52kkDaodOh01nHdhm4EzeyTjE6vTU0O+9kyUD0gJKmurh8xJ465+tQhmlQF8gUP/nEEdOl3Xm4Gn39vAZWVcNP4E6gNu2GWPS/Tx30BNgI9P7eBy4MybSljUGWSteYGdcSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289708; c=relaxed/simple;
	bh=oHs0edHK2ZH//P9wlXUiorha791DOO+hA3lq1vKIHRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUMea3n4ivnUPe3l/UCekNmSVTtFQ+dsrIi3U6yE0P5+y8DoDjWZbN+jQr1U4dVR6/hgwMDmalEskBc18L9VGdJDDwxrydVKujXlsOdv4grRqLBs5uT/3qvnPQ31waoNmfI2Fhhria2tdTB6dXmZIreJp+H3v9Ov/RUluOQBejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2jJ8j7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C90C4AF10;
	Thu, 22 Aug 2024 01:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289707;
	bh=oHs0edHK2ZH//P9wlXUiorha791DOO+hA3lq1vKIHRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i2jJ8j7yO5ZxaxcgqkfrVoOX1ioF/kpI7DKJFezNvjCQnlVOinULY8Zjak9ELFf9g
	 7+6uhM3r3wLXETAStuORju7Yf7rkffQS5BOOAlApFwtSO1KPWev4UPd1mHu5oh8PFU
	 JubPSf9+gWhnfejdO34HXSUwzypCNvnm3sjNO/xtiB6WzkLhfFGXOIWaWYvVQ4zjNV
	 ZD3s9WFpYW/F1nxM7G4JOt/B015t+ByXRQgyifr92N8KVuDLjFzhkn60I66kqPUy8D
	 jIhqv+traJMxxpKdDso4fEgQBnhI9PsrSymhZA0wP7gyuPUkZ4ALZSO4Yi/uEpm8Ds
	 kvvnZvB7c8HpQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:31 +0100
Subject: [PATCH v11 28/39] kselftest/arm64: Verify the GCS hwcap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-28-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oHs0edHK2ZH//P9wlXUiorha791DOO+hA3lq1vKIHRU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpE5VVU3mpFKJ3hhjwa1thDydHnqMetxvpjvhVp+
 8HDjHUmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaROQAKCRAk1otyXVSH0AsLB/
 9E1Fcy2IXhvd/JhwhLRd+hrphvNVZfzJt505FwMtQNrnZzVixBvseWV9X6QlBFErh6ouCP81vIrMCq
 t2rSdIK/pY1jXzvzGra8yMdPJynAThpNy0Iz8l8hiyQrFOZR2cR7LkWqS4r7PwaBUdZlwXy165+Kqq
 1VJIDF3fOjOgWpZ/UVwApLw+/dJIZhKvZtrCUrndbg0vD6sUyQuW/OD6q4MkHZeyxMoDCJK1wOhtJl
 tJ/3fzsjZ6SivGFUbnlwr+8gmS5VtzX6PUNQwOmZh3tcaaCuSIUt+4UP5lYhIOJl8gQ4EbSff1Qzj+
 rqDAauZOO0JhY7bXmhQBlbkhQv7v/a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage of the GCS hwcap to the hwcap selftest, using a read of
GCSPR_EL0 to generate SIGILL without having to worry about enabling GCS.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index d8909b2b535a..dc54ae894fe5 100644
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
@@ -528,6 +539,14 @@ static const struct hwcap_data {
 		.sigill_fn = fpmr_sigill,
 		.sigill_reliable = true,
 	},
+	{
+		.name = "GCS",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_GCS,
+		.cpuinfo = "gcs",
+		.sigill_fn = gcs_sigill,
+		.sigill_reliable = true,
+	},
 	{
 		.name = "JSCVT",
 		.at_hwcap = AT_HWCAP,

-- 
2.39.2


