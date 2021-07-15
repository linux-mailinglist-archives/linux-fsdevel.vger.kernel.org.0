Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815393C965B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhGODTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:19:16 -0400
Received: from foss.arm.com ([217.140.110.172]:46020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234069AbhGODTM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:19:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F34F1042;
        Wed, 14 Jul 2021 20:16:19 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F147E3F7D8;
        Wed, 14 Jul 2021 20:16:16 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 07/13] iomap: simplify iomap_swapfile_fail() with '%pD' specifier
Date:   Thu, 15 Jul 2021 11:15:27 +0800
Message-Id: <20210715031533.9553-8-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After the behavior of '%pD' is change to print the full path of file,
iomap_swapfile_fail() can be simplified.

Given the space with proper length would be allocated in vprintk_store(),
the kmalloc() is not required any more.

Besides, the previous number postfix of '%pD' in format string is
pointless.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/iomap/direct-io.c | 2 +-
 fs/iomap/swapfile.c  | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..e876a5f9d888 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -426,7 +426,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 		 * iomap_apply() call in the DIO path, then it will see the
 		 * DELALLOC block that the page-mkwrite allocated.
 		 */
-		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %pD4 Comm: %.20s\n",
+		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %pD Comm: %.20s\n",
 				    dio->iocb->ki_filp, current->comm);
 		return -EIO;
 	default:
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 6250ca6a1f85..17032c14e466 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -73,13 +73,7 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
 
 static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
 {
-	char *buf, *p = ERR_PTR(-ENOMEM);
-
-	buf = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (buf)
-		p = file_path(isi->file, buf, PATH_MAX);
-	pr_err("swapon: file %s %s\n", IS_ERR(p) ? "<unknown>" : p, str);
-	kfree(buf);
+	pr_err("swapon: file %pD %s\n", isi->file, str);
 	return -EINVAL;
 }
 
-- 
2.17.1

