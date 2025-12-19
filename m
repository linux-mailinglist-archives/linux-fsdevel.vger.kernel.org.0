Return-Path: <linux-fsdevel+bounces-71759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E1ACD1173
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 18:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC09430169BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CEB35FF51;
	Fri, 19 Dec 2025 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu2dCyJi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B235F8C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766161008; cv=none; b=QWDW0eqCjQZcgkUxU+cRqpoIYXMxngzLHQcQZLEAxAIFM2W80XQs4jlcCz4i94T9rz1ZrucrCllh5q63S4T3Wcq79L/7SC+3VD9xj0kyhmb+yQMOnJKQTx7POZJU4wht4Z0X1WvdAh6AR15koLFLWs6ZYqmjechg/YPbeqm64ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766161008; c=relaxed/simple;
	bh=47hL5I2ijXMcmF1JU7EI3Nhpa9ZQCp3egcgt0wmJuoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/1YbIzP2KIWzKkppd8HpjrG1U0juKXDYCK1S+qCXp2R4D05rHplgM2LxCxJyssn2kLG64kSJciZAVlEVJ4dMButyFWgY0/4WTnylc/tAvzj0deaJXpj6bV85v0KCjSLSf0Gw3ZVVyI9vWHwt/Q6iDXQS3xoYwc+NLq/Lw8crGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu2dCyJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9ACC4CEF1;
	Fri, 19 Dec 2025 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766161007;
	bh=47hL5I2ijXMcmF1JU7EI3Nhpa9ZQCp3egcgt0wmJuoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cu2dCyJigvnIJ4mGAhXUE+8LQLSdMxxsf9j1n6iwtD4VW3+uKb8f1+ydeAa7BQ8zQ
	 S+h9zdfukpR/1sKyw8Nv2b86nr52SGY6JZoNsmB5Wlxv/HpNKUZ1oXRuc0+whL4nPQ
	 n8M07pw863419mdts5E4xVdf+QQ2GL+hgz0UuwBsKdv5/oe1ChTaWfxhmL2BLv8sjy
	 7Ck7DTgFi+BX8xgYCywqy7IxdyCa5XadbES2il8LMaf0eu342WX+CZTNt8Tb22655s
	 bKaqIzztqrF73J1cLSW9sVWu65aIlAguqbxhWwd5aHrU7UWeTQGhofmrZ2lJaFtSVA
	 ZF79v11xxcRBQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthew Wilcox <willy@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH 2/4] ARM: add CONFIG_VMSPLIT_2G_OPT option
Date: Fri, 19 Dec 2025 17:15:57 +0100
Message-Id: <20251219161559.556737-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219161559.556737-1-arnd@kernel.org>
References: <20251219161559.556737-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Unlike x86 and powerpc, there is currently no option to use exactly 2GiB
of lowmem on Arm. Since 2GiB is still a relatively common configuration
on embedded systems, it makes sense to allow this to be used in
non-highmem builds.

Add the Kconfig option and make this the default for non-LPAE builds
with highmem enabled instead of CONFIG_VMSPLIT_2G.  LPAE still requires
the vmsplit to be on a gigabyte boundary, so this is only available for
classic pagetables at the moment, same as CONFIG_VMSPLIT_3G_OPT.

Tested in qemu -M virt, both with and without HIGHMEM enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7c0ac017e086..921ea61aa96e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1009,7 +1009,8 @@ config BL_SWITCHER_DUMMY_IF
 choice
 	prompt "Memory split"
 	depends on MMU
-	default VMSPLIT_2G if HIGHMEM || ARM_LPAE
+	default VMSPLIT_2G if ARM_LPAE
+	default VMSPLIT_2G_OPT if HIGHMEM
 	default VMSPLIT_3G_OPT
 	help
 	  Select the desired split between kernel and user memory.
@@ -1026,6 +1027,9 @@ choice
 		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
+	config VMSPLIT_2G_OPT
+		depends on !ARM_LPAE
+		bool "2G/2G user/kernel split (for full 2G low memory)"
 	config VMSPLIT_1G
 		bool "1G/3G user/kernel split"
 endchoice
@@ -1034,6 +1038,7 @@ config PAGE_OFFSET
 	hex
 	default PHYS_OFFSET if !MMU
 	default 0x40000000 if VMSPLIT_1G
+	default 0x70000000 if VMSPLIT_2G_OPT
 	default 0x80000000 if VMSPLIT_2G
 	default 0xB0000000 if VMSPLIT_3G_OPT
 	default 0xC0000000
@@ -1042,6 +1047,7 @@ config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN
 	default 0x1f000000 if PAGE_OFFSET=0x40000000
+	default 0x4f000000 if PAGE_OFFSET=0x70000000
 	default 0x5f000000 if PAGE_OFFSET=0x80000000
 	default 0x9f000000 if PAGE_OFFSET=0xC0000000
 	default 0x8f000000 if PAGE_OFFSET=0xB0000000
-- 
2.39.5


