Return-Path: <linux-fsdevel+bounces-22397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E7C916C2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F144A1F2B9E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D7183083;
	Tue, 25 Jun 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2xsFbIE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF5178390;
	Tue, 25 Jun 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327827; cv=none; b=jyQcEvahRjouMDy/bNIen2ZlApX95N5gdqGQvXQGg1NQ7vjHfCc2eLPMQi6m0ZhE+Wlj6i01tHhc8iJCsD0eJTx+uL/7FyiSEMuScWtOw4ScLxtKFizsDGPyIyVZreel5expyALa+KmugNXeeC2VZaiqdQthxyUA30FaA5ueo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327827; c=relaxed/simple;
	bh=fjC2QiGsrbMcCkXrGFM5RiSenF/23moS6IQnQJ7tLdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBuW22muShTdQHKwckDMSwxtt5jjjE+z+iQpMQ88JjotNRLT+Z9ndtvtjE17EmsVr69cV8t7cWGhGzMQH3WtvxelvandRWmEl1rW9y3b4W/xj1mgP6aH9eQrFc+kNg9/VQku8yhug6IwYb7/Dfb+qXuNrbMWAFVM+Jl/B9Un5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2xsFbIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6C7C4AF0A;
	Tue, 25 Jun 2024 15:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327826;
	bh=fjC2QiGsrbMcCkXrGFM5RiSenF/23moS6IQnQJ7tLdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l2xsFbIETEPKGbR69SWsfYufg6rpbRn4aaptp5DtVcbSm+gRqRmpD2995e2y8WGim
	 eCRcbHiIQJ9pqY5hWpsMfCcDmmgdUqN5aJjCIFdPU70s2FqZgkpUwl0vGFg4JvUhqM
	 4R47oEbqzTI/WIzPgeKJ8EyaVVlcSIGP6vCKjtr9UfEomWTHc7ivJggF+Wsk89OTlh
	 wFjrot6UoGGCjUc+BQcPE4Hcrd/4lr2FjzLykKDT4Ars+AhqTtk0YUxWBXmBDuNa20
	 LK4zLQdD2O4gn8+MU+yZ3cskmZeebN965PyinB6Im0jRSXCXTS6IHMl5u/aRBwe8kH
	 3kXJHBn/ECzmQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:54 +0100
Subject: [PATCH v9 26/39] arm64: Add Kconfig for Guarded Control Stack
 (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-26-0f634469b8f0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fjC2QiGsrbMcCkXrGFM5RiSenF/23moS6IQnQJ7tLdI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmetuGg1xlcnXPlN04dXEBbnUnfgQS+G3jS350+dWn
 /izc6wKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbhgAKCRAk1otyXVSH0KfjB/
 9KWonE6xeKtgOTtQX2JO7awYH9lQ6LkvpJLYKruT/tw3b5S8asSEMPcfTcPyEneVXId/HNouOKa9RN
 wGGAWeR7McyjYD95XpmwDqTx4zPmmme9t2V0A6LxKTGf8/Zw3LuK9L9WP/4FiItiDYbKXFHHbR1MmS
 YrBnyYjZm0vjLZMMdI2vobtYQ2xicVgK00Qyr/80i1MP6FhmpFoNNYpYplfFJ9JcDJTl6SKx0ZVoTu
 +skJQfsafa6R60XpkYGtVyB3Och3vSkyNhNc/dLNxh/JH/oW7Sp0pYRTESkaxSdnQLoMFTzY5D5H+a
 7eWD6b20Ne30nkS0CHcIRuEvSi2DB8
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
index 5d91259ee7b5..248697a29d78 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2140,6 +2140,26 @@ config ARM64_EPAN
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


