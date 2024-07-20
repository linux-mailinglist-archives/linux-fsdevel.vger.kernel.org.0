Return-Path: <linux-fsdevel+bounces-24043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF3D938237
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 19:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CB9B212A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C546A147C82;
	Sat, 20 Jul 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5Dg2ad4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890E372;
	Sat, 20 Jul 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721495002; cv=none; b=brdUtvHVX+4bpMF5P7IgLN+Bx66XjwqpUKSUvwwdCeAk21oHKwGGGvNJZZ/I/wAIfA1ill+P3Qi43xV4WIis5uKqhIIM0iYLGOkWnsJ9i3bjgcDZ7GMderXzSPTFqWwuhfGMxXJHdXrBj5ySrrUqEd65MFmj0cqeBjQk2XfPj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721495002; c=relaxed/simple;
	bh=qEBnWjm61+wRL7eX7/aXBBow1IWLbMAFODhMXVKb66I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JvhHtMxLq4YnuEQkIH4VVkASrYiQOFgnVRJmb6Ok3qSV85RqJ0ZZzOaNFT8b5loV5mhNGfUJCfuvU6fBIOYf3Nmmp5oKHQZfNybxYNqUwfhiKVjeBHOKiXDy0mKxKoS+5B1YIMZcFi5IQ4okMYNEu1qLo2D3RNgAxGePbaFdjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5Dg2ad4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906AAC2BD10;
	Sat, 20 Jul 2024 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721495001;
	bh=qEBnWjm61+wRL7eX7/aXBBow1IWLbMAFODhMXVKb66I=;
	h=From:To:Cc:Subject:Date:From;
	b=B5Dg2ad45KT0c+aLELUY73/HAtGV0LUyYyyCQIQ3V5vKWqEBuJRiSwzZPKphZ8kDf
	 LUTypv8n6DiTx3KaCR5g2IJTlWyZL6pnooxye/0914n+njnCfySNckMHTGQzhH0Ykc
	 lcLSzJs/UNhb/c0y01zlLq7scJY6Lw7mOlkFOwxa3P3qpF3uvpaZl+7Io1UtJ9r7m/
	 1c2CuB1dFir4cbRnNR4/Ak76nHilJIBzzFVATVlphDB5P+ipa2B33tLaq2NTQ1NuxZ
	 Ph8ZKkPWLHWL5EKhIf2KbDRLs+3KK5igy+9nqo6ojGudBfmeOTRYII4bMuINJBtBaU
	 qYiU9oEYJ7H6g==
From: Kees Cook <kees@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] execve: Move KUnit tests to tests/ subdirectory
Date: Sat, 20 Jul 2024 10:03:14 -0700
Message-Id: <20240720170310.it.942-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3013; i=kees@kernel.org; h=from:subject:message-id; bh=qEBnWjm61+wRL7eX7/aXBBow1IWLbMAFODhMXVKb66I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmm+3S2HZ6G04SOgBaf9X+62wdW1PD/xOdySwpS zQvUQDcMn+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpvt0gAKCRCJcvTf3G3A Jk8QD/9EfZpLg6iOLyQ4Dg0xACvfCEXKq8zLBTn5Sh9/QL/0sd8qANQ55YcNuTTD3do7gY4l/5o Lgn+SdVj8xHwDsXIK98k6PoACOa/7dZ7Rq4cvx1233JcgD3eDpLtzwPNFDJcimcJuRpKs/pW70H mVtZrQ1Cp6W2ZgJ4+eZVcdgPzpMxXO5ZjjW6GKLBmPiWjRV3aNb4Cn38AgsPqYas1TZE1yJWUUm pX0lOBLLN18y58UYvdy6A4jY/skZkawIYztFytr0fga81BmBsXR11I9nvliTk9RhulTAC2jTnP3 maMlJyJ0p5GYOBSgbZV05eTSDLP6xyP6bbx6325savLbu8W6vxSPVJckOczUvxpriqgJFsm/UyO eWWhPztdKnIKoxk/3uBp7wYVuW6jVSwf/fsflkwrb4OKILlvjAcSTNGR5v/6FFksKdezaNLgEaT pS6CNIGNR22/jw0bQrqhZW9Plu/86CKiMIR7191iWXyjXW/VMae3BaZmxm4kzilxGx7vtKP4pQx OUF7/8PbLayR8SqOxLnrKuxAX8PPPTC74Owm58xFDolw/EWCaawCqHgTtW6NOjI0CZQyaB1GcHE /b//nIoqUUnghDoQmFjGt8Ezcgru1hFOD8N7N+YMWLtRiaIXwoq9MqXGruulHNnE6YKdsGDvZCc kOW46yLGjK8GP
 kg==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Move the exec KUnit tests into a separate directory to avoid polluting
the local directory namespace. Additionally update MAINTAINERS for the
new files and mark myself as Maintainer.

Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v1: https://lore.kernel.org/lkml/20240717212230.work.346-kees@kernel.org/
 v2: file suffix changed to _kunit instead of _test
I'll toss this into -next and send it to Linus before -rc1 closes.
---
Cc: David Gow <davidgow@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 MAINTAINERS                                        | 5 +++--
 fs/binfmt_elf.c                                    | 2 +-
 fs/exec.c                                          | 2 +-
 fs/{binfmt_elf_test.c => tests/binfmt_elf_kunit.c} | 0
 fs/{exec_test.c => tests/exec_kunit.c}             | 0
 5 files changed, 5 insertions(+), 4 deletions(-)
 rename fs/{binfmt_elf_test.c => tests/binfmt_elf_kunit.c} (100%)
 rename fs/{exec_test.c => tests/exec_kunit.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8dfbe998f175..396bd1f1e4b9 100644
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
+F:	fs/tests/binfmt_*_kunit.c
+F:	fs/tests/exec_kunit.c
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
 F:	include/uapi/linux/binfmts.h
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 40111451aa95..04e748c5955f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2152,5 +2152,5 @@ core_initcall(init_elf_binfmt);
 module_exit(exit_elf_binfmt);
 
 #ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
-#include "binfmt_elf_test.c"
+#include "tests/binfmt_elf_kunit.c"
 #endif
diff --git a/fs/exec.c b/fs/exec.c
index 5b580ff8d955..32d6537ece07 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2244,5 +2244,5 @@ fs_initcall(init_fs_exec_sysctls);
 #endif /* CONFIG_SYSCTL */
 
 #ifdef CONFIG_EXEC_KUNIT_TEST
-#include "exec_test.c"
+#include "tests/exec_kunit.c"
 #endif
diff --git a/fs/binfmt_elf_test.c b/fs/tests/binfmt_elf_kunit.c
similarity index 100%
rename from fs/binfmt_elf_test.c
rename to fs/tests/binfmt_elf_kunit.c
diff --git a/fs/exec_test.c b/fs/tests/exec_kunit.c
similarity index 100%
rename from fs/exec_test.c
rename to fs/tests/exec_kunit.c
-- 
2.34.1


