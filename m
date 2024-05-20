Return-Path: <linux-fsdevel+bounces-19840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C78CA3D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 23:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BBE1C21476
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862E139D0B;
	Mon, 20 May 2024 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="olLQjaRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555E55E43;
	Mon, 20 May 2024 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716240983; cv=none; b=Q0dXLb54hqwlCI9k9ySOim2244W+ufOMWNV0zUZC0YQQn8mptqr8Exa7WDkQWWIz+oydlZEvSCg6zaZH1hg/SQp90uiuCQU6zxPkGSX57aMR/KyuBBmHgN3Kl+WKoV+w0IhwmiZPcnMiveUAB+zCU6g3zgQz86n+ST3gI8OH4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716240983; c=relaxed/simple;
	bh=x48YcDZycYBkj2Phwetwph6CXUcIag9OaAHRLH6QlOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NSM5VwLY8+aLeTOitYeSx3Xizy8wTAaMi0T6MmDMJLwpIJRi5GtaC+00Z0lLa+8rLE6IMaqXBMuNQZPfnJbMKRZ1btzn84lDPdBBzGqk7vKDK6heuX+Lq3USgT0NrH183qKi4eh6hR5Kn6OYVFCt25Q9CT4F/pZKHnowy5/Hc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=olLQjaRP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VjrV33vVMz9sGX;
	Mon, 20 May 2024 23:36:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1716240971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BXvAc5+yvOeOxZBq8vsWGYVPth6HUKUv5k3v/N890/4=;
	b=olLQjaRP+PPrcDXinmD3wD4A7LPG0bg6uXH9DM+rOz6cnKuOC6yidBDMvpQJjZZYBfNFl8
	cMCsPlDdTZL+W+w6SiwTxmCH3KYm5/b4M3l7fH/XBteQUK42AwamQ9jiAeHpbPQdzp1CnJ
	nI4PsETh3g9yugW5BO24lz68PoqTRifXyq2GxZnToVN5t1JtFeBgHWTez8mG7bO90LmPeX
	50/IJrk2Fqk3emiBV4LkmgLBmgfBS1w84RZ6fRey06zVOtsbmlLPrIIGCiBJmRyHng42Vt
	aBil7Z0RsF+Ps8yflPGZO92H6TMnftgX/nUPqi2XzfPz22MCrS0Ju6URDyUT8Q==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 20 May 2024 17:35:49 -0400
Subject: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
X-B4-Tracking: v=1; b=H4sIADTCS2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0NT3dSKgvyikrRi3VIzE93c/NK8EqAKXcvUpCTTZFOLJFPjZCWg3oK
 i1LTMCrC50UpBbs5KsbW1AAtgJA1sAAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3969; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=x48YcDZycYBkj2Phwetwph6CXUcIag9OaAHRLH6QlOk=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaR5H3KYutXprEaJjcWnmyd2fy874WzhXnkp68ydrdqt9
 QL+7w3UO0pZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBEPs5iZLjz6/3tuvdFbfLt
 1Qmrp9W/uCprn+D99IFl0O9HX6+IbFFkZHjVWCRu2899dvUxqxNGv2PV1VUavQX4tn28JmZ7f2o
 GAx8A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Now that we have stabilised the unique 64-bit mount ID interface in
statx, we can now provide a race-free way for name_to_handle_at(2) to
provide a file handle and corresponding mount without needing to worry
about racing with /proc/mountinfo parsing.

As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* bit
that doesn't make sense for name_to_handle_at(2).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/fhandle.c               | 27 +++++++++++++++++++--------
 include/uapi/linux/fcntl.h |  2 ++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 8a7f86c2139a..6bc7ffccff8c 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -16,7 +16,8 @@
 
 static long do_sys_name_to_handle(const struct path *path,
 				  struct file_handle __user *ufh,
-				  int __user *mnt_id, int fh_flags)
+				  void __user *mnt_id, bool unique_mntid,
+				  int fh_flags)
 {
 	long retval;
 	struct file_handle f_handle;
@@ -69,10 +70,16 @@ static long do_sys_name_to_handle(const struct path *path,
 	} else
 		retval = 0;
 	/* copy the mount id */
-	if (put_user(real_mount(path->mnt)->mnt_id, mnt_id) ||
-	    copy_to_user(ufh, handle,
-			 struct_size(handle, f_handle, handle_bytes)))
-		retval = -EFAULT;
+	if (unique_mntid)
+		retval = put_user(real_mount(path->mnt)->mnt_id_unique,
+				  (u64 __user *) mnt_id);
+	else
+		retval = put_user(real_mount(path->mnt)->mnt_id,
+				  (int __user *) mnt_id);
+	/* copy the handle */
+	if (!retval)
+		retval = copy_to_user(ufh, handle,
+				struct_size(handle, f_handle, handle_bytes));
 	kfree(handle);
 	return retval;
 }
@@ -83,6 +90,7 @@ static long do_sys_name_to_handle(const struct path *path,
  * @name: name that should be converted to handle.
  * @handle: resulting file handle
  * @mnt_id: mount id of the file system containing the file
+ *          (u64 if AT_HANDLE_UNIQUE_MNT_ID, otherwise int)
  * @flag: flag value to indicate whether to follow symlink or not
  *        and whether a decodable file handle is required.
  *
@@ -92,7 +100,7 @@ static long do_sys_name_to_handle(const struct path *path,
  * value required.
  */
 SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
-		struct file_handle __user *, handle, int __user *, mnt_id,
+		struct file_handle __user *, handle, void __user *, mnt_id,
 		int, flag)
 {
 	struct path path;
@@ -100,7 +108,8 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 	int fh_flags;
 	int err;
 
-	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID))
+	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID |
+		     AT_HANDLE_UNIQUE_MNT_ID))
 		return -EINVAL;
 
 	lookup_flags = (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
@@ -109,7 +118,9 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 		lookup_flags |= LOOKUP_EMPTY;
 	err = user_path_at(dfd, name, lookup_flags, &path);
 	if (!err) {
-		err = do_sys_name_to_handle(&path, handle, mnt_id, fh_flags);
+		err = do_sys_name_to_handle(&path, handle, mnt_id,
+					    flag & AT_HANDLE_UNIQUE_MNT_ID,
+					    fh_flags);
 		path_put(&path);
 	}
 	return err;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index c0bcc185fa48..fda970f92fba 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -118,6 +118,8 @@
 #define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
 					compare object identity and may not
 					be usable to open_by_handle_at(2) */
+#define AT_HANDLE_UNIQUE_MNT_ID	AT_STATX_FORCE_SYNC /* returned mount id is
+					the u64 unique mount id */
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000
 #endif

---
base-commit: 584bbf439d0fa83d728ec49f3a38c581bdc828b4
change-id: 20240515-exportfs-u64-mount-id-9ebb5c58b53c

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


