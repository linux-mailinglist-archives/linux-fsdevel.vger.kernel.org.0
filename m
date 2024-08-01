Return-Path: <linux-fsdevel+bounces-24757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E0F944C01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F461F220BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B31F1A4B3A;
	Thu,  1 Aug 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbNqHBPc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14801A070F;
	Thu,  1 Aug 2024 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517095; cv=none; b=DC3zpxt0Yk0uc/U00VNlPsEBJ/RJIedLhmS8QLATvj6MJSdrxq/DiCoXAd0+bwLYP9rEBxpzcLm2opH+KITnImd7jZ444OSv3avZYAxsm9R93MoI7vScpsVEm4v/TjseC6ePQu3OSpKQPREXT3cM19e+kH+reBldmy6+KI8ErtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517095; c=relaxed/simple;
	bh=9zyM2kDwaHrPoIdC+tOITu/EBfLF+6/APyyopskSW+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFpvMS5u4X9ES2PUacen/wFIaviaGfOQAI1Z0aKJxdetYZkUmJFGEDcZAhKvh8rBOfP36H+CXJPOl/G3iNReTpKUfBQoiAUdW9UqRFbYNn4XiXZamrORweSb+8n4Pu4PM7ejyyLjmv76AMfFR//uG2+x1qhCr61+VjbWkn+BhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbNqHBPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4743BC4AF12;
	Thu,  1 Aug 2024 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517094;
	bh=9zyM2kDwaHrPoIdC+tOITu/EBfLF+6/APyyopskSW+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MbNqHBPcT9Y5beIJ6gploRPX48lF/ic8+DFzi6qdc6cvt1vT0gJAFXuZWU/kINSbG
	 w01rYdOQQA70NsmuDwunpJubsh8i49z3114zgqs38oC03JE2Bqoc6n80qPrvENvVII
	 81drmw9RC0wAULSAgtpeMwsJVVFhmHjeXiwAARS7LEA7/G0/xLGStM6i1X36yW9kla
	 DOX+sdvAgON5kBgQ4fl7b16mFYaxAlkwxQdWUoOUlKpWlx2i9A9Jh1XksQdoAltZZH
	 gr93pgYFmS5Q3Kyna7upwfm/6x7XCQYA0Sya8gOelUhPJsMBBrgnSlvAZwD8zwzTBc
	 y0OUMFpqw4uNA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:35 +0100
Subject: [PATCH v10 08/40] arm64/gcs: Provide put_user_gcs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-8-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9zyM2kDwaHrPoIdC+tOITu/EBfLF+6/APyyopskSW+Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YMRl/JJcB0rkEcqgIQ8gNudAtrXaRRngscnrbl
 bPqr4syJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGDAAKCRAk1otyXVSH0FzhB/
 9vnbFMIfpN3H8ylPPtfhBn++BSFNylLU467N/+QYoDoXnkw48vtuHXvlXdbhmG/pVEekaIYqr4GbWj
 zTbVXnZdpLmf7S0M6QwCO4+jX59+0EOzOzIMR/69gC1VgZ4ZKDB5QA+Rx/l35VUF7O02mso6fO+HG0
 2qbZzy/7tnkXVbPiyYZnF+OYGE+wK4xseNeRUDCnMYSKpPokJkZ1M86zvEhAkA9L9+nCGNYpPWot+T
 3vcDQ8wwL6TUiu6/gDqeVp38IKPlTX3LZXVQecVANGqtSEzyzf+TT/qE0Fq7ArvcD9PXt2GrcIARrn
 lTxU0WZ6Qu9SZe+Heyb4/hIEo5nDr5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order for EL1 to write to an EL0 GCS it must use the GCSSTTR instruction
rather than a normal STTR. Provide a put_user_gcs() which does this.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/uaccess.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 6aba10e38d1c..ecdd47cf1d01 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -522,6 +522,24 @@ static inline int gcssttr(unsigned long __user *addr, unsigned long val)
 	return err;
 }
 
+static inline void put_user_gcs(unsigned long val, unsigned long __user *addr,
+				int *err)
+{
+	int ret;
+
+	if (!access_ok((char __user *)addr, sizeof(u64))) {
+		*err = -EFAULT;
+		return;
+	}
+
+	uaccess_ttbr0_enable();
+	ret = gcssttr(addr, val);
+	if (ret != 0)
+		*err = ret;
+	uaccess_ttbr0_disable();
+}
+
+
 #endif /* CONFIG_ARM64_GCS */
 
 #endif /* __ASM_UACCESS_H */

-- 
2.39.2


