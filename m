Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D6A403B8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351935AbhIHOaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:30:23 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:41494 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351933AbhIHOaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:30:23 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1mNyAO-0004rQ-So; Wed, 08 Sep 2021 10:03:08 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] coda: Avoid hidden code duplication in rename.
Date:   Wed,  8 Sep 2021 10:03:04 -0400
Message-Id: <20210908140308.18491-6-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
References: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We were actually fixing up the directory mtime in both branches after
the negative dentry test, it was just that one branch was only flagging
the directory inodes to refresh their attributes while the other branch
used the optional optimization to set mtime to the current time and not
go back to the Coda client.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/dir.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 3fd085009f26..328d7a684b63 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -317,13 +317,10 @@ static int coda_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 				coda_dir_drop_nlink(old_dir);
 				coda_dir_inc_nlink(new_dir);
 			}
-			coda_dir_update_mtime(old_dir);
-			coda_dir_update_mtime(new_dir);
 			coda_flag_inode(d_inode(new_dentry), C_VATTR);
-		} else {
-			coda_flag_inode(old_dir, C_VATTR);
-			coda_flag_inode(new_dir, C_VATTR);
 		}
+		coda_dir_update_mtime(old_dir);
+		coda_dir_update_mtime(new_dir);
 	}
 	return error;
 }
-- 
2.25.1

