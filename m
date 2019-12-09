Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BD116BF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfLILJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:56 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60094 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfLILJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+Hyvn2fxXrbhm1RrRf7VBFOwOcZ8lJu0pq6ZWwwTelM=; b=xf+3+dcaldyg5XozjfTVmRnTNZ
        olbXZsd0Bu/e6PSnh1BsDbBxW5pV+Ohx9o2aC6vjW0PEej9f9PC7VMfVD5EHVRg6KxVQ3Qkz1PsFq
        1fxzEgJsJFF1vgeNxLqbCPz2K3oGaUm+2h9Fk3lCvjLZFu3idbrL67qPtw5JN1e8fHHcRyF9LhbHB
        Jso4jaWoP0ppajc0J2U5FZLsxPGg/1/sSPup/DbBnmfaWBufe/igClCFYXKFkqzF8yAqctbFHYc3j
        6tuYntwzgqJhPzoxf1g1pb3oil/XZDDyVrlaZaioRHTTTUUffeoDAxf7U7dlSFog0QU66bTwhBdKs
        58R1FyPg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54076 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvH-0002VC-Kt; Mon, 09 Dec 2019 11:09:51 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvH-0004bj-3C; Mon, 09 Dec 2019 11:09:51 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/41] fs/adfs: dir: update directory locking
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGvH-0004bj-3C@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:51 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update directory locking such that it covers the validation of the
directory, which could fail if another thread is concurrently writing
to the same directory.  Since we may sleep, we need to use a rwsem
rather than a rw spinlock.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c | 55 +++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index e8aafc65d545..ff9c921be31c 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -12,7 +12,7 @@
 /*
  * For future.  This should probably be per-directory.
  */
-static DEFINE_RWLOCK(adfs_dir_lock);
+static DECLARE_RWSEM(adfs_dir_rwsem);
 
 int adfs_dir_copyfrom(void *dst, struct adfs_dir *dir, unsigned int offset,
 		      size_t len)
@@ -232,26 +232,25 @@ adfs_readdir(struct file *file, struct dir_context *ctx)
 	if (ctx->pos >> 32)
 		return 0;
 
+	down_read(&adfs_dir_rwsem);
 	ret = adfs_dir_read_inode(sb, inode, &dir);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	if (ctx->pos == 0) {
 		if (!dir_emit_dot(file, ctx))
-			goto free_out;
+			goto unlock_relse;
 		ctx->pos = 1;
 	}
 	if (ctx->pos == 1) {
 		if (!dir_emit(ctx, "..", 2, dir.parent_id, DT_DIR))
-			goto free_out;
+			goto unlock_relse;
 		ctx->pos = 2;
 	}
 
-	read_lock(&adfs_dir_lock);
-
 	ret = ops->setpos(&dir, ctx->pos - 2);
 	if (ret)
-		goto unlock_out;
+		goto unlock_relse;
 	while (ops->getnext(&dir, &obj) == 0) {
 		if (!dir_emit(ctx, obj.name, obj.name_len,
 			      obj.indaddr, DT_UNKNOWN))
@@ -259,12 +258,14 @@ adfs_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos++;
 	}
 
-unlock_out:
-	read_unlock(&adfs_dir_lock);
-
-free_out:
+unlock_relse:
+	up_read(&adfs_dir_rwsem);
 	adfs_dir_relse(&dir);
 	return ret;
+
+unlock:
+	up_read(&adfs_dir_rwsem);
+	return ret;
 }
 
 int
@@ -281,13 +282,13 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 	if (!ops->update)
 		return -EINVAL;
 
+	down_write(&adfs_dir_rwsem);
 	ret = adfs_dir_read(sb, obj->parent_id, 0, &dir);
 	if (ret)
-		goto out;
+		goto unlock;
 
-	write_lock(&adfs_dir_lock);
 	ret = ops->update(&dir, obj);
-	write_unlock(&adfs_dir_lock);
+	up_write(&adfs_dir_rwsem);
 
 	if (ret == 0)
 		adfs_dir_mark_dirty(&dir);
@@ -299,7 +300,10 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 	}
 
 	adfs_dir_relse(&dir);
-out:
+	return ret;
+
+unlock:
+	up_write(&adfs_dir_rwsem);
 #endif
 	return ret;
 }
@@ -336,17 +340,14 @@ static int adfs_dir_lookup_byname(struct inode *inode, const struct qstr *qstr,
 	u32 name_len;
 	int ret;
 
+	down_read(&adfs_dir_rwsem);
 	ret = adfs_dir_read_inode(sb, inode, &dir);
 	if (ret)
-		goto out;
-
-	obj->parent_id = inode->i_ino;
-
-	read_lock(&adfs_dir_lock);
+		goto unlock;
 
 	ret = ops->setpos(&dir, 0);
 	if (ret)
-		goto unlock_out;
+		goto unlock_relse;
 
 	ret = -ENOENT;
 	name = qstr->name;
@@ -357,13 +358,15 @@ static int adfs_dir_lookup_byname(struct inode *inode, const struct qstr *qstr,
 			break;
 		}
 	}
+	obj->parent_id = inode->i_ino;
 
-unlock_out:
-	read_unlock(&adfs_dir_lock);
-
-free_out:
+unlock_relse:
+	up_read(&adfs_dir_rwsem);
 	adfs_dir_relse(&dir);
-out:
+	return ret;
+
+unlock:
+	up_read(&adfs_dir_rwsem);
 	return ret;
 }
 
-- 
2.20.1

