Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E03C6F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhGMLSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235881AbhGMLSq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:18:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7185261284;
        Tue, 13 Jul 2021 11:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174956;
        bh=EuWHHVhQpz/8kN4i1Eoh23f1Icsz4lC46RL9K9vSwPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyYvnwcGHsOuHJAjX4boHGZ457QR3HnGJ75+ZsEQrnZMXP/id9JJ9zIzipHT3Ni6E
         EWjZ7qBbAH+aUxdeK09nfSrNrODyBzFrKfvRM4eRYdAFTPyNjGqoIdYinc9Fx3P1FT
         yLbxGB+vwTlQvtYWaTyi6icUofDfqDU0bgkMH9yOzuGHuNd9rRIJ5ZlLit2xQ4o8QW
         Nzpz+ef/gbREbzQlizzKYAznSHesnKYvDtFVakeekJLx0xPUssOyxAjCQbkNQV/aDU
         XAm/nmHCrz7M0e6kzaBxXZ6dzxm4cA38fbO0YLTZJu+W4OqlpuxbDZld1pwmdCuSBF
         IPR3mLuMgJv3w==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 07/24] btrfs/inode: allow idmapped getattr iop
Date:   Tue, 13 Jul 2021 13:13:27 +0200
Message-Id: <20210713111344.1149376-8-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; h=from:subject; bh=AHCYizuH9bI3Zjt3oYc7YEGdTu64DtmP6yYi9l33a40=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY30fnvzfF6+5s5/8a9nOIrv+Mr0YENm9CLLjSlc6eX/ f13o6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5O8M/8xTAlbuzBNmUmi4l7D+jM A2poTrS6/nfl94xl5+wo3iizyMDEtv7b2+Nsc9XSo0uOnLxAC/J1WHP+eW6t01S68/xHDOkxEA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_getattr() to handle idmapped mounts. This is just a matter of
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
index c0c386cf8a2e..4d8cfc10ffd0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9106,7 +9106,7 @@ static int btrfs_getattr(struct user_namespace *mnt_userns,
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(mnt_userns, inode, stat);
 	stat->dev = BTRFS_I(inode)->root->anon_dev;
 
 	spin_lock(&BTRFS_I(inode)->lock);
-- 
2.30.2

