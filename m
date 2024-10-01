Return-Path: <linux-fsdevel+bounces-30581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AFA98C8AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EAB4B20D84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD41D015E;
	Tue,  1 Oct 2024 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVOwfzln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E7194AD1;
	Tue,  1 Oct 2024 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823690; cv=none; b=nw9M+AcuYjsoVQGjViQApBPZeJauzMnkf7ZSt7sQrj0SbXHgZQberUA0J8+AucdMcpYgwZjj6lBfxZfH85EInRCiePx8bHnchCpidh7n7HcyZp2MjGrIHKR8Sxl5ncNIlgK7EJFtHQcjTqczl1E+HxJyW9Y3MbDPy29g+cKi+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823690; c=relaxed/simple;
	bh=cWAEuqYZg+17LABQvN9oRF3fUQ66H1+faDLiqviD7Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3tGikya+V2BeOyA8Pr9R2naulIYPQ7WuhRF3JKGRFwpFnvrAOed9FfxekUOfCFfseD+iQvL/rQ0lYDZqtMXsbvNFSXga0ezW9wDtWe4MzlF3OrUKLWdjjTFwWSbg4oA+Cawm4hXE5kj2H606/PoYrk8894VPCtrfjZBxqtLj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVOwfzln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7FFC4CEC6;
	Tue,  1 Oct 2024 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823690;
	bh=cWAEuqYZg+17LABQvN9oRF3fUQ66H1+faDLiqviD7Rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JVOwfzlnQ1yPBDbyHnBgjdhX8SQ8mjDy1QRkyFkl+gx37UIxMkNToKrHVI1wydeCy
	 RvfGEfIUbYLBkyn5jLSMtS4EU1FuCrXR9nErfytRVB8rKmIeiUyzqTAXya3u5hSYSW
	 ZBqvuVQ+khkZqPwaAr87X/XDdwoPeZijmcaMzMRbnvSldy09sAicXE81Snt3Ig6vI0
	 OC4JtKB6DHV97T5dceAw0Jo4Bhxw6j2Y/6yYFnKqZbGelN+KxP2Y/5mZwrYxZIAI4z
	 3LSsPRBfwp/s0bVks8hgqIqV80OhU249mQTsriYGh3sReyLGn6wuVQhtXoHqTkFdWt
	 MzUy1utdiCF1g==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:47 +0100
Subject: [PATCH v13 08/40] arm64/sysreg: Add definitions for architected
 GCS caps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-8-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cWAEuqYZg+17LABQvN9oRF3fUQ66H1+faDLiqviD7Rg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7KzFUM+Tl6KY9+ZmIs9ee3X2SFnChzVHp/wsKS
 BBUyQIuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+ygAKCRAk1otyXVSH0IRzB/
 40t5IAmsVTGi7QY/R5VsHa1iNQj0hKlpetd6TJOdMvRKsXR7+KpNuOvRgAkbhlDXCwJYjeU4V4pZTC
 49GPGeYHCub8P8aKfD8/+tiWv28sHcRKtOz1ur8l73Orsj2Cd/ed/JcBfulU4rXfyfI0SpWxr9JucH
 OwLTLsF1AA17SaFcrEInmJ2dOxjQOIIXfZ7+rCJWC1BBDKx5VwB19cZ07spFGUITn5wpQr3Gzb/8wK
 jyrS73oi0ChXeCFjRaYAEy8XRgWK3W/PS/rbmSvFxKS0Br/eqUVWIMTnB7+8JZ4zsPVbUs3ZdGhLY9
 5ld0bkuoXsL76SMw36DmJc7xoDL2LX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The architecture defines a format for guarded control stack caps, used
to mark the top of an unused GCS in order to limit the potential for
exploitation via stack switching. Add definitions associated with these.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9ea97dddefc4..9c98ff448bd9 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1101,6 +1101,26 @@
 /* Initial value for Permission Overlay Extension for EL0 */
 #define POR_EL0_INIT	POE_RXW
 
+/*
+ * Definitions for Guarded Control Stack
+ */
+
+#define GCS_CAP_ADDR_MASK		GENMASK(63, 12)
+#define GCS_CAP_ADDR_SHIFT		12
+#define GCS_CAP_ADDR_WIDTH		52
+#define GCS_CAP_ADDR(x)			FIELD_GET(GCS_CAP_ADDR_MASK, x)
+
+#define GCS_CAP_TOKEN_MASK		GENMASK(11, 0)
+#define GCS_CAP_TOKEN_SHIFT		0
+#define GCS_CAP_TOKEN_WIDTH		12
+#define GCS_CAP_TOKEN(x)		FIELD_GET(GCS_CAP_TOKEN_MASK, x)
+
+#define GCS_CAP_VALID_TOKEN		0x1
+#define GCS_CAP_IN_PROGRESS_TOKEN	0x5
+
+#define GCS_CAP(x)	((((unsigned long)x) & GCS_CAP_ADDR_MASK) | \
+					       GCS_CAP_VALID_TOKEN)
+
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Defined for compatibility only, do not add new users. */

-- 
2.39.2


