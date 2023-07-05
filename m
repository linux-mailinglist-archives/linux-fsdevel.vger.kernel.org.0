Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5599C748D38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjGETIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjGETHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1D62D7D;
        Wed,  5 Jul 2023 12:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66C45616F0;
        Wed,  5 Jul 2023 19:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127C8C433C8;
        Wed,  5 Jul 2023 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583879;
        bh=HMc0jNblEpTL0q66n2SmSXQDQ5qyWhGAaTZI7OU1vek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jxqj2wZ4nW3tOavyswpioRQkyYxJkqDGHI21QHG1MKFfRiCciQJV30aV5X2QTuksP
         zzZzSxlGIA5/7O5BK64IiICsHPMBRILLMgZ+ysWEtJO2oxRNXKdJD6/QSuraCGIGUh
         cmh1OzuL0YNktry/dDym/eXSaQ84jc5TB2qXvWP4jz8NjUJaD4l5EkX8LsFWSVEpsg
         6gZPIt8aAA34bPISMZ8fWG2Tq3bISVHXWrxHryhhHvOp8+VEtEAtPxDjogAWRWkCGn
         q03f2us3/1a561OAkL4cztGSD6w2/jwlTpj1NB//0DOjS9mkgaOl/oVW0WVcP1SEjK
         8VArq6CiR4buw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 54/92] jffs2: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:19 -0400
Message-ID: <20230705190309.579783-52-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jffs2/dir.c      | 24 +++++++++++++++---------
 fs/jffs2/file.c     |  3 ++-
 fs/jffs2/fs.c       | 10 +++++-----
 fs/jffs2/os-linux.h |  2 +-
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 5075a0a6d594..091ab0eaabbe 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -204,7 +204,8 @@ static int jffs2_create(struct mnt_idmap *idmap, struct inode *dir_i,
 	if (ret)
 		goto fail;
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(ri->ctime));
+	dir_i->i_mtime = inode_set_ctime_to_ts(dir_i,
+					       ITIME(je32_to_cpu(ri->ctime)));
 
 	jffs2_free_raw_inode(ri);
 
@@ -237,7 +238,7 @@ static int jffs2_unlink(struct inode *dir_i, struct dentry *dentry)
 	if (dead_f->inocache)
 		set_nlink(d_inode(dentry), dead_f->inocache->pino_nlink);
 	if (!ret)
-		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
+		dir_i->i_mtime = inode_set_ctime_to_ts(dir_i, ITIME(now));
 	return ret;
 }
 /***********************************************************************/
@@ -271,7 +272,7 @@ static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct de
 		set_nlink(d_inode(old_dentry), ++f->inocache->pino_nlink);
 		mutex_unlock(&f->sem);
 		d_instantiate(dentry, d_inode(old_dentry));
-		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
+		dir_i->i_mtime = inode_set_ctime_to_ts(dir_i, ITIME(now));
 		ihold(d_inode(old_dentry));
 	}
 	return ret;
@@ -422,7 +423,8 @@ static int jffs2_symlink (struct mnt_idmap *idmap, struct inode *dir_i,
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = inode_set_ctime_to_ts(dir_i,
+					       ITIME(je32_to_cpu(rd->mctime)));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -566,7 +568,8 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = inode_set_ctime_to_ts(dir_i,
+					       ITIME(je32_to_cpu(rd->mctime)));
 	inc_nlink(dir_i);
 
 	jffs2_free_raw_dirent(rd);
@@ -607,7 +610,7 @@ static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
 	ret = jffs2_do_unlink(c, dir_f, dentry->d_name.name,
 			      dentry->d_name.len, f, now);
 	if (!ret) {
-		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
+		dir_i->i_mtime = inode_set_ctime_to_ts(dir_i, ITIME(now));
 		clear_nlink(d_inode(dentry));
 		drop_nlink(dir_i);
 	}
@@ -743,7 +746,8 @@ static int jffs2_mknod (struct mnt_idmap *idmap, struct inode *dir_i,
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = inode_set_ctime_to_ts(dir_i,
+					       ITIME(je32_to_cpu(rd->mctime)));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -864,14 +868,16 @@ static int jffs2_rename (struct mnt_idmap *idmap,
 		 * caller won't do it on its own since we are returning an error.
 		 */
 		d_invalidate(new_dentry);
-		new_dir_i->i_mtime = new_dir_i->i_ctime = ITIME(now);
+		new_dir_i->i_mtime = inode_set_ctime_to_ts(new_dir_i,
+							   ITIME(now));
 		return ret;
 	}
 
 	if (d_is_dir(old_dentry))
 		drop_nlink(old_dir_i);
 
-	new_dir_i->i_mtime = new_dir_i->i_ctime = old_dir_i->i_mtime = old_dir_i->i_ctime = ITIME(now);
+	old_dir_i->i_mtime = inode_set_ctime_to_ts(old_dir_i, ITIME(now));
+	new_dir_i->i_mtime = inode_set_ctime_to_ts(new_dir_i, ITIME(now));
 
 	return 0;
 }
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 2345ca3f09ee..11c66793960e 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -317,7 +317,8 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			inode->i_size = pos + writtenlen;
 			inode->i_blocks = (inode->i_size + 511) >> 9;
 
-			inode->i_ctime = inode->i_mtime = ITIME(je32_to_cpu(ri->ctime));
+			inode->i_mtime = inode_set_ctime_to_ts(inode,
+							       ITIME(je32_to_cpu(ri->ctime)));
 		}
 	}
 
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 038516bee1ab..0403efab4089 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -115,7 +115,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	ri->isize = cpu_to_je32((ivalid & ATTR_SIZE)?iattr->ia_size:inode->i_size);
 	ri->atime = cpu_to_je32(I_SEC((ivalid & ATTR_ATIME)?iattr->ia_atime:inode->i_atime));
 	ri->mtime = cpu_to_je32(I_SEC((ivalid & ATTR_MTIME)?iattr->ia_mtime:inode->i_mtime));
-	ri->ctime = cpu_to_je32(I_SEC((ivalid & ATTR_CTIME)?iattr->ia_ctime:inode->i_ctime));
+	ri->ctime = cpu_to_je32(I_SEC((ivalid & ATTR_CTIME)?iattr->ia_ctime:inode_get_ctime(inode)));
 
 	ri->offset = cpu_to_je32(0);
 	ri->csize = ri->dsize = cpu_to_je32(mdatalen);
@@ -148,7 +148,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	}
 	/* It worked. Update the inode */
 	inode->i_atime = ITIME(je32_to_cpu(ri->atime));
-	inode->i_ctime = ITIME(je32_to_cpu(ri->ctime));
+	inode_set_ctime_to_ts(inode, ITIME(je32_to_cpu(ri->ctime)));
 	inode->i_mtime = ITIME(je32_to_cpu(ri->mtime));
 	inode->i_mode = jemode_to_cpu(ri->mode);
 	i_uid_write(inode, je16_to_cpu(ri->uid));
@@ -284,7 +284,7 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	inode->i_size = je32_to_cpu(latest_node.isize);
 	inode->i_atime = ITIME(je32_to_cpu(latest_node.atime));
 	inode->i_mtime = ITIME(je32_to_cpu(latest_node.mtime));
-	inode->i_ctime = ITIME(je32_to_cpu(latest_node.ctime));
+	inode_set_ctime_to_ts(inode, ITIME(je32_to_cpu(latest_node.ctime)));
 
 	set_nlink(inode, f->inocache->pino_nlink);
 
@@ -388,7 +388,7 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
 	iattr.ia_gid = inode->i_gid;
 	iattr.ia_atime = inode->i_atime;
 	iattr.ia_mtime = inode->i_mtime;
-	iattr.ia_ctime = inode->i_ctime;
+	iattr.ia_ctime = inode_get_ctime(inode);
 
 	jffs2_do_setattr(inode, &iattr);
 }
@@ -475,7 +475,7 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
 	inode->i_mode = jemode_to_cpu(ri->mode);
 	i_gid_write(inode, je16_to_cpu(ri->gid));
 	i_uid_write(inode, je16_to_cpu(ri->uid));
-	inode->i_atime = inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	ri->atime = ri->mtime = ri->ctime = cpu_to_je32(I_SEC(inode->i_mtime));
 
 	inode->i_blocks = 0;
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index 8da19766c101..50727a1ff931 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -35,7 +35,7 @@ struct kvec;
 #define ITIME(sec) ((struct timespec64){sec, 0})
 #define JFFS2_NOW() JFFS2_CLAMP_TIME(ktime_get_real_seconds())
 #define I_SEC(tv) JFFS2_CLAMP_TIME((tv).tv_sec)
-#define JFFS2_F_I_CTIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_ctime)
+#define JFFS2_F_I_CTIME(f) I_SEC(inode_get_ctime(OFNI_EDONI_2SFFJ(f)))
 #define JFFS2_F_I_MTIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_mtime)
 #define JFFS2_F_I_ATIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_atime)
 #define sleep_on_spinunlock(wq, s)				\
-- 
2.41.0

