Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F893BBFE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhGEPdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 11:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232603AbhGEPc6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:32:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 097C7619A8;
        Mon,  5 Jul 2021 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625499021;
        bh=Qdwvlvloc+EY50CgHCAEUBF3NINQSruHvX/lPYGFb/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJ6G6hAEao++F2s696PCJ1m3SsrTqyhzkAgONh50QdVFN08xdTd45F9i2Mnsb2icR
         r1ionr2/mKe/7rOTHwp+vLSKTsndxmdOSSnb2KqSiSr12s5COWJFXSlb57Y5CWnT8i
         /3OQIfvXLEm+HeeCxJd6IL/4MY3GitMnNx0xMKzEaHf93EiHR0DfhHUC+IQEro/L1J
         PZTwEMSoNpGKzVBjaMQO+NFMufhnySEnCEpi1a0O1HuBmYuujFRq+4bJ5hiApWDRDx
         98ll9Fl38rO5lUpo9jVQtIwb+RD6kU45eQCFs8bnJSeJAT+Nv6kxuzC4j7KxHwHaXe
         kXuYqr/D3rgSQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 15/41] open: don't silently ignore unknown O-flags in openat2()
Date:   Mon,  5 Jul 2021 11:29:35 -0400
Message-Id: <20210705153001.1521447-15-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210705153001.1521447-1-sashal@kernel.org>
References: <20210705153001.1521447-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

[ Upstream commit cfe80306a0dd6d363934913e47c3f30d71b721e5 ]

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

Link: https://lore.kernel.org/r/20210528092417.3942079-3-brauner@kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reported-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/open.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 4d7537ae59df..3aaaad47d9ca 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -993,12 +993,20 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 
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
2.30.2

