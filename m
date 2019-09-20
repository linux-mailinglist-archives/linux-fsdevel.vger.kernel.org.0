Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F90B8B52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2019 09:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394948AbfITHC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 03:02:26 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:36020 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394945AbfITHC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:02:26 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Sep 2019 03:02:24 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 174ED18013A68;
        Fri, 20 Sep 2019 08:54:47 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0DMwfpTKi4jM; Fri, 20 Sep 2019 08:54:46 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 49ghSciSR6TN; Fri, 20 Sep 2019 08:54:46 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Christoph Hellwig <hch@lst.de>,
        Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH] ubifs: Remove obsolete TODO from dfs_file_write()
Date:   Fri, 20 Sep 2019 08:54:29 +0200
Message-Id: <20190920065429.19709-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

AFAICT this kind of problems are no longer possible since
debugfs gained file removal protection via
e9117a5a4bf6 ("debugfs: implement per-file removal protection").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/debug.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index a5f10d79e0dd..d67f91752f83 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2737,18 +2737,6 @@ static ssize_t dfs_file_write(struct file *file, const char __user *u,
 	struct dentry *dent = file->f_path.dentry;
 	int val;
 
-	/*
-	 * TODO: this is racy - the file-system might have already been
-	 * unmounted and we'd oops in this case. The plan is to fix it with
-	 * help of 'iterate_supers_type()' which we should have in v3.0: when
-	 * a debugfs opened, we rember FS's UUID in file->private_data. Then
-	 * whenever we access the FS via a debugfs file, we iterate all UBIFS
-	 * superblocks and fine the one with the same UUID, and take the
-	 * locking right.
-	 *
-	 * The other way to go suggested by Al Viro is to create a separate
-	 * 'ubifs-debug' file-system instead.
-	 */
 	if (file->f_path.dentry == d->dfs_dump_lprops) {
 		ubifs_dump_lprops(c);
 		return count;
-- 
2.16.4

