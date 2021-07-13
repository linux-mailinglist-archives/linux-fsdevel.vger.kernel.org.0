Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A173C6F61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhGMLTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235967AbhGMLTc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29F446023F;
        Tue, 13 Jul 2021 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175002;
        bh=LqQWbaMFnk7v2oD022KqzI2BGEA0CLtc3MBEjuZtkBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUVIvC3+su3VXz/kmolI0/47h+kWXlYlEi/xvZOsvYSfw2ugTzuYe62XehEQMgEhv
         oJJ6n1W9wct0WPJg8uAh2cHT4FHMB8Jb3gwgK5KGtfCOgB0Hyc9oI9bI+LIUeoMbGQ
         MuOZcmpCFDZ048inNmNGsEnM1737exQg8jdZuZE1M1D2EaNAa2DAsd7UfAMSlJYHkq
         5ds37y5RMhhLgcW42VTb+G1KHZapv5QIUsSRROX2jiEGb6mO2sDJo3zerbGy2LOx+E
         tGDYA2bfcLtoUvE+PHgkuYANzeRrnnz/mxi84EbmooZ7OJKsyRnuPD0lR9LbN5aXaP
         pJxuaqi5ZT4tg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 15/24] btrfs/ioctl: check whether fs{g,u}id are mapped during subvolume creation
Date:   Tue, 13 Jul 2021 13:13:35 +0200
Message-Id: <20210713111344.1149376-16-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; h=from:subject; bh=sv03z0zOZb92w1232TW8Rxao9nQV9t8jRDp53bmIzPU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY2W7Oie/kRXp1hx9n325hUWbm7Gl1cXeTJlRakcuq/F F/yyo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJP+Rn+J+wt/jhzw5yePwckM/lei8 +vXsjlynGxK3Tf8U3W3Ak3MhkZloWtX/Hpg8cGh2377E3MvYSEWP5OPamSU3Gvcu+z2y/+cgAA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

When a new subvolume is created btrfs currently doesn't check whether the
fs{g,u}id of the caller actually have a mapping in the user namespace attached
to the filesystem. The vfs always checks this to make sure that the caller's
fs{g,u}id can be represented on-disk. This is most relevant for filesystems
that can be mounted inside user namespaces but it is in general a good
hardening measure to prevent unrepresentable {g,u}ids from being written to
disk.
Since we want to support idmapped mounts for btrfs ioctls to create subvolumes
in follow-up patches this becomes important since we want to make sure the
fs{g,u}id of the caller as mapped according to the idmapped mount can be
represented on-disk. Simply add the missing fsuidgid_has_mapping() line from
the vfs may_create() version to btrfs_may_create().

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8ec67e52fde3..f332de258058 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -870,6 +870,8 @@ static inline int btrfs_may_create(struct inode *dir, struct dentry *child)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
+	if (!fsuidgid_has_mapping(dir->i_sb, &init_user_ns))
+		return -EOVERFLOW;
 	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 }
 
-- 
2.30.2

