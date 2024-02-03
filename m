Return-Path: <linux-fsdevel+bounces-10174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FCC84860E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0421C21829
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D067A73E;
	Sat,  3 Feb 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGYfE4kQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193FA5FB81;
	Sat,  3 Feb 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963577; cv=none; b=Aki6pwWqB1cNHVtA7v8gM6UTxgjxGbMHIFzU2L1Fa4w78CBNf+nI14OxeSuyQgKtaWqKWEmlDj9VEaZg6S7Lg2bW7+i+IvVhnijUyawRJOKT+mwWjJbiAlMHfJRqNt+vIaIpAFOsQm7OdlkFH706SUckBIrE7tsUkE5UHrus/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963577; c=relaxed/simple;
	bh=DtrqsekNxnVEUxJ8rAESK/JTguJ8OvysbbylOwjoIT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMgtnstdQeWcoTrLbFlH5Evy6YBkhlvDFE+snhmlViscEeX0p7WpU7W7zPhh233yAD7o+K/v4i6iINr+bsUP1pBKw3DQeZSKjniko+rzCCgYGdV9+qA4CAshxlxQuKbzAAs2RlvVtzt8TEe+28q4pTjXdshmrJHMI9GNao2zU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGYfE4kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898ABC433F1;
	Sat,  3 Feb 2024 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963576;
	bh=DtrqsekNxnVEUxJ8rAESK/JTguJ8OvysbbylOwjoIT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HGYfE4kQfFJTkP+Wqk8QZtSm5RueAXKxjESpueLeH7HPY7j4/myKGkfJ/UO+kZLh7
	 VmEtxEktqR5oV7tLUjrqVK0h58wp6sqQVThoC95tFeif4sRU53w7Ohn0PxU45EF1rp
	 +aRmnGvth+vUGx1hOYgwjOnEb39QVh52CSZcozaGFHhiNcmycgW7u+/U6KxX4vqJti
	 ioyuktkoRfEolu6A2hd4MrU/LlzrhXmXnT1Jd4pNNHPm9NtjDWKpJ9I1n0MW5Cw1XY
	 C485bROd/xTJIrAV+3TsH1rv+AIz9rhWjehFzpLEgi5GutqJI/ZaSELkEuAzvECzPM
	 EbRR3wYBa1LpA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:55 +0000
Subject: [PATCH v8 29/38] kselftest/arm64: Add framework support for GCS to
 signal handling tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-29-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DtrqsekNxnVEUxJ8rAESK/JTguJ8OvysbbylOwjoIT0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDnOVaHEEY7+NXAHmCg/VtR09vNp/bX1TdG9fwL
 Tx65GRaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w5wAKCRAk1otyXVSH0FlKB/
 98DOBU/u0IXok/Y7pavvt27Ga+5AFK+X7M4Gm1LULE6Yd0z4a1VMfHZnEMGqp8Pzn3n8zAItI7CBIP
 ewOFrR5SPZbvYqb8s0OQxWwzHGWkqrz+6XiZAtdY1z+ijSFOEm2fJ3Qrb3QMaqlI3yUst/QDAfSR8W
 4vPxCYl/hSoqqlWbEXPMcR9P80SnN/grc5/vx0SerNYmyYKrOvJ26hngl6HIpgBJ1LiC7s3vEzfRCj
 Yq/guQu9c0fDL3JCGOxha0pESNb+rwBL6mpBWC6gthrLRNSAOcdlT6PjxpgYvzWVjA/K+P5tT/mM1k
 VATLPwnO13OC+VbJeZiCnFuMPgU0Zy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Teach the framework about the GCS signal context, avoiding warnings on
the unknown context.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 7 +++++++
 tools/testing/selftests/arm64/signal/testcases/testcases.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 9f580b55b388..1cd124732be4 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -209,6 +209,13 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			zt = (struct zt_context *)head;
 			new_flags |= ZT_CTX;
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
index a08ab0d6207a..9b2599745c29 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -19,6 +19,7 @@
 #define ZA_CTX		(1 << 2)
 #define EXTRA_CTX	(1 << 3)
 #define ZT_CTX		(1 << 4)
+#define GCS_CTX		(1 << 5)
 
 #define KSFT_BAD_MAGIC	0xdeadbeef
 

-- 
2.30.2


