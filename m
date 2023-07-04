Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF5A7471F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGDM5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjGDM5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:57:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8646D10CB;
        Tue,  4 Jul 2023 05:57:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB94D2289F;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688475423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrS3hC5VnXLyqrchQxaMGNTkNZQ8Lg/3MLwJBaPU+y0=;
        b=gqbJbU/HZRYQFJ8o/6N8u6RkXXR+bUmZoH6xDwAdSxfgmrse26eKfWC+0Ly79w3FUvuiHp
        GccK2LJCC8Rm2ZIJxK5FwTOtyDoteuK5htBpJBjGQ4N97lCY5bVgBr0ZpDPkl8qo+6l9kB
        KwU5f61JYU+o/I7FKdOb5mTQ2hpWMew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688475423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrS3hC5VnXLyqrchQxaMGNTkNZQ8Lg/3MLwJBaPU+y0=;
        b=1T7gAAAwMTZutKfVyv5iJ26JkKeICzrERRt9KPowscGjBHJv9lI7YKTCImw3wi+/KRULux
        CU8eg10/LEpe26CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC8731346D;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x+XUNR8XpGRWQwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:57:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0B7DAA0768; Tue,  4 Jul 2023 14:57:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>,
        <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/6] fs: Make bind mounts work with bdev_allow_write_mounted=n
Date:   Tue,  4 Jul 2023 14:56:54 +0200
Message-Id: <20230704125702.23180-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230704122727.17096-1-jack@suse.cz>
References: <20230704122727.17096-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9190; i=jack@suse.cz; h=from:subject; bh=6xoHWZ6rajVTnIYh7MZCs9+peehN7n1JkO674Qk1ieo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpBcVmSO+tEKS17zqp34cfj75JL53r49CurVYu9in MRhxuVWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQXFQAKCRCcnaoHP2RA2Q7eB/ 0agGBUG6EEeO59m597vlHZWaelx3Aponf6dGFQHiFafueKPmvIgeZun5nRto/vVdvolVYjTPHNZbwS cttlF3ZZ+a+LNAA5fBJ2edYIIQ+cU1KYpeqHzNeNceVTFHLK0W+9ylC8Iuv3jA6mzitNaw+rvPA9t9 /b403gMwfxfQ/I4COZuORzJC3h/sphHVNRhQyc0TMAMbuZG9eSUOe+Wid2T0n8zHr7F8sdDCwPLqW4 3ZJijWt1l3e8j80piHAf7HbudTAyGfVqrXsllE94dABcPkTTw79K0pYy69NA2hMLDrtKy34vYtrZLY 0uLCtpneXPWRbulqKVD2iM6N01A/4j
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we don't allow opening of mounted block devices for writing, bind
mounting is broken because the bind mount tries to open the block device
before finding the superblock for it already exists. Reorganize the
mounting code to first look whether the superblock for a particular
device is already mounted and open the block device only if it is not.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/super.c | 188 +++++++++++++++++++++++++----------------------------
 1 file changed, 89 insertions(+), 99 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index ea135fece772..fdf1e286926e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1228,13 +1228,7 @@ static const struct blk_holder_ops fs_holder_ops = {
 
 static int set_bdev_super(struct super_block *s, void *data)
 {
-	s->s_bdev_handle = data;
-	s->s_bdev = s->s_bdev_handle->bdev;
-	s->s_dev = s->s_bdev->bd_dev;
-	s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
-
-	if (bdev_stable_writes(s->s_bdev))
-		s->s_iflags |= SB_I_STABLE_WRITES;
+	s->s_dev = *(dev_t *)data;
 	return 0;
 }
 
@@ -1246,7 +1240,53 @@ static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 {
 	return !(s->s_iflags & SB_I_RETIRED) &&
-		s->s_bdev == ((struct bdev_handle *)fc->sget_key)->bdev;
+	       s->s_dev == *(dev_t *)fc->sget_key;
+}
+
+static int setup_bdev_super(struct super_block *s, int sb_flags,
+			    struct fs_context *fc)
+{
+	struct bdev_handle *bdev_handle;
+
+	bdev_handle = blkdev_get_by_dev(s->s_dev, sb_open_mode(sb_flags),
+					s->s_type, &fs_holder_ops);
+	if (IS_ERR(bdev_handle)) {
+		if (fc)
+			errorf(fc, "%s: Can't open blockdev", fc->source);
+		return PTR_ERR(bdev_handle);
+	}
+	spin_lock(&sb_lock);
+	s->s_bdev_handle = bdev_handle;
+	s->s_bdev = bdev_handle->bdev;
+	s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
+
+	if (bdev_stable_writes(s->s_bdev))
+		s->s_iflags |= SB_I_STABLE_WRITES;
+	spin_unlock(&sb_lock);
+
+	/*
+	 * Until SB_BORN flag is set, there can be no active superblock
+ 	 * references and thus no filesystem freezing. get_active_super()
+	 * will just loop waiting for SB_BORN so even freeze_bdev() cannot
+	 * proceed. It is enough to check bdev was not frozen before we set
+	 * s_bdev.
+	 */
+	mutex_lock(&s->s_bdev->bd_fsfreeze_mutex);
+	if (s->s_bdev->bd_fsfreeze_count > 0) {
+		mutex_unlock(&s->s_bdev->bd_fsfreeze_mutex);
+		if (fc)
+			warnf(fc, "%pg: Can't mount, blockdev is frozen",
+			      s->s_bdev);
+		return -EBUSY;
+	}
+	mutex_unlock(&s->s_bdev->bd_fsfreeze_mutex);
+
+	snprintf(s->s_id, sizeof(s->s_id), "%pg", s->s_bdev);
+	shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
+				fc->fs_type->name, s->s_id);
+	sb_set_blocksize(s, block_size(s->s_bdev));
+
+	return 0;
 }
 
 /**
@@ -1258,75 +1298,51 @@ int get_tree_bdev(struct fs_context *fc,
 		int (*fill_super)(struct super_block *,
 				  struct fs_context *))
 {
-	struct bdev_handle *bdev_handle;
-	struct block_device *bdev;
+	dev_t dev;
 	struct super_block *s;
 	int error = 0;
 
 	if (!fc->source)
 		return invalf(fc, "No source specified");
 
-	bdev_handle = blkdev_get_by_path(fc->source,
-					 sb_open_mode(fc->sb_flags),
-					 fc->fs_type, &fs_holder_ops);
-	if (IS_ERR(bdev_handle)) {
-		errorf(fc, "%s: Can't open blockdev", fc->source);
-		return PTR_ERR(bdev_handle);
-	}
-	bdev = bdev_handle->bdev;
-
-	/* Once the superblock is inserted into the list by sget_fc(), s_umount
-	 * will protect the lockfs code from trying to start a snapshot while
-	 * we are mounting
-	 */
-	mutex_lock(&bdev->bd_fsfreeze_mutex);
-	if (bdev->bd_fsfreeze_count > 0) {
-		mutex_unlock(&bdev->bd_fsfreeze_mutex);
-		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		blkdev_put(bdev_handle);
-		return -EBUSY;
+	error = lookup_bdev(fc->source, &dev);
+	if (error) {
+		errorf(fc, "%s: Can't lookup blockdev", fc->source);
+		return error;
 	}
 
 	fc->sb_flags |= SB_NOSEC;
-	fc->sget_key = bdev_handle;
+	fc->sget_key = &dev;
 	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
-	mutex_unlock(&bdev->bd_fsfreeze_mutex);
-	if (IS_ERR(s)) {
-		blkdev_put(bdev_handle);
+	if (IS_ERR(s))
 		return PTR_ERR(s);
-	}
 
 	if (s->s_root) {
 		/* Don't summarily change the RO/RW state. */
 		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY) {
-			warnf(fc, "%pg: Can't mount, would change RO state", bdev);
+			warnf(fc, "%pg: Can't mount, would change RO state", s->s_bdev);
 			deactivate_locked_super(s);
-			blkdev_put(bdev_handle);
 			return -EBUSY;
 		}
-
+	} else {
 		/*
-		 * s_umount nests inside open_mutex during
-		 * __invalidate_device().  blkdev_put() acquires open_mutex and
-		 * can't be called under s_umount.  Drop s_umount temporarily.
-		 * This is safe as we're holding an active reference.
+		 * We drop s_umount here because we need to lookup bdev and
+		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
+		 * invalidate_bdev()). It is safe because we have active sb
+		 * reference and SB_BORN is not set yet.
 		 */
 		up_write(&s->s_umount);
-		blkdev_put(bdev_handle);
+		error = setup_bdev_super(s, fc->sb_flags, fc);
 		down_write(&s->s_umount);
-	} else {
-		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
-		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
-					fc->fs_type->name, s->s_id);
-		sb_set_blocksize(s, block_size(bdev));
-		error = fill_super(s, fc);
+		if (!error)
+			error = fill_super(s, fc);
 		if (error) {
 			deactivate_locked_super(s);
 			return error;
 		}
 
 		s->s_flags |= SB_ACTIVE;
-		bdev->bd_super = s;
+		s->s_bdev->bd_super = s;
 	}
 
 	BUG_ON(fc->root);
@@ -1337,81 +1353,53 @@ EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
 {
-	return !(s->s_iflags & SB_I_RETIRED) &&
-		s->s_bdev == ((struct bdev_handle *)data)->bdev;
+	return !(s->s_iflags & SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
 }
 
 struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
 {
-	struct bdev_handle *bdev_handle;
-	struct block_device *bdev;
 	struct super_block *s;
 	int error = 0;
+	dev_t dev;
 
-	bdev_handle = blkdev_get_by_path(dev_name, sb_open_mode(flags),
-					 fs_type, &fs_holder_ops);
-	if (IS_ERR(bdev_handle))
-		return ERR_CAST(bdev_handle);
-	bdev = bdev_handle->bdev;
+	error = lookup_bdev(dev_name, &dev);
+	if (error)
+		return ERR_PTR(error);
 
-	/*
-	 * once the super is inserted into the list by sget, s_umount
-	 * will protect the lockfs code from trying to start a snapshot
-	 * while we are mounting
-	 */
-	mutex_lock(&bdev->bd_fsfreeze_mutex);
-	if (bdev->bd_fsfreeze_count > 0) {
-		mutex_unlock(&bdev->bd_fsfreeze_mutex);
-		error = -EBUSY;
-		goto error_bdev;
-	}
-	s = sget(fs_type, test_bdev_super, set_bdev_super, flags | SB_NOSEC,
-		 bdev_handle);
-	mutex_unlock(&bdev->bd_fsfreeze_mutex);
+	flags |= SB_NOSEC;
+	s = sget(fs_type, test_bdev_super, set_bdev_super, flags, &dev);
 	if (IS_ERR(s))
-		goto error_s;
+		return ERR_CAST(s);
 
 	if (s->s_root) {
 		if ((flags ^ s->s_flags) & SB_RDONLY) {
 			deactivate_locked_super(s);
-			error = -EBUSY;
-			goto error_bdev;
+			return ERR_PTR(-EBUSY);
 		}
-
+	} else {
 		/*
-		 * s_umount nests inside open_mutex during
-		 * __invalidate_device().  blkdev_put() acquires open_mutex and
-		 * can't be called under s_umount.  Drop s_umount temporarily.
-		 * This is safe as we're holding an active reference.
+		 * We drop s_umount here because we need to lookup bdev and
+		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
+		 * invalidate_bdev()). It is safe because we have active sb
+		 * reference and SB_BORN is not set yet.
 		 */
 		up_write(&s->s_umount);
-		blkdev_put(bdev_handle);
+		error = setup_bdev_super(s, flags, NULL);
 		down_write(&s->s_umount);
-	} else {
-		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
-		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
-					fs_type->name, s->s_id);
-		sb_set_blocksize(s, block_size(bdev));
-		error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
+		if (!error)
+			error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
 		if (error) {
 			deactivate_locked_super(s);
-			goto error;
+			return ERR_PTR(error);
 		}
 
 		s->s_flags |= SB_ACTIVE;
-		bdev->bd_super = s;
+		s->s_bdev->bd_super = s;
 	}
 
 	return dget(s->s_root);
-
-error_s:
-	error = PTR_ERR(s);
-error_bdev:
-	blkdev_put(bdev_handle);
-error:
-	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(mount_bdev);
 
@@ -1419,10 +1407,12 @@ void kill_block_super(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
 
-	bdev->bd_super = NULL;
 	generic_shutdown_super(sb);
-	sync_blockdev(bdev);
-	blkdev_put(sb->s_bdev_handle);
+	if (bdev) {
+		bdev->bd_super = NULL;
+		sync_blockdev(bdev);
+		blkdev_put(sb->s_bdev_handle);
+	}
 }
 
 EXPORT_SYMBOL(kill_block_super);
-- 
2.35.3

