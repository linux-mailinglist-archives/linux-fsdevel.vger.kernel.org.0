Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59881F963C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgFOMOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:14:04 -0400
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:49671 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729962AbgFOMOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:14:02 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 959681C35BA
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 13:14:00 +0100 (IST)
Received: (qmail 24394 invoked from network); 15 Jun 2020 12:14:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Jun 2020 12:14:00 -0000
Date:   Mon, 15 Jun 2020 13:13:58 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] fs: Do not check if there is a fsnotify watcher on pseudo
 inodes
Message-ID: <20200615121358.GF3183@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changelog since v1
o Updated changelog

The kernel uses internal mounts created by kern_mount() and populated
with files with no lookup path by alloc_file_pseudo for a variety of
reasons. An example of such a mount is for anonymous pipes. For pipes,
every vfs_write regardless of filesystem, fsnotify_modify() is called to
notify of any changes which incurs a small amount of overhead in fsnotify
even when there are no watchers. It can also trigger for reads and readv
and writev, it was simply vfs_write() that was noticed first.

A patch is pending that reduces, but does not eliminte, the overhead of
fsnotify but for files that cannot be looked up via a path, even that
small overhead is unnecessary. The user API for fanotify is based on
the pathname and a dirfd and proc entries appear to be the only visible
representation of the files. Proc does not have the same pathname as the
internal entry and the proc inode is not the same as the internal inode
so even if fanotify is used on a file under /proc/XX/fd, no useful events
are notified.

This patch changes alloc_file_pseudo() to always opt out of fsnotify by
setting FMODE_NONOTIFY flag so that no check is made for fsnotify watchers
on pseudo files. This should be safe as the underlying helper for the
dentry is d_alloc_pseudo which explicitly states that no lookups are ever
performed meaning that fanotify should have nothing useful to attach to.

The test motivating this was "perf bench sched messaging --pipe". On
a single-socket machine using threads the difference of the patch was
as follows.

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
while marginal, there is still some small benefit to ignoring fsnotify
for files allocated via alloc_file_pseudo in some cases.

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
