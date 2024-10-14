Return-Path: <linux-fsdevel+bounces-31880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1CB99C7E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 13:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9EE1C23499
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0385D1A4F2A;
	Mon, 14 Oct 2024 10:59:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8A19D077;
	Mon, 14 Oct 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903594; cv=none; b=azqBMwU83uzBfJJzMRR9pGXLlLmhYqTaX+snY+h7MID5dTzY5CKgmSL0gr3FhdURVpMqgcr/vohxx3pOOEsTjSNyGTxJ0KT7sg2l4stC5n+4hkyrf1lTMciNV+icQs0nYqR8NmWN8tpNiFcr5wALJj7tvOIvjgc9obW20qLY/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903594; c=relaxed/simple;
	bh=3XfQ5I8mWAlXuJQxSqs2Kf702tOHKF3RE2BktmUIEOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJ8zj0N1a5Vc07C68wqqR7Gw9rDHKg51+6xJviWGwUGVmGF+xqO+tOrw8fPz9BHtHriiUvnKid3AZPvup5YXJfIYiMPYrHmUK8Fuq1CG9UO8fe529zQCDEbzYSusX4A2kd31rALNB0bpSBYjphEyEVoeVbgLfX0ADz0mqJ1Yjlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FE2A1688;
	Mon, 14 Oct 2024 04:00:22 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B86113F51B;
	Mon, 14 Oct 2024 03:59:49 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 08/57] fs: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:15 +0100
Message-ID: <20241014105912.3207374-8-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

In binfmt_elf, convert CPP conditional to C ternary operator; this will
be folded to the same code by the compiler when in compile-time page
size mode, but will also work for runtime evaluation in boot-time page
size mode.

In coredump, modify __dump_skip() to emit zeros in blocks of
PAGE_SIZE_MIN. This resolves to the previous PAGE_SIZE for compile-time
page size, but that doesn't work for boot-time page size. PAGE_SIZE_MIN
is preferred here over PAGE_SIZE_MAX to save memory.

Wrap global variables that are initialized with PAGE_SIZE derived values
using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
deferred for boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 fs/binfmt_elf.c | 11 ++++-------
 fs/coredump.c   |  8 ++++----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 19fa49cd9907f..e439d36c43c7e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -84,11 +84,8 @@ static int elf_core_dump(struct coredump_params *cprm);
 #define elf_core_dump	NULL
 #endif
 
-#if ELF_EXEC_PAGESIZE > PAGE_SIZE
-#define ELF_MIN_ALIGN	ELF_EXEC_PAGESIZE
-#else
-#define ELF_MIN_ALIGN	PAGE_SIZE
-#endif
+#define ELF_MIN_ALIGN							\
+	(ELF_EXEC_PAGESIZE > PAGE_SIZE ? ELF_EXEC_PAGESIZE : PAGE_SIZE)
 
 #ifndef ELF_CORE_EFLAGS
 #define ELF_CORE_EFLAGS	0
@@ -98,7 +95,7 @@ static int elf_core_dump(struct coredump_params *cprm);
 #define ELF_PAGEOFFSET(_v) ((_v) & (ELF_MIN_ALIGN-1))
 #define ELF_PAGEALIGN(_v) (((_v) + ELF_MIN_ALIGN - 1) & ~(ELF_MIN_ALIGN - 1))
 
-static struct linux_binfmt elf_format = {
+static DEFINE_GLOBAL_PAGE_SIZE_VAR(struct linux_binfmt, elf_format, {
 	.module		= THIS_MODULE,
 	.load_binary	= load_elf_binary,
 	.load_shlib	= load_elf_library,
@@ -106,7 +103,7 @@ static struct linux_binfmt elf_format = {
 	.core_dump	= elf_core_dump,
 	.min_coredump	= ELF_EXEC_PAGESIZE,
 #endif
-};
+});
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
diff --git a/fs/coredump.c b/fs/coredump.c
index 7f12ff6ad1d3e..203f2a158246e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -825,7 +825,7 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 
 static int __dump_skip(struct coredump_params *cprm, size_t nr)
 {
-	static char zeroes[PAGE_SIZE];
+	static char zeroes[PAGE_SIZE_MIN];
 	struct file *file = cprm->file;
 	if (file->f_mode & FMODE_LSEEK) {
 		if (dump_interrupted() ||
@@ -834,10 +834,10 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 		cprm->pos += nr;
 		return 1;
 	} else {
-		while (nr > PAGE_SIZE) {
-			if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
+		while (nr > PAGE_SIZE_MIN) {
+			if (!__dump_emit(cprm, zeroes, PAGE_SIZE_MIN))
 				return 0;
-			nr -= PAGE_SIZE;
+			nr -= PAGE_SIZE_MIN;
 		}
 		return __dump_emit(cprm, zeroes, nr);
 	}
-- 
2.43.0


