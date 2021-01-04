Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103352E9D48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 19:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbhADSoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 13:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbhADSoa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:44:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B15D21D1B;
        Mon,  4 Jan 2021 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609785829;
        bh=GylU2VtkYsBj1SJe+f/YDhcp84RMGLIp50WYd8oU+uk=;
        h=From:To:Cc:Subject:Date:From;
        b=Jmmz/bZfEAzWJkm5bA3KblGdEIESV5oR+BF5aSgTeXrwOMRbg5Zn93I/3dSqyKrSd
         Vy5UXlcI9Hg3vtMSzrR1NUyrhazNegiC49xhfKOgHW0W5BY4fOMMdIw2Z6B/7M/DLg
         iZxrI8Q3gA6vapS6RWOblEI0guafRHgU8GxF0ii97ra05XO3NH2VYejp9lMlittVPo
         t+OTCU8CeZCORDC3fMbY89Qb6Ogrb3w41ejqu+HqdJ5VVbDI29IiPe/4BE2Er0OXpv
         zvK8yOy9JZnkM6UnkgFlOxTuGebZkpoClVbLVbj1/PULKKXG638N/HBCNAjFIHC79A
         /h5yxAKUzw4dg==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sargun@sargun.me, amir73il@gmail.com, vgoyal@redhat.com
Subject: [PATCH][RESEND] vfs: serialize updates to file->f_sb_err with f_lock
Date:   Mon,  4 Jan 2021 13:43:47 -0500
Message-Id: <20210104184347.90598-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When I added the ability for syncfs to report writeback errors, I
neglected to adequately protect file->f_sb_err. While changes to
sb->s_wb_err don't require locking, we do need to protect the errseq_t
cursor in file->f_sb_err.

We could have racing updates to that value if two tasks are issuing
syncfs() on the same fd at the same time, possibly causing an error to
be reported twice or not at all.

Fix this by protecting the f_sb_err field with the file->f_lock.

Fixes: 735e4ae5ba28 ("vfs: track per-sb writeback errors and report them to syncfs")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/sync.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Al, could you pick up this patch for v5.11 or v5.12? I sent the original
version about a month ago, but it didn't get picked up.

In the original posting I marked this for stable, but I'm not sure it
really qualifies since it's a pretty unlikely race with an oddball
use-case (overlapping syncfs() calls on the same fd).

diff --git a/fs/sync.c b/fs/sync.c
index 1373a610dc78..3be26ff72431 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -162,7 +162,7 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 {
 	struct fd f = fdget(fd);
 	struct super_block *sb;
-	int ret, ret2;
+	int ret, ret2 = 0;
 
 	if (!f.file)
 		return -EBADF;
@@ -172,7 +172,12 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 	ret = sync_filesystem(sb);
 	up_read(&sb->s_umount);
 
-	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
+	if (errseq_check(&sb->s_wb_err, f.file->f_sb_err)) {
+		/* Something changed, must use slow path */
+		spin_lock(&f.file->f_lock);
+		ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
+		spin_unlock(&f.file->f_lock);
+	}
 
 	fdput(f);
 	return ret ? ret : ret2;
-- 
2.29.2

