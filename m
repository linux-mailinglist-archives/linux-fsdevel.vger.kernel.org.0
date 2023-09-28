Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D254F7B1A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjI1LIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjI1LG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:06:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCB61737;
        Thu, 28 Sep 2023 04:05:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE9BC433C7;
        Thu, 28 Sep 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899107;
        bh=H0o2l6yZgbuV+AHtD4UZSzh1xRcgDyq1popfRqn5BpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRPGkEbLGP0ZilgxwHKoK5aa3Diu6rGwzQIj4aLFkIQjfUt+EgtEy1nJXYP/627YU
         ICEyhlyn0yeIxNQphxQSK88BktMCjTMQAg2uX0JZS4eeWeIuKYUOzW6rI77YSgVm9Y
         Jxl0oMN+olO4Gr3qaW+oMVTT/vUEumTwP96IeqGlhkdyQTYdlXrxwMCqPc7wgXFTMF
         3IDKvaFuLOaICQho3lWkxJjsy81ss0wr6kOIOmzgllwv/h4OkF5m0tEFC8MVMQiWDb
         RqCfzmWaH2s6A7gTKcfqTsFrtHS7SCH0wKnJ8kl/DJJ65E6MAnHSt5dne/AUwqfNSX
         eeEf4W3OXyuBQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org
Subject: [PATCH 46/87] fs/jffs2: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:55 -0400
Message-ID: <20230928110413.33032-45-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jffs2/dir.c      | 35 ++++++++++++++++++++---------------
 fs/jffs2/file.c     |  4 ++--
 fs/jffs2/fs.c       | 20 ++++++++++----------
 fs/jffs2/os-linux.h |  4 ++--
 4 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 091ab0eaabbe..2b2938970da3 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -204,8 +204,8 @@ static int jffs2_create(struct mnt_idmap *idmap, struct inode *dir_i,
 	if (ret)
 		goto fail;
 
-	dir_i->i_mtime = inode_set_ctime_to_ts(dir_i,
-					       ITIME(je32_to_cpu(ri->ctime)));
+	inode_set_mtime_to_ts(dir_i,
+			      inode_set_ctime_to_ts(dir_i, ITIME(je32_to_cpu(ri->ctime))));
 
 	jffs2_free_raw_inode(ri);
 
@@ -238,7 +238,8 @@ static int jffs2_unlink(struct inode *dir_i, struct dentry *dentry)
 	if (dead_f->inocache)
 		set_nlink(d_inode(dentry), dead_f->inocache->pino_nlink);
 	if (!ret)
-		dir_i->i_mtime = inode_set_ctime_to_ts(dir_i, ITIME(now));
+		inode_set_mtime_to_ts(dir_i,
+				      inode_set_ctime_to_ts(dir_i, ITIME(now)));
 	return ret;
 }
 /***********************************************************************/
@@ -272,7 +273,8 @@ static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct de
 		set_nlink(d_inode(old_dentry), ++f->inocache->pino_nlink);
 		mutex_unlock(&f->sem);
 		d_instantiate(dentry, d_inode(old_dentry));
-		dir_i->i_mtime = inode_set_ctime_to_ts(dir_i, ITIME(now));
+		inode_set_mtime_to_ts(dir_i,
+				      inode_set_ctime_to_ts(dir_i, ITIME(now)));
 		ihold(d_inode(old_dentry));
 	}
 	return ret;
@@ -423,8 +425,8 @@ static int jffs2_symlink (struct mnt_idmap *idmap, struct inode *dir_i,
 		goto fail;
 	}
 
-	dir_i->i_mtime = inode_set_ctime_to_ts(dir_i,
-					       ITIME(je32_to_cpu(rd->mctime)));
+	inode_set_mtime_to_ts(dir_i,
+			      inode_set_ctime_to_ts(dir_i, ITIME(je32_to_cpu(rd->mctime))));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -568,8 +570,8 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
 		goto fail;
 	}
 
-	dir_i->i_mtime = inode_set_ctime_to_ts(dir_i,
-					       ITIME(je32_to_cpu(rd->mctime)));
+	inode_set_mtime_to_ts(dir_i,
+			      inode_set_ctime_to_ts(dir_i, ITIME(je32_to_cpu(rd->mctime))));
 	inc_nlink(dir_i);
 
 	jffs2_free_raw_dirent(rd);
@@ -610,7 +612,8 @@ static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
 	ret = jffs2_do_unlink(c, dir_f, dentry->d_name.name,
 			      dentry->d_name.len, f, now);
 	if (!ret) {
-		dir_i->i_mtime = inode_set_ctime_to_ts(dir_i, ITIME(now));
+		inode_set_mtime_to_ts(dir_i,
+				      inode_set_ctime_to_ts(dir_i, ITIME(now)));
 		clear_nlink(d_inode(dentry));
 		drop_nlink(dir_i);
 	}
@@ -746,8 +749,8 @@ static int jffs2_mknod (struct mnt_idmap *idmap, struct inode *dir_i,
 		goto fail;
 	}
 
-	dir_i->i_mtime = inode_set_ctime_to_ts(dir_i,
-					       ITIME(je32_to_cpu(rd->mctime)));
+	inode_set_mtime_to_ts(dir_i,
+			      inode_set_ctime_to_ts(dir_i, ITIME(je32_to_cpu(rd->mctime))));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -868,16 +871,18 @@ static int jffs2_rename (struct mnt_idmap *idmap,
 		 * caller won't do it on its own since we are returning an error.
 		 */
 		d_invalidate(new_dentry);
-		new_dir_i->i_mtime = inode_set_ctime_to_ts(new_dir_i,
-							   ITIME(now));
+		inode_set_mtime_to_ts(new_dir_i,
+				      inode_set_ctime_to_ts(new_dir_i, ITIME(now)));
 		return ret;
 	}
 
 	if (d_is_dir(old_dentry))
 		drop_nlink(old_dir_i);
 
-	old_dir_i->i_mtime = inode_set_ctime_to_ts(old_dir_i, ITIME(now));
-	new_dir_i->i_mtime = inode_set_ctime_to_ts(new_dir_i, ITIME(now));
+	inode_set_mtime_to_ts(old_dir_i,
+			      inode_set_ctime_to_ts(old_dir_i, ITIME(now)));
+	inode_set_mtime_to_ts(new_dir_i,
+			      inode_set_ctime_to_ts(new_dir_i, ITIME(now)));
 
 	return 0;
 }
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 11c66793960e..62ea76da7fdf 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -317,8 +317,8 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			inode->i_size = pos + writtenlen;
 			inode->i_blocks = (inode->i_size + 511) >> 9;
 
-			inode->i_mtime = inode_set_ctime_to_ts(inode,
-							       ITIME(je32_to_cpu(ri->ctime)));
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_to_ts(inode, ITIME(je32_to_cpu(ri->ctime))));
 		}
 	}
 
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 0403efab4089..d175cccb7c55 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -113,8 +113,8 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 
 
 	ri->isize = cpu_to_je32((ivalid & ATTR_SIZE)?iattr->ia_size:inode->i_size);
-	ri->atime = cpu_to_je32(I_SEC((ivalid & ATTR_ATIME)?iattr->ia_atime:inode->i_atime));
-	ri->mtime = cpu_to_je32(I_SEC((ivalid & ATTR_MTIME)?iattr->ia_mtime:inode->i_mtime));
+	ri->atime = cpu_to_je32(I_SEC((ivalid & ATTR_ATIME)?iattr->ia_atime:inode_get_atime(inode)));
+	ri->mtime = cpu_to_je32(I_SEC((ivalid & ATTR_MTIME)?iattr->ia_mtime:inode_get_mtime(inode)));
 	ri->ctime = cpu_to_je32(I_SEC((ivalid & ATTR_CTIME)?iattr->ia_ctime:inode_get_ctime(inode)));
 
 	ri->offset = cpu_to_je32(0);
@@ -147,9 +147,9 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 		return PTR_ERR(new_metadata);
 	}
 	/* It worked. Update the inode */
-	inode->i_atime = ITIME(je32_to_cpu(ri->atime));
+	inode_set_atime_to_ts(inode, ITIME(je32_to_cpu(ri->atime)));
 	inode_set_ctime_to_ts(inode, ITIME(je32_to_cpu(ri->ctime)));
-	inode->i_mtime = ITIME(je32_to_cpu(ri->mtime));
+	inode_set_mtime_to_ts(inode, ITIME(je32_to_cpu(ri->mtime)));
 	inode->i_mode = jemode_to_cpu(ri->mode);
 	i_uid_write(inode, je16_to_cpu(ri->uid));
 	i_gid_write(inode, je16_to_cpu(ri->gid));
@@ -282,8 +282,8 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	i_uid_write(inode, je16_to_cpu(latest_node.uid));
 	i_gid_write(inode, je16_to_cpu(latest_node.gid));
 	inode->i_size = je32_to_cpu(latest_node.isize);
-	inode->i_atime = ITIME(je32_to_cpu(latest_node.atime));
-	inode->i_mtime = ITIME(je32_to_cpu(latest_node.mtime));
+	inode_set_atime_to_ts(inode, ITIME(je32_to_cpu(latest_node.atime)));
+	inode_set_mtime_to_ts(inode, ITIME(je32_to_cpu(latest_node.mtime)));
 	inode_set_ctime_to_ts(inode, ITIME(je32_to_cpu(latest_node.ctime)));
 
 	set_nlink(inode, f->inocache->pino_nlink);
@@ -386,8 +386,8 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
 	iattr.ia_mode = inode->i_mode;
 	iattr.ia_uid = inode->i_uid;
 	iattr.ia_gid = inode->i_gid;
-	iattr.ia_atime = inode->i_atime;
-	iattr.ia_mtime = inode->i_mtime;
+	iattr.ia_atime = inode_get_atime(inode);
+	iattr.ia_mtime = inode_get_mtime(inode);
 	iattr.ia_ctime = inode_get_ctime(inode);
 
 	jffs2_do_setattr(inode, &iattr);
@@ -475,8 +475,8 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
 	inode->i_mode = jemode_to_cpu(ri->mode);
 	i_gid_write(inode, je16_to_cpu(ri->gid));
 	i_uid_write(inode, je16_to_cpu(ri->uid));
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
-	ri->atime = ri->mtime = ri->ctime = cpu_to_je32(I_SEC(inode->i_mtime));
+	simple_inode_init_ts(inode);
+	ri->atime = ri->mtime = ri->ctime = cpu_to_je32(I_SEC(inode_get_mtime(inode)));
 
 	inode->i_blocks = 0;
 	inode->i_size = 0;
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index 50727a1ff931..86ab014a349c 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -36,8 +36,8 @@ struct kvec;
 #define JFFS2_NOW() JFFS2_CLAMP_TIME(ktime_get_real_seconds())
 #define I_SEC(tv) JFFS2_CLAMP_TIME((tv).tv_sec)
 #define JFFS2_F_I_CTIME(f) I_SEC(inode_get_ctime(OFNI_EDONI_2SFFJ(f)))
-#define JFFS2_F_I_MTIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_mtime)
-#define JFFS2_F_I_ATIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_atime)
+#define JFFS2_F_I_MTIME(f) I_SEC(inode_get_mtime(OFNI_EDONI_2SFFJ(f)))
+#define JFFS2_F_I_ATIME(f) I_SEC(inode_get_atime(OFNI_EDONI_2SFFJ(f)))
 #define sleep_on_spinunlock(wq, s)				\
 	do {							\
 		DECLARE_WAITQUEUE(__wait, current);		\
-- 
2.41.0

