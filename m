Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489947B8CC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245048AbjJDS7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245079AbjJDS6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:58:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF061BD0;
        Wed,  4 Oct 2023 11:55:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C18C43391;
        Wed,  4 Oct 2023 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445708;
        bh=Mxx0BtmMInezBzzuDb5FKs83348Tgftw3CavncYhdKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pcu9yRaX24NjYh70pmYyj25yD44b36Gj1v0ldhfV2ISDV83mAY4WRMOVlg/44uMs6
         MsRxg/Mk7BvUrkEGk4OQDNXKkC8Y11ur2sQePDteP9mSKu1nJLg00dgRK6DYeaalCu
         4Ns8rgsXa4mIHxqrP/D1R4NWoPgrabvZCKZewoOyMPYed0r4Mh6R63wME78fbPIjrg
         MQiO7upcmNcr4rswGFl6B378G9nHFQVtsGaSzPq9+Uetpi9diNrjKURLBqEZXmktkl
         LOMpiB026iqWL97WEadqLmoreluLzTQ2/+USQVdSIuZ2qkf04uh2H+ctWkfzb3xEwF
         vWATO/WuKaEGA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH v2 68/89] client: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:53 -0400
Message-ID: <20231004185347.80880-66-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
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

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/file.c    | 18 ++++++++++--------
 fs/smb/client/fscache.h |  6 +++---
 fs/smb/client/inode.c   | 17 ++++++++---------
 fs/smb/client/smb2ops.c |  6 ++++--
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 2108b3b40ce9..cf17e3dd703e 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1085,7 +1085,8 @@ int cifs_close(struct inode *inode, struct file *file)
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
 		    dclose) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
-				inode->i_mtime = inode_set_ctime_current(inode);
+				inode_set_mtime_to_ts(inode,
+						      inode_set_ctime_current(inode));
 			}
 			spin_lock(&cinode->deferred_lock);
 			cifs_add_deferred_close(cfile, dclose);
@@ -2596,7 +2597,7 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 					   write_data, to - from, &offset);
 		cifsFileInfo_put(open_file);
 		/* Does mm or vfs already set times? */
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		if ((bytes_written > 0) && (offset))
 			rc = 0;
 		else if (bytes_written < 0)
@@ -4647,11 +4648,13 @@ static void cifs_readahead(struct readahead_control *ractl)
 static int cifs_readpage_worker(struct file *file, struct page *page,
 	loff_t *poffset)
 {
+	struct inode *inode = file_inode(file);
+	struct timespec64 atime, mtime;
 	char *read_data;
 	int rc;
 
 	/* Is the page cached? */
-	rc = cifs_readpage_from_fscache(file_inode(file), page);
+	rc = cifs_readpage_from_fscache(inode, page);
 	if (rc == 0)
 		goto read_complete;
 
@@ -4666,11 +4669,10 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 		cifs_dbg(FYI, "Bytes read %d\n", rc);
 
 	/* we do not want atime to be less than mtime, it broke some apps */
-	file_inode(file)->i_atime = current_time(file_inode(file));
-	if (timespec64_compare(&(file_inode(file)->i_atime), &(file_inode(file)->i_mtime)))
-		file_inode(file)->i_atime = file_inode(file)->i_mtime;
-	else
-		file_inode(file)->i_atime = current_time(file_inode(file));
+	atime = inode_set_atime_to_ts(inode, current_time(inode));
+	mtime = inode_get_mtime(inode);
+	if (timespec64_compare(&atime, &mtime))
+		inode_set_atime_to_ts(inode, inode_get_mtime(inode));
 
 	if (PAGE_SIZE > rc)
 		memset(read_data + rc, 0, PAGE_SIZE - rc);
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index 84f3b09367d2..a3d73720914f 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -49,12 +49,12 @@ static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
 				 struct cifs_fscache_inode_coherency_data *cd)
 {
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct timespec64 ctime = inode_get_ctime(inode);
+	struct timespec64 mtime = inode_get_mtime(inode);
 
 	memset(cd, 0, sizeof(*cd));
-	cd->last_write_time_sec   = cpu_to_le64(cifsi->netfs.inode.i_mtime.tv_sec);
-	cd->last_write_time_nsec  = cpu_to_le32(cifsi->netfs.inode.i_mtime.tv_nsec);
+	cd->last_write_time_sec   = cpu_to_le64(mtime.tv_sec);
+	cd->last_write_time_nsec  = cpu_to_le32(mtime.tv_nsec);
 	cd->last_change_time_sec  = cpu_to_le64(ctime.tv_sec);
 	cd->last_change_time_nsec = cpu_to_le32(ctime.tv_nsec);
 }
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d7c302442c1e..3abfe77bfa46 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -82,6 +82,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 {
 	struct cifs_fscache_inode_coherency_data cd;
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
+	struct timespec64 mtime;
 
 	cifs_dbg(FYI, "%s: revalidating inode %llu\n",
 		 __func__, cifs_i->uniqueid);
@@ -101,7 +102,8 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 
 	 /* revalidate if mtime or size have changed */
 	fattr->cf_mtime = timestamp_truncate(fattr->cf_mtime, inode);
-	if (timespec64_equal(&inode->i_mtime, &fattr->cf_mtime) &&
+	mtime = inode_get_mtime(inode);
+	if (timespec64_equal(&mtime, &fattr->cf_mtime) &&
 	    cifs_i->server_eof == fattr->cf_eof) {
 		cifs_dbg(FYI, "%s: inode %llu is unchanged\n",
 			 __func__, cifs_i->uniqueid);
@@ -164,10 +166,10 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	fattr->cf_ctime = timestamp_truncate(fattr->cf_ctime, inode);
 	/* we do not want atime to be less than mtime, it broke some apps */
 	if (timespec64_compare(&fattr->cf_atime, &fattr->cf_mtime) < 0)
-		inode->i_atime = fattr->cf_mtime;
+		inode_set_atime_to_ts(inode, fattr->cf_mtime);
 	else
-		inode->i_atime = fattr->cf_atime;
-	inode->i_mtime = fattr->cf_mtime;
+		inode_set_atime_to_ts(inode, fattr->cf_atime);
+	inode_set_mtime_to_ts(inode, fattr->cf_mtime);
 	inode_set_ctime_to_ts(inode, fattr->cf_ctime);
 	inode->i_rdev = fattr->cf_rdev;
 	cifs_nlink_fattr_to_inode(inode, fattr);
@@ -1816,7 +1818,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 					   when needed */
 		inode_set_ctime_current(inode);
 	}
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	cifs_inode = CIFS_I(dir);
 	CIFS_I(dir)->time = 0;	/* force revalidate of dir as well */
 unlink_out:
@@ -2131,7 +2133,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 	cifsInode->time = 0;
 
 	inode_set_ctime_current(d_inode(direntry));
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 rmdir_exit:
 	free_dentry_path(page);
@@ -2337,9 +2339,6 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	/* force revalidate to go get info when needed */
 	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
 
-	source_dir->i_mtime = target_dir->i_mtime = inode_set_ctime_to_ts(source_dir,
-									  inode_set_ctime_current(target_dir));
-
 cifs_rename_exit:
 	kfree(info_buf_source);
 	free_dentry_path(page2);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 9aeecee6b91b..f4849a8ad40b 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1403,12 +1403,14 @@ smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* Creation time should not need to be updated on close */
 	if (file_inf.LastWriteTime)
-		inode->i_mtime = cifs_NTtimeToUnix(file_inf.LastWriteTime);
+		inode_set_mtime_to_ts(inode,
+				      cifs_NTtimeToUnix(file_inf.LastWriteTime));
 	if (file_inf.ChangeTime)
 		inode_set_ctime_to_ts(inode,
 				      cifs_NTtimeToUnix(file_inf.ChangeTime));
 	if (file_inf.LastAccessTime)
-		inode->i_atime = cifs_NTtimeToUnix(file_inf.LastAccessTime);
+		inode_set_atime_to_ts(inode,
+				      cifs_NTtimeToUnix(file_inf.LastAccessTime));
 
 	/*
 	 * i_blocks is not related to (i_size / i_blksize),
-- 
2.41.0

