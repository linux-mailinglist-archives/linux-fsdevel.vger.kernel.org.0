Return-Path: <linux-fsdevel+bounces-23878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7FB9343C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 23:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA3284AA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 21:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75C186292;
	Wed, 17 Jul 2024 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPiqK0nH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5321CD26;
	Wed, 17 Jul 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251356; cv=none; b=X2B9Vw2fSCtI2qwHe4a2EDJgqq7Jvs6in8aBxRQfMtJNriyTxStrjQiOLiXNoDxl2U8aGWKkw8SHs0UNb7mMrhKZglsBYe5WKk5Rdb3XwoGhnZM5Zhw/+w1vMxsXo1URvWjX1uOCqnveKbVd9p8JR/+5/m1JwRmMerukPjX1hD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251356; c=relaxed/simple;
	bh=YCziOMnrRecac0Wts4T5B9xkrgY8ubZsqNRaZ+L02IM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KJoIaxrOVbxsmmaxyed4dXAzJ2hTtSlmly8N7WLQ+qZbL0VhkWq+zsPW1SVRq/2lwTRD4b6XShAJaOeQSpZflvfYwVEuFcgvMLy+rb8QdxP52MMg0Tq0QpOqolJ+UK714uIFUzm+gAlgrcZRO76VwEzelFC2hspgi6iPpklV7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPiqK0nH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C9DC2BD10;
	Wed, 17 Jul 2024 21:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721251355;
	bh=YCziOMnrRecac0Wts4T5B9xkrgY8ubZsqNRaZ+L02IM=;
	h=From:To:Cc:Subject:Date:From;
	b=hPiqK0nH3OOxE+BYCcq+liH41hELurgeXzrpbUs2wQWZZYR+wUv1tt4aDnMwphmkD
	 vGpAnE4YnT17aJa7Xup93Fjuk3kXMTTJXcoql2dn36CzLzMwIxavTqZTBHLk6sgs1B
	 cV0/6IB5cZ720Afe8C5+rNM67coZd6jLwoDKYc/EYX6eeH67iAQimrFNTzk1DsQTq1
	 PiRIELvK3ZGrgAbXErVr6aHlSy7S5+L1IlLtz9mjuETHKi/ORbaHxuGGRmtlml4g2t
	 rphNIfy9BlLPmgzJpFditPs2Z+9xHxeLj5OW1OoXWbjolRqUF/xvYYLcjJjz7XQUeg
	 6lDn5k/7jHCkg==
From: Kees Cook <kees@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	David Gow <davidgow@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] execve: Move KUnit tests to tests/ subdirectory
Date: Wed, 17 Jul 2024 14:22:34 -0700
Message-Id: <20240717212230.work.346-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666; i=kees@kernel.org; h=from:subject:message-id; bh=YCziOMnrRecac0Wts4T5B9xkrgY8ubZsqNRaZ+L02IM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmmDYZ6lDl5Gdke5gK3g98RQwDevl2XHLN5auYZ rOolZfBf+SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpg2GQAKCRCJcvTf3G3A Jo5VD/4nuVehBFuUbkYqfQGY4HxiAjH4wfC4/6lz+8Gr0mjWcIW22a+0bAEvrRJwzZB3Fo9QpGj MrAz30BLnnPAiBoZN9CIIHvH7Tbf5Kh/SuM1argM5qWeIRTD+nknPrHXdzwjnJazxscwrFkbaYz AVS2gNRdyVQu5o/WzCI52LMbb5iufVAl9qw5lyRzafPdemarOnMY83PBW78QbtE/uLEgD6lAiXH v/AbU79a9sfHe6A/KqGTDBSqhIqrCTvrDZtVKFUlkE8roM8vNrwmvDEUIzZbV/kvJkCXkDeR78j nod8sItmsa9IoHBkPLharsn+j/c8aOv6+78QpRxoYjEuwxwpd9V4GYMsgSS8zHZ8FFqx8DvXMcs jYyqnW7L3fsQPPU6Qnjv87n/+hp1bvWxoc/9H5AIDWlkVtl2o/8TbMPvdbm7D0nTJ2S0hw3CNM8 Hm/X/YeAqVq4etWd9nKLDlUiFkxxL7feH0jSmDvPX7YV3YLdoD1bbmmuPEL8Rfg+BYcVDepxXAP 8VtDg1SSdCqXKGIOYlSUdWyhh9RXEc4EuAmg0exB3OkIf5WIrTpBH798v/wO2yPzlY/ID9b7DPt ge9lWXiWPfBf3oMydJaTtkaag3C3hUflMIwRHLs1P4EVCYEY3ZX2DMx6pe79y7HpmFUuYTuXkEI p2cpJ7ub3cWrs
 Bw==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Move the exec KUnit tests into a separate directory to avoid polluting
the local directory namespace. Additionally update MAINTAINERS for the
new files and mark myself as Maintainer.

Signed-off-by: Kees Cook <kees@kernel.org>
---
I'll toss this into -next and send it to Linus before -rc1 closes.
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 MAINTAINERS                      | 5 +++--
 fs/binfmt_elf.c                  | 2 +-
 fs/exec.c                        | 2 +-
 fs/{ => tests}/binfmt_elf_test.c | 0
 fs/{ => tests}/exec_test.c       | 0
 5 files changed, 5 insertions(+), 4 deletions(-)
 rename fs/{ => tests}/binfmt_elf_test.c (100%)
 rename fs/{ => tests}/exec_test.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8dfbe998f175..35474718c05b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8211,8 +8211,8 @@ S:	Maintained
 F:	rust/kernel/net/phy.rs
 
 EXEC & BINFMT API, ELF
+M:	Kees Cook <keescook@chromium.org>
 R:	Eric Biederman <ebiederm@xmission.com>
-R:	Kees Cook <keescook@chromium.org>
 L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
@@ -8220,7 +8220,8 @@ F:	Documentation/userspace-api/ELF.rst
 F:	fs/*binfmt_*.c
 F:	fs/Kconfig.binfmt
 F:	fs/exec.c
-F:	fs/exec_test.c
+F:	fs/tests/binfmt_*_test.c
+F:	fs/tests/exec_test.c
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
 F:	include/uapi/linux/binfmts.h
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 40111451aa95..1a032811b304 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2152,5 +2152,5 @@ core_initcall(init_elf_binfmt);
 module_exit(exit_elf_binfmt);
 
 #ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
-#include "binfmt_elf_test.c"
+#include "tests/binfmt_elf_test.c"
 #endif
diff --git a/fs/exec.c b/fs/exec.c
index 5b580ff8d955..5a59063c50b1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2244,5 +2244,5 @@ fs_initcall(init_fs_exec_sysctls);
 #endif /* CONFIG_SYSCTL */
 
 #ifdef CONFIG_EXEC_KUNIT_TEST
-#include "exec_test.c"
+#include "tests/exec_test.c"
 #endif
diff --git a/fs/binfmt_elf_test.c b/fs/tests/binfmt_elf_test.c
similarity index 100%
rename from fs/binfmt_elf_test.c
rename to fs/tests/binfmt_elf_test.c
diff --git a/fs/exec_test.c b/fs/tests/exec_test.c
similarity index 100%
rename from fs/exec_test.c
rename to fs/tests/exec_test.c
-- 
2.34.1


