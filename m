Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6211EDB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 23:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLMWZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 17:25:01 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:23782 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLMWZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:25:01 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 47ZQG13TJdzKmTp;
        Fri, 13 Dec 2019 23:24:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id d9EHptyMxc7J; Fri, 13 Dec 2019 23:24:54 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] openat2: switch to __attribute__((packed)) for open_how
Date:   Sat, 14 Dec 2019 09:23:50 +1100
Message-Id: <20191213222351.14071-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The design of the original open_how struct layout was such that it
ensured that there would be no un-labelled (and thus potentially
non-zero) padding to avoid issues with struct expansion, as well as
providing a uniform representation on all architectures (to avoid
complications with OPEN_HOW_SIZE versioning).

However, there were a few other desirable features which were not
fulfilled by the previous struct layout:

 * Adding new features (other than new flags) should always result in
   the struct getting larger. However, by including a padding field, it
   was possible for new fields to be added without expanding the
   structure. This would somewhat complicate version-number based
   checking of feature support.

 * A non-zero bit in __padding yielded -EINVAL when it should arguably
   have been -E2BIG (because the padding bits are effectively
   yet-to-be-used fields). However, the semantics are not entirely clear
   because userspace may expect -E2BIG to only signify that the
   structure is too big. It's much simpler to just provide the guarantee
   that new fields will always result in a struct size increase, and
   -E2BIG indicates you're using a field that's too recent for an older
   kernel.

 * While the alignment for u64s was manually backed by extra padding
   fields, some languages (such as Rust) do not currently support
   enforcing alignment of struct field members.

 * The padding wasted space needlessly, and would very likely not be
   used up entirely by future extensions for a long time (because it
   couldn't fit a u64).

While none of these outstanding issues are deal-breakers, we can iron
out these warts before openat2(2) lands in Linus's tree. Instead of
using alignment and padding, we simply pack the structure with
__attribute__((packed)). Rust supports #[repr(packed)] and it removes
all of the issues with having explicit padding.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/open.c                                      |  2 --
 include/uapi/linux/fcntl.h                     | 11 +++++------
 tools/testing/selftests/openat2/helpers.h      | 11 +++++------
 tools/testing/selftests/openat2/openat2_test.c | 18 +-----------------
 4 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 50a46501bcc9..8cdb2b675867 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -993,8 +993,6 @@ static inline int build_open_flags(const struct open_how *how,
 		return -EINVAL;
 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
 		return -EINVAL;
-	if (memchr_inv(how->__padding, 0, sizeof(how->__padding)))
-		return -EINVAL;
 
 	/* Deal with the mode. */
 	if (WILL_CREATE(flags)) {
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index d886bdb585e4..0e070c7f568a 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -109,17 +109,16 @@
  * O_TMPFILE} are set.
  *
  * @flags: O_* flags.
- * @mode: O_CREAT/O_TMPFILE file mode.
  * @resolve: RESOLVE_* flags.
+ * @mode: O_CREAT/O_TMPFILE file mode.
  */
 struct open_how {
-	__aligned_u64 flags;
+	__u64 flags;
+	__u64 resolve;
 	__u16 mode;
-	__u16 __padding[3]; /* must be zeroed */
-	__aligned_u64 resolve;
-};
+} __attribute__((packed));
 
-#define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
+#define OPEN_HOW_SIZE_VER0	18 /* sizeof first published struct */
 #define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
 
 /* how->resolve flags for openat2(2). */
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index 43ca5ceab6e3..eb1535c8fa2e 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -32,17 +32,16 @@
  * O_TMPFILE} are set.
  *
  * @flags: O_* flags.
- * @mode: O_CREAT/O_TMPFILE file mode.
  * @resolve: RESOLVE_* flags.
+ * @mode: O_CREAT/O_TMPFILE file mode.
  */
 struct open_how {
-	__aligned_u64 flags;
+	__u64 flags;
+	__u64 resolve;
 	__u16 mode;
-	__u16 __padding[3]; /* must be zeroed */
-	__aligned_u64 resolve;
-};
+} __attribute__((packed));
 
-#define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
+#define OPEN_HOW_SIZE_VER0	18 /* sizeof first published struct */
 #define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
 
 bool needs_openat2(const struct open_how *how);
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0b64fedc008b..cbf95d160b1b 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -40,7 +40,7 @@ struct struct_test {
 	int err;
 };
 
-#define NUM_OPENAT2_STRUCT_TESTS 10
+#define NUM_OPENAT2_STRUCT_TESTS 7
 #define NUM_OPENAT2_STRUCT_VARIATIONS 13
 
 void test_openat2_struct(void)
@@ -57,22 +57,6 @@ void test_openat2_struct(void)
 		  .arg.inner.flags = O_RDONLY,
 		  .size = sizeof(struct open_how_ext) },
 
-		/* Normal struct with broken padding. */
-		{ .name = "normal struct (non-zero padding[0])",
-		  .arg.inner.flags = O_RDONLY,
-		  .arg.inner.__padding = {0xa0, 0x00, 0x00},
-		  .size = sizeof(struct open_how_ext), .err = -EINVAL },
-		{ .name = "normal struct (non-zero padding[1])",
-		  .arg.inner.flags = O_RDONLY,
-		  .arg.inner.__padding = {0x00, 0x1a, 0x00},
-		  .size = sizeof(struct open_how_ext), .err = -EINVAL },
-		{ .name = "normal struct (non-zero padding[2])",
-		  .arg.inner.flags = O_RDONLY,
-		  .arg.inner.__padding = {0x00, 0x00, 0xef},
-		  .size = sizeof(struct open_how_ext), .err = -EINVAL },
-
-		/* TODO: Once expanded, check zero-padding. */
-
 		/* Smaller than version-0 struct. */
 		{ .name = "zero-sized 'struct'",
 		  .arg.inner.flags = O_RDONLY, .size = 0, .err = -EINVAL },

base-commit: 912dfe068c43fa13c587b8d30e73d335c5ba7d44
-- 
2.24.0

