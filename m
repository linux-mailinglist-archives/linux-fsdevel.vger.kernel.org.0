Return-Path: <linux-fsdevel+bounces-30576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FA098C890
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D96B233C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293C1CF7B4;
	Tue,  1 Oct 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzU3C8wB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1A1CF282;
	Tue,  1 Oct 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823631; cv=none; b=fBiQWMlrYf0mphMZsMsS9tnkWedqGcC0OCXOAxIsT2IUkQMpFrNnnoQMJSx7L7Fd++/AhvEsJPNaHWA3Wt+P6Uk//DeAubwFik/6nVP4NusRvb0AYkitUY+UX8j3AXyb6d3eIZZYBfUKXvfhyYb3ldW38OzJQ4p2f6+aM3kmI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823631; c=relaxed/simple;
	bh=is0r9uSxnBrJsURPndZS8euUNnh9hat0c9erNc615eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hA4MMw52uxA/L7mRXBZPkqwdWlECFNWEu2Ag+HvnvbSpNnpCfWOrt05FtfoABiYMvwQP9bME0seieNmzhSwZEiD9QJeoXucpmjEC14it9waS2WxrQSAZntAQm3jRo5q5Pz9iZdBDuNsh9/5VhypnjXXWurJ8NRLxpOp/D9zUYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzU3C8wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3DCC4CEC6;
	Tue,  1 Oct 2024 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823631;
	bh=is0r9uSxnBrJsURPndZS8euUNnh9hat0c9erNc615eY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OzU3C8wBK2OXHIrGHnNZpdo/rQ6MSb1jHODyDJAoNGG9AyZNy5xOhOnImbc9d60wE
	 qSXmDByXxXOp7Ghp9V8hGG6xCGWGNhmsxXa6baFwojfTnq9JMUn7NQgzr7ymCVQr9M
	 xQzltE3MEY3qlx7wv2dUGT9EHgsMa2EePeQK3qEgp//bYFWGY2XK9BHxnCXxy14lsW
	 y6hOpdEVVsRQOy2lqROKkzEl3teZgHd64wyHyPEWP29kxwJ3TVQ7xEfvLf+sSEt1u3
	 0tpfKhhLduhLswCXEr93fOz97JzdTpXZH9WZYuRAlc/qi7p3danUp/VqXou6eelRs8
	 /UTfMxcLCXHGA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:42 +0100
Subject: [PATCH v13 03/40] arm64/mm: Restructure arch_validate_flags() for
 extensibility
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-3-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=broonie@kernel.org;
 h=from:subject:message-id; bh=is0r9uSxnBrJsURPndZS8euUNnh9hat0c9erNc615eY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7GKNZdsoQOiuGpwbETH3V3HnhsUT9brBj4a8sc
 0mwQI0yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+xgAKCRAk1otyXVSH0OpuB/
 9pWeD6rdk7JLYO1MPcZh358jd/19/BInjhws/y8H6gPcPEhXrqV3svABMXzkhapPykA0FPynYWJ3Bt
 CVWT6h4z/az2texWxSamLzYf+NpFxo0KTA6Xs3FbEQNSLhX6NVP5ShtTxUTRPPqC8WQDiw2//sVF1q
 A/RTUy4F7OXGB7G2mAcnlkzpyemeS4Jdu5U3o6EafIil48jzkrO3jeu/jQIfS8xwQf5UOFkbK7CXEY
 QU452e6zmm0e9iAjhYcZALFD7pZ3ZjVBk0ZI4cEGACD5cU1doG8qkctAhdvnI0j0Tz4DLaIJl5HJWh
 sJYxu/Wz7X4HBFgP9tyB+yg3XUAKpC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently arch_validate_flags() is written in a very non-extensible
fashion, returning immediately if MTE is not supported and writing the MTE
check as a direct return. Since we will want to add more checks for GCS
refactor the existing code to be more extensible, no functional change
intended.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/mman.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 9e39217b4afb..03b790fd0ad8 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -62,11 +62,17 @@ static inline bool arch_validate_prot(unsigned long prot,
 
 static inline bool arch_validate_flags(unsigned long vm_flags)
 {
-	if (!system_supports_mte())
-		return true;
+	if (system_supports_mte()) {
+		/*
+		 * only allow VM_MTE if VM_MTE_ALLOWED has been set
+		 * previously
+		 */
+		if ((vm_flags & VM_MTE) && !(vm_flags & VM_MTE_ALLOWED))
+			return false;
+	}
+
+	return true;
 
-	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
-	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
 }
 #define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
 

-- 
2.39.2


