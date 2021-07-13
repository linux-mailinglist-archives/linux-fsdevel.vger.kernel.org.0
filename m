Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F91C3C6F53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhGMLTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235933AbhGMLTT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1118A6127C;
        Tue, 13 Jul 2021 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174989;
        bh=aGlfbs5KocbR7/3OZMjyoQ/sfpsdzO8gCgcw9kXMDt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5reKjnl2lHfq1rdjzBWckRxhcmanu9AQATMGDOzUDUpvZWMHiSnq8eb1lZuobKHJ
         PmyDhF6o4ti81Xm5kINt/lrZdBGMEbx9G30Wdyeo39VgzCtCddOJVVq7MQXs9YBsj8
         ygXkPV90WdrkbiHfEFGMj0mmJS8AgrQeqCg116SrHV37t3ljo2EfHBeTjhDVlDNf5Y
         Xjy7T3y2oXc+YP+blZN6HLZBbYyR0V4+2pForRz+LHwhPso5Tju1aGy1iFPN5yyEWl
         GEDpr6mdvjzw3aUWYIczjlzFUiUogE4uPKsl4YmneCfzGVe59ihhqic/2P7wu/SWNk
         7Smu57xjf0B5w==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 11/24] btrfs/inode: allow idmapped symlink iop
Date:   Tue, 13 Jul 2021 13:13:31 +0200
Message-Id: <20210713111344.1149376-12-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; h=from:subject; bh=mHAf1CJI7TSQSYXIAqNuV3KwWC8VYy3PPvHsFQU03jM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY2Ksnmv/LEwp2jdx59yHu9yjZSWOXO4Rnleyf2XznyT RfJLRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETy5jIy3JzTmxZXJT4z0tfd7WtB/Z IlPh9VnTOPXTjXeiRIYo7PTYb/Dte7F837UjuDa0rsd7WlZf85+TsLHyZqGpudqPAJmxXGDwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_symlink() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5038ab28f688..9b87ac971875 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9858,7 +9858,7 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 				dentry->d_name.name, dentry->d_name.len,
 				btrfs_ino(BTRFS_I(dir)), objectid,
 				S_IFLNK | S_IRWXUGO, &index);
-- 
2.30.2

