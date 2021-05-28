Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02332393FEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhE1J2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 05:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhE1J23 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 05:28:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A2CB6127A;
        Fri, 28 May 2021 09:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622194014;
        bh=n7L8THJ3hgZnP0QknCDp3CNVsn2J9iLiP7bBjnxa8/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8nGVd+7W0rKD5PftV8egcAMuatHe4J+OZtYV19FwqQFAHfZquYE+leRb2IC3gYvt
         wOXn7EHa6rjwWcmK6TrQpigfUZf+gLjjMkJsfMyWE+pmE0P2AP3b/62Q3dDFpJNdw9
         dcE4j5IheFRI35++VXbGxNacmwkaA9um4dZVNobg3B8dyDSRlUPvWUbcXaS43M70GM
         2LnW4SEBEG4uRn+hNToRpWpSADwYZ+FE+h/f/CxEudyG7VRNGRsXaFZGUkI2rev30N
         gKsI2RszmhHxAEdtWNcPE/q8lHPhdbRm5YUTzhC6UBe19EV4R8/RWXCxrj4vqjDRgq
         9Cf5lEa8vMGGQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 2/3] open: don't silently ignore unknown O-flags in openat2()
Date:   Fri, 28 May 2021 11:24:16 +0200
Message-Id: <20210528092417.3942079-3-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528092417.3942079-1-brauner@kernel.org>
References: <20210528092417.3942079-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=6HfI8flciKZB4VJnvGhErn3MBardNcPBqXfs5h/OfHw=; m=/i3HZZPKrmP04P+3mxM9YAOUPpHgr0g11FybAeMMEik=; p=NhmB7D6ZKh509a1KOnsYyxxVfeBSiBZ7igGZNN3BR3g=; g=de67de0e05d85c0da892ea52f4de0f5e1b5519a9
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYLC2egAKCRCRxhvAZXjcoij8AP9XPXl 44vksthPj4/+j9WHtdJ1Q8xK0S4MBt28P7cKEiwEAv5nt5d97XgTj97gtcPjyKTatf7xQsth/Ts8y sJGXCgI=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The new openat2() syscall verifies that no unknown O-flag values are
set and returns an error to userspace if they are while the older open
syscalls like open() and openat() simply ignore unknown flag values:

  #define O_FLAG_CURRENTLY_INVALID (1 << 31)
  struct open_how how = {
          .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID,
          .resolve = 0,
  };

  /* fails */
  fd = openat2(-EBADF, "/dev/null", &how, sizeof(how));

  /* succeeds */
  fd = openat(-EBADF, "/dev/null", O_RDONLY | O_FLAG_CURRENTLY_INVALID);

However, openat2() silently truncates the upper 32 bits meaning:

  #define O_FLAG_CURRENTLY_INVALID_LOWER32 (1 << 31)
  #define O_FLAG_CURRENTLY_INVALID_UPPER32 (1 << 40)

  struct open_how how_lowe32 = {
          .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID_LOWER32,
  };

  struct open_how how_upper32 = {
          .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID_UPPER32,
  };

  /* fails */
  fd = openat2(-EBADF, "/dev/null", &how_lower32, sizeof(how_lower32));

  /* succeeds */
  fd = openat2(-EBADF, "/dev/null", &how_upper32, sizeof(how_upper32));

Fix this by preventing the immediate truncation in build_open_flags().

There's a snafu here though stripping FMODE_* directly from flags would
cause the upper 32 bits to be truncated as well due to integer promotion
rules since FMODE_* is unsigned int, O_* are signed ints (yuck).

In addition, struct open_flags currently defines flags to be 32 bit
which is reasonable. If we simply were to bump it to 64 bit we would
need to change a lot of code preemptively which doesn't seem worth it.
So simply add a compile-time check verifying that all currently known
O_* flags are within the 32 bit range and fail to build if they aren't
anymore.

This change shouldn't regress old open syscalls since they silently
truncate any unknown values anyway. It is a tiny semantic change for
openat2() but it is very unlikely people pass ing > 32 bit unknown flags
and the syscall is relatively new too.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reported-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Richard Guy Briggs <rgb@redhat.com>:
  - Add an explicit BUILD_BUG_ON() to check when we need to change
    struct open_flags to account for O_* flags > 32 bits.
---
 fs/open.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index e53af13b5835..53bc0573c0ec 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1002,12 +1002,20 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 
 inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 {
-	int flags = how->flags;
+	u64 flags = how->flags;
+	u64 strip = FMODE_NONOTIFY | O_CLOEXEC;
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
-	/* Must never be set by userspace */
-	flags &= ~(FMODE_NONOTIFY | O_CLOEXEC);
+	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPEN_FLAGS),
+			 "struct open_flags doesn't yet handle flags > 32 bits");
+
+	/*
+	 * Strip flags that either shouldn't be set by userspace like
+	 * FMODE_NONOTIFY or that aren't relevant in determining struct
+	 * open_flags like O_CLOEXEC.
+	 */
+	flags &= ~strip;
 
 	/*
 	 * Older syscalls implicitly clear all of the invalid flags or argument
-- 
2.27.0

