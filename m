Return-Path: <linux-fsdevel+bounces-77123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEc1BkX+jmmOGwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:34:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E81351ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040B830479EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D06934D4CC;
	Fri, 13 Feb 2026 10:34:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A87E0FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978879; cv=none; b=fwOjnY+cnSJ7KIcv++Ur8nnVC05ncEcKUlZ6YTmBXzlL1e51PpfavZ1uGnSY11GaqHB3WJLlMplNJRT6oZuIg77eSf7w4rrMbVV+pnowKn8kctqDfrOrtXQKAaAvsKK6SnS8pR3wAcw2OanvMh73RHlB4fHWn0+fwXdKL1Hgbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978879; c=relaxed/simple;
	bh=bph7eOmTWMVnVQ4EEK2TjDE0feOTFDUrlVxTjM42+Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeHJQnBNmZjSa24vLYOwhBmjk2vP2N/L2TQbrQulBJvtlWk2lit3mrWzdPWB79fUvNdibKyAe4NFUSXsrLnHww3NZoKCBQEbrw9hdnIlxTFQ6nPLsGdpK0zpt8ZtQDJ1qosnfpCZBLK1is6B9qatMGefM6YmOaqK5HSBZcjKb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61DAYOfE057553;
	Fri, 13 Feb 2026 19:34:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61DAYOWU057550
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Feb 2026 19:34:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ef597d09-0fe0-44bc-93ff-b0223eb97ce8@I-love.SAKURA.ne.jp>
Date: Fri, 13 Feb 2026 19:34:24 +0900
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <62e01a3505bca9d1e8779f85e0223ec02c24a6de.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77123-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[ibm.com,physik.fu-berlin.de,vivo.com,dubeyko.com,xs4all.nl];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: F37E81351ED
X-Rspamd-Action: no action

On 2026/02/13 6:51, Viacheslav Dubeyko wrote:
> On Thu, 2026-02-12 at 22:27 +0900, Tetsuo Handa wrote:
>> On 2026/02/12 7:36, Viacheslav Dubeyko wrote:
>>>> Only compile tested.
>>>
>>> Maybe, it makes sense to run some tests? :)
>>>
>>
>> I tried below diff. While this diff worked, I came to feel that we don't need to
>> fail operations upon overflow of ->file_count or ->folder_count.
>>
>> Since ->next_id is used for inode number, we should check for next_id >= 16.
>>
>> But ->file_count and ->folder_count are (if I understand correctly) only for
>> statistical purpose and *currently checking for overflow on creation and not
>> checking for overflow on deletion*.
>>
> 
> These fields exist not for statistical purpose. We store these values in struct
> hfs_mdb [1, 2] and, finally, on the volume. As file system driver as FSCK tool
> can use these values for comparing with b-trees' content.
> 
> As I remember, we are checking the deletion case too [3].
> 
>> There are ->root_files and ->root_dirs
>> which are also for statistical purpose and *currently not checking for overflow*.
> 
> It's also not for statistical purpose. :)  I think to have the checking logic
> for root_files and root_dirs will be good too.

Well, I called "statistical purpose" because inaccurate values do not cause serious
problems (such as memory corruption, system crash, loss of file data).

> 
>> Overflowing on these counters are not fatal enough to make operations fail.
>>
>> I think that we can use 32bits atomic_t for ->file_count / ->folder_count, and cap
>> max/min range using atomic_add_unless(v, 1, -1)/atomic_add_unless(v, -1, 0).
> 
> These values are __be32 and it means that U32_MAX is completely normal value.
> This is why atomic64_t was selected.

atomic_add_unless(v, 1, -1) is atomic version of

  if (v != -1) v++;

and atomic_add_unless(v, -1, 0) is atomic version of

  if (v != 0) v--;

. The v can accept U32_MAX as normal value.

Below is what I suggest; don't fail operations if counter values for files/directories
overflowed, instead later suggest fsck.hfs when writing to mdb. This is a heuristic
based on an assumption that "legitimate users unlikely crete 65536+ files/directories
under the root directory and 4294967296+ files/directories within one filesystem";
in other words, "overflow of the counter values is likely a signal for a filesystem
corruption (or fuzz testing)".


 fs/hfs/hfs_fs.h |    5 +++--
 fs/hfs/inode.c  |   54 +++++++++++++++++++++++++++++++-----------------------
 fs/hfs/mdb.c    |   30 +++++++++++-------------------
 fs/hfs/super.c  |    8 +++-----
 4 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ac0e83f77a0f..779394f7f2b9 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -80,10 +80,10 @@ struct hfs_sb_info {
 						   the extents b-tree */
 	struct hfs_btree *cat_tree;			/* Information about
 						   the catalog b-tree */
-	atomic64_t file_count;			/* The number of
+	atomic_t file_count;			/* The number of
 						   regular files in
 						   the filesystem */
-	atomic64_t folder_count;		/* The number of
+	atomic_t folder_count;			/* The number of
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
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d6..0ed145b92803 100644
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
+		if (unlikely(!atomic_add_unless(&HFS_SB(sb)->folder_count, 1, -1)))
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
+		if (unlikely(!atomic_add_unless(&HFS_SB(sb)->file_count, 1, -1)))
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
+		if (unlikely(!atomic_add_unless(&HFS_SB(sb)->folder_count, -1, 0)))
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
+	if (unlikely(!atomic_add_unless(&HFS_SB(sb)->file_count, -1, 0)))
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
index a97cea35ca2e..ef969e3c2192 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -67,22 +67,11 @@ static int hfs_get_last_session(struct super_block *sb,
 bool is_hfs_cnid_counts_valid(struct super_block *sb)
 {
 	struct hfs_sb_info *sbi = HFS_SB(sb);
-	bool corrupted = false;
+	s64 next_id = atomic64_read(&sbi->next_id);
 
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
+	if (unlikely(upper_32_bits(next_id) || next_id < HFS_FIRSTUSER_CNID))
+		sbi->suggest_fsck = true;
+	return !sbi->suggest_fsck;
 }
 
 /*
@@ -177,8 +166,8 @@ int hfs_mdb_get(struct super_block *sb)
 	atomic64_set(&HFS_SB(sb)->next_id, be32_to_cpu(mdb->drNxtCNID));
 	HFS_SB(sb)->root_files = be16_to_cpu(mdb->drNmFls);
 	HFS_SB(sb)->root_dirs = be16_to_cpu(mdb->drNmRtDirs);
-	atomic64_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
-	atomic64_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
+	atomic_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
+	atomic_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
 
 	if (!is_hfs_cnid_counts_valid(sb)) {
 		pr_warn("filesystem possibly corrupted, running fsck.hfs is recommended. Mounting read-only.\n");
@@ -291,6 +280,9 @@ void hfs_mdb_commit(struct super_block *sb)
 	if (sb_rdonly(sb))
 		return;
 
+	if (!is_hfs_cnid_counts_valid(sb))
+		pr_warn("filesystem error was detected, running fsck.hfs is recommended.\n");
+
 	lock_buffer(HFS_SB(sb)->mdb_bh);
 	if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
 		/* These parameters may have been modified, so write them back */
@@ -301,9 +293,9 @@ void hfs_mdb_commit(struct super_block *sb)
 		mdb->drNmFls = cpu_to_be16(HFS_SB(sb)->root_files);
 		mdb->drNmRtDirs = cpu_to_be16(HFS_SB(sb)->root_dirs);
 		mdb->drFilCnt =
-			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
+			cpu_to_be32((u32)atomic_read(&HFS_SB(sb)->file_count));
 		mdb->drDirCnt =
-			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
+			cpu_to_be32((u32)atomic_read(&HFS_SB(sb)->folder_count));
 
 		/* write MDB to disk */
 		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 97546d6b41f4..499e89cacd82 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -34,7 +34,6 @@ MODULE_LICENSE("GPL");
 
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
-	is_hfs_cnid_counts_valid(sb);
 	hfs_mdb_commit(sb);
 	return 0;
 }
@@ -66,8 +65,6 @@ static void flush_mdb(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
-	is_hfs_cnid_counts_valid(sb);
-
 	hfs_mdb_commit(sb);
 }
 
@@ -322,8 +319,9 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	int silent = fc->sb_flags & SB_SILENT;
 	int res;
 
-	atomic64_set(&sbi->file_count, 0);
-	atomic64_set(&sbi->folder_count, 0);
+	sbi->suggest_fsck = false;
+	atomic_set(&sbi->file_count, 0);
+	atomic_set(&sbi->folder_count, 0);
 	atomic64_set(&sbi->next_id, 0);
 
 	/* load_nls_default does not fail */


