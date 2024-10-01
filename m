Return-Path: <linux-fsdevel+bounces-30588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E8798C8D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D28286D59
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDB11D0799;
	Tue,  1 Oct 2024 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUqqh7nY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB02207A;
	Tue,  1 Oct 2024 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823758; cv=none; b=l14c6ZnJGzewzYPBgR6nzWBaUk9P1Q+DiADCRvWPjWrn42AF0ApurND5GeBL4XCXhg8pLknxSm/GPRO6f+u0HpZGD4HjDD112DMttiJ4Zr1UhHGTXtMZlHRp/lTPms7bI0xgrAYdG4P7m5LabEHoHGl7QN1f1F9ac+I3wnvNzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823758; c=relaxed/simple;
	bh=iaOo/eHnt7nVAYYY04s0CJoGcZR71Wh0L0z0tfAjj5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JVun44LcetMuAWsYEnGDdj2rX9Pbt+e7D1SPBfTXjQUTvC03Tx46BXJ0QVV/gvYNAb7zEDOi/NBePE+92u8wCXJin4tpQCHTolMHjxwjRibQKheKenWXun/hBlH1qrig9uYrLujhljcHMS/a3VFYLTso8es5dfjwSF5MXbiTZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUqqh7nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32691C4CEC6;
	Tue,  1 Oct 2024 23:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823758;
	bh=iaOo/eHnt7nVAYYY04s0CJoGcZR71Wh0L0z0tfAjj5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gUqqh7nY8DifOXx4W85pnErZS2D1gnTtAy+3DgFxNMmQtLboM/sTyjbKi0UGUvxYE
	 MnPV6ZCsIIJ6o7qGezeh+gI3YMVvc9Jb6VGhEpr3Ph1WOsyCPsnWO/QMsj4eHdpx20
	 P5298HT7y+dw1g1P5hyBAQlmS4D34zxnf2h9aYrrJGJtHSPGXczECZxbvomv0JSMEI
	 2brqU6kp7yqRC63sx+2NCcxw7ZEYrBATr3AqXdUwFLg8qnmQ0HQYdQ5eBj99fc3UTK
	 3WHErdya4+QHcjBF9VZIutYVj3Booae9dNtS22ZpYGEV1wpuiYpI32CInMnHzD7Phl
	 eZsvlvNUlqAyQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:54 +0100
Subject: [PATCH v13 15/40] arm64/mm: Map pages for guarded control stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-15-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iaOo/eHnt7nVAYYY04s0CJoGcZR71Wh0L0z0tfAjj5s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7P1EJJZsPfYIE0QBq/tINqmBg6uzvjA9MNO4G2
 WFi9f7CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+zwAKCRAk1otyXVSH0IY5B/
 9I4+JyQBe97ebsZEscKo1qo7/m+PT10LjgI7Sgz+xOEzztCrZMsOVvxpJOfRz9LSx3HXo7l/r2fMhO
 o70EbKlG3Ndfo8ukorzVw/0u/VlVIE+M0+uxJE46CJS+gaJLEvLlTr/mr9roUwkqHeI5YJ3u1qCxDg
 sfdiVWbdejibK6kkPIsuDcMl7qLDgPPgfGyCaCEVo58dYkq5niIfdflsydhtntcNM/C56Pa+c0aUx3
 c1CWAKMjvXY1Y+G6FwbVbqON1ejk1JFXdCKgSslWxH6sD1MB8vblGF7f9LD5Jkj1AV8uIM49MW5V/u
 qCNkmAnsAgQFFEoUsAkeMHuk7yKJ/0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Map pages flagged as being part of a GCS as such rather than using the
full set of generic VM flags.

This is done using a conditional rather than extending the size of
protection_map since that would make for a very sparse array.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/mman.h | 9 +++++++++
 arch/arm64/mm/mmap.c          | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 03b790fd0ad8..f6d784f8e6e0 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -71,6 +71,15 @@ static inline bool arch_validate_flags(unsigned long vm_flags)
 			return false;
 	}
 
+	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
+		/* An executable GCS isn't a good idea. */
+		if (vm_flags & VM_EXEC)
+			return false;
+
+		/* The memory management core should prevent this */
+		VM_WARN_ON(vm_flags & VM_SHARED);
+	}
+
 	return true;
 
 }
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 7e3ad97e27d8..07aeab8a7606 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -83,8 +83,15 @@ arch_initcall(adjust_protection_map);
 
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	pteval_t prot = pgprot_val(protection_map[vm_flags &
+	pteval_t prot;
+
+	/* Short circuit GCS to avoid bloating the table. */
+	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
+		prot = _PAGE_GCS_RO;
+	} else {
+		prot = pgprot_val(protection_map[vm_flags &
 				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
+	}
 
 	if (vm_flags & VM_ARM64_BTI)
 		prot |= PTE_GP;

-- 
2.39.2


