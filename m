Return-Path: <linux-fsdevel+bounces-22373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200F7916B99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCAA1F2342D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6643A176AD5;
	Tue, 25 Jun 2024 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzTxWTli"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534016F8FB;
	Tue, 25 Jun 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327661; cv=none; b=IqCzaCYZNc9FwYYu3UmoxMq+7usrB2ejH9K6ScFDbI0www8vRqbaWKK6nLLmFjMm1DcMw+m6/ocWqtAjGxgwb9tzfoC6GZqVOWzQ3FzPL5gad9lrM28I+SqeWFBPo/dZWf4HcVdX4F/ZCJ6xjQNCAczb9xbAp4WguheOHsZnU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327661; c=relaxed/simple;
	bh=2jWl08+8re+Jbyu9WlYwMAOos2oJrw5SQjRGnUXuA4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MW4hjGH8rDHs1Tenwi6PML/Nzzomd/YSqi06d6kDqDF0VaXiuFsYqSrz82YiKB5GtKNa+aDHvibc6tHVd18+QHxD6oR5Jhq45/vZy0gSlWMIHqjnyPM1xs/O91jRCqt2CMR/mrOPtAVYMHXGbRCWUcTmOwA3PhfI9drWjsA05wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzTxWTli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F182C32786;
	Tue, 25 Jun 2024 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327661;
	bh=2jWl08+8re+Jbyu9WlYwMAOos2oJrw5SQjRGnUXuA4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mzTxWTliTuTTk2JUY2LHGWlCpOYNhYQnbqbOaFCe1eKW3ChL80lwGsA7v15pLtIRr
	 /CY5sah9wnG+/M/txc13UoiuTO17cga0aTsKBhWydbMUTpqWTnXbQDAs1a0SfXHdLl
	 qoVcTGQynXNZq/6dMkLB1GEjLpGe+SlvF97AnPT4nal9BAJupDUdL6g1YvtgvjwhMw
	 U7N5JBpsOck0pb6hjzSqcgOGUvjanbOjMt0n1yZOv7628rSels/zwtth3YaW1p5bfT
	 c78+EMP6WFoUlDyn7SE6zLhy3h7EzsZ6bHr8FIMO+0yD80LEqzwuQEWN6u9EWokxPR
	 RHWBkVwDixtzw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:31 +0100
Subject: [PATCH v9 03/39] mman: Add map_shadow_stack() flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-3-0f634469b8f0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2jWl08+8re+Jbyu9WlYwMAOos2oJrw5SQjRGnUXuA4U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmett0AYMvTd4M+mUQzuB+sU2VGcUcJh2k6ep8k/Oa
 xyt8GD+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbdAAKCRAk1otyXVSH0Le7B/
 4p0K3blNBx+osPkkQaCF9XLApSwBKl8n26fdMeAmlfh9bwsWryKXKzkHHLO75WHM/ERBc/0i0yBbEz
 zKduRjPO+mSToFcQa1HgNifE5HXJ2OsSGNnQq71vZtOnDHVzxP+UwGe431j5UV5/6dHUMIj9lfY0g+
 6MJKhHwJ43INBah+hkUj4yNnSmM/eK4Ujfo3CuMqn6aBRXjQlxqsRH1KoLQR0q0d1YBUN6/pV2jCCx
 BTzIJ/gM/FsVYtegicohXfVWCnHv41lXYJL7HVDBny0rtyvj+u6H7erniqjPqueHr2ZBKmWeO293xS
 kwYER8Ltdo/507ycRN89NL9U18KQ/V
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for adding arm64 GCS support make the map_shadow_stack()
SHADOW_STACK_SET_TOKEN flag generic and add _SET_MARKER. The existing
flag indicats that a token usable for stack switch should be added to
the top of the newly mapped GCS region while the new flag indicates that
a top of stack marker suitable for use by unwinders should be added
above that.

For arm64 the top of stack marker is all bits 0.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/include/uapi/asm/mman.h | 3 ---
 include/uapi/asm-generic/mman.h  | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 46cdc941f958..ac1e6277212b 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -5,9 +5,6 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 #define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
-/* Flags for map_shadow_stack(2) */
-#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
-
 #include <asm-generic/mman.h>
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index 57e8195d0b53..d6a282687af5 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -19,4 +19,8 @@
 #define MCL_FUTURE	2		/* lock all future mappings */
 #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
 
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_MARKER (1ULL << 1)     /* Set up a top of stack merker in the shadow stack */
+
+
 #endif /* __ASM_GENERIC_MMAN_H */

-- 
2.39.2


