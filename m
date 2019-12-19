Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37690126014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 11:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLSK4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 05:56:36 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:53288 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLSK4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:56:36 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 47dphx0fNmzQlBH;
        Thu, 19 Dec 2019 11:56:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id B7u5OQElizV3; Thu, 19 Dec 2019 11:56:29 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        David Laight <david.laight@aculab.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        dev@opencontainers.org, containers@lists.linux-foundation.org,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] openat2: drop open_how->__padding field
Date:   Thu, 19 Dec 2019 21:55:30 +1100
Message-Id: <20191219105533.12508-3-cyphar@cyphar.com>
In-Reply-To: <20191219105533.12508-1-cyphar@cyphar.com>
References: <20191219105533.12508-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of explicit padding was to allow us to use the space in the
future (C provides no guarantee about the value of padding bytes and
thus userspace could've provided garbage).

However, the downside of explicit padding is that any extension we wish
to add should fit the space exactly (otherwise we may end up with a u16
which will never be used). In addition, the correct error to return for
non-zero padding is not clear (-EINVAL doesn't imply "you're using an
extension field unsupported by this kernel", but -E2BIG seems a bit odd
if the structure size isn't different).

The simplest solution is to just match the design of clone3(2) -- use
u64s for all fields. The extra few-bytes cost of extra fields is not
significant (it's unlikely configuration structs will ever be extremely
large) and it allows for more flag space if necessary.

As openat2(2) is not yet in Linus's tree, we can iron out these minor
warts before we commit to this as a stable ABI.

Suggested-by: David Laight <david.laight@aculab.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/open.c                                     |  2 --
 include/uapi/linux/openat2.h                  |  3 +--
 tools/testing/selftests/openat2/helpers.h     |  3 +--
 .../testing/selftests/openat2/openat2_test.c  | 24 +++++++------------
 4 files changed, 10 insertions(+), 22 deletions(-)

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
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index 19ef775e8e5e..76fad4ada2d4 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -16,8 +16,7 @@
  */
 struct open_how {
 	__aligned_u64 flags;
-	__u16 mode;
-	__u16 __padding[3]; /* must be zeroed */
+	__aligned_u64 mode;
 	__aligned_u64 resolve;
 };
 
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index 43ca5ceab6e3..d756775d0725 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -37,8 +37,7 @@
  */
 struct open_how {
 	__aligned_u64 flags;
-	__u16 mode;
-	__u16 __padding[3]; /* must be zeroed */
+	__aligned_u64 mode;
 	__aligned_u64 resolve;
 };
 
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0b64fedc008b..b386367c606b 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -40,7 +40,7 @@ struct struct_test {
 	int err;
 };
 
-#define NUM_OPENAT2_STRUCT_TESTS 10
+#define NUM_OPENAT2_STRUCT_TESTS 7
 #define NUM_OPENAT2_STRUCT_VARIATIONS 13
 
 void test_openat2_struct(void)
@@ -57,20 +57,6 @@ void test_openat2_struct(void)
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
 		/* TODO: Once expanded, check zero-padding. */
 
 		/* Smaller than version-0 struct. */
@@ -169,7 +155,7 @@ struct flag_test {
 	int err;
 };
 
-#define NUM_OPENAT2_FLAG_TESTS 21
+#define NUM_OPENAT2_FLAG_TESTS 23
 
 void test_openat2_flags(void)
 {
@@ -214,9 +200,15 @@ void test_openat2_flags(void)
 		{ .name = "invalid how.mode and O_CREAT",
 		  .how.flags = O_CREAT,
 		  .how.mode = 0xFFFF, .err = -EINVAL },
+		{ .name = "invalid (very large) how.mode and O_CREAT",
+		  .how.flags = O_CREAT,
+		  .how.mode = 0xC000000000000000ULL, .err = -EINVAL },
 		{ .name = "invalid how.mode and O_TMPFILE",
 		  .how.flags = O_TMPFILE | O_RDWR,
 		  .how.mode = 0x1337, .err = -EINVAL },
+		{ .name = "invalid (very large) how.mode and O_TMPFILE",
+		  .how.flags = O_TMPFILE | O_RDWR,
+		  .how.mode = 0x0000A00000000000ULL, .err = -EINVAL },
 
 		/* ->resolve must only contain RESOLVE_* flags. */
 		{ .name = "invalid how.resolve and O_RDONLY",
-- 
2.24.0

