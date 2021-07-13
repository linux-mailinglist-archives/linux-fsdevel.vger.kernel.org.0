Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172773C6F4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhGMLSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235835AbhGMLSv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:18:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 797DC61164;
        Tue, 13 Jul 2021 11:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174962;
        bh=VUdQVTm26WiGnoVun2g1DOkKZS40zDCEmxEtD2MOx0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IM/+DxpMuUJvfwdTFUYeuUsHDqO+6ZaA7DPjeB7f+AG7/0qbEQZ7897Ptyj26OO8X
         lPCdgVkJNJNchut3KXYp9618PLVBwOY83ae1PURNKocFufUGCJ5r5+kJq1bWeJmqi/
         InhTC8i/gLn4IAegsXMUVEqPBCFzLYMRo5XnJxN/YcK2dEcNtRi6HwhwT92p3RS0Wk
         S4KY8HQmZpdvgdZ4rR1zN4MA4AiqxrF7kF3gO/WIOF8k7dzvn8BCEAi5oRUKnhSVaF
         pdw5aWoFjI9cnWdyxjDMZXxlrLqhejc03hiCuX4Z/alo+tdhjhmkXOeAVMsvextr2k
         G1pXEPlWriNkw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 08/24] btrfs/inode: allow idmapped mknod iop
Date:   Tue, 13 Jul 2021 13:13:28 +0200
Message-Id: <20210713111344.1149376-9-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; h=from:subject; bh=+EwkFPpYeKnXwij6N6mXNqdIdWglyubNpLK7STf44c8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY3co379pvGyS5sufbMubuiZe/+l96c6xtp1AUImk7w/ e2U6dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk4DnDP2tmLeG7x2cnC782jK9Z8H XBlmk3LD9p2E3oeS4bxDVf9BcjQ7t4uAe7Tuyc2Umf7v7QcpYRXWZ5pj/fKojt9g593tuF/AA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_mknod() to handle idmapped mounts. This is just a matter of
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
index 4d8cfc10ffd0..979869bc76bd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6576,7 +6576,7 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
-- 
2.30.2

