Return-Path: <linux-fsdevel+bounces-18620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B438C8BACFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E5EB22C8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F073153BC2;
	Fri,  3 May 2024 13:02:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A883015357D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741346; cv=none; b=e1eD/mG58x+KIc9TLxl5NwVlBtn71hGTPgNzRH0kH4cIEoSNLT2EFDrD1gpfRWFa8ueTjY/fbdGLcY+UkRdecmBChF7V/vKRy1OhqHurWAfpeMvZQR5JNjLLM0fFK2Wl9zr5Ta7hhDfi0yYx6lLldieRFw4zYCGnKh7Pfi8buGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741346; c=relaxed/simple;
	bh=8zlAb2LXqzm+y9Kq+yYFjSQ26oumXjkOAFar2LNZqmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNBm/Wel+gF69X76mwJ6VVY2mrs7jhTt35H/mG3npunXldhKTZ929nesrS6CracSLLgnxT2IxmnUpYiOlLcxtODRYoLzJ1jnRCMIcTeGLlNN9KNYOJM+/7rbdIiMCFFAf+SmtjuFswx9lpenbfyGxJpyMoJ2NjBnK7dgMc9Vo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9246B1682;
	Fri,  3 May 2024 06:02:50 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412BC3F73F;
	Fri,  3 May 2024 06:02:22 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: [PATCH v4 09/29] KVM: arm64: use `at s1e1a` for POE
Date: Fri,  3 May 2024 14:01:27 +0100
Message-Id: <20240503130147.1154804-10-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503130147.1154804-1-joey.gouly@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FEAT_ATS1E1A introduces a new instruction: `at s1e1a`.
This is an address translation, without permission checks.

POE allows read permissions to be removed from S1 by the guest.  This means
that an `at` instruction could fail, and not get the IPA.

Switch to using `at s1e1a` so that KVM can get the IPA regardless of S1
permissions.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/include/hyp/fault.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/fault.h b/arch/arm64/kvm/hyp/include/hyp/fault.h
index 487c06099d6f..17df94570f03 100644
--- a/arch/arm64/kvm/hyp/include/hyp/fault.h
+++ b/arch/arm64/kvm/hyp/include/hyp/fault.h
@@ -14,6 +14,7 @@
 
 static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
 {
+	int ret;
 	u64 par, tmp;
 
 	/*
@@ -27,7 +28,9 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
 	 * saved the guest context yet, and we may return early...
 	 */
 	par = read_sysreg_par();
-	if (!__kvm_at(OP_AT_S1E1R, far))
+	ret = system_supports_poe() ? __kvm_at(OP_AT_S1E1A, far) :
+	                              __kvm_at(OP_AT_S1E1R, far);
+	if (!ret)
 		tmp = read_sysreg_par();
 	else
 		tmp = SYS_PAR_EL1_F; /* back to the guest */
-- 
2.25.1


