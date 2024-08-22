Return-Path: <linux-fsdevel+bounces-26608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A695A998
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F561B22A12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED61BDDC;
	Thu, 22 Aug 2024 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E97AXxJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927AB25624;
	Thu, 22 Aug 2024 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289471; cv=none; b=QLct1zgmsWtl23ZfKOd3Q12+OfpMfsbZQLCB2tHwSsuHUovRTMGiI5aLrZSl1p/uuED4xpFwMPPAhcKKYX7hp8R7cMOp9RJtlW25b5t8A5+UCpkdUyddHshFVLs+HrheA6Pcyj0CCexmgCe1zRP1Waq6Sz7XR+0kCM9HwjFSyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289471; c=relaxed/simple;
	bh=0WRESyvBFvhlHiGA4Y8lOQoOddezzHHj49JAXCWn5As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ommnWdnEW+l/k8hZhn567YZGIhBlj12NIdR6YaqUtQMZ/M4+zB0kHbtp4Hvlp0YpFF6ZgZjW7D4+vrh0W/e4QHbOS2T7vpFEImto9KI/giWRTQ9FDtkdqEJqKcKkcjGYf33nFduycq80MVdEl7CkZauLGStfumggjK1nNGS7fI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E97AXxJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AD9C32781;
	Thu, 22 Aug 2024 01:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289471;
	bh=0WRESyvBFvhlHiGA4Y8lOQoOddezzHHj49JAXCWn5As=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E97AXxJyaLvA4eWkGc/srnZc1i0qVSJTBX+sUDHdNmRoGg03x0HFQ0Ma+lm8HaScc
	 Duhxzy20BDn4wqnOjRbwWBgCYTz4T/8RKkYrgjUzHGXtwd7KzLvitF7UHI5r/KgwBc
	 D3Xj7aLSG9QI8DbtgXVwjDCG4RVVA/dfn33LCkbnC6u2lMNcNiDhFsHFEZJh38yt20
	 wZfoyvPjNo/c22X5tqMwJ9SzQ2ScyDn1mnrstbZFjIM838vHpOIcUtHrDSdOhjD+1W
	 pd1vcED/CnO9KgVwk4ZIjzZyBONBoqPTyeOdWydoAfX4uOic+6BiQsIkg8VIPNOGTv
	 Js2v5T0IkyuBA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:12 +0100
Subject: [PATCH v11 09/39] arm64/gcs: Provide put_user_gcs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-9-41b81947ecb5@kernel.org>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
In-Reply-To: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEqxiyXnYx2N/sii4yn4wPWEiex3gccD8helpbj
 Tm7s6tOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRKgAKCRAk1otyXVSH0C9WB/
 wN8Eqbg+t1T6Ozlrs7p4tljp5Q6/NNlBRl+CXbZ4BJz0pmv0aBbMKEf69fLa7ToBqPn4l2Ce1sdaiT
 KJyqgPAxHOH+75KzzM286S7M2f2pY2ZF+/PKd+ydSP3j/w4XjWv90XxSZzLEMsCbrndYbD2524082z
 x4+8Oq9sWcKTTu3gUmWcST86jfaJdgluokx7H84dj00F0VDxn3PFfHnO3eho5joU49GfxI7IfHh0pV
 8nKEJXul/ofTART5hQHANESLXtY9P/ArrqfmrF7QyFzUpEFmlGciorgGHLwxf4Q3gqtOmzRaJ5GPMi
 fHNdmoz6JFKxZkDwoEy87pw3AtZnr+
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


