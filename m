Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF3E8FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfD2R1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:58446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729008AbfD2R1m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C88F7AE8D;
        Mon, 29 Apr 2019 17:27:40 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 17/18] btrfs: Disable dax-based defrag and send
Date:   Mon, 29 Apr 2019 12:26:48 -0500
Message-Id: <20190429172649.8288-18-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This is temporary, and a TODO.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ioctl.c | 13 +++++++++++++
 fs/btrfs/send.c  |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5ebb52848d5a..2470f90c9983 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2990,6 +2990,12 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			goto out;
 		}
 
+		if (IS_DAX(inode)) {
+			btrfs_warn(root->fs_info, "File defrag is not supported with DAX");
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
 		if (argp) {
 			if (copy_from_user(range, argp,
 					   sizeof(*range))) {
@@ -4653,6 +4659,10 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* send can be on a directory, so check super block instead */
+	if (btrfs_test_opt(fs_info, DAX))
+		return -EOPNOTSUPP;
+
 	ret = mnt_want_write_file(file);
 	if (ret)
 		return ret;
@@ -5505,6 +5515,9 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
 	struct btrfs_ioctl_send_args *arg;
 	int ret;
 
+	if (IS_DAX(file_inode(file)))
+		return -EOPNOTSUPP;
+
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 		struct btrfs_ioctl_send_args_32 args32;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7ea2d6b1f170..9679fd54db86 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6609,6 +6609,10 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	int sort_clone_roots = 0;
 	int index;
 
+	/* send can be on a directory, so check super block instead */
+	if (btrfs_test_opt(fs_info, DAX))
+		return -EOPNOTSUPP;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.16.4

