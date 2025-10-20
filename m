Return-Path: <linux-fsdevel+bounces-64778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E3BF3CEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 232354F6BBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236ED2F12D9;
	Mon, 20 Oct 2025 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE0pAF6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5509E2D0C62;
	Mon, 20 Oct 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997679; cv=none; b=fJfQ856Q8Am7NpJt8otykHEU5mhziRQHq7UmDqcD5CatawAaisltP8+wMS2rAKsjlslNgcwTSa0CdgMP9xUOIVa/j3ko1U93D75Mmu0Won+MzSE24M05V43r8ZSbm/6MH7bN1W8EY8ZtGZU4E65UNoKYeYHhsuJd1lbdo+R5TPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997679; c=relaxed/simple;
	bh=7+0qu+Gu0CqwtZbcxHs4OLhPuV8Fj8KuBq9/KFtLGnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=un0aObGtPLr8f0Gr40N3bJhoZoZgajBoq/MCf8Y1ckNcKw3N0wo3ZoGS23TE+huOd9ccwQq2OvGI27R6W9FKdJyy1uQoKWLx8SX40QIugjT0Y+/qiiVDKlg+ckH0PcXUkcDQugZ76h62ofsrJpoA2NyfNElrSJPljHUJIxLs/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE0pAF6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7890C116D0;
	Mon, 20 Oct 2025 22:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760997678;
	bh=7+0qu+Gu0CqwtZbcxHs4OLhPuV8Fj8KuBq9/KFtLGnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IE0pAF6gtzyz+Wp8tXsF0dcWrkIeTEu5HXMsKrLz1Z9AR8nJ4i4ZMkUDzDgF0m8pH
	 Fjt3tygypFFzHVgFYMT2f+r1oNO5zwEOIBGwUcjiGqYE/xr3XggqMnGsDo3wWBv9TR
	 wbeGozBQhFYF5UGcf84xMxcqIZVtsQsvySEucBErs96Cz8c9qYhJpS1oDRGTMOVGrx
	 a/23yabAl6nMWrW5Y8caWSxwlQHom8Ik9mBsjxGDFEzbHhwZs8sw52J3DpGqwhyw5b
	 WPMRpd/NuB6s0Xa24OAPH2EUn0/sJmpyybDyZtzsB6roGJK/V5tqj/XcbIQqFBRmR3
	 3sFq4LqpwHz4w==
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Tamir Duberstein <tamird@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	kernel test robot <lkp@intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Yafang Shao <laoar.shao@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Christopher Ferris <cferris@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] lkdtm/bugs: Add __counted_by_ptr() test PTR_BOUNDS
Date: Mon, 20 Oct 2025 15:01:16 -0700
Message-Id: <20251020220118.1226740-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020220005.work.095-kees@kernel.org>
References: <20251020220005.work.095-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4744; i=kees@kernel.org; h=from:subject; bh=7+0qu+Gu0CqwtZbcxHs4OLhPuV8Fj8KuBq9/KFtLGnY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfNur8unplg3+cLl+j6ZMb02M/feXZ4V00bcPbk1vlZ +jW/als7ihlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjIvWxGhkPTVYrmBLvdX/wt U/qSt9K/luwf/Nk3j4kVfTOWj/9UcoOR4VjH9uQz1wTE5fNa7zXVOzzu7dT9G6dts8N6e9Orshm MDAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Provide run-time validation of the __counted_by_ptr() annotation via
newly added PTR_BOUNDS LKDTM test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/lkdtm/bugs.c               | 90 ++++++++++++++++++++++---
 tools/testing/selftests/lkdtm/tests.txt |  2 +
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 376047beea3d..a069a7d686fc 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -414,32 +414,32 @@ static void lkdtm_ARRAY_BOUNDS(void)
 		pr_expected_config(CONFIG_UBSAN_BOUNDS);
 }
 
-struct lkdtm_annotated {
+struct lkdtm_cb_fam {
 	unsigned long flags;
 	int count;
 	int array[] __counted_by(count);
 };
 
-static volatile int fam_count = 4;
+static volatile int element_count = 4;
 
 static void lkdtm_FAM_BOUNDS(void)
 {
-	struct lkdtm_annotated *inst;
+	struct lkdtm_cb_fam *inst;
 
-	inst = kzalloc(struct_size(inst, array, fam_count + 1), GFP_KERNEL);
+	inst = kzalloc(struct_size(inst, array, element_count + 1), GFP_KERNEL);
 	if (!inst) {
 		pr_err("FAIL: could not allocate test struct!\n");
 		return;
 	}
 
-	inst->count = fam_count;
+	inst->count = element_count;
 	pr_info("Array access within bounds ...\n");
-	inst->array[1] = fam_count;
+	inst->array[1] = element_count;
 	ignored = inst->array[1];
 
 	pr_info("Array access beyond bounds ...\n");
-	inst->array[fam_count] = fam_count;
-	ignored = inst->array[fam_count];
+	inst->array[element_count] = element_count;
+	ignored = inst->array[element_count];
 
 	kfree(inst);
 
@@ -454,6 +454,79 @@ static void lkdtm_FAM_BOUNDS(void)
 		pr_expected_config(CONFIG_UBSAN_BOUNDS);
 }
 
+struct lkdtm_extra {
+	short a, b;
+	u16 sixteen;
+	u32 bigger;
+	u64 biggest;
+};
+
+struct lkdtm_cb_ptr {
+	int a, b, c;
+	int nr_extra;
+	char *buf __counted_by_ptr(len);
+	size_t len;
+	struct lkdtm_extra *extra __counted_by_ptr(nr_extra);
+};
+
+static noinline void check_ptr_len(struct lkdtm_cb_ptr *p, size_t len)
+{
+	if (__member_size(p->buf) != len)
+		pr_err("FAIL: could not determine size of inst->buf: %zu\n",
+			__member_size(p->buf));
+	else
+		pr_info("good: inst->buf length is %zu\n", len);
+}
+
+static void lkdtm_PTR_BOUNDS(void)
+{
+	struct lkdtm_cb_ptr *inst;
+
+	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
+	if (!inst) {
+		pr_err("FAIL: could not allocate struct lkdtm_cb_ptr!\n");
+		return;
+	}
+
+	inst->buf = kzalloc(element_count, GFP_KERNEL);
+	if (!inst->buf) {
+		pr_err("FAIL: could not allocate inst->buf!\n");
+		return;
+	}
+	inst->len = element_count;
+
+	/* Double element_count */
+	inst->extra = kcalloc(element_count * 2, sizeof(*inst->extra), GFP_KERNEL);
+	inst->nr_extra = element_count * 2;
+
+	pr_info("Pointer access within bounds ...\n");
+	check_ptr_len(inst, 4);
+	/* All 4 bytes */
+	inst->buf[0] = 'A';
+	inst->buf[1] = 'B';
+	inst->buf[2] = 'C';
+	inst->buf[3] = 'D';
+	/* Halfway into the array */
+	inst->extra[element_count].biggest = 0x1000;
+
+	pr_info("Pointer access beyond bounds ...\n");
+	ignored = inst->extra[inst->nr_extra].b;
+
+	kfree(inst->extra);
+	kfree(inst->buf);
+	kfree(inst);
+
+	pr_err("FAIL: survived access of invalid pointer member offset!\n");
+
+	if (!IS_ENABLED(CONFIG_CC_HAS_COUNTED_BY_PTR))
+		pr_warn("This is expected since this %s was built with a compiler that does not support __counted_by_ptr\n",
+			lkdtm_kernel_info);
+	else if (IS_ENABLED(CONFIG_UBSAN_BOUNDS))
+		pr_expected_config(CONFIG_UBSAN_TRAP);
+	else
+		pr_expected_config(CONFIG_UBSAN_BOUNDS);
+}
+
 static void lkdtm_CORRUPT_LIST_ADD(void)
 {
 	/*
@@ -716,6 +789,7 @@ static struct crashtype crashtypes[] = {
 	CRASHTYPE(OVERFLOW_UNSIGNED),
 	CRASHTYPE(ARRAY_BOUNDS),
 	CRASHTYPE(FAM_BOUNDS),
+	CRASHTYPE(PTR_BOUNDS),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index cff124c1eddd..204d4a669632 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -9,6 +9,8 @@ EXCEPTION
 #CORRUPT_STACK Crashes entire system on success
 #CORRUPT_STACK_STRONG Crashes entire system on success
 ARRAY_BOUNDS call trace:|UBSAN: array-index-out-of-bounds
+FAM_BOUNDS call trace:|UBSAN: array-index-out-of-bounds
+PTR_BOUNDS call trace:|UBSAN: array-index-out-of-bounds
 CORRUPT_LIST_ADD list_add corruption
 CORRUPT_LIST_DEL list_del corruption
 STACK_GUARD_PAGE_LEADING
-- 
2.34.1


