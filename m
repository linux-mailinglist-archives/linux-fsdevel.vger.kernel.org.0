Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E61AB688
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 06:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDPELU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 00:11:20 -0400
Received: from sandeen.net ([63.231.237.45]:55798 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgDPELS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 00:11:18 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id A6E4A170B41;
        Wed, 15 Apr 2020 23:10:54 -0500 (CDT)
Subject: [PATCH 2/2 V2] exfat: truncate atimes to 2s granularity
From:   Eric Sandeen <sandeen@sandeen.net>
To:     fsdevel <linux-fsdevel@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
References: <ef3cdac4-9967-a225-fb04-4dbb4c7037a9@sandeen.net>
 <abfc2cdf-0ff1-3334-da03-8fbcc6eda328@sandeen.net>
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <381e5327-618b-13ab-ebe5-175f99abf7db@sandeen.net>
Date:   Wed, 15 Apr 2020 23:11:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <abfc2cdf-0ff1-3334-da03-8fbcc6eda328@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

exfat atimes are restricted to only 2s granularity so after
we set an atime, round it down to the nearest 2s and set the
sub-second component of the timestamp to 0.

Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
---

V2: don't just zero tv_nsec, must also round down tv_sec I think.

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 67d4e46fb810..d67fb8a6f770 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -507,6 +507,7 @@ void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
 		__printf(3, 4) __cold;
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 tz, __le16 time, __le16 date, u8 time_ms);
+void exfat_truncate_atime(struct timespec64 *ts);
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 *tz, __le16 *time, __le16 *date, u8 *time_ms);
 unsigned short exfat_calc_chksum_2byte(void *data, int len,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 483f683757aa..4f76764165cf 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -273,6 +273,7 @@ int exfat_getattr(const struct path *path, struct kstat *stat,
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 
 	generic_fillattr(inode, stat);
+	exfat_truncate_atime(&stat->atime);
 	stat->result_mask |= STATX_BTIME;
 	stat->btime.tv_sec = ei->i_crtime.tv_sec;
 	stat->btime.tv_nsec = ei->i_crtime.tv_nsec;
@@ -339,6 +340,7 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	setattr_copy(inode, attr);
+	exfat_truncate_atime(&inode->i_atime);
 	mark_inode_dirty(inode);
 
 out:
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 14a3300848f6..c8b33278d474 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -88,7 +88,8 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 	if (time_ms) {
 		ts->tv_sec += time_ms / 100;
 		ts->tv_nsec = (time_ms % 100) * 10 * NSEC_PER_MSEC;
-	}
+	} else
+		exfat_truncate_atime(ts);
 
 	if (tz & EXFAT_TZ_VALID)
 		/* Adjust timezone to UTC0. */
@@ -124,6 +125,13 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 	*tz = EXFAT_TZ_VALID;
 }
 
+/* atime has only a 2-second resolution */
+void exfat_truncate_atime(struct timespec64 *ts)
+{
+	ts->tv_sec = round_down(ts->tv_sec, 2); 
+	ts->tv_nsec = 0;
+}
+
 unsigned short exfat_calc_chksum_2byte(void *data, int len,
 		unsigned short chksum, int type)
 {
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index a8681d91f569..b72d782568b8 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -595,6 +595,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	inode_inc_iversion(inode);
 	inode->i_mtime = inode->i_atime = inode->i_ctime =
 		EXFAT_I(inode)->i_crtime = current_time(inode);
+	exfat_truncate_atime(&inode->i_atime);
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	d_instantiate(dentry, inode);
@@ -854,6 +855,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 
 	inode_inc_iversion(dir);
 	dir->i_mtime = dir->i_atime = current_time(dir);
+	exfat_truncate_atime(&dir->i_atime);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
@@ -861,6 +863,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 
 	clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = current_time(inode);
+	exfat_truncate_atime(&inode->i_atime);
 	exfat_unhash_inode(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
 unlock:
@@ -903,6 +906,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode_inc_iversion(inode);
 	inode->i_mtime = inode->i_atime = inode->i_ctime =
 		EXFAT_I(inode)->i_crtime = current_time(inode);
+	exfat_truncate_atime(&inode->i_atime);
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	d_instantiate(dentry, inode);
@@ -1019,6 +1023,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	inode_inc_iversion(dir);
 	dir->i_mtime = dir->i_atime = current_time(dir);
+	exfat_truncate_atime(&dir->i_atime);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
@@ -1027,6 +1032,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = current_time(inode);
+	exfat_truncate_atime(&inode->i_atime);
 	exfat_unhash_inode(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
 unlock:
@@ -1387,6 +1393,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	inode_inc_iversion(new_dir);
 	new_dir->i_ctime = new_dir->i_mtime = new_dir->i_atime =
 		EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
+	exfat_truncate_atime(&new_dir->i_atime);
 	if (IS_DIRSYNC(new_dir))
 		exfat_sync_inode(new_dir);
 	else
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 16ed202ef527..aed62cafb0da 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -351,6 +351,7 @@ static int exfat_read_root(struct inode *inode)
 	exfat_save_attr(inode, ATTR_SUBDIR);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = ei->i_crtime =
 		current_time(inode);
+	exfat_truncate_atime(&inode->i_atime);
 	exfat_cache_init_inode(inode);
 	return 0;
 }

