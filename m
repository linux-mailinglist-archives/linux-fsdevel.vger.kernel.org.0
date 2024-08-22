Return-Path: <linux-fsdevel+bounces-26626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9B995A9F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF37D1F21C7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2726139CF6;
	Thu, 22 Aug 2024 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkmOBJHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31B10A3D;
	Thu, 22 Aug 2024 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289697; cv=none; b=CJwXWJimrOuZ/1oyn1Bb4gxnreCGM3LZb6U00edEPoi2Uk5OOt+V+Z69mnq4l0GK6ZWVfQK7vW2eQyzpXqRqlv2B6XRA/hBNGO5d7wTU4EnJUL5PLADt9a0zjreFf1Sj0MQXp3chZgBpUvo/sEWUEYJyRJWLlONKKe18C5/HgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289697; c=relaxed/simple;
	bh=dtxeJFa9YuBd+oBMECBxmd/jn10TctjlQUazqWWROYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPtueyxCWvnfnWdvJyb5xH3KLtGCLd1BcICI3h/quJ9b5BuKNL3fs5XS/Y0BErAjQZyTZJMKmpmVR2F8Tn+npG4G2S4vqYSDIJyN6DM29n2Zr5Eo33FDEn+RyFnvvvzwX55YTlzybtRsOXGmlakzoebEoup2IgvfACDIh4cx1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkmOBJHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108E0C32781;
	Thu, 22 Aug 2024 01:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289696;
	bh=dtxeJFa9YuBd+oBMECBxmd/jn10TctjlQUazqWWROYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NkmOBJHKojz8DSwM6nYzZvbL6emtNKUeA7JkKQLB8uH5taYHO+I14fWAwDNwrTKB7
	 0T32RnpajPiK9jC/FzglUYmAX7r6zJ59RUqRXBuSXJOxiXwjDb/UhKmPt1EbV3ufOc
	 dABlspAytswhq3Yzqww+v8myDmkXdtcKm9zrxvD8OIuvPeFnFDZfB3cE4jYYHWU1MH
	 ABwSvvvgZs1w3wnnWqKyZr2EE4xwgT1y9mEuLK1fbheEle6qSyi79MUSXiYkZSLxsr
	 SMDNlWpcM1ouaNsCfzmPBC+6Ds78A3H+FewAEcvhF+RTUbpS8mk13nVcAVNHuCBOTm
	 zkNQ59HZYJQIw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:30 +0100
Subject: [PATCH v11 27/39] arm64: Add Kconfig for Guarded Control Stack
 (GCS)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-27-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dtxeJFa9YuBd+oBMECBxmd/jn10TctjlQUazqWWROYc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpE4HX3waWR6P/nVlIS4iaRLKyJcXdN5BJ4frnqU
 HySFidqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaROAAKCRAk1otyXVSH0EsBB/
 4ota43I49BjlXLJArTjty05r+82yt0hMdYO4E5E3AqVvSo6NYPm/EaH0sjMV4CXVYPSK7O8E5RULwI
 70ZaN0kEcZcK7zfvzjnAUtxbQzQHxSo7KjIdrxwbReqbfZPJ2pcPCSPV57KutXRs6RpslMVS5Z7BDw
 bbgqBqDLv/lywndPg1znx2CFWWtZt9YgogyB3inCURWJFCpBsXqacbrtLejVxu9M2ESDMz9qkZyjVC
 BKMU3Fnvs6t1nq3gwuX4cnK7QzcBudiUV3jP3Cyjh64/YAqArluaXS9tRZK51HZOWT1qS3x918virB
 wdZaz1Pctay537JnWPba0phAwyJKVB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a Kconfig option allowing the user to select if GCS support is
built into the kernel.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..772f9ba99fe8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2137,6 +2137,26 @@ config ARM64_EPAN
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


