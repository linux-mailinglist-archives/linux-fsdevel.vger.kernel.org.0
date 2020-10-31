Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757002A121A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 01:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJaApW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 20:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJaApW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 20:45:22 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2303C2076D;
        Sat, 31 Oct 2020 00:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604105122;
        bh=cdd9+Pv9fufUcYB0lU28QpkU85Hlo6TrQs3OVc65FyU=;
        h=From:To:Cc:Subject:Date:From;
        b=zPMgj+BWXzPuhbtqPJPbMDrfooqbpVw8ORW9pJMLfvVFtgGfhymYBWnBe50Ts5d/o
         lMhUCQMs5tNPfxrIn/cWpoD2J+39D9HXze1PjoGjPdZMfxHbq2TIMNxvvKYCo/Mdci
         vd+udcONf6rK9UuSVN7xB7fDM9BMSGOiiqqpsxXc=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH] fs/inode.c: make inode_init_always() initialize i_ino to 0
Date:   Fri, 30 Oct 2020 17:44:20 -0700
Message-Id: <20201031004420.87678-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Currently inode_init_always() doesn't initialize i_ino to 0.  This is
unexpected because unlike the other inode fields that aren't initialized
by inode_init_always(), i_ino isn't guaranteed to end up back at its
initial value after the inode is freed.  Only one filesystem (XFS)
actually sets set i_ino back to 0 when freeing its inodes.

So, callers of new_inode() see some random previous i_ino.  Normally
that's fine, since normally i_ino isn't accessed before being set.
There can be edge cases where that isn't necessarily true, though.

The one I've run into is that on ext4, when creating an encrypted file,
the new file's encryption key has to be set up prior to the jbd2
transaction, and thus prior to i_ino being set.  If something goes
wrong, fs/crypto/ may log warning or error messages, which normally
include i_ino.  So it needs to know whether it is valid to include i_ino
yet or not.  Also, on some files i_ino needs to be hashed for use in the
crypto, so fs/crypto/ needs to know whether that can be done yet or not.

There are ways this could be worked around, either in fs/crypto/ or in
fs/ext4/.  But, it seems there's no reason not to just fix
inode_init_always() to do the expected thing and initialize i_ino to 0.

So, do that, and also remove the initialization in jfs_fill_super() that
becomes redundant.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/inode.c     | 1 +
 fs/jfs/super.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d78c37b00b81..eb001129f157c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -142,6 +142,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	atomic_set(&inode->i_count, 1);
 	inode->i_op = &empty_iops;
 	inode->i_fop = &no_open_fops;
+	inode->i_ino = 0;
 	inode->__i_nlink = 1;
 	inode->i_opflags = 0;
 	if (sb->s_xattr)
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index b2dc4d1f9dcc5..1f0ffabbde566 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -551,7 +551,6 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 		ret = -ENOMEM;
 		goto out_unload;
 	}
-	inode->i_ino = 0;
 	inode->i_size = i_size_read(sb->s_bdev->bd_inode);
 	inode->i_mapping->a_ops = &jfs_metapage_aops;
 	inode_fake_hash(inode);

base-commit: 5fc6b075e165f641fbc366b58b578055762d5f8c
-- 
2.29.1

