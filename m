Return-Path: <linux-fsdevel+bounces-22378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A847916BB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBD01C2544D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3599C17C7DF;
	Tue, 25 Jun 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCKBRIM7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F516F859;
	Tue, 25 Jun 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327698; cv=none; b=sAQR+LHU4g5S0aSh0Z2QSxR7I6AOeah2VJ/zFdpueliz/NvP5NBbXqmxHL/5uV74vD52cgCYq3I8YuEDX59HKyDtBZE10I/WHUIK8xnlXgqNMSTMu4qS5z/APC84R1EgbdkljlvXS+gH1PW7cKwM8mM+PWWOzT8op8te8MIL4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327698; c=relaxed/simple;
	bh=SpxTDPkJgZRI3y2Hq1n9QzpjFWZ3Gxi3l59ZtBf4jLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVIuTbPdTSqt4zV1dPS1NXfQlsK6HQwl0+nIs3L/TlXl56swTTc7/xGftmwIAOLW361CxgwvG+s7Vnf/1aKEWOMWF2PKcwUxT31N6gjVONTEgc5yPW3e09pdsKppijmx00O0kC0HLZ4cWKP31lOluec1qZBVrwym5Glyv908VGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCKBRIM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75909C32786;
	Tue, 25 Jun 2024 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327698;
	bh=SpxTDPkJgZRI3y2Hq1n9QzpjFWZ3Gxi3l59ZtBf4jLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LCKBRIM7P1X1xpvsS4XEya+CU9QncvalN8/HgV0jOcZrtdPH96iZ79e/FfldlYcyQ
	 KG4D/US9JjKXYl6B32tA/WiIsea5bmSRxlZ8rD+s9jRPHVCl2dfCCaNrSUGkPvyfTj
	 f1I5FPA1gSm4owfH/cYTM//+93y5ac9PdpqIsqUC5aI5zL3mgYULmUS10eqDN02DIq
	 s/+fZZEtRgCN8Yu91NoAulTdaszPk2cIrUC+Vub4cZGRGySZQD7qaEf30fZXBDXLWg
	 apjmyGRWF49cRMCO2zvSf9I8skh6/KYYKTNe/c1B4e8lNgRIB89TjkLsb8q6EKyBRI
	 v632mqX63KxEw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:36 +0100
Subject: [PATCH v9 08/39] arm64/gcs: Provide put_user_gcs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-8-0f634469b8f0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SpxTDPkJgZRI3y2Hq1n9QzpjFWZ3Gxi3l59ZtBf4jLI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmett4CKl1cP0GjqsEsHZQn+ZUgv8UOnY1gwbJGEPy
 0nF1gWuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbeAAKCRAk1otyXVSH0GTvB/
 4rzP26uQ2jw9FuRsJAqw1gE2ydgI2bc/iKdMxs34w3uUiteyu1KQntu5r5O6S/pDWsDvBv9DBJSjbX
 C3BsRvj08B3YrbhlpjJ8tIwJrzT0vK8lfVijApbbnDEGHfkQ+ktEFeGlNYYxlpcM0Dua+4CplUqp5v
 URfmO1+u9hbBub4a7rjyBrKim/HyioooMWWoj15ZNBrNVzgiZwuDPsq+EFXJ4OTwDXDflKXC4mpytk
 yRKGcwTpLlL/Y5xmDIsOW81n+j6uhypg+JIlOx/pXvC2LYHCcqFjuGdcEZetVcrga5Km8RdHiVztO4
 fEt0Wr4EPbNTgi0mUCzBzWL4XUs9a/
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
index 22e10e79f56a..e118c3d772c8 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -445,6 +445,24 @@ static inline int gcssttr(unsigned long __user *addr, unsigned long val)
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


