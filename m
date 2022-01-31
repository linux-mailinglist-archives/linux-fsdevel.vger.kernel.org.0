Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE96F4A4CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 18:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380744AbiAaRKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 12:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377208AbiAaRKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:10:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADC3C061714;
        Mon, 31 Jan 2022 09:10:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AE61B82B94;
        Mon, 31 Jan 2022 17:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D27C340E8;
        Mon, 31 Jan 2022 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643649046;
        bh=/r/ZnBTV4TiO+z1dN1aEerUQVoNaGQNdyWQJyouZjw4=;
        h=From:To:Cc:Subject:Date:From;
        b=uq/6QeXDFVrsVE/P4NqpoOwCEWHijusiEbATGsytAcD3hkBKM5VcMy7oedybZEyb6
         OeRqpU6xLzPJ4ud7I0eYV8d2uQmounckED3bvUA5sKQyDCaF2obksU2yeE8/DA8lmC
         6KXLezv/ZSfD3VOtnv68F9nDQZOk/RN2pXApKEvYwWsqEoz1390K9U5AYppbx6FpSt
         8BsaxlEkrugpQV3HQgp9iYlvA9kNY96L+G+Qr9/V2uPHch3AhmGIL39NT3qz/IRc9T
         UT3xJgkpIn01Q68pkZ0AHi/Od0KAYJS5sEunv9H+eYl8yTOGmAz2dl4JPjLAUfnyOj
         aI3g3zGfvNuMQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>,
        Kees Cook <keescook@chromium.org>,
        Rich Felker <dalias@libc.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH] generic/633: adapt execveat() invocations
Date:   Mon, 31 Jan 2022 18:10:23 +0100
Message-Id: <20220131171023.2836753-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2797; h=from:subject; bh=/r/ZnBTV4TiO+z1dN1aEerUQVoNaGQNdyWQJyouZjw4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST+EI9iEZ7JdPJTSNsz4Y8rpFcHMN0wiwh6pvlU5gx3ZmKf DpdyRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETWf2Zk+P6Q1aBZZe/EnVa7nqwQbP h37e6mcwtjWoMnxJq1zw55NZPhf772msorPKtl7TOeie+OrJjPy6Mzd6JV2Uq23q8t3sWzmQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a push by Ariadne to enforce that argv[0] cannot be NULL. So far
we've allowed this. Fix the execveat() invocations to set argv[0] to the
name of the file we're about to execute.

Cc: Ariadne Conill <ariadne@dereferenced.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20220127000724.15106-1-ariadne@dereferenced.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 src/idmapped-mounts/idmapped-mounts.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 4cf6c3bb..76b559ae 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -3598,7 +3598,7 @@ static int setid_binaries(void)
 			NULL,
 		};
 		static char *argv[] = {
-			NULL,
+			"",
 		};
 
 		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 5000, 5000))
@@ -3726,7 +3726,7 @@ static int setid_binaries_idmapped_mounts(void)
 			NULL,
 		};
 		static char *argv[] = {
-			NULL,
+			"",
 		};
 
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 15000, 15000))
@@ -3865,7 +3865,7 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
 			NULL,
 		};
 		static char *argv[] = {
-			NULL,
+			"",
 		};
 
 		if (!switch_userns(attr.userns_fd, 0, 0, false))
@@ -3924,7 +3924,7 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
 			NULL,
 		};
 		static char *argv[] = {
-			NULL,
+			"",
 		};
 
 		if (!caps_supported()) {
@@ -3992,7 +3992,7 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
 			NULL,
 		};
 		static char *argv[] = {
-			NULL,
+			"",
 		};
 
 		if (!switch_userns(attr.userns_fd, 0, 0, false))
@@ -4150,7 +4150,7 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
 			NULL,
 		};
 		static char *argv[] = {
-			NULL,
+			"",
 		};
 
 		userns_fd = get_userns_fd(0, 10000, 10000);
@@ -4214,7 +4214,7 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
 			NULL,
 		};
 		static char *argv[] = {
-			NULL,
+			"",
 		};
 
 		userns_fd = get_userns_fd(0, 10000, 10000);
@@ -4286,7 +4286,7 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
 			NULL,
 		};
 		static char *argv[] = {
-			NULL,
+			"",
 		};
 
 		userns_fd = get_userns_fd(0, 10000, 10000);

base-commit: d8dee1222ecdfa1cff1386a61248e587eb3b275d
-- 
2.32.0

