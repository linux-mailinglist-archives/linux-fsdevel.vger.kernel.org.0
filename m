Return-Path: <linux-fsdevel+bounces-22371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFDC916B8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9DB1C251A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D147E16F0ED;
	Tue, 25 Jun 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/DeTr8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3416DEA4;
	Tue, 25 Jun 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327648; cv=none; b=LK6YktooCjyR1wXqba+XeZ2QQEcy75qjOG1HFF4o/mEaIFpJBN5/J+LtMpeM8p3WEILqoJ3calDJB9fosgBAVNpLPQR1BTX4zSNzWpn7YbybizK08i2sUWsAsFoM7V3lpqgp4EkG0M88GtSZEpOmjlGS1IClB/DudOxbLhzF0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327648; c=relaxed/simple;
	bh=bsiMqAlOgEwP0cbRhsqWxUT30GAWtj7CcR/m2yEY+EM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1TC6xBDtuf5l62MQNahrqnrW4wp88coQrRZh3FiH7sF5ojzGrGf1Rx76zuNW+dxfc8WJ6Ay4cgI53YUucO0y47y08Nin56FQ2yhTSe9n80SH4BD+LhnrxZVdG4juE3IhK+1N5b9PjIF/qG93TQqCfWxEGI8xHOFKkb8WtVkbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/DeTr8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4B5C4AF0D;
	Tue, 25 Jun 2024 15:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327647;
	bh=bsiMqAlOgEwP0cbRhsqWxUT30GAWtj7CcR/m2yEY+EM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l/DeTr8DtWFxGVC0HSS5cpujEUcCgKLCZdzEw1O9VJ2Y4+V401JvdWm7738DDT2/C
	 G31QUqtzxIQZYudpEY0/P5f2zr7w1zPdsTPrEbkp5lmRa2tsGlqVdN0CyC1dp6NjtL
	 ELltzeKbigD9l+7ZGj84vGJd+3Uqd4d6bk4ACP8dyOyavMy/Oaewyx3t1Q8fZb319K
	 Gqdq1v0FTLFQvDNb784RnjnjMGe10RcOmczkA5hsJNRyqwCfmZ5A8PWj+63UUI0/J3
	 pp6kLurbonsGGkBgjQnu3gHPCidOe++OBQ9irsvejwzmw+SvRVZeM17QnuBInZ4aah
	 hUj2m/22++x8A==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:29 +0100
Subject: [PATCH v9 01/39] arm64/mm: Restructure arch_validate_flags() for
 extensibility
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-1-0f634469b8f0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bsiMqAlOgEwP0cbRhsqWxUT30GAWtj7CcR/m2yEY+EM=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrSq28XSrHeTDQNbdl0X0BCQ+rpHkPMtP8d2NzG3RUzHQzoy
 7sR2MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQATEatn/8OVLK9tLPw9cH7NJM1ajY
 fK+jNFwy/NbM93yxcLMmBMVcja8Gbirm3POx4XMj4I41xe9pop+rUF8682uRZLjk28NszHFd5cqpx/
 j7vQWzJz4bzta5OXTe5SFBWZ6TShQze17E7yRqfk9212NYGh0S5X6kr14lXCunZP+bDy8NSVBTVtU6
 R010Uof3l5SzrbkbWe4dDihxdOVb51+VHL9T+ta9Pp3L6Z/ruMU2OEuOc1326Pn22nkf60uO7OcQHB
 Zhn+so3s6m6xu2o+L3s9PzDuSfYpi8QNnz5Z/NoXuZFVxLh2vnzbqiU1UWFNdxR3SYf/X3FdRmH6bb
 OewP3bQgO2rb38+iVD9o3lDDorAQ==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently arch_validate_flags() is written in a very non-extensible
fashion, returning immediately if MTE is not supported and writing the MTE
check as a direct return. Since we will want to add more checks for GCS
refactor the existing code to be more extensible, no functional change
intended.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/mman.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..c21849ffdd88 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -52,11 +52,17 @@ static inline bool arch_validate_prot(unsigned long prot,
 
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


