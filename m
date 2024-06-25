Return-Path: <linux-fsdevel+bounces-22398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D2E916C36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987E21C24DE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B21836DE;
	Tue, 25 Jun 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVcHIs3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F63178390;
	Tue, 25 Jun 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327834; cv=none; b=oKA4YQmQaPWEA57m6oVF9LHEwFw2O7oUA93BvzBSc94DI3YqHw0f8wDILAhOfnBBSf2PxY4QoRVGiEc/+vnzJkIG8As+NYwgLx91P4506sCKh1wPncZCqmGgu8/I14XJC+TNeOyt+tkMaoziVa/hlGYK39sc33ThmoQqZfVztis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327834; c=relaxed/simple;
	bh=oHs0edHK2ZH//P9wlXUiorha791DOO+hA3lq1vKIHRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAkDFGqz6sFVhZNfW9W0m75eg1OTQAz8Me7ViTDwYlYnyQ9XWRA0cuQsYABssRMRjx6aj3l2N7PLcra4parjIggujsk7pJGGWoPzVb/3ODf2coq9PaWsk2eBIIjzo8R65d/dXsw55dBSL1noxenOT6Bg9OxLVwHkXNF4SwTVcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVcHIs3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D40BC4AF0B;
	Tue, 25 Jun 2024 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327834;
	bh=oHs0edHK2ZH//P9wlXUiorha791DOO+hA3lq1vKIHRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RVcHIs3e0+1BTODXPOdXj48xTE6Ig2X77qbNnTIQRIsQ1F/J+hGQH3DoCpTsV74KQ
	 LP4Qq7EwvxhXEaHHjIjrYyUvTxzK77ehOh//lQv8X7OkWgdjstOMorkAbbx+KHNX8q
	 ROWqziyU952y0sO0yHkuO3MMdFFLczKsxuLA84f3p5kl05IXBvb14Owt3bAZqhg5ca
	 dmGd1AnNLQrvvSqMYd/hpvNjgpq3P6QwCOEIgl3e5F7U6Sgudc33b1GrSWb3pdJmGz
	 I2NzxVo+oIdHLb9gxBTnyjAvtRXZA9Ft3ss+7ArRfSNZRQDRf0jpb8Y1uP2KVUxvDI
	 epU+0l3m7Vx5w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:55 +0100
Subject: [PATCH v9 27/39] kselftest/arm64: Verify the GCS hwcap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-27-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
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
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oHs0edHK2ZH//P9wlXUiorha791DOO+hA3lq1vKIHRU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmetuHDmIv/1BR7AmyIP7TdZpBb0DyVJraa/k+giyf
 IMNNkZeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbhwAKCRAk1otyXVSH0GErB/
 9P0d2K2QWmEiq6MtR98YyQMB73y0NDVSTD0oL7snO1bVGdOgv3ptXZGHFRdCTsQEa39LCg09KHmEfQ
 uaxKzfCQgFpTtBTQ/V7TBQNmyNgv15eCxTBzb+bcJWTbQ69u7FmV9LUqaXf46j7gsK1RTSQPijNICB
 43+McjEr3BipgL91KboTE8OffZ1hik0Lp3s5RXWvYgyHnYuwzaYNfGWKaFHiNm+XhLMBsFUJFBBODe
 S6XKVjZpD6+x8cR3DNl+jf0H/VUNt9Mv+ekTdgAOwCMdnCWAN9wXJ2khka98U9PvPIJEglltn1BqE3
 D5k/13JN4yj/0zmk0jjehdcje46viA
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


