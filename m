Return-Path: <linux-fsdevel+bounces-26629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA895AA02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D57D2826A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9081BC49;
	Thu, 22 Aug 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAC6VEWh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90E13C90A;
	Thu, 22 Aug 2024 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289730; cv=none; b=tUrYlMPpIXrRBi3RW5jdvX8Gv/E26oiYY7MKeD0AnV48NHLvWVQaumMBnl296IcUbgJ7v6JLPCHKpcapVjHzSpQmlVl17bSHmer7qFcoNXKx8aLUjX1pQjvEXhztqqsvgP2YtAt+iJaqqe7R1yhWXpAJFx9pCQ+e3nImyh7U9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289730; c=relaxed/simple;
	bh=sPSz542BQgC8GDr8WCulUI2iE6roG4Js5HwD3OcoqCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/VaYWgeT7FuKOJd4sf+aJN69Jma/lCNH4NhJ2gnTvn+XxLDEvph14Dl3xgOeR5wu6xQtsX8JhYvtKKA7zrBTiGF00MVtmtLXUxNYn+P2wQXk8ws0sOeWip4T8fz8uM7cf3knffRFuoA005rOHdm7wofZtW7AJ0QEHznXGZ10r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAC6VEWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A24C32781;
	Thu, 22 Aug 2024 01:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289729;
	bh=sPSz542BQgC8GDr8WCulUI2iE6roG4Js5HwD3OcoqCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uAC6VEWhqTL+cBNI2eAUFI40yJ6zaIbicFzZHIA9aVQhz9+Nmj1EPHgtejkleUwU2
	 9eoLbSp2FoFQTA9mHeTOqm6a/cmAGA0AFvzkvpmrMcOK0GOF4qWO+Sg5XE5dDs7fdY
	 DjtdvHZaCyv1G/PS0AfMPwUsDQCeuOC58d/2Qe1JQN/XW4WpNaD3f9ZrtCM2FB3Tgf
	 u6GwLRRCSsqUp/M1on4cDxitAMb4pBdeTW2QVEyeDMzaaLfINMhdkjGI5CIBxaIi9M
	 4abWcFCb9kARtAD6hw6hMCqfdRGtMxnPISIgSGFhJn1v1uNlGlpwE5OA9wUTgn4u+2
	 dQ8Lz1RMoBGvA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:33 +0100
Subject: [PATCH v11 30/39] kselftest/arm64: Add framework support for GCS
 to signal handling tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-30-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sPSz542BQgC8GDr8WCulUI2iE6roG4Js5HwD3OcoqCo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpE7VRZgG2Z7/DOjWxHR2ISARiB0523hr1ytG8M7
 JL8y1+CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaROwAKCRAk1otyXVSH0EQUB/
 4keLewH0EzA9rHUse6NUxquX1JhR5vNrTj+fWGR0Iuq3Jd7vUcyPg1KOgUkrJbapQqOa7/MvsfkH2P
 snPa1PsqGlRCYJMszDiUb4y9NmpGrG5vtHoctMSNxgEm/2WdgD9KAN5LP/WVJLijPAQ1QfXhodpTx7
 FvXCsBAOmHxJ0BypQiv2yDwUhqLqUzlbsaGWGtuye5kO5OT8o/pRmysdBh/1U2FW92ZtKNo+iB3qNZ
 jEFOn4MtGN+pUdl1PvzyJGXfiPOA0Ry9FrSkLzpgvro1tLNymg+WYe3FBnZDoDsaOVGmDDz/+05kZY
 yqMAf+H3DK8lyrZ396WQp3EudgGO+V
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
index 674b88cc8c39..49d036e97996 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -217,6 +217,13 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
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
index 7727126347e0..dc3cf777dafe 100644
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


