Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2DC3690E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbhDWLL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 07:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242206AbhDWLL4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 07:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A946461469;
        Fri, 23 Apr 2021 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619176280;
        bh=r4O3KqJfam0P2TE7fyRmDac+amuU1Nhos7EG9f94Mi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HauTSVNeqsOMO3tCO+7FtGE8hIvn752IX45r1uWvh2rWSZ+P4dFCmLPD6vc7dL9Uw
         Cw+CY77dCuSJX2qQTVSmc1vVMPovYaV+lAaf7/iLYAzfKg1h6KINkqCoI44UTYhusA
         snn0TWsilSABuJ33fcx2vGuybFjYJr96Bw6TdL+6WC7pqdB1/NTj1Q6uFkljsQS47X
         /KtLIL85Gv8EUdafP5kzEv+eIfIV2OWE6miTdzgGtUhy/lU92pzjNSyxL1jDPcTRmZ
         rzRzBNPbp6S/Dyb92KC+j60cVAPSeDDQQaRFMj2AULe1bInTOVjIf5BfVOc3j6nsK3
         JiQMrZpgDPvUw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/3] open: don't silently ignore unknown O-flags in openat2()
Date:   Fri, 23 Apr 2021 13:10:36 +0200
Message-Id: <20210423111037.3590242-2-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210423111037.3590242-1-brauner@kernel.org>
References: <20210423111037.3590242-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=6HfI8flciKZB4VJnvGhErn3MBardNcPBqXfs5h/OfHw=; m=YAUWuGreYWY5BJ8YWdYkCsjkQG4NYhRc+h08FFpz+qQ=; p=9DvMh1owOk4P3ZOKugjlJZ91bi4fDIcfB+PVsEVZrB8=; g=e75d4dfeaf1230f374fccbe201fc4f3d5beff203
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYIKrKAAKCRCRxhvAZXjcom0XAP9tAA6 6r7s4YlF34OT6fq9rU+qMKjJf1qm5UG4c584BSgD/dKqTvrmgV7Vz+q37vUkDlZsdySZgznf5oguN m4IQggk=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The new openat2() syscall verifies that no unknown O-flag values are
set and returns an error to userspace if they are while the older open
syscalls like open() and openat2() simply ignore unknown flag values:

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
          .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID_LOWE32,
          .resolve = 0,
  };

  struct open_how how_upper32 = {
          .flags = O_RDONLY | O_FLAG_CURRENTLY_INVALID_LOWE32,
          .resolve = 0,
  };

  /* fails */
  fd = openat2(-EBADF, "/dev/null", &how_lower32, sizeof(how_lower32));

  /* succeeds */
  fd = openat2(-EBADF, "/dev/null", &how_upper32, sizeof(how_upper32));

That seems like a bug. Fix it by preventing the truncation in
build_open_flags().

There's a snafu here though stripping FMODE_* directly from flags would
cause the upper 32 bits to be truncated as well due to integer promotion
rules since FMODE_* is unsigned int, O_* are signed ints (yuck).

This change shouldn't regress old open syscalls since they silently
truncate any unknown values.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reported-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/open.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index e53af13b5835..96644aa325eb 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1002,12 +1002,17 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 
 inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 {
-	int flags = how->flags;
+	u64 flags = how->flags;
+	u64 strip = FMODE_NONOTIFY | O_CLOEXEC;
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
-	/* Must never be set by userspace */
-	flags &= ~(FMODE_NONOTIFY | O_CLOEXEC);
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

