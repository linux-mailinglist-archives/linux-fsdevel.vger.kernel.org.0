Return-Path: <linux-fsdevel+bounces-30575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8597398C88C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB231F25191
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA011CF5D2;
	Tue,  1 Oct 2024 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l96NGn7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC81CB513;
	Tue,  1 Oct 2024 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823620; cv=none; b=Uo1B3VHwPrh9raKeBkS6Ddtya8Y1gTpP/nnJzjBXkxOw8JFmgXZbGehQ8UuPujT168uOHeYpRlUjVkHlI8W0vaPOuuyQzcFl0s3oqE1+a+lHhJRM16q4nFkAXpm5gFOKDyqE138YG0KgNGNryFiVrx/ag0qNdlAcN1lafTZd6Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823620; c=relaxed/simple;
	bh=E+STpDluPni1qqn1pN34uc0md3Dbr7p50mwxPtfPVv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9ETBH2cjjxg1ytk4CJCqvkJpiE1xb8UPmZzc8sjosAofgOgPHa1RllmwfHVr+hGKoXeTwugpkyzYQcQQl2Hse8j5lvnBnXBl3YiRlDAJcG9zL6btcdbN/VOHZEBEYeLCoT5Qhee/KcMCNCtVdY1DW65QC9V88SI/5dDfqGBvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l96NGn7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FADC4CECD;
	Tue,  1 Oct 2024 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823620;
	bh=E+STpDluPni1qqn1pN34uc0md3Dbr7p50mwxPtfPVv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l96NGn7TPurtYSYyEpu0VnZYlAC2GuD2+RbdqPXib+mqQAeBSqqkmnezOKTnlqVjr
	 HDbSwGS+mgTjMLa07JGqmUfBnR0ypexjQGKJaNBgwajGZwKwRsxdv0AKZ0xRiwe56F
	 Ao8ZG+9U5OS5Ve6nVTGHYWROxrqGeMoeMc71uZS0QrY0VZUEYy5W2+NhFjwXiCtCim
	 +Nct63DmkECUz2AZK7Oiyx9s45YrUR/vEgDrJPLoW4fLqNroyzIth5HIga6UfMOvMe
	 sAugk1xN/dOaAabMo8cz3b3m2WGmTmp5NFmB0lKgERg/V11rLMz3zxPeL1oHAHXyVs
	 XDfHSOswPd4sQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:41 +0100
Subject: [PATCH v13 02/40] mm: Define VM_HIGH_ARCH_6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-2-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=broonie@kernel.org;
 h=from:subject:message-id; bh=E+STpDluPni1qqn1pN34uc0md3Dbr7p50mwxPtfPVv4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7FqkbqHSry4P1gTmihgOrWZBFx7sDukTznRbrU
 2uCRGoCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+xQAKCRAk1otyXVSH0F4rB/
 9amfpCTqeJr4oMpmSRZ4U6Ditl6XVFokj/OXg+LAKqsq6EhoA3N+8gdc/aS5cnW13+1ac1jZeWXWrg
 hp3oVPQPuVmteub5aFl3SQzh/BKX8YHEq56dKgJA1udA1tiAkKjASjDqBpIkUH0AFjU0kv0u4Xh+ND
 dJfTfnKT0IzpOCcfSpCSGhidKn7KUnuBFjPPmw40/aRUZF069RKTCk0USiZqlY1TSUbe33MhAVt3hr
 nZ3RYPMnOpZs00/ydAeSFTD1hwI9QE9t6Ah0uenxM/o06Cd1v9n2mS9NMPMdLJpFbndB0W4fQmIG0E
 3CMqg/lvoOg4PUH/jEwsL0eXZfDCF9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The addition of protection keys means that on arm64 we now use all of the
currently defined VM_HIGH_ARCH_x bits. In order to allow us to allocate a
new flag for GCS pages define VM_HIGH_ARCH_6.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/mm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..182bad0c55df 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -329,12 +329,14 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_6	38	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
 #define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
+#define VM_HIGH_ARCH_6	BIT(VM_HIGH_ARCH_BIT_6)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS

-- 
2.39.2


