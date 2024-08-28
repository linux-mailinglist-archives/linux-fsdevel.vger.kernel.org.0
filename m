Return-Path: <linux-fsdevel+bounces-27672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91953963597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC0828642E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494EE1AE035;
	Wed, 28 Aug 2024 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQCBLNOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934651AE034;
	Wed, 28 Aug 2024 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887777; cv=none; b=aPFkirRgI9REMgBbuwd+YVPwT5M4fC1zHInc+sOVHcnTSAayMpLcDaWr3piqIoS5S0BBjVBK3+vDiATG+5oG3iPdG7QnNEwLk7tanwSjcorhgr05rpeBXv+zcx+Z6cghEMO2jrx2gqnMB1fxE4iZ3TKgvPFV3RMXVWzvsU3bg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887777; c=relaxed/simple;
	bh=0WRESyvBFvhlHiGA4Y8lOQoOddezzHHj49JAXCWn5As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QOlUW0C+6vbGI2ZYTF+DT7sJG6VqLxTrFolJrf+g9Lj1291MBbRmYPtHr2hTBSGjoakVVmCaOPSx48pmu4nAljGbPdGoYteTznz4JBpv/+ulcmStVOM6MOtUGb5QZLLW2HdhVTOgNviggwN5K+XjpMmI8Hy2kFNPA1WdNxMApew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQCBLNOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509A0C4CEC5;
	Wed, 28 Aug 2024 23:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887777;
	bh=0WRESyvBFvhlHiGA4Y8lOQoOddezzHHj49JAXCWn5As=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TQCBLNOTt4uPoil78DH70AOWVpIT6LIQ5JGnF8pCl9Kwb2+T2aoH8vA75dLA88j4y
	 KzL26gabHDxytCwlUFatG6fR1Zvr5uTqt2pShr3pPCTMn33PxgrgHv/pPqIxtTLFnQ
	 Ey1twIbnnj5qLHrSSrYYGfsUjFldPiC+SUfCZAAFNmNW+3Xa3o4eriYNIwXnPNhtWI
	 1ohkI3dobfcvnJLKqjUPXbtK1H5vOU58SMjFghxknNoLATb+4juyD5w/c/Ag8Wp2Ci
	 OtqF9pP5xADxmHSkNwnT2wu9pMyM7UgrrXlopqBfP7xPJ5s52DOIQb4ZQoKDa55z6X
	 6aqd4cZGM2Mdg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:25 +0100
Subject: [PATCH v12 09/39] arm64/gcs: Provide put_user_gcs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-9-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0WRESyvBFvhlHiGA4Y8lOQoOddezzHHj49JAXCWn5As=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7J/KST71VyjmixMxH0mLOiq0X9OEBGYvS8Br+Qk
 rapbHhCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yfwAKCRAk1otyXVSH0IEyB/
 9dPMuvqOeex4MLAMJJV3WaYG8PgSfjupmm2EgWeN3PodFZUAH1v2ObWF8R8GWSN47b867WTbPrnUK2
 E/z43W2Ch+wVpTSLr0+bF7FvoXBo0Zw+4qi29psoG61NIvksaICvPytuz4veHug8g84QxMfdgBrQJB
 waIKJHxR3e1CluOtD4ERbimgFq6MquNG+8P0BrwkJc8CIWY4jiqKIf2vNmE2qBHtCKZ2jw8/yPZqzU
 UMi4CggPBy3S2pqqaubqBzuXEUqXzrbZc2hnNo2XHtn6LVzbBO0JtSHb03LM2SRFNANo/InJvS0Net
 +SJZZSugc6TOvTjh1Xb/ZHbpGii1jW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order for EL1 to write to an EL0 GCS it must use the GCSSTTR instruction
rather than a normal STTR. Provide a put_user_gcs() which does this.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
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


