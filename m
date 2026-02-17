Return-Path: <linux-fsdevel+bounces-77367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPifD29vlGk0DwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 14:38:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BBB14CAE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 14:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B01733006234
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E24833858F;
	Tue, 17 Feb 2026 13:38:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7B32AAA2
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335528; cv=none; b=sJuBVc7l5XUqo0/BeZTNOxVmmrVuf/+VkhbZryxry2AeIpm4Rwl6lhX08mh6ImQ2QmCuTqk/UhvaWOQrLnG056+3BpDBzGB1TzvP0z3etzxFWZlErz7A8jVVdf2N1Li03q/4tSsfhS6eXsdNPo+HNLEXEGsUcKiO+GKH+2ccJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335528; c=relaxed/simple;
	bh=g3ciZjNQtPfg80AuuwCzZQIRvxuDrGiym1CmfASYXCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QifKF/ZncMStH3Aiyxsy5rNsA3nz3U5h0fjmLeFMGZTsn9LLxyZzWXshGeNF2t9vMRVuBZlb70HphFAWasCUbuLw6Tg1eeAyXIGVxwQ3Owb8+Gvca5vs9ixKWHSSqUj+XxxOTgeNxATpzIN+nIAHUNAZDphNviR4MBXMivNflrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61HCfiGJ033433;
	Tue, 17 Feb 2026 21:41:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61HCfiDr033429
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 17 Feb 2026 21:41:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <524bed1e-fceb-4061-b274-219e64a6b619@I-love.SAKURA.ne.jp>
Date: Tue, 17 Feb 2026 21:41:45 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: evaluate the upper 32bits for detecting overflow
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
 <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
 <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
 <62e01a3505bca9d1e8779f85e0223ec02c24a6de.camel@ibm.com>
 <ef597d09-0fe0-44bc-93ff-b0223eb97ce8@I-love.SAKURA.ne.jp>
 <37b976e33847b4e3370d423825aaa23bdc081606.camel@ibm.com>
 <f8700c59-3763-4ea9-b5c2-f4510c2106ed@I-love.SAKURA.ne.jp>
 <40a8f3a228cf8f3580f633b9289cd371b553c3e4.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <40a8f3a228cf8f3580f633b9289cd371b553c3e4.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FREEMAIL_TO(0.00)[ibm.com,physik.fu-berlin.de,vivo.com,dubeyko.com,xs4all.nl];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77367-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33BBB14CAE2
X-Rspamd-Action: no action

On 2026/02/17 9:59, Viacheslav Dubeyko wrote:
>> We can represent __be32 using signed 32bits integer when counting number of
>> files/directories (which by definition cannot take a negative value), for
>> we can interpret [-2147483648,-1] range as [2147483648,4294967295] range
>> because we don't need to handle [-2147483648,-1] range.
> 
> If you suggest to increment the atomic_t until U32_MAX and somehow keep in the
> mind that we need to treat negative value as positive, then it's confusing and
> nobody will follow to this solution. It will introduce the bugs easily. Using
> atomic64_t is clear solution, we don't need to use any tricks and everybody can
> follow to such technique.

Then, we can use u32 and U32_MIN/U32_MAX like below. (I'm not trying to convert
next_id to u32, for it needs more inspection before we are convinced that there is
no possibility for overflow.) Do you still dislike converting to u32?

 fs/hfs/hfs_fs.h |   37 ++++++++++++++++++++++++++++++++++---
 fs/hfs/inode.c  |   54 +++++++++++++++++++++++++++++++-----------------------
 fs/hfs/mdb.c    |   31 ++++---------------------------
 fs/hfs/super.c  |   12 +++++++-----
 4 files changed, 76 insertions(+), 58 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ac0e83f77a0f..73792460f938 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -80,10 +80,10 @@ struct hfs_sb_info {
 						   the extents b-tree */
 	struct hfs_btree *cat_tree;			/* Information about
 						   the catalog b-tree */
-	atomic64_t file_count;			/* The number of
+	u32 file_count;				/* The number of
 						   regular files in
 						   the filesystem */
-	atomic64_t folder_count;		/* The number of
+	u32 folder_count;			/* The number of
 						   directories in the
 						   filesystem */
 	atomic64_t next_id;			/* The next available
@@ -132,6 +132,7 @@ struct hfs_sb_info {
 	int work_queued;		/* non-zero delayed work is queued */
 	struct delayed_work mdb_work;	/* MDB flush delayed work */
 	spinlock_t work_lock;		/* protects mdb_work and work_queued */
+	bool suggest_fsck;
 };
 
 #define HFS_FLG_BITMAP_DIRTY	0
@@ -199,7 +200,6 @@ extern void hfs_delete_inode(struct inode *inode);
 extern const struct xattr_handler * const hfs_xattr_handlers[];
 
 /* mdb.c */
-extern bool is_hfs_cnid_counts_valid(struct super_block *sb);
 extern int hfs_mdb_get(struct super_block *sb);
 extern void hfs_mdb_commit(struct super_block *sb);
 extern void hfs_mdb_close(struct super_block *sb);
@@ -289,4 +289,35 @@ static inline void hfs_bitmap_dirty(struct super_block *sb)
 	__bh;						\
 })
 
+static inline bool inc_u32_unless_wraparound(u32 *v)
+{
+	while (1) {
+		const u32 t = data_race(READ_ONCE(*v)); /* silence KCSAN */
+
+		if (unlikely(t == U32_MAX))
+			return false;
+		if (likely(cmpxchg(v, t, t + 1) == t))
+			return true;
+	}
+}
+
+static inline bool dec_u32_unless_wraparound(u32 *v)
+{
+	while (1) {
+		const u32 t = data_race(READ_ONCE(*v)); /* silence KCSAN */
+
+		if (unlikely(t == U32_MIN))
+			return false;
+		if (likely(cmpxchg(v, t, t - 1) == t))
+			return true;
+	}
+}
+
+static inline bool is_hfs_cnid_counts_valid(struct super_block *sb)
+{
+	s64 next_id = atomic64_read(&HFS_SB(sb)->next_id);
+
+	return next_id >= HFS_FIRSTUSER_CNID && !upper_32_bits(next_id);
+}
+
 #endif
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d6..5dc48629d27c 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -185,8 +185,6 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = new_inode(sb);
 	s64 next_id;
-	s64 file_count;
-	s64 folder_count;
 	int err = -ENOMEM;
 
 	if (!inode)
@@ -199,7 +197,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	if (next_id > U32_MAX) {
+	if (upper_32_bits(next_id)) {
 		atomic64_dec(&HFS_SB(sb)->next_id);
 		pr_err("cannot create new inode: next CNID exceeds limit\n");
 		goto out_discard;
@@ -216,28 +214,28 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	HFS_I(inode)->tz_secondswest = sys_tz.tz_minuteswest * 60;
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
-		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		if (folder_count> U32_MAX) {
-			atomic64_dec(&HFS_SB(sb)->folder_count);
-			pr_err("cannot create new inode: folder count exceeds limit\n");
-			goto out_discard;
+		if (unlikely(!inc_u32_unless_wraparound(&HFS_SB(sb)->folder_count)))
+			HFS_SB(sb)->suggest_fsck = true;
+		if (dir->i_ino == HFS_ROOT_CNID) {
+			if (unlikely(HFS_SB(sb)->root_dirs == U16_MAX))
+				HFS_SB(sb)->suggest_fsck = true;
+			else
+				HFS_SB(sb)->root_dirs++;
 		}
-		if (dir->i_ino == HFS_ROOT_CNID)
-			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		inode->i_mode |= S_IRWXUGO;
 		inode->i_mode &= ~HFS_SB(inode->i_sb)->s_dir_umask;
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
-		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		if (file_count > U32_MAX) {
-			atomic64_dec(&HFS_SB(sb)->file_count);
-			pr_err("cannot create new inode: file count exceeds limit\n");
-			goto out_discard;
+		if (unlikely(!inc_u32_unless_wraparound(&HFS_SB(sb)->file_count)))
+			HFS_SB(sb)->suggest_fsck = true;
+		if (dir->i_ino == HFS_ROOT_CNID) {
+			if (unlikely(HFS_SB(sb)->root_files == U16_MAX))
+				HFS_SB(sb)->suggest_fsck = true;
+			else
+				HFS_SB(sb)->root_files++;
 		}
-		if (dir->i_ino == HFS_ROOT_CNID)
-			HFS_SB(sb)->root_files++;
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
@@ -272,17 +270,27 @@ void hfs_delete_inode(struct inode *inode)
 
 	hfs_dbg("ino %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
-		atomic64_dec(&HFS_SB(sb)->folder_count);
-		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
-			HFS_SB(sb)->root_dirs--;
+		if (unlikely(!dec_u32_unless_wraparound(&HFS_SB(sb)->folder_count)))
+			HFS_SB(sb)->suggest_fsck = true;
+		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID)) {
+			if (unlikely(!HFS_SB(sb)->root_dirs))
+				HFS_SB(sb)->suggest_fsck = true;
+			else
+				HFS_SB(sb)->root_dirs--;
+		}
 		set_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags);
 		hfs_mark_mdb_dirty(sb);
 		return;
 	}
 
-	atomic64_dec(&HFS_SB(sb)->file_count);
-	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
-		HFS_SB(sb)->root_files--;
+	if (unlikely(!dec_u32_unless_wraparound(&HFS_SB(sb)->file_count)))
+		HFS_SB(sb)->suggest_fsck = true;
+	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID)) {
+		if (unlikely(!HFS_SB(sb)->root_files))
+			HFS_SB(sb)->suggest_fsck = true;
+		else
+			HFS_SB(sb)->root_files--;
+	}
 	if (S_ISREG(inode->i_mode)) {
 		if (!inode->i_nlink) {
 			inode->i_size = 0;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..c0e55e7233c9 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -64,27 +64,6 @@ static int hfs_get_last_session(struct super_block *sb,
 	return 0;
 }
 
-bool is_hfs_cnid_counts_valid(struct super_block *sb)
-{
-	struct hfs_sb_info *sbi = HFS_SB(sb);
-	bool corrupted = false;
-
-	if (unlikely(atomic64_read(&sbi->next_id) > U32_MAX)) {
-		pr_warn("next CNID exceeds limit\n");
-		corrupted = true;
-	}
-	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
-		pr_warn("file count exceeds limit\n");
-		corrupted = true;
-	}
-	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
-		pr_warn("folder count exceeds limit\n");
-		corrupted = true;
-	}
-
-	return !corrupted;
-}
-
 /*
  * hfs_mdb_get()
  *
@@ -177,8 +156,8 @@ int hfs_mdb_get(struct super_block *sb)
 	atomic64_set(&HFS_SB(sb)->next_id, be32_to_cpu(mdb->drNxtCNID));
 	HFS_SB(sb)->root_files = be16_to_cpu(mdb->drNmFls);
 	HFS_SB(sb)->root_dirs = be16_to_cpu(mdb->drNmRtDirs);
-	atomic64_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
-	atomic64_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
+	HFS_SB(sb)->file_count = be32_to_cpu(mdb->drFilCnt);
+	HFS_SB(sb)->folder_count = be32_to_cpu(mdb->drDirCnt);
 
 	if (!is_hfs_cnid_counts_valid(sb)) {
 		pr_warn("filesystem possibly corrupted, running fsck.hfs is recommended. Mounting read-only.\n");
@@ -300,10 +279,8 @@ void hfs_mdb_commit(struct super_block *sb)
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
 		mdb->drNmFls = cpu_to_be16(HFS_SB(sb)->root_files);
 		mdb->drNmRtDirs = cpu_to_be16(HFS_SB(sb)->root_dirs);
-		mdb->drFilCnt =
-			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
-		mdb->drDirCnt =
-			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
+		mdb->drFilCnt = cpu_to_be32(HFS_SB(sb)->file_count);
+		mdb->drDirCnt = cpu_to_be32(HFS_SB(sb)->folder_count);
 
 		/* write MDB to disk */
 		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 97546d6b41f4..e150550a5ded 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -34,7 +34,6 @@ MODULE_LICENSE("GPL");
 
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
-	is_hfs_cnid_counts_valid(sb);
 	hfs_mdb_commit(sb);
 	return 0;
 }
@@ -50,6 +49,10 @@ static void hfs_put_super(struct super_block *sb)
 {
 	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
 	hfs_mdb_close(sb);
+
+	if (!is_hfs_cnid_counts_valid(sb) || HFS_SB(sb)->suggest_fsck)
+		pr_warn("filesystem error was detected, running fsck.hfs is recommended.\n");
+
 	/* release the MDB's resources */
 	hfs_mdb_put(sb);
 }
@@ -66,8 +69,6 @@ static void flush_mdb(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
-	is_hfs_cnid_counts_valid(sb);
-
 	hfs_mdb_commit(sb);
 }
 
@@ -322,8 +323,9 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	int silent = fc->sb_flags & SB_SILENT;
 	int res;
 
-	atomic64_set(&sbi->file_count, 0);
-	atomic64_set(&sbi->folder_count, 0);
+	sbi->suggest_fsck = false;
+	sbi->file_count = 0;
+	sbi->folder_count = 0;
 	atomic64_set(&sbi->next_id, 0);
 
 	/* load_nls_default does not fail */



