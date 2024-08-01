Return-Path: <linux-fsdevel+bounces-24779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC6944C7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C11B1F212EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E671A08AD;
	Thu,  1 Aug 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaeczFSW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283A1A2C25;
	Thu,  1 Aug 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517250; cv=none; b=CePY9cgcxQKRZ+k9djRid+MUFIiusCDqlEgbnI043lHGUaOg/KT74A3W3yEm1UAfgoUn76yOsMY1n5RB8d10TN+B4iq6nvCYWrVBrLPSeGYz1PI0ZDHvODmXstJpBnvXmQqjCXjUN3h/X9VueTiRgs8m6G321BeX4chG+FWr0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517250; c=relaxed/simple;
	bh=daws7+gY8b6XFlV57O+J5ZaQ5dAS4S0GI4Vh7sgzmHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Njm6tr9QHmlcaOR+zAz6n4Mh1VP0JUnnCfzvpmaUTx20tmExb3i2DOg6ucPyYBfzm2/+V/wtrYkjtpxQTrLqPtzlkJ7saF7qogE1I9AYxcASr0L7wMNNPbhiBmwvQJm0GWRQG06MWrHX/OhsizrtmgM1PQvXWYdcqfbffRZTcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaeczFSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9507C32786;
	Thu,  1 Aug 2024 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517250;
	bh=daws7+gY8b6XFlV57O+J5ZaQ5dAS4S0GI4Vh7sgzmHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YaeczFSW/0sQVi4Y5MZxG0vXvCbqJ3B5xzzE5AP9dTzYvhAzl/vQ3+MYM6uYprAOe
	 70sA7AYgAVjQD2r6xVtm2I+QdnfpYpgb38IG0UvMK88+S9If+ArSDMipaZa139A8Aa
	 amnSXsdY0QAmRVZRHyUaLz9RHZvhUZEBoD1RNXnhXsJM/Oh5kw5Ir48Lb5Uc+P48GC
	 L1EMrJ1FWOTRIyygtumExRrL5WQTM+hzMyVys/ZrDZ/E5Yx1aFTNNf4YfF085NmlYT
	 7xGguAyHeqD58lUBuw4xsj6qRJLzqe34cjOTUlZlt3PSgLpNFkepoD/v9BoZcVi5hn
	 GMKYDblaFYphA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:57 +0100
Subject: [PATCH v10 30/40] kselftest/arm64: Add GCS as a detected feature
 in the signal tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-30-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=broonie@kernel.org;
 h=from:subject:message-id; bh=daws7+gY8b6XFlV57O+J5ZaQ5dAS4S0GI4Vh7sgzmHk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4Yd/AayJpdDJb2tH+bu+tocCjvDaVO7v9RFDWZu
 YTIKLIeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGHQAKCRAk1otyXVSH0Ji6B/
 49n/gPVSOC0zUdOFsKaXyNbeJnnjaeAF6Gi0yO/OvRf6VhmA1x9nevcrHxGpv9DmgkfvS1ypLr5tnA
 i4w0As1xKtNtyuW7oYQecE0S2I8n9mVnIQt+N5kfwKwsHQr+n/GJCNd29oNl4QZIEeFqOVYeu/6a0b
 HB/wcdBizcnOfVCSchCJZPMPOyeBHkP5+q+4FiTIPtAddvi9WiYoYv1IDkYLyarNhgHtFWHNEl0MhV
 UiHVNfUn0FsTrxnnEaml6vKI7WrzvQKeELLE4SHw6rHgudllTAtV1UffSDB5Kuidf6INcLHWx0iECg
 FQCqn39dvgOsLwpZxr5jqd2j64PGrJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for testing GCS related signal handling add it as a feature
we check for in the signal handling support code.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/test_signals.h       | 2 ++
 tools/testing/selftests/arm64/signal/test_signals_utils.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index 1e6273d81575..7ada43688c02 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -35,6 +35,7 @@ enum {
 	FSME_BIT,
 	FSME_FA64_BIT,
 	FSME2_BIT,
+	FGCS_BIT,
 	FMAX_END
 };
 
@@ -43,6 +44,7 @@ enum {
 #define FEAT_SME		(1UL << FSME_BIT)
 #define FEAT_SME_FA64		(1UL << FSME_FA64_BIT)
 #define FEAT_SME2		(1UL << FSME2_BIT)
+#define FEAT_GCS		(1UL << FGCS_BIT)
 
 /*
  * A descriptor used to describe and configure a test case.
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 0dc948db3a4a..89ef95c1af0e 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -30,6 +30,7 @@ static char const *const feats_names[FMAX_END] = {
 	" SME ",
 	" FA64 ",
 	" SME2 ",
+	" GCS ",
 };
 
 #define MAX_FEATS_SZ	128
@@ -329,6 +330,8 @@ int test_init(struct tdescr *td)
 			td->feats_supported |= FEAT_SME_FA64;
 		if (getauxval(AT_HWCAP2) & HWCAP2_SME2)
 			td->feats_supported |= FEAT_SME2;
+		if (getauxval(AT_HWCAP2) & HWCAP2_GCS)
+			td->feats_supported |= FEAT_GCS;
 		if (feats_ok(td)) {
 			if (td->feats_required & td->feats_supported)
 				fprintf(stderr,

-- 
2.39.2


