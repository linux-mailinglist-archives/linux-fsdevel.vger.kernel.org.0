Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01AE3C6F51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhGMLTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhGMLTQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 377C66023F;
        Tue, 13 Jul 2021 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174986;
        bh=DOtylg3BZ15KVtpI04TjlNkmDDRmeNx1Lm9LkW5LhlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzQXfFhZRiGhyJhD/Fsh4gJDNXMf1cKR2e+0ksdHv+6NXAtQ6wM0hOTXKfQK0GLoC
         nfoyDSqFqtd2z4I62Nn7XMKwcZKVj33ds4XixSn9is1f9P1LszkXQXolrBeBXt/VZw
         tW8Sy+nLF5dKa9G1er6JwrYNldKou9RpYpHL2bD9hAKpJ/FXtKUqlahrEOuKuZzKZf
         ILJlUNBUkbKRJ7es2RLpoSkpphhEBNrvoXT4lM4zqx2Y7Ll8sDaUllRL9lEi7ai6oh
         xGQEpa3Ott7lWe1xQZ5/uyUCbIFC8uLknjCCS4ncKCTJOXlHXvY2zgjuqRmCW4Quhg
         SIAOFQmKGlt7g==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 10/24] btrfs/inode: allow idmapped mkdir iop
Date:   Tue, 13 Jul 2021 13:13:30 +0200
Message-Id: <20210713111344.1149376-11-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; h=from:subject; bh=PGRv/5X8UUVctjkmNx2b/IITQrP/e2NROk58J20eAnY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY3a/3br77fvfzQKfJg0q/ioemiw1fPAXZzLH/I+3Omi 9pbvakcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEArgZGeYa1Hsfs8s9oSH5aUq6wu mtnk0Xl709WituaKklcy5rJRcjw1/LxFnXYmfzn0q5ViP4c99cnddFm+WbVY6syd2THs35nRkA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_mkdir() to handle idmapped mounts. This is just a matter of
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
index e21003e8a408..5038ab28f688 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6785,7 +6785,7 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_fail;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid,
 			S_IFDIR | mode, &index);
-- 
2.30.2

