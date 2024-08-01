Return-Path: <linux-fsdevel+bounces-24775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047B944C69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3FA1C25A11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461721B8EB8;
	Thu,  1 Aug 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zdk/HN3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA91B8E9C;
	Thu,  1 Aug 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517222; cv=none; b=dqNOCKlT0sdLZKp3c+baN+t/9RuaimAr9fvYvm1JdJtkX8LSUxszSp8tTw0L0MZ4nsm4Ay6yh4abwq464ONxWlp49fzzXNAmM+kLg0DDrBdnVimvbFsCb52I+MTnD9onGyn/Udo8lO7H0dtRPcqFqbUw6Jw+sM+WpH3GWY6X3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517222; c=relaxed/simple;
	bh=jCz9TB/T2gtL+Dj1sBbCVvFYWqxLMS2lgt+ihDoyD98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qgPTMpq7iSYTNwVPnI+zAQav7o8QQwVhlxgt1BOEN6HBl+ccHh07vkogQgbKHwU1qW5fw8WLwhGsrLaYJXvqV1vuCTnkIWV6u6jnoqzSXHqjDpFg/zpGq5qqTZOQeZmKMxGO2IE5a9y+sv52fIvJL92Mn7DjSaxMhhXh6YwJSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zdk/HN3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A461EC4AF09;
	Thu,  1 Aug 2024 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517222;
	bh=jCz9TB/T2gtL+Dj1sBbCVvFYWqxLMS2lgt+ihDoyD98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zdk/HN3Vv5MCR9tWdyaa/VEftixl5lcXiTlx9bdPKbc6eaT3FWEIZma95Z+GhffvM
	 EcnEtjxjUMY7BtJNNzPCC7DDT43xLDYiM+AZJdYOlDlAIPK9JiTcxM9ZYM42+e7C+U
	 9M+FRULwYAKFy9B+Z/awaXXUyELOAV1XBrU0mp4w/mkVPsn/eOz7VKSFLsmAIwwW7B
	 lew6XfI7DwPM58JgIGVw2nkB0gIogzXMI6WGBoekN/T1iW0VC3dDiHWS29AQH9c6VV
	 IV9oIsnZ+4eQBNTMn/6CGQLJ5TBXgVfn0mxsqA1OzKNu7nMhgKP1rnDfsJkBxLzSKi
	 FYf/bx/yCadnw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:53 +0100
Subject: [PATCH v10 26/40] arm64: Add Kconfig for Guarded Control Stack
 (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-26-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jCz9TB/T2gtL+Dj1sBbCVvFYWqxLMS2lgt+ihDoyD98=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YaZfoQpmqEUbybjMAYNvLQbJaJ5ach0jFFKMwt
 WAXMRf6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGGgAKCRAk1otyXVSH0GzQB/
 0VUEM5IVaWGWCtsoHGuHQHdtM8+bn0nEmmu8lC+oIKaYCzNy9VMZzgyUqowYnTd7bPlWUz/Y86I44V
 RwpJj/EKex2ZFhiaMSKwZKk5ZycQwwdhmGqd8wkhELOTAU5tPmelrk1C5oPSDSLU5/cK5yCygjrcBh
 KSD25yGvlDBzmQwU8A2hU2FXizsVvxQGd/XPIkN4qnQLAWZKEaHYFH8a475LGnHg8uUfsFCToCPjWh
 6YUfe9z6iCQUb0w218AdqDzqriKwGOuLBU2jkxLaydWomcfvewT1WWRsu2cMVLqUa0d9CiOZRK5wBg
 Uww68Gf9sKSJ6c/5O3iLSaPKkTUUYX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a Kconfig option allowing the user to select if GCS support is
built into the kernel.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3fc891f1544..83e27857bc6a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2127,6 +2127,26 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+menu "v9.4 architectural features"
+
+config ARM64_GCS
+	bool "Enable support for Guarded Control Stack (GCS)"
+	default y
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	help
+	  Guarded Control Stack (GCS) provides support for a separate
+	  stack with restricted access which contains only return
+	  addresses.  This can be used to harden against some attacks
+	  by comparing return address used by the program with what is
+	  stored in the GCS, and may also be used to efficiently obtain
+	  the call stack for applications such as profiling.
+
+	  The feature is detected at runtime, and will remain disabled
+	  if the system does not implement the feature.
+
+endmenu # "v9.4 architectural features"
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y

-- 
2.39.2


