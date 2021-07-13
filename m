Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9489E3C6F50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhGMLTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhGMLTL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFB9E61178;
        Tue, 13 Jul 2021 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174982;
        bh=MLIhPumDu6HfavaPPyljeBF/5Sypk1xI//R6cojm6YY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTaBD0Gus39X1Q6497agTM/SjTeUNtaV+vt4FWHhePvnnlCZ69U9YUunduniM7pnA
         h8XWZiQWN7m2Gy5TIykMbKtdbxrg9puPf6Qijyh/a8XI6T6Mzdwfji2svWKW12BNUz
         DhyX+pnd72v93LZuX18tjl/iD+sYeQvpkJ55pAtKc0WmfHp+PP+WK13RZVR8Dbyfq2
         6i3oNoCnSqsyogaErGULlpydFIuA3Atd3WP0tCJB+oj7OgGc6PGBrvFooM0r4AwC5T
         KfljN8j953ybeZ0tBE/u+R5cQKFObM19sqjUkvlVVGexJpERqEVW2BHesTx00a+24G
         Rk0YNxI09uSng==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 09/24] btrfs/inode: allow idmapped create iop
Date:   Tue, 13 Jul 2021 13:13:29 +0200
Message-Id: <20210713111344.1149376-10-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; h=from:subject; bh=o4DzlH9QFw3NAVOXB5qDthHpAOFD0Rf35IibVfJFgbM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY2M/hazJX/NG23V2Q2G64+5VIT06kwPZ34kZitl7Cic HHqho5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKZ0gz/dDaz+P5tu8ajd7/+89/9nf NdGyrTFN0qFe73+/wr2NjtxvBP9cWht+citCRbu38eTouWefMpaorCas3qFxl7VHJ6RHw4AQ==
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_create() to handle idmapped mounts. This is just a matter of
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
index 979869bc76bd..e21003e8a408 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6640,7 +6640,7 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
-- 
2.30.2

