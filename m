Return-Path: <linux-fsdevel+bounces-16007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC66896A0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 11:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9907528C122
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3770CA7;
	Wed,  3 Apr 2024 09:10:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35292AE7C;
	Wed,  3 Apr 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135413; cv=none; b=JGPiB3c5ra597QZ/MufyY3uloKuipkaxpsI6wXY+qdSPPt2w4phocQLlcS5lseNJKXV8dpQjtdtJKkERotY7Ij6aveeqRA4vRap6utYtm/j4UgkyZvCrn1JuRQ0a4hfsOLPWZ3SRQBzIRqpIrDBNOUpWkveOQIeziCe/zCiKHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135413; c=relaxed/simple;
	bh=QgoE+OfmdPvK6VPzB9LV9LayCaBdrKNtJSdxQEmkaI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lg6JPW+K4Cxiune1KOo1mvOsIpvKaoRg+CjtJ0EGNyMwcsYSxTefpTsamYzx4fvyv4op3lPRRTtdEGxSnFeRtbDWIZ2j4PWm14VawBRh3WzpzsHI/wOswdorUI1ZnJ55a7XeXB4Er5wZL3H6uXVJeGSSvdXxOAp89ALcBTXr/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4V8dp91MfZz9xHvZ;
	Wed,  3 Apr 2024 16:53:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8C1FA140412;
	Wed,  3 Apr 2024 17:09:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LBXYHA1mI_KDBQ--.29734S2;
	Wed, 03 Apr 2024 10:09:57 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	pc@manguebit.com,
	torvalds@linux-foundation.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Steve French <smfrench@gmail.com>
Subject: [RESEND][PATCH v3] security: Place security_path_post_mknod() where the original IMA call was
Date: Wed,  3 Apr 2024 11:07:49 +0200
Message-Id: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwA3LBXYHA1mI_KDBQ--.29734S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWrXFyUKr4rJFy3trWrKrg_yoW5AF4kpF
	4rtF1DK34rJFy3WF1kAFy7CFyIvay5WFW5XFsYgr13AF9Igr1YgF1S9ryY9rZ8KrWUtry0
	va17KrZxXw4UZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5gMswAAsS

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit 08abce60d63f ("security: Introduce path_post_mknod hook")
introduced security_path_post_mknod(), to replace the IMA-specific call to
ima_post_path_mknod().

For symmetry with security_path_mknod(), security_path_post_mknod() was
called after a successful mknod operation, for any file type, rather than
only for regular files at the time there was the IMA call.

However, as reported by VFS maintainers, successful mknod operation does
not mean that the dentry always has an inode attached to it (for example,
not for FIFOs on a SAMBA mount).

If that condition happens, the kernel crashes when
security_path_post_mknod() attempts to verify if the inode associated to
the dentry is private.

Move security_path_post_mknod() where the ima_post_path_mknod() call was,
which is obviously correct from IMA/EVM perspective. IMA/EVM are the only
in-kernel users, and only need to inspect regular files.

Reported-by: Steve French <smfrench@gmail.com>
Closes: https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: 08abce60d63f ("security: Introduce path_post_mknod hook")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/namei.c          | 7 ++-----
 security/security.c | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ceb9ddf8dfdd..c5b2a25be7d0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4050,6 +4050,8 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 		case 0: case S_IFREG:
 			error = vfs_create(idmap, path.dentry->d_inode,
 					   dentry, mode, true);
+			if (!error)
+				security_path_post_mknod(idmap, dentry);
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
@@ -4060,11 +4062,6 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 					  dentry, mode, 0);
 			break;
 	}
-
-	if (error)
-		goto out2;
-
-	security_path_post_mknod(idmap, dentry);
 out2:
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
diff --git a/security/security.c b/security/security.c
index 7e118858b545..0a9a0ac3f266 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1793,11 +1793,11 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry,
 EXPORT_SYMBOL(security_path_mknod);
 
 /**
- * security_path_post_mknod() - Update inode security field after file creation
+ * security_path_post_mknod() - Update inode security after reg file creation
  * @idmap: idmap of the mount
  * @dentry: new file
  *
- * Update inode security field after a file has been created.
+ * Update inode security field after a regular file has been created.
  */
 void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
-- 
2.34.1


