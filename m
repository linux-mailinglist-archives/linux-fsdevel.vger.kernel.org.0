Return-Path: <linux-fsdevel+bounces-24780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD27944C84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BAB289437
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19CC1A2C25;
	Thu,  1 Aug 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAUnG7gy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AE1A38DE;
	Thu,  1 Aug 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517257; cv=none; b=dnj7cdTZ41RluX1vZGeo8K3o8SQGYlOEObdY+9mUeIrmrRljVcttpUY6tMZK7ZsSpnp8GX26Ndv20HMgNll4zHV/E5h10NUyK+HwZXip4z0jJcTf75RAharjiWcrvfkVczDOCazv/S5iDKkPZvY+tXuq7pkGIT5ZySjs1nrqiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517257; c=relaxed/simple;
	bh=sPSz542BQgC8GDr8WCulUI2iE6roG4Js5HwD3OcoqCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pr3nru11w49leYCd8llSRZpPUDZrRyTLIL1IPE1Khu82XRZH1WrZK+Hfoji8XnqS15ucfsgkzjIqR5UP9pZ29PMhEPwEYmP1UKdGPGtI5NiawNs/eviiRUePj41CpIokAfJcl/qgE4r+nodLjk91txRFnulPZD2kHkWngeR+opI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAUnG7gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C837AC4AF0A;
	Thu,  1 Aug 2024 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517257;
	bh=sPSz542BQgC8GDr8WCulUI2iE6roG4Js5HwD3OcoqCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZAUnG7gymw3ama46N4/FSDxSkR6dolweB/eurjLYlAnm9DLowUGKqcj7YqINGC+uj
	 8HTwVpyNStWp08+y3E2ISQEhbnaEsEDOOsMyJDIMovAiFVpgrUVzjTc6Fzff1xAo6P
	 NsmhUz3gsA3y+FnV4UnLlGhUyOzmRgpnZtLqrP78J8DCfwokXMbOzvXajVyn/14NjF
	 ExlFSy68rqNsm05R8bNTJfpJwPwchXZNvHkOxwVGR3TaweNxzlMfILcTC5tAnFHizm
	 F2vIDbFxuDuPBfG0wHbwGaUjWnz6X/l+Se/Es9JGGP0GW3nCRoB7wv14Fm8VG2uM7B
	 cSyLTYYRcdj4g==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:58 +0100
Subject: [PATCH v10 31/40] kselftest/arm64: Add framework support for GCS
 to signal handling tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-31-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sPSz542BQgC8GDr8WCulUI2iE6roG4Js5HwD3OcoqCo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YehzAb9JAu3bcFU1tOhATrFl7Jobwqpz0k6Kx0
 4Nt/ApiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGHgAKCRAk1otyXVSH0HeQB/
 4r2nNmyla5byu5l9a+dzkSs2P7VDc57ojHjMgUHaxYSGDO5UZe7asC3ePZ0AjtK1zU/AepiUi5IEvT
 ZG3t5pco4RLuWa6DfFqJyzCiXyhzRq3ydh+yaptLtFfdBWMp0mMp+uXLHNRFjsu55OHXS6bt2eP3am
 ajrJDyiATeO/DeDHObUcHTJX+aFIk+V7urQv6jeJaZdyB0mL0wEFHuwQ0RA2No44U72IFcrjY5U+Wt
 bhYy+0SykeTjQc+Q7ob9QIwQqnnd9KxRv2qi482zdXbC1wc3F6P7b3PHZHGywBZdDNS2ptnfL22Ed+
 wtDYRLVKGjK9pDzEgdKczzr6s1FElI
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Teach the framework about the GCS signal context, avoiding warnings on
the unknown context.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 7 +++++++
 tools/testing/selftests/arm64/signal/testcases/testcases.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 674b88cc8c39..49d036e97996 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -217,6 +217,13 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 				*err = "Bad size for fpmr_context";
 			new_flags |= FPMR_CTX;
 			break;
+		case GCS_MAGIC:
+			if (flags & GCS_CTX)
+				*err = "Multiple GCS_MAGIC";
+			if (head->size != sizeof(struct gcs_context))
+				*err = "Bad size for gcs_context";
+			new_flags |= GCS_CTX;
+			break;
 		case EXTRA_MAGIC:
 			if (flags & EXTRA_CTX)
 				*err = "Multiple EXTRA_MAGIC";
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index 7727126347e0..dc3cf777dafe 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -20,6 +20,7 @@
 #define EXTRA_CTX	(1 << 3)
 #define ZT_CTX		(1 << 4)
 #define FPMR_CTX	(1 << 5)
+#define GCS_CTX		(1 << 6)
 
 #define KSFT_BAD_MAGIC	0xdeadbeef
 

-- 
2.39.2


