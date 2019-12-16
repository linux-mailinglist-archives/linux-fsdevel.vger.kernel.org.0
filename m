Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10524121637
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 19:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfLPS1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 13:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731057AbfLPS1l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:27:41 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759B720674;
        Mon, 16 Dec 2019 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520860;
        bh=HVseHPcnE1SswtFAF5XcNNtHAkobnesKHgy8huKCLSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUYdc5xzAeUOdN2tAJQfXza6yXftaKMDJ1oDsxKigYRdbRN0+1i7lBFvu2g5Ljb2t
         8vl/jblTnpi/0R0JTq5qy2gU1vw3kYQYRuMfon5iG8P8OxPSn2rXlmCex6zd8NfavT
         ACRgNqo/XCdjR8QEfJcE7Tgrp12E+qJvJEC7Hh4c=
From:   fdmanana@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        darrick.wong@oracle.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] fs: allow deduplication of eof block into the end of the destination file
Date:   Mon, 16 Dec 2019 18:26:55 +0000
Message-Id: <20191216182656.15624-2-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191216182656.15624-1-fdmanana@kernel.org>
References: <20191216182656.15624-1-fdmanana@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We always round down, to a multiple of the filesystem's block size, the
length to deduplicate at generic_remap_check_len().  However this is only
needed if an attempt to deduplicate the last block into the middle of the
destination file is requested, since that leads into a corruption if the
length of the source file is not block size aligned.  When an attempt to
deduplicate the last block into the end of the destination file is
requested, we should allow it because it is safe to do it - there's no
stale data exposure and we are prepared to compare the data ranges for
a length not aligned to the block (or page) size - in fact we even do
the data compare before adjusting the deduplication length.

After btrfs was updated to use the generic helpers from VFS (by commit
34a28e3d77535e ("Btrfs: use generic_remap_file_range_prep() for cloning
and deduplication")) we started to have user reports of deduplication
not reflinking the last block anymore, and whence users getting lower
deduplication scores.  The main use case is deduplication of entire
files that have a size not aligned to the block size of the filesystem.

We already allow cloning the last block to the end (and beyond) of the
destination file, so allow for deduplication as well.

Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo.N5dq.dFFD/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/read_write.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5bbf587f5bc1..7458fccc59e1 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1777,10 +1777,9 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
  * else.  Assume that the offsets have already been checked for block
  * alignment.
  *
- * For deduplication we always scale down to the previous block because we
- * can't meaningfully compare post-EOF contents.
- *
- * For clone we only link a partial EOF block above the destination file's EOF.
+ * For clone we only link a partial EOF block above or at the destination file's
+ * EOF.  For deduplication we accept a partial EOF block only if it ends at the
+ * destination file's EOF (can not link it into the middle of a file).
  *
  * Shorten the request if possible.
  */
@@ -1796,8 +1795,7 @@ static int generic_remap_check_len(struct inode *inode_in,
 	if ((*len & blkmask) == 0)
 		return 0;
 
-	if ((remap_flags & REMAP_FILE_DEDUP) ||
-	    pos_out + *len < i_size_read(inode_out))
+	if (pos_out + *len < i_size_read(inode_out))
 		new_len &= ~blkmask;
 
 	if (new_len == *len)
-- 
2.11.0

