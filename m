Return-Path: <linux-fsdevel+bounces-22376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2F916BAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0A91F27CF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EE917B511;
	Tue, 25 Jun 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBApK9Cr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1C17109B;
	Tue, 25 Jun 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327684; cv=none; b=IjU+kBWvJ4Ey//q9IW6LkoAfEL/B0g1NGh0uIwEi/PAT2CyiomDMoEITxnaJMcHlB/IfeZgfQz+9r+8ugt0BXdX+DsyPAH0NhbXZ6nqmgc6Bhmcu+fy0akdpsJ88/wX5YpSowZ9hRJhf90+eyCoywrqDHP8dNZNCtiA1i4mqpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327684; c=relaxed/simple;
	bh=OtVuYnhHZ3Ff9iifqi0z8zMYVHFXjow5mOcREWek5jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WjHyIWqqZFJ64jFYLz3GIHEYritFm5qJyAEdP+l2tvLxwzqAoE4gVJ1AL9/ESZM37aEfC/YdsI/PRc790S2XetNj16Oe+qBCUQ35ja6mTsNXss5w8S5DBQ7miZsmGjWrj8JL7tNwBTBTRZ+1pgBKcmc8TQEIsH9UCJMDC0E3L14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBApK9Cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0C7C4AF0C;
	Tue, 25 Jun 2024 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327684;
	bh=OtVuYnhHZ3Ff9iifqi0z8zMYVHFXjow5mOcREWek5jw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tBApK9CrubSeAIcZz7A44caQcV2AMjXOrBWKOAQ3YTROjS6A3B4P8v4DYUloTh3iu
	 L2JunxfQe6hZaIBlEPk9nSW/4o4pQZmJ/DFcV3ws0UAQ2v71qgRnh8O5ROxwbkVS2u
	 Od4fFEhLHznvAgb0qV5QQr4wYTOrgQxeo8iT/UyiHXH2mwQ2Gv2eBlAo0sUKyHa2/H
	 EpnCO7nOAwCEH3PE/YoT1josQRX1DA+TcpWW/DUzAO+2gk4RVwbzuTXJNrK+uZkuae
	 1NtJZFXhf4RCRNResyygODc36rxxsXvch8b78J0So8bQnWcrBWUvDry124M1g2R/jY
	 7LKsbul7AtnxA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:34 +0100
Subject: [PATCH v9 06/39] arm64/sysreg: Add definitions for architected GCS
 caps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-6-0f634469b8f0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OtVuYnhHZ3Ff9iifqi0z8zMYVHFXjow5mOcREWek5jw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmett2xSPtaVh5MhskCkWC9d+Vs/ZeudvczR6T8fnM
 pi3EiCKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbdgAKCRAk1otyXVSH0A6RB/
 9c9lgKwWs8KNFn8y602zbLtUWWDwRky5DJm0wa9ndVkr99Np3G6Sgp0kjHCrAME1Jhs3loF7ZRybJP
 cE8qjsWIDeZ5xnO1Xyk9fkQnHnEnm+mx6iD3x4MjqpDs+Llqis9IJMXZUXdHhR+S5XUJHaNOUmE9d4
 OVBHUXg7rMVfhK+/LBd9eQgwyt+T37LYbSEJE4mDUJL25MGhqGZ/C7KVwXwFLuAD9Ego1WlN6c1Jux
 E69W8dgNbYY5tptjL9vw8zgrp+QLEHvMwCxgPYkTzlK49PHBow+u8sN1eOjKFNvIYEKwHwcmDTHJWI
 ofycDRnMbkf8lWLsyocl3/o+4LmsPY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The architecture defines a format for guarded control stack caps, used
to mark the top of an unused GCS in order to limit the potential for
exploitation via stack switching. Add definitions associated with these.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index af3b206fa423..325a1daa98ed 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1064,6 +1064,26 @@
 #define POE_RXW		UL(0x7)
 #define POE_MASK	UL(0xf)
 
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


