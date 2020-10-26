Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C0B299926
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 22:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391063AbgJZVx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 17:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391058AbgJZVx2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:53:28 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443852084C;
        Mon, 26 Oct 2020 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603749208;
        bh=cbvz8JZpRk6jgUksGk7xL97fNKKDmg9abo4AHqnljqE=;
        h=From:To:Cc:Subject:Date:From;
        b=sRv3EjZur1PCPWhhj3mdgNha05v1M2MO1n/C3QZ7d2HyClMSDBGuYjcwreXwAsxn+
         IMHaDbYbvkwvvSLHQEaesminOpgedDGwc4KNOCEqAODKQXa2j2qGkyqRiGtOo60imy
         bl0plDlCdKtBqZo3GC5uXKq0wQQavhw03XU38t1A=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] seq_file: fix clang warning for NULL pointer arithmetic
Date:   Mon, 26 Oct 2020 22:52:56 +0100
Message-Id: <20201026215321.3894419-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang points out that adding something to NULL is notallowed
in standard C:

fs/kernfs/file.c:127:15: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                return NULL + !*ppos;
                       ~~~~ ^
fs/seq_file.c:529:14: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
        return NULL + (*pos == 0);

Rephrase the function to do the same thing without triggering that
warning. Linux already relies on a specific binary representation
of NULL, so it makes no real difference here. The instance in
kernfs was copied from single_start, so fix both at once.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: c2b19daf6760 ("sysfs, kernfs: prepare read path for kernfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/kernfs/file.c | 2 +-
 fs/seq_file.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f277d023ebcd..b55e6ef4d677 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -124,7 +124,7 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 		 * The same behavior and code as single_open().  Returns
 		 * !NULL if pos is at the beginning; otherwise, NULL.
 		 */
-		return NULL + !*ppos;
+		return (void *)(uintptr_t)!*ppos;
 	}
 }
 
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 31219c1db17d..d456468eb934 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -526,7 +526,7 @@ EXPORT_SYMBOL(seq_dentry);
 
 static void *single_start(struct seq_file *p, loff_t *pos)
 {
-	return NULL + (*pos == 0);
+	return (void *)(uintptr_t)(*pos == 0);
 }
 
 static void *single_next(struct seq_file *p, void *v, loff_t *pos)
-- 
2.27.0

