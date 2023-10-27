Return-Path: <linux-fsdevel+bounces-1406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0A7D9F91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F5FB21A19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C023DFE0;
	Fri, 27 Oct 2023 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B33DFE1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:09:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6594FAC;
	Fri, 27 Oct 2023 11:09:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C04221424;
	Fri, 27 Oct 2023 11:10:29 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2A533F64C;
	Fri, 27 Oct 2023 11:09:45 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 18/24] kselftest/arm64: move get_header()
Date: Fri, 27 Oct 2023 19:08:44 +0100
Message-Id: <20231027180850.1068089-19-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027180850.1068089-1-joey.gouly@arm.com>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put this function in the header so that it can be used by other tests, without
needing to link to testcases.c.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 .../arm64/signal/testcases/testcases.c        | 23 -----------------
 .../arm64/signal/testcases/testcases.h        | 25 +++++++++++++++++--
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 9f580b55b388..fe950b6bca6b 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -6,29 +6,6 @@
 
 #include "testcases.h"
 
-struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
-				size_t resv_sz, size_t *offset)
-{
-	size_t offs = 0;
-	struct _aarch64_ctx *found = NULL;
-
-	if (!head || resv_sz < HDR_SZ)
-		return found;
-
-	while (offs <= resv_sz - HDR_SZ &&
-	       head->magic != magic && head->magic) {
-		offs += head->size;
-		head = GET_RESV_NEXT_HEAD(head);
-	}
-	if (head->magic == magic) {
-		found = head;
-		if (offset)
-			*offset = offs;
-	}
-
-	return found;
-}
-
 bool validate_extra_context(struct extra_context *extra, char **err,
 			    void **extra_data, size_t *extra_size)
 {
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index a08ab0d6207a..d33154c9a4bd 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -87,8 +87,29 @@ struct fake_sigframe {
 
 bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err);
 
-struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
-				size_t resv_sz, size_t *offset);
+static inline struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
+				size_t resv_sz, size_t *offset)
+{
+	size_t offs = 0;
+	struct _aarch64_ctx *found = NULL;
+
+	if (!head || resv_sz < HDR_SZ)
+		return found;
+
+	while (offs <= resv_sz - HDR_SZ &&
+	       head->magic != magic && head->magic) {
+		offs += head->size;
+		head = GET_RESV_NEXT_HEAD(head);
+	}
+	if (head->magic == magic) {
+		found = head;
+		if (offset)
+			*offset = offs;
+	}
+
+	return found;
+}
+
 
 static inline struct _aarch64_ctx *get_terminator(struct _aarch64_ctx *head,
 						  size_t resv_sz,
-- 
2.25.1


