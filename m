Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A178F007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbjHaPOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 11:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjHaPOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:14:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68E4E4C;
        Thu, 31 Aug 2023 08:14:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50087d47d4dso1794419e87.1;
        Thu, 31 Aug 2023 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693494859; x=1694099659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ds4Givk68LirZVTl9NW6wfSOzQYyw2PUU0ONbdxW9os=;
        b=Pwbx8xpEfoxKLqV7kFSEqe974/Hana1v1nNN0LaOXMfbELi2bVGoUVDrbARNG+bb8l
         hrzZTQLxQ9qrMGO+KWN9OcJMzywVW696YRTfwT2I/2ZN4yqcKC65uSquf/3w/4Gi5vO+
         U3U6f/tzSTKj7ifmnwUsKVxNGS7UxWZoH5CK0kp3jo+w2qRkAJqpEW/UEliqJdZ/UUMx
         cGbHtdhAmCtQJwPiNbjrK8VyYTN3P56EtLNFVVcfc13AVjluctinM+eJafPMmFyf/ZOX
         b25FPY2Y1x/xCz3dcggonvUOhT+BhFkH2WdiMXL5vCp6l0FmY45SD9yeJ8l6UZgnihyg
         mPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693494859; x=1694099659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ds4Givk68LirZVTl9NW6wfSOzQYyw2PUU0ONbdxW9os=;
        b=PJ8INThzJjVUeb8ArAHGYXKPKZdhEzKuuBJTdR7ViaOg+/2tq2yTHqXOaB8DArCGRX
         p51W5X1dcgfMkxuyLWU3d4W4WQgp4PYW7zhQ68eqGniINhFiFTGQ6x3xRh/GStys/YcR
         /y2RQ+CNQMe1FD2+1LRhbebLw+umQFeULmGFtrqZSv76QP5aAWA6ugaxMxy4c1/2Lii2
         thI3tGuQN+XkZb2mh44xX99louejxJc36cI+d22c1EixvJ93xPLaUcDUXluCPCgLQ2zJ
         0Nvb63Jh7Nh+/BnJDTO9tgP9gsYF+erbwdSVDShx7QEPDlzmhpzPQd01c2YYmvpwHFVt
         dlcg==
X-Gm-Message-State: AOJu0YwlPvJVY6AHhYxlSjlhUbAlnkMpgmmljSfAHrm760/iye336piQ
        6+5kSQQUTp4eLCp8AT74uEKClPSbXMk=
X-Google-Smtp-Source: AGHT+IGKZC22fSWCtfui55ES8Kg/t8/2ATxB2rnvX7StTYacf9bsLelZEWi6rU120ArWM5ongK5ghg==
X-Received: by 2002:a19:f816:0:b0:500:b5db:990c with SMTP id a22-20020a19f816000000b00500b5db990cmr3477693lff.57.1693494858510;
        Thu, 31 Aug 2023 08:14:18 -0700 (PDT)
Received: from f.. (cst-prg-30-15.cust.vodafone.cz. [46.135.30.15])
        by smtp.gmail.com with ESMTPSA id e11-20020a056402148b00b00529fa63ef6fsm901538edv.57.2023.08.31.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:14:17 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     brauner@kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH] vfs: add inode lockdep assertions
Date:   Thu, 31 Aug 2023 17:14:14 +0200
Message-Id: <20230831151414.2714750-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thread "Use exclusive lock for file_remove_privs" [1] reports an issue
which should have been found by asserts -- inode not write locked by the
caller.

It did not happen because the attempt to do it in notify_change:
WARN_ON_ONCE(!inode_is_locked(inode));

passes if the inode is only read-locked:
static inline int rwsem_is_locked(struct rw_semaphore *sem)
{
        return atomic_long_read(&sem->count) != 0;
}

According to git blame this regressed from 2 commits:
1. 5955102c9984 ("wrappers for ->i_mutex access") which replaced a
   bunch of mutex_is_locked with inode_is_locked
2. 9902af79c01a ("parallel lookups: actual switch to rwsem") which
   implemented inode_is_locked as a mere check on the semaphore being
   held in *any* manner

In order to remedy this I'm proposing lockdep-ing the check with 2
helpers: inode_assert_locked and inode_assert_write_locked

Below I'm adding the helpers and converting *some* of the spots modified
by the first patch. I boot tested it and nothing blow up on ext4, but
btrfs should cause a complaint.

I can finish the other spots originally touched by 1 and touch up the 3
uses I grepped in fs/namei.c, but ultimately filesystem maintainers are
going to have to patch their code at their leasure. On top of that there
are probably quite a few places which should assert, but don't.

Comments?

Link: https://lore.kernel.org/linux-fsdevel/20230830181519.2964941-1-bschubert@ddn.com/

---
 fs/attr.c          |  2 +-
 fs/btrfs/xattr.c   |  2 +-
 fs/ext4/ext4.h     |  4 ++--
 fs/ext4/extents.c  |  4 ++--
 fs/ext4/inode.c    |  4 ++--
 include/linux/fs.h | 10 ++++++++++
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index a8ae5f6d9b16..90dec999a952 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -387,7 +387,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct timespec64 now;
 	unsigned int ia_valid = attr->ia_valid;
 
-	WARN_ON_ONCE(!inode_is_locked(inode));
+	inode_assert_write_locked(inode);
 
 	error = may_setattr(idmap, inode, ia_valid);
 	if (error)
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 96828a13dd43..46b268a433dd 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -120,7 +120,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 	 * locks the inode's i_mutex before calling setxattr or removexattr.
 	 */
 	if (flags & XATTR_REPLACE) {
-		ASSERT(inode_is_locked(inode));
+		inode_assert_write_locked(inode);
 		di = btrfs_lookup_xattr(NULL, root, path,
 				btrfs_ino(BTRFS_I(inode)), name, name_len, 0);
 		if (!di)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 481491e892df..df428f22f624 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3364,8 +3364,8 @@ do {								\
 /* Update i_disksize. Requires i_rwsem to avoid races with truncate */
 static inline void ext4_update_i_disksize(struct inode *inode, loff_t newsize)
 {
-	WARN_ON_ONCE(S_ISREG(inode->i_mode) &&
-		     !inode_is_locked(inode));
+	if (S_ISREG(inode->i_mode))
+		inode_assert_write_locked(inode);
 	down_write(&EXT4_I(inode)->i_data_sem);
 	if (newsize > EXT4_I(inode)->i_disksize)
 		WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 202c76996b62..149783ecfe16 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5588,8 +5588,8 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 
 	BUG_ON(!rwsem_is_locked(&EXT4_I(inode1)->i_data_sem));
 	BUG_ON(!rwsem_is_locked(&EXT4_I(inode2)->i_data_sem));
-	BUG_ON(!inode_is_locked(inode1));
-	BUG_ON(!inode_is_locked(inode2));
+	inode_assert_write_locked(inode1);
+	inode_assert_write_locked(inode2);
 
 	ext4_es_remove_extent(inode1, lblk1, count);
 	ext4_es_remove_extent(inode2, lblk2, count);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 89737d5a1614..2ecdef6ddc88 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3797,7 +3797,7 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 
 	loff_t size = i_size_read(inode);
 
-	WARN_ON(!inode_is_locked(inode));
+	inode_assert_write_locked(inode);
 	if (offset > size || offset + len < size)
 		return 0;
 
@@ -4068,7 +4068,7 @@ int ext4_truncate(struct inode *inode)
 	 * have i_rwsem locked because it's not necessary.
 	 */
 	if (!(inode->i_state & (I_NEW|I_FREEING)))
-		WARN_ON(!inode_is_locked(inode));
+		inode_assert_write_locked(inode);
 	trace_ext4_truncate_enter(inode);
 
 	if (!ext4_can_truncate(inode))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c8ff4156a0a1..93d48b6b9f67 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -842,6 +842,16 @@ static inline void inode_lock_shared_nested(struct inode *inode, unsigned subcla
 	down_read_nested(&inode->i_rwsem, subclass);
 }
 
+static inline void inode_assert_locked(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_rwsem);
+}
+
+static inline void inode_assert_write_locked(struct inode *inode)
+{
+	lockdep_assert_held_write(&inode->i_rwsem);
+}
+
 static inline void filemap_invalidate_lock(struct address_space *mapping)
 {
 	down_write(&mapping->invalidate_lock);
-- 
2.39.2

