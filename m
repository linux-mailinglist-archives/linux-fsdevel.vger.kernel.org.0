Return-Path: <linux-fsdevel+bounces-10153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2308485A5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA68A1C21951
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B699B60DC5;
	Sat,  3 Feb 2024 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shZj4zmb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485A60873;
	Sat,  3 Feb 2024 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963406; cv=none; b=mdshrv186sBy8CC4Mu+Xn0No7+mdlE7fVYSD8QyprqKUw/mgkRGhmtMEMkn4XrzJuP6+g4xpm4yWvzRQua4arf2xfALE+jSO6JkF6piPlu+mBwkFQ8yu/e57gc50zHJs4YhYaSDY3dHXKujQxwdygxFApKPH3MVn2k5Q7XVkUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963406; c=relaxed/simple;
	bh=39WiY3pJD/byvb21132HZ1FFf2AaFNt9bxr2VNbG8Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8CQRPbRxyjgwHVvJFFbnb3Y+DFHklLi5cSvAMq9Lx+qBwrCiEsseKMVm2gG3YfpJE4uNHCZqzBHApcq1gWDypQv1/Eb2mnMCLYGONU2s1j4yyb5JqKv0H870KfoXa1CiVA9/Ng6W68Aw7OtnzCsXr+alddUhiGu+ba9Bdj4m4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shZj4zmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CBBC43394;
	Sat,  3 Feb 2024 12:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963405;
	bh=39WiY3pJD/byvb21132HZ1FFf2AaFNt9bxr2VNbG8Fw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=shZj4zmbEG51YJXT2HR/hbkSqqeTtDXlNZZf7YSTfM8hx53j8LXpmJZLw3Iv82n8T
	 EmsnjZlBS3Whdw84UibP2OywFky27fJU1kV1ZQZrvMHmo5oo6DDxG7Ve+KACATX2av
	 DyY97pWgxe8gwFmEDtgEyjX1bk3f/dH3s4xHFsuiFE52tVb78u03HcN/O2BbuJHAi7
	 KNMQRWaioIbZCcU/WSDqiLZ81LH+jBUTthLazxEBHx9RWs8ibKA/VQQFMjwhktb/Sh
	 61x79dnbtbMxzrMbLJs9q2PhBw/ScBw5eG6rQTZlugcKruZnKQ6rD0cO+jKGPxrzE1
	 jHMBTdnV+2cdA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:34 +0000
Subject: [PATCH v8 08/38] arm64/gcs: Provide put_user_gcs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-8-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=broonie@kernel.org;
 h=from:subject:message-id; bh=39WiY3pJD/byvb21132HZ1FFf2AaFNt9bxr2VNbG8Fw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDXlOhNa5wqLtdcsL9HXNagaPZlUCqhjcNX1c/m
 OGZhZROJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w1wAKCRAk1otyXVSH0GPoB/
 41N6+udhNIKyfclpuplMcjQpE4Medy7BQP1spdA3c3PSHB2nlB6id9g5c3aaDNbOG37yHJfw2ZoUN8
 sgb3yLFVwhS5JnwHUUpsdwrK7jftwR1SlVArLgVwgyqyz9VuVeZ71IXLIBRhx9kDgK412ZYWfDCUag
 cByQrhbCoyfJSbprcOy7eNXWxpd4+C4do+G2udTLpptHhhxMqt/0zB6iOYBYk7SaIIXok1V3v/bKNx
 lQ5mXxZ9LYnsYVcbi9w8SQzJ4VZGzDcECPlEhUS0e2APKEEdGo2EJJ3bjMgkTEPN9C6B03JU9IPhRE
 A/tP1bU7676ZdvRcI96pstycM97i9L
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order for EL1 to write to an EL0 GCS it must use the GCSSTTR instruction
rather than a normal STTR. Provide a put_user_gcs() which does this.

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
2.30.2


