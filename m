Return-Path: <linux-fsdevel+bounces-68561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD3C6024C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 10:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F78D3BC00D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 09:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A8B220F29;
	Sat, 15 Nov 2025 09:19:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FA2CCC0
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763198349; cv=none; b=PPFnXZncWLkATyQSc+g1vW8xmV3XcF2jMTeu5aK2ZMA7NlvtNnMGV+JaGPEPAggWc4b3GHNcdbWT3L9fn4xyNUp2UokSvnEYeusulPKqPiqHAhjazXiPDoUoti1u4vchuDDY1Sx980nJVQtY7mNoeUqwPKYfaGzOuOA4b7L/e3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763198349; c=relaxed/simple;
	bh=9BrTjfHQCYK17+J64u/sIbak8Xf7tXoo2ezw++CzxkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RCi7GkNetvPWmQAUU9vDCnEfO1MRsowTPOtGplPJfbPA0oswnVFlmLz1anjeufIeSi+GPj6Y0hVhEqnK8b+6laitHNX4Bdz2OJTjhPp30rluN8m40as6KU+s5u9FbYamXl0kzfFcQ6GoZ0ZaHugeR+mD7AIk5+6IEdZFu3pSeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5AF9Ire9042613;
	Sat, 15 Nov 2025 18:18:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5AF9IrS0042610
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 15 Nov 2025 18:18:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <04ded9f9-73fb-496c-bfa5-89c4f5d1d7bb@I-love.SAKURA.ne.jp>
Date: Sat, 15 Nov 2025 18:18:54 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] hfsplus: Verify inode mode when loading from disk
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <10028383-1d85-402a-a390-3639e49a9b52@I-love.SAKURA.ne.jp>
 <bfad42ac8e1710e26329b7f1f816199cb1cf0c88.camel@dubeyko.com>
 <d089dcbd-0db2-48a1-86b0-0df3589de9cc@I-love.SAKURA.ne.jp>
 <125c234e-9ffb-4372-bcc4-3a1fbc93825b@I-love.SAKURA.ne.jp>
 <a4fee92f0ae18fd66d32c2ffc6cf731d1a4d498d.camel@dubeyko.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <a4fee92f0ae18fd66d32c2ffc6cf731d1a4d498d.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

syzbot is reporting that S_IFMT bits of inode->i_mode can become bogus when
the S_IFMT bits of the 16bits "mode" field loaded from disk are corrupted.

According to [1], the permissions field was treated as reserved in Mac OS
8 and 9. According to [2], the reserved field was explicitly initialized
with 0, and that field must remain 0 as long as reserved. Therefore, when
the "mode" field is not 0 (i.e. no longer reserved), the file must be
S_IFDIR if dir == 1, and the file must be one of S_IFREG/S_IFLNK/S_IFCHR/
S_IFBLK/S_IFIFO/S_IFSOCK if dir == 0.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Link: https://developer.apple.com/library/archive/technotes/tn/tn1150.html#HFSPlusPermissions [1]
Link: https://developer.apple.com/library/archive/technotes/tn/tn1150.html#ReservedAndPadFields [2]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hfsplus/inode.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index b51a411ecd23..e290e417ed3a 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -180,13 +180,29 @@ const struct dentry_operations hfsplus_dentry_operations = {
 	.d_compare    = hfsplus_compare_dentry,
 };
 
-static void hfsplus_get_perms(struct inode *inode,
-		struct hfsplus_perm *perms, int dir)
+static int hfsplus_get_perms(struct inode *inode,
+			     struct hfsplus_perm *perms, int dir)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	u16 mode;
 
 	mode = be16_to_cpu(perms->mode);
+	if (dir) {
+		if (mode && !S_ISDIR(mode))
+			goto bad_type;
+	} else if (mode) {
+		switch (mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFLNK:
+		case S_IFCHR:
+		case S_IFBLK:
+		case S_IFIFO:
+		case S_IFSOCK:
+			break;
+		default:
+			goto bad_type;
+		}
+	}
 
 	i_uid_write(inode, be32_to_cpu(perms->owner));
 	if ((test_bit(HFSPLUS_SB_UID, &sbi->flags)) || (!i_uid_read(inode) && !mode))
@@ -212,6 +228,10 @@ static void hfsplus_get_perms(struct inode *inode,
 		inode->i_flags |= S_APPEND;
 	else
 		inode->i_flags &= ~S_APPEND;
+	return 0;
+bad_type:
+	pr_err("invalid file type 0%04o for inode %lu\n", mode, inode->i_ino);
+	return -EIO;
 }
 
 static int hfsplus_file_open(struct inode *inode, struct file *file)
@@ -516,7 +536,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		}
 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
 					sizeof(struct hfsplus_cat_folder));
-		hfsplus_get_perms(inode, &folder->permissions, 1);
+		res = hfsplus_get_perms(inode, &folder->permissions, 1);
+		if (res)
+			goto out;
 		set_nlink(inode, 1);
 		inode->i_size = 2 + be32_to_cpu(folder->valence);
 		inode_set_atime_to_ts(inode, hfsp_mt2ut(folder->access_date));
@@ -545,7 +567,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 
 		hfsplus_inode_read_fork(inode, HFSPLUS_IS_RSRC(inode) ?
 					&file->rsrc_fork : &file->data_fork);
-		hfsplus_get_perms(inode, &file->permissions, 0);
+		res = hfsplus_get_perms(inode, &file->permissions, 0);
+		if (res)
+			goto out;
 		set_nlink(inode, 1);
 		if (S_ISREG(inode->i_mode)) {
 			if (file->permissions.dev)
-- 
2.47.3



