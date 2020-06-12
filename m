Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301C01F75FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFLJdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:33:14 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:50563 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgFLJdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:33:13 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 05:33:12 EDT
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 669DCFADDB
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 10:26:05 +0100 (IST)
Received: (qmail 12271 invoked from network); 12 Jun 2020 09:26:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jun 2020 09:26:05 -0000
Date:   Fri, 12 Jun 2020 10:26:03 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs: Do not check if there is a fsnotify watcher on pseudo
 inodes
Message-ID: <20200612092603.GB3183@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel uses internal mounts for a number of purposes including pipes.
On every vfs_write regardless of filesystem, fsnotify_modify() is called
to notify of any changes which incurs a small amount of overhead in fsnotify
even when there are no watchers.

A patch is pending that reduces, but does not eliminte, the overhead
of fsnotify but for the internal mounts, even the small overhead is
unnecessary. The user API is based on the pathname and a dirfd and proc
is the only visible path for inodes on an internal mount. Proc does not
have the same pathname as the internal entry so even if fatrace is used
on /proc, no events trigger for the /proc/X/fd/ files.

This patch changes alloc_file_pseudo() to set the internal-only
FMODE_NONOTIFY flag on f_flags so that no check is made for fsnotify
watchers on internal mounts. When fsnotify is updated, it may be that
this patch becomes redundant but it is more robust against any future
changes that may reintroduce overhead for fsnotify on inodes with no
watchers. The test motivating this was "perf bench sched messaging
--pipe". On a single-socket machine using threads the difference of the
patch was as follows.

                              5.7.0                  5.7.0
                            vanilla        nofsnotify-v1r1
Amean     1       1.3837 (   0.00%)      1.3547 (   2.10%)
Amean     3       3.7360 (   0.00%)      3.6543 (   2.19%)
Amean     5       5.8130 (   0.00%)      5.7233 *   1.54%*
Amean     7       8.1490 (   0.00%)      7.9730 *   2.16%*
Amean     12     14.6843 (   0.00%)     14.1820 (   3.42%)
Amean     18     21.8840 (   0.00%)     21.7460 (   0.63%)
Amean     24     28.8697 (   0.00%)     29.1680 (  -1.03%)
Amean     30     36.0787 (   0.00%)     35.2640 *   2.26%*
Amean     32     38.0527 (   0.00%)     38.1223 (  -0.18%)

The difference is small but in some cases it's outside the noise so
while marginal, there is still a small benefit to ignoring fsnotify
for internal mounts.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 fs/file_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 30d55c9a1744..0076ccf67a7d 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -229,7 +229,7 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
 		d_set_d_op(path.dentry, &anon_ops);
 	path.mnt = mntget(mnt);
 	d_instantiate(path.dentry, inode);
-	file = alloc_file(&path, flags, fops);
+	file = alloc_file(&path, flags | FMODE_NONOTIFY, fops);
 	if (IS_ERR(file)) {
 		ihold(inode);
 		path_put(&path);
