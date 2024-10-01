Return-Path: <linux-fsdevel+bounces-30604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BD798C925
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DA71C24197
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6969B1D0F61;
	Tue,  1 Oct 2024 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx1yRMnd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55291CF7D1;
	Tue,  1 Oct 2024 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823943; cv=none; b=pt0hDmduiI/rUvt1iNuciVqjSJumDx79kjvA73f9jWy06Kb2gebHeIuGiRUj4Xq9WLXImEweSmwOGfYWWT+7us+/iE8rMkB1eFZEGYzRDSMF/69JJyNvV0mUZq+8PoeycZ3CTYP4m/NWSTwkwV0svFsbMXVqAspVYBXvgiSvikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823943; c=relaxed/simple;
	bh=ioeceP+BFqA3jud12cOD0sJcVjWnQPo6t2cQSXLuyHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hx6sbFuw2IZRicwh6KKUCdHBFua700xWXhfEth/I5INp+Q8mGKNDwlFDUZN5G7/a9dr+fKbcSSH6NH5n9ErJWCGCWTb4i2lvSJLL7TTB/HN82O0AF167Neyo53/HlffMaCksJ/ruae1QUcatC+1XTktSqJPYno69+rAEpTAiVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx1yRMnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CC6C4CECD;
	Tue,  1 Oct 2024 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823943;
	bh=ioeceP+BFqA3jud12cOD0sJcVjWnQPo6t2cQSXLuyHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kx1yRMndAjUJvJPAMXQ2VC6z8G7NmOrbYUt2g6DGAQP0QBoyDPQi+1Se7fH8Pxi44
	 8mvl5WOTzRbf99m4gw2xagRAK2roEvxigIh1LXSaGpVE34YNdy5aUzv5WeL8D50IOT
	 LUIhobuoHDtNwmChk2d2L9GtjRFAmIkRCV/UIyyK9WYiAVu33DZwXkDtiAKB7Um1EA
	 EVPUikALWWsBe23EXO3le7nTxuwuXLjQ8OEss6r4D6OZptAp6Q/LVdwoGlMKt3MQVA
	 uGFLZvzjwVHUBTCE493ZGDPjR4ai6lU73zH9qbTRrb8MSLsUN1vOls8dpEDDhNArWo
	 uYO311Tyxczrg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:10 +0100
Subject: [PATCH v13 31/40] kselftest/arm64: Add framework support for GCS
 to signal handling tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-31-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ioeceP+BFqA3jud12cOD0sJcVjWnQPo6t2cQSXLuyHs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7cl2+Mx+1HhzjopTN729pEuYjBFsWKPZlO2MdU
 P92ymjqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+3AAKCRAk1otyXVSH0Ig8B/
 9GZyQlFK4iDt8NbeQZL9to6g92whSIQqB6IZ/45SH8X0FcRvl3aYwQRzVYoXwCsi7Rd7Wv899pD2hg
 ETXnYNckPSxj+/Hg+b1GAPnHeWVVBVjFf8tQZkfBj/aqGF7dehT2mEkIn7I6Ne5FEEegty03McxT3B
 SQ+9/X4Gicx8vTjF13/ij+9T9m+D2zXt56RjM4bGDcoEqX8z+sSm3fys+crSlDhD0b9wgtVkjrO2LG
 KqizOqhNT1kF2bGNuK5x+U3FUcjJ6C7g9QR0DUYFUb+s2hLLRGPa7qNnCVj8aIjJj1o7x1xiOmBXOj
 hPUP7NjNQh7lMAUg9LW0vgYN3lcBvk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Teach the framework about the GCS signal context, avoiding warnings on
the unknown context.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 7 +++++++
 tools/testing/selftests/arm64/signal/testcases/testcases.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index e6daa94fcd2e..0c1a6b26afac 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -198,6 +198,13 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 				*err = "Bad size for fpmr_context";
 			new_flags |= FPMR_CTX;
 			break;
+		case GCS_MAGIC:
+			if (flags & GCS_CTX)
+				*err = "Multiple GCS_MAGIC";
+			if (head->size != sizeof(struct gcs_context))
+				*err = "Bad size for gcs_context";
+			new_flags |= GCS_CTX;
+			break;
 		case EXTRA_MAGIC:
 			if (flags & EXTRA_CTX)
 				*err = "Multiple EXTRA_MAGIC";
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index 9872b8912714..98b97efdda23 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -20,6 +20,7 @@
 #define EXTRA_CTX	(1 << 3)
 #define ZT_CTX		(1 << 4)
 #define FPMR_CTX	(1 << 5)
+#define GCS_CTX		(1 << 6)
 
 #define KSFT_BAD_MAGIC	0xdeadbeef
 

-- 
2.39.2


