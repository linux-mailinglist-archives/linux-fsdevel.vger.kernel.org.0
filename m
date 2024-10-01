Return-Path: <linux-fsdevel+bounces-30583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94798C8B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733061C21ACC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F051CF2BE;
	Tue,  1 Oct 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+nAC/nm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC81CEEA2;
	Tue,  1 Oct 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823710; cv=none; b=EqjWh36EvYzdE10r67oLOiF3oYaja7P5023Tr/O6ejbWtd64VXnInyOsp1LQBiKqXE+zHbYMLHd5vbuZRDsMvA+VFoaZ3u4YINSjdi8bTZqmo5KIKEXO7L3b99QDdwGDabkVZ8In1u/FFzxwuQAxvvhie16wcwVnfMJsRfZLREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823710; c=relaxed/simple;
	bh=MhYyeOgDPJjiPnqJmYVftV/y+2757NB2AZxb6KEZfRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GECjUx6vnF9Wt38InysiWe1QbBJJssA1W3MpBYnL6/l9lRk/2fKGGwrbTRO7CBdCdDApu11Q7TVupSJzctS0v62L+2TKbzYCZ63tsia3UyaAXOfAN+2G0yGcXrfFTbTCHnVKzerrFusK4Hb3aQlIqtyodFOt9YirVeFsnk9OFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+nAC/nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBEEC4AF09;
	Tue,  1 Oct 2024 23:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823709;
	bh=MhYyeOgDPJjiPnqJmYVftV/y+2757NB2AZxb6KEZfRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O+nAC/nmVZwWMWdkYfsQ5QNw1HeIy87NQ75pgl+F8dMYjFyJLBFGMFpjkHg1uQZRC
	 vjYEghqCTeKu90RZu6kQL5Xonwg3xCT124/BQe26yHucyusg5jSF2xblyLFGbab7fi
	 uOn+iDl4a6d4TN4fSkEy8Moq5uBIhZUdIz31oCpfKK/a2I3362UA9ntiotma8DV6jm
	 sECKdDjAV8rPgzAJY6xaj2NsVoU7s6sQohoK54N5DXGYbog663prRwHWOZ0Zf4D1SH
	 dDG6Aif2oT5rhMvpfA7/UW4NLwNAgjFcxyZkDngxoM+ye3IYl2cJHm9rHoIDtFSBfJ
	 DdysV8yEx9C7Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:49 +0100
Subject: [PATCH v13 10/40] arm64/gcs: Provide put_user_gcs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-10-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MhYyeOgDPJjiPnqJmYVftV/y+2757NB2AZxb6KEZfRo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7LRW4KlQxlmJfUOX9ON9sOn/C7Urh9KeH3veeC
 argNFK2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+ywAKCRAk1otyXVSH0HNOB/
 42LopqO9IfXhDQ4aJcLBH1V2IPSjrLJspB/s/FscgnTaFVT9Rk9vsh9BmrNqn4XzTtZ3lZEmU0PUMs
 J1sxyGjeOZvm4zGr1aJRDxScmujmlYg9GcalYcDWB9ySDZ6VxlD5ppP8qBZIfKtcFFEnThokH+FKBg
 tCkanKoKvK12U6GC9yWSQUlUNVkcsrfkIkCrxE9sM7rtPJbokfu1iXbwkJj/wVeh0a7KpgwwFydlxW
 Aps76h9pOYeYrdt+IY5CbvfOiHTJLDSjNo8NuYCZgK2I1NSCmbakO3qflwWHkQsBdBLsPd8ztMXzVZ
 yCkkvq97G8U8jAVxUciDeAjQRNCcTk
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
index 0db494b24dd0..5b91803201ef 100644
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


