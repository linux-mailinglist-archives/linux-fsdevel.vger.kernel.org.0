Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B52483A7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 03:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiADCK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 21:10:26 -0500
Received: from m12-16.163.com ([220.181.12.16]:4206 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbiADCKZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:10:25 -0500
X-Greylist: delayed 928 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 21:10:23 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=anOjr
        qvHO1Z4432Qm8RpuzEHkUu3oj36DsNbGYJrNVU=; b=KyKG1GHdAkxVeJp33G9eT
        Y+5gs5+xSFU0+pcoKf26zFJj27qEsWPkRFDKCfHQIyhRhS1ldclaUs+RWcoDqM2n
        c9us2PyYmVgl0zLc/s0XIZn5WQZSSHQ4+vnCjaWGwVl5PEDx1BOkidB0b2jYgWBw
        zSTFK+ZSqmylrTXQ/MUWW8=
Received: from localhost.localdomain (unknown [101.93.205.203])
        by smtp12 (Coremail) with SMTP id EMCowADH_EHgqNNh6ZCeAw--.4698S2;
        Tue, 04 Jan 2022 09:54:50 +0800 (CST)
From:   Qinghua Jin <qhjin_dev@163.com>
Cc:     qhjin_dev@163.com, Colin Ian King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: fix bug when opening a file with O_DIRECT on a file system that does not support it will leave an empty file
Date:   Tue,  4 Jan 2022 09:53:58 +0800
Message-Id: <20220104015358.57443-1-qhjin_dev@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADH_EHgqNNh6ZCeAw--.4698S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1DKF1kCw4xCFWktry5Jwb_yoW8ZF4kpF
        WfKa4UK34kJryIgF1kZa1vv3W0g34xGay7JrWkWa4DArnIvFyFgFWagF1kWr1YqF95Ar4F
        qw45Aw1UWrW5AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRLSdPUUUUU=
X-Originating-IP: [101.93.205.203]
X-CM-SenderInfo: ptkmx0hbgh4qqrwthudrp/1tbi7xN+HFr8Ad0C5gAAsA
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Colin Ian King reported the following

1. create a minix file system and mount it
2. open a file on the file system with O_RDWR | O_CREAT | O_TRUNC | O_DIRECT
3. open fails with -EINVAL but leaves an empty file behind.  All other open() failures don't leave the
failed open files behind.

The reason is because when checking the O_DIRECT in do_dentry_open, the inode has created, and later err
processing can't remove the inode:

        /* NB: we're sure to have correct a_ops only after f_op->open */
        if (f->f_flags & O_DIRECT) {
                if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
                        return -EINVAL;
        }

The patch will check the O_DIRECT before creating the inode in lookup_open function.

Signed-off-by: Qinghua Jin <qhjin_dev@163.com>
Reported-by:  Colin Ian King <colin.king@canonical.com>
---
 fs/namei.c | 7 +++++++
 fs/open.c  | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f9d2187c765..24c6bcba702d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3277,6 +3277,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			goto out_dput;
 		}
 
+		if (open_flag & O_DIRECT) {
+			if (!dir_inode->i_mapping || !dir_inode->i_mapping->a_ops ||
+					!dir_inode->i_mapping->a_ops->direct_IO) {
+				error = -EINVAL;
+				goto out_dput;
+			}
+		}
 		error = dir_inode->i_op->create(mnt_userns, dir_inode, dentry,
 						mode, open_flag & O_EXCL);
 		if (error)
diff --git a/fs/open.c b/fs/open.c
index f732fb94600c..2829c3613c0f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -838,12 +838,6 @@ static int do_dentry_open(struct file *f,
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
 
-	/* NB: we're sure to have correct a_ops only after f_op->open */
-	if (f->f_flags & O_DIRECT) {
-		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
-			return -EINVAL;
-	}
-
 	/*
 	 * XXX: Huge page cache doesn't support writing yet. Drop all page
 	 * cache for this file before processing writes.
-- 
2.30.2


