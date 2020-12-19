Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93B82DEFE0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 14:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgLSNsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 08:48:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgLSNsr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 08:48:47 -0500
From:   Jeff Layton <jlayton@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     viro@zeniv.linux.org.uk
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sargun@sargun.me, amir73il@gmail.com,
        vgoyal@redhat.com
Subject: [PATCH][RESEND] vfs: protect file->f_sb_err with f_lock
Date:   Sat, 19 Dec 2020 08:48:04 -0500
Message-Id: <20201219134804.20034-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When I added the ability for syncfs to report writeback errors, I
neglected to adequately protect file->f_sb_err. We could have racing
updates to that value if two tasks are issuing syncfs() on the same
fd at the same time.

Fix this by protecting the f_sb_err field with the file->f_lock,
similarly to how the f_wb_err field is protected.

Cc: stable@vger.kernel.org # v5.8+
Fixes: 735e4ae5ba28 (vfs: track per-sb writeback errors and report them to syncfs)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/sync.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

I sent this a couple of weeks ago, but no one picked it up. No changes
from the original posting, but added the Fixes tag and marked it for
stable.

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

