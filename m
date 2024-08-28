Return-Path: <linux-fsdevel+bounces-27692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B57963601
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79D91F22AA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20C11B81BF;
	Wed, 28 Aug 2024 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJ/mOv9K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72D1AE035;
	Wed, 28 Aug 2024 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887926; cv=none; b=gvvBSBMFs6jeq+tKl2K8NK8mYvkddkM2qR5WU8qqkvG5keKOiBO01JR6+2KS3ZAIraoVavzPpgQM4t8cmNeKhG7XBMhji+AaPsVAFskMDLoT6P8wYI01ZqpjDw1SxV2ysH7Zg0ReGjJ8fvEVp40voyZAJaEf8U/+9h7FB/x63KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887926; c=relaxed/simple;
	bh=daws7+gY8b6XFlV57O+J5ZaQ5dAS4S0GI4Vh7sgzmHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNp7PWD9M3C4tPh0xZDH5IBI02hXRAZlRrGlSy3VYf7cyHUQmjNb1HOv6gMauZyFOstyP57ZRzwQfq+oewPo0dvniS919GsiJ6dssh4rVF3msKwGlun9X32q5Kbky4JXMIAWLS6YGAcdvj0B7H7fedsCOme/wxczKPpHGk86AnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJ/mOv9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317C4C4CEC5;
	Wed, 28 Aug 2024 23:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887926;
	bh=daws7+gY8b6XFlV57O+J5ZaQ5dAS4S0GI4Vh7sgzmHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dJ/mOv9KyokVDXmrKaGF7gLW3dPjymJfn9vb85KHKRfDBxzmkwC9ADfonFPZ8smil
	 lVUMVMuUNhhbJ2NxXXFiIeiG0zG95/TuIBKwlFGx2wK+hcD7RRK/S7lFFHB1bLWYLJ
	 pIcw0wRbfkrBoTmDs3+yC+sYY08RX4IbXRpytuGpMalbpANP6nNmpiUZcRqBAVbKD4
	 I/8UGpU799FHgqw4qxWC6NDxnjPQCuGK99PHHFd+8s57C/va7Ua/t+i8aKywtq2BoP
	 HasJA19H5ZfYEKlcC98VNm6g9mtHJCdXm+ny1GTBPZByKD9izBfLIV8zOwby2XumUo
	 cSauXnMCy2+6Q==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:45 +0100
Subject: [PATCH v12 29/39] kselftest/arm64: Add GCS as a detected feature
 in the signal tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-29-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=broonie@kernel.org;
 h=from:subject:message-id; bh=daws7+gY8b6XFlV57O+J5ZaQ5dAS4S0GI4Vh7sgzmHk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KPgjRA+l66s77QyY94j1U0r46JzOAjWBQoCK26
 nUTS0oaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yjwAKCRAk1otyXVSH0KV6B/
 9b7oXkWayuyQxO8M+w9SB/jK8Qt3ogM/TMwIBuJV0cFLhWUSfPTNC861LHRMCk/2uyI18kQ4HJFFmK
 zIYR8Gsv8zWZm6Knr+I7wWnw7WTE5o2QAZvTWO1AkuNLaqaOUDXnTdFYRoaqxGYooEMhq0WAO7GPPa
 ESvcYbIe4d9PDSE0ImczVbNpRQSWSvaqU46/0aBaE9oW/xvO2ffowyxQCG3Cfk8RIStCOEDAy0Vg+I
 nvCFwDnHjqMGsUM4ezhR/wNa4TkdNCn15xcMCMElvGL7BnAbEoNJhPJLlW2fHh9ENCUmxcEHJFI8pf
 3bdOHXG59TA2Vbi6nJCYC9DaxUSNyQ
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


