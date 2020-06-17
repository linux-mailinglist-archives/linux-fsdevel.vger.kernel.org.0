Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348081FD00A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgFQOxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 10:53:16 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:43731 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbgFQOxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:53:15 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 1ACF3FAE9A
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 15:53:13 +0100 (IST)
Received: (qmail 30696 invoked from network); 17 Jun 2020 14:53:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jun 2020 14:53:12 -0000
Date:   Wed, 17 Jun 2020 15:53:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs, pseudo: Do not update atime for pseudo inodes
Message-ID: <20200617145310.GK3183@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel uses internal mounts created by kern_mount() and populated
with files with no lookup path by alloc_file_pseudo() for a variety of
reasons. An relevant example is anonymous pipes because every vfs_write
also checks if atime needs to be updated even though it is unnecessary.
Most of the relevant users for alloc_file_pseudo() either have no statfs
helper or use simple_statfs which does not return st_atime. The closest
proxy measure is the proc fd representations of such inodes which do not
appear to change once they are created. This patch sets the S_NOATIME
on inode->i_flags for inodes created by new_inode_pseudo() so that atime
will not be updated.

The test motivating this was "perf bench sched messaging --pipe" where
atime-related functions were noticeable in the profiles. On a single-socket
machine using threads the difference of the patch was as follows. The
difference in performance was

                          5.8.0-rc1              5.8.0-rc1
                            vanilla       pseudoatime-v1r1
Amean     1       0.4807 (   0.00%)      0.4623 *   3.81%*
Amean     3       1.5543 (   0.00%)      1.4610 (   6.00%)
Amean     5       2.5647 (   0.00%)      2.5183 (   1.81%)
Amean     7       3.7407 (   0.00%)      3.7120 (   0.77%)
Amean     12      5.9900 (   0.00%)      5.5233 (   7.79%)
Amean     18      8.8727 (   0.00%)      6.8353 *  22.96%*
Amean     24     11.1510 (   0.00%)      8.9123 *  20.08%*
Amean     30     13.9330 (   0.00%)     10.8743 *  21.95%*
Amean     32     14.2177 (   0.00%)     10.9923 *  22.69%*

Note that I consider the impact to be disproportionate and so it may not
be universal. On a profiled run for just *one* group, the difference in
perf profiles for atime-related functions were

     0.23%     -0.18%  [kernel.vmlinux]    [k] atime_needs_update
     0.13%     -0.02%  [kernel.vmlinux]    [k] touch_atime

So there is a large reduction in atime overhead which on this particular
machine must have gotten incrementally worse as the group count
increased. I could measure it specifically but I think it's reasonable
to reduce atime overhead for pseudo files unconditionally.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..6d4ea0c9fe3e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -930,6 +930,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 	if (inode) {
 		spin_lock(&inode->i_lock);
 		inode->i_state = 0;
+		inode->i_flags |= S_NOATIME;
 		spin_unlock(&inode->i_lock);
 		INIT_LIST_HEAD(&inode->i_sb_list);
 	}
