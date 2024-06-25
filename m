Return-Path: <linux-fsdevel+bounces-22374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775C6916B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336822837C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116BD176FC9;
	Tue, 25 Jun 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlQ6TOIX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2A16F8FB;
	Tue, 25 Jun 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327670; cv=none; b=EOVm+RQucMZ9eaSeKvjCX21QtSC4ly1dTMxyWN2PPaM/E9yqVXY1GYEk1yGsYFwrBEMcSC+YgCHRZPvuR4MxpoqZ+uK3q03lLuV30qTOry/46PLYwNOi13cnM8yaURjSmQWsnAikgbgsF2bGH8XeW1ABNZcHEr3+FWGHMe/E1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327670; c=relaxed/simple;
	bh=TLqYNWudouYZxLvdqWlChA6sggy7uu0Dwx9vwrb4VlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3OXpgFdT6QB40bb46gB9hz6g/ZM5cpBdFvk1mpx8Wqx9Ev+jez6soMZDxNqBRg/MMMgcvP6BZ6C9OPdlik8vkHhRlUeG+dSkuy/L52GodVJOfqpuXOT7yC78qY3gS4dmUFJyRDuq5xONkpkaDhTrSJicgfgk80KI5zIHj4a0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlQ6TOIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B79FC4AF10;
	Tue, 25 Jun 2024 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327669;
	bh=TLqYNWudouYZxLvdqWlChA6sggy7uu0Dwx9vwrb4VlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UlQ6TOIX5U/4oKhEYjjToTqMk9dhcx8quYDFp8K0sioj/tbOYeCCXfVrd96oczp8z
	 Q0pQ1AEPE7/HiIy4iLFB5K7j5ibW0DWVokTzX4lE65DjnZTxPuLIEonL3nXQHZo4wb
	 I1UJpZGPwwry2LnPeMsiR4GEMN+zugwHkF83hfkYU8H4IXeLNzBw13xm9v08eRsvXH
	 o2UnnQAkyjFtDHERdOf7OtR/mv89YzeejZ1SfVXzTUUNH+mqa6o4P92D1jIP5EgTu/
	 wa1xvOncxWbLm85Mi336N62dGPkN48DTMsPDIWS/7EieOqRHewAkc+v7shYz7cTJ2Y
	 S49TMB6XfDAVg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:32 +0100
Subject: [PATCH v9 04/39] arm64: Document boot requirements for Guarded
 Control Stacks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-4-0f634469b8f0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TLqYNWudouYZxLvdqWlChA6sggy7uu0Dwx9vwrb4VlA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmett1Wk4bVcZOcqjYz+jP+BA1iZz4W5DlLa3jsX37
 CNbJR56JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbdQAKCRAk1otyXVSH0PzkB/
 4mz1VzfKV2IStH+P2yx6moJG/TRBVMdnGiYeYEGpCKpfcS9fvAUUa+UcXCtCzkp6kwSyxHpNEH1t5W
 YF4qIhKfZK6ckvcyKEOjNRfTC201wS27OPawQmtGg9vUVLxpqvVXuUbk3ogailOroPHmLUqVJuyCsl
 3IUNWQ8gBTfYiBHY1hM43UNn0TlRByOSPmRBK+1TYhSXjtiTb/Z3qOdvSQezoQaOaN7eRBUIKtkhgn
 Rxd9FaiCF5v2yyEsMNB5/Dzu7pQQZulY0aNKv0PmF4ir7jQ12xzbj/eBym76YS0TSBWH1pLhCjjN0d
 qgro1ApVVUoCz8Ybcj1G+v6E3ZNxhP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_GCS introduces a number of new system registers, we require that
access to these registers is not trapped when we identify that the feature
is detected.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/booting.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index b57776a68f15..de3679770c64 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -411,6 +411,28 @@ Before jumping into the kernel, the following conditions must be met:
 
     - HFGRWR_EL2.nPIRE0_EL1 (bit 57) must be initialised to 0b1.
 
+ - For features with Guarded Control Stacks (FEAT_GCS):
+
+  - If EL3 is present:
+
+    - SCR_EL3.GCSEn (bit 39) must be initialised to 0b1.
+
+ - If the kernel is entered at EL1 and EL2 is present:
+
+    - HFGITR_EL2.nGCSEPP (bit 59) must be initialised to 0b1.
+
+    - HFGITR_EL2.nGCSSTR_EL1 (bit 58) must be initialised to 0b1.
+
+    - HFGITR_EL2.nGCSPUSHM_EL1 (bit 57) must be initialised to 0b1.
+
+    - HFGRTR_EL2.nGCS_EL1 (bit 53) must be initialised to 0b1.
+
+    - HFGRTR_EL2.nGCS_EL0 (bit 52) must be initialised to 0b1.
+
+    - HFGWTR_EL2.nGCS_EL1 (bit 53) must be initialised to 0b1.
+
+    - HFGWTR_EL2.nGCS_EL0 (bit 52) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented

-- 
2.39.2


