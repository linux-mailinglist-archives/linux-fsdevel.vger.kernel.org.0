Return-Path: <linux-fsdevel+bounces-24778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB03C944C79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B151F21B9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F01BA873;
	Thu,  1 Aug 2024 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeDPSC+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8CF1A38D6;
	Thu,  1 Aug 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517244; cv=none; b=jSBMnmSD0eueIgm0q050fpkczK8FlSYfAAYFbGg72xJSArCYG5kmEb+9aWeBb00i0ZbgTUB5y99iTh7bwBI/6ZOxTuqd7hIOuzM7uZkzp/Nn+X0d3oCeJP/nJ8uGmfcOnFmHL7SEjMnoQLNV9z0QuBajqc3zUavDsQTG6mgVQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517244; c=relaxed/simple;
	bh=b9Gx7QUiEPIAdR9RNFo057BasR3/TeEIE9B40jmDJ/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jAn+Opm5MegBsC6VuzwC1rm1nSu0uPsLYnfXiJXJyPLs/MzGce0CefWZXwAIuzZQBIczFXCt7zCiQcPyVyR8hP7xWbYCv1NtDIlmvCQijTWkFdz8xPMet2n5koayCB198rodm66+RlXu/xuTlB+trKN09Vm1BBALH8scVoXL+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeDPSC+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AEAC4AF0F;
	Thu,  1 Aug 2024 13:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517243;
	bh=b9Gx7QUiEPIAdR9RNFo057BasR3/TeEIE9B40jmDJ/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BeDPSC+svn9jwZ5HO/dupvJkJ+PBmmW9gsAmHLvayeZzSX8Pr0bdYPgA7jak1loAG
	 B+uFxjpvPSKnLe9VaN/Hlx7dl+x/cqqPwzW7yFwl42FezkGYJiZN5RCg9+cL1GKlel
	 hyNKn4hrTImC+r+ryQAO+gyOhsxyza1wdGUrMl+hMtYqKJ3sctWYb+MRxx9F8lf/hq
	 AnucC0+Di4cr2GDyoAFoNgeWce0gSe/fC9ceMx9WMu0F+SYnoIrtWWV67/YXMXM5zH
	 dzBjJNaYYqVheTGKdo3bvH2fiTYpPrhOSPFpxnXYKzNJKXaUHR2l72RHB5pjJrFUXZ
	 msXrY9gmhemOA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:56 +0100
Subject: [PATCH v10 29/40] selftests/clone3: Enable arm64 shadow stack
 testing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-29-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=broonie@kernel.org;
 h=from:subject:message-id; bh=b9Gx7QUiEPIAdR9RNFo057BasR3/TeEIE9B40jmDJ/c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YcGlhpOj6DsmlrQLB9sFNjFcmtR7a/7hcuDPJi
 1WPfvR2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGHAAKCRAk1otyXVSH0N2DB/
 4u1y7NKCOY37zU67JkUPEpNLsIl+VxURgETEUY2dZxEx6yYfE1aGAywt3yaSnGUEbwMW6edKYAUchr
 4lX1kFqnAkhrcwH/nHkE9EbHAp4S4onx5plRdvTdDXwbgmz9ElwxH6PAqrgAMAIjlcAemgMh1vsL8Y
 Jg0/iFzW4BJk+Rce85J3+MBPkk3olEf8DTdwKM+HBVHKZp7ROhXC+Nae32yoRdbOhKnyP9M7hapDmf
 uhlvd8GF7sxAUK3Kn9pUCmdB6uiYGekqzCCdForvtzIVTGBYp26p5Q3D2VBstoD/ZA/AUXheARDpJB
 N5WUxquIwZz86X9UXY/FGZfGSvrPm7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to test shadow stack support in clone3() the clone3() selftests
need to have a fully inline clone3() call, provide one for arm64.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_selftests.h | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 38d82934668a..e32915085333 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -69,6 +69,32 @@ static pid_t __always_inline sys_clone3(struct __clone_args *args, size_t size)
 
 	return ret;
 }
+#elif defined(__aarch64__)
+static pid_t __always_inline sys_clone3(struct __clone_args *args, size_t size)
+{
+	register long _num  __asm__ ("x8") = __NR_clone3;
+	register long _args __asm__ ("x0") = (long)(args);
+	register long _size __asm__ ("x1") = (long)(size);
+	register long arg2 __asm__ ("x2") = 0;
+	register long arg3 __asm__ ("x3") = 0;
+	register long arg4 __asm__ ("x4") = 0;
+
+	__asm__ volatile (
+		"svc #0\n"
+		: "=r"(_args)
+		: "r"(_args), "r"(_size),
+		  "r"(_num), "r"(arg2),
+		  "r"(arg3), "r"(arg4)
+		: "memory", "cc"
+	);
+
+	if ((int)_args < 0) {
+		errno = -((int)_args);
+		return -1;
+	}
+
+	return _args;
+}
 #else
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
 {

-- 
2.39.2


