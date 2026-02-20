Return-Path: <linux-fsdevel+bounces-77801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA5NF8OEmGnKJQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:58:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BCE1691F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92B01309B4E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FAA34EEEE;
	Fri, 20 Feb 2026 15:58:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0041C62
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603094; cv=none; b=s0HT3E6EqWbeA7W641SLHR2WUcR7YqnbPjyX5/ildh63ofSn1NNC4OiuWm8dvk4vjBBlKsLVrVZhx9JXYr+57+ajJb4c6UdB9AIwqMjJc8ccXgyL6moiNce0RWajuVl3TWFHYl6F+b5H6iqtZeMn5mrX0pfUk5HwCLnyWuFdqEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603094; c=relaxed/simple;
	bh=CcYFFV0LzMmy/UiYm7GNT6GfXfz3plwILj9TdeQ7n/E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UK2j4F0wv0cqjpKMr+6D6LVl+kuOBr10MqMBczaM1BL0z2ZMx2C5oLqtRzm8vVm47xGWm/p8rNBqKAtGw84VUiIYiFDANssQ6Q+sTpbS+fbzw9kmvGGZtdjUTC5L3d68IQ6zxxrhkPmA1/JZ0rwPeOlCf9S+t94N8l1t10kej0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61KFvqlv078043;
	Sat, 21 Feb 2026 00:57:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61KFvp6k078029
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Feb 2026 00:57:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fd5c05a5-2752-4dab-ba98-2750577fb9a4@I-love.SAKURA.ne.jp>
Date: Sat, 21 Feb 2026 00:57:48 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] hfs: don't fail operations when files/directories counter
 overflows
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
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
 <524bed1e-fceb-4061-b274-219e64a6b619@I-love.SAKURA.ne.jp>
 <645baa4f25bb435217be8f9f6aa1448de5d5744e.camel@ibm.com>
 <a6e9fe8b-5a20-4c01-a1f8-144572fc3f4a@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <a6e9fe8b-5a20-4c01-a1f8-144572fc3f4a@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77801-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[ibm.com,physik.fu-berlin.de,vivo.com,dubeyko.com,xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.933];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39BCE1691F7
X-Rspamd-Action: no action

Commit b226804532a8 ("hfs: Replace BUG_ON with error handling for CNID
count checks") was an improvement in that it avoids kernel crash, but
was not an improvement in several aspects.

First aspect is that it increased possibility of committing corrupted
counter values to mdb, for that commit did not eliminate possibility of
temporarily overflowing counter values despite these counter values might
be concurrently read by hfs_mdb_commit() because nothing serializes
hfs_new_inode() and hfs_mdb_commit().

  hfs_new_inode() {                             hfs_mdb_commit() {
    (...snipped...)                               (...snipped...)
    // 4294967295 -> 4294967296
    file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
    // Detects overflow
    if (file_count > U32_MAX) {
                                                  // 0 will be committed instead of 4294967295
                                                  mdb->drFilCnt = cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
      // 4294967296 -> 4294967295
      atomic64_dec(&HFS_SB(sb)->file_count);
      goto out_discard;
    }
    (...snipped...)                               (...snipped...)
  }                                             }

Second aspect is that is_hfs_cnid_counts_valid() cannot check for
negative counter values due to s64 and u32 comparison.

  if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
    pr_warn("file count exceeds limit\n");
    corrupted = true;
  }

Third aspect is that is_hfs_cnid_counts_valid() needlessly rejects
creation/deletion of files/directories, for overflow of these counter
values is not fatal error condition. These counter values are only for
informational use (which is not guaranteed to be in sync with actual
number of files/directories). The only fatal error condition that must
reject is that all available 32bits inode numbers are already in use
when creating a file or directory. Other conditions can be checked and
corrected when fsck.hfs is run.

Fourth aspect is that is_hfs_cnid_counts_valid() calls printk() without
ratelimit. A filesystem could stay in mounted state for days/weeks/months,
and e.g. sync() request could be called for e.g. 100 times per second.
The consequence will be stall problem due to printk() flooding and/or
out of disk space due to unimportant kernel messages.

Fix some of these aspects, by don't allow temporarily overflowing counter
values for files/directories and remove printk() for file/directory
counters. This patch does not touch next_id counter, for there are
different topics to consider.

Technically speaking, we can shrink these counter values from atomic64_t
to atomic_t, but this patch does not change because Viacheslav Dubeyko
does not want to treat -1 (negative value) as U32_MAX (positive value).

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hfs/inode.c | 30 ++++++++++--------------------
 fs/hfs/mdb.c   |  8 --------
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d6..e10f96d1711e 100644
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
@@ -216,13 +214,8 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	HFS_I(inode)->tz_secondswest = sys_tz.tz_minuteswest * 60;
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
-		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		if (folder_count> U32_MAX) {
-			atomic64_dec(&HFS_SB(sb)->folder_count);
-			pr_err("cannot create new inode: folder count exceeds limit\n");
-			goto out_discard;
-		}
-		if (dir->i_ino == HFS_ROOT_CNID)
+		atomic64_add_unless(&HFS_SB(sb)->folder_count, 1, U32_MAX);
+		if (dir->i_ino == HFS_ROOT_CNID && HFS_SB(sb)->root_dirs != U16_MAX)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
@@ -230,13 +223,8 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 		inode->i_mode &= ~HFS_SB(inode->i_sb)->s_dir_umask;
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
-		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		if (file_count > U32_MAX) {
-			atomic64_dec(&HFS_SB(sb)->file_count);
-			pr_err("cannot create new inode: file count exceeds limit\n");
-			goto out_discard;
-		}
-		if (dir->i_ino == HFS_ROOT_CNID)
+		atomic64_add_unless(&HFS_SB(sb)->file_count, 1, U32_MAX);
+		if (dir->i_ino == HFS_ROOT_CNID && HFS_SB(sb)->root_files != U16_MAX)
 			HFS_SB(sb)->root_files++;
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
@@ -272,16 +260,18 @@ void hfs_delete_inode(struct inode *inode)
 
 	hfs_dbg("ino %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
-		atomic64_dec(&HFS_SB(sb)->folder_count);
-		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
+		atomic64_add_unless(&HFS_SB(sb)->folder_count, -1, 0);
+		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID) &&
+		    HFS_SB(sb)->root_dirs)
 			HFS_SB(sb)->root_dirs--;
 		set_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags);
 		hfs_mark_mdb_dirty(sb);
 		return;
 	}
 
-	atomic64_dec(&HFS_SB(sb)->file_count);
-	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
+	atomic64_add_unless(&HFS_SB(sb)->file_count, -1, 0);
+	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID) &&
+	    HFS_SB(sb)->root_files)
 		HFS_SB(sb)->root_files--;
 	if (S_ISREG(inode->i_mode)) {
 		if (!inode->i_nlink) {
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..e79e36b7ed84 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -73,14 +73,6 @@ bool is_hfs_cnid_counts_valid(struct super_block *sb)
 		pr_warn("next CNID exceeds limit\n");
 		corrupted = true;
 	}
-	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
-		pr_warn("file count exceeds limit\n");
-		corrupted = true;
-	}
-	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
-		pr_warn("folder count exceeds limit\n");
-		corrupted = true;
-	}
 
 	return !corrupted;
 }
-- 
2.53.0



