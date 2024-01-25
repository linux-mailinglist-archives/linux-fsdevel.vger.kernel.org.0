Return-Path: <linux-fsdevel+bounces-8910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1107F83C00E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349D61C20A7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0794F6A012;
	Thu, 25 Jan 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0CBBpPx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492B67E9F;
	Thu, 25 Jan 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179541; cv=none; b=tbjgAADb9pX3DRrsxdnRlTJnK9B4b8ZltJruuzHsn2HqR+Tg5Sm8FwxaETUx1CQ5R8liX4P2Ui2qxB71WV6sqK97GORwmarfhwWrsDKh/xVhZWtWSCxzFi/+IQrKKl9tbVStzRP+qSaaZfsTc3w/X7tRB7Eeu/zIvwe0UrZctmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179541; c=relaxed/simple;
	bh=0d5rnPV7pVlVsQkdQfvtcATDyqVhadACxbi50CfJHjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3UxV4A91R59SE2wlV89s0QqZyrVaUvL/0llRgSYklW4ryWMwMGNWhNKgieDt0noLUwEKh4bq5lh3Lz16WvLL8KjSOz1LM9ihvGQ+d2d2tYbA3uLGPFWmETfku4NdehEx7+JJUVDOmMgiyfxsWAlusIrwzr1WmpVb3cGiATwhco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0CBBpPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFF6C43390;
	Thu, 25 Jan 2024 10:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179540;
	bh=0d5rnPV7pVlVsQkdQfvtcATDyqVhadACxbi50CfJHjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F0CBBpPxAOTSyrv0lc7DHq/CKgTy33jtAmvR7bAQLHuuKmkkBl2wSVhNzgtjOsaYF
	 uZZOn77gA9c2LqfoSDIg4ktVmH/KOhOuyIm16eoaYGHUlfAXxi4VnfzYQf9rg80IDy
	 Y/I989sT4vX/KrQZshkPxYn8YEEexmgUJOADTZNXhuY3ob5dC/zlznfNpGeOgDAd0R
	 vtMZTwGPG+Hg1c5ysf2wph7mewkrjMJiIT5xIRhFFcaRSnfIsJsMvB3ejyhgUwgV6H
	 XMk0SHrYHNurmrRE8MBquL3aBroiszz827oj0CE3JYqndxkc88MX8pBcwFdwb7+cFh
	 uvDfQSbYTqPKg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:19 -0500
Subject: [PATCH v2 38/41] smb/client: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-38-7485322b62c7@kernel.org>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
In-Reply-To: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Jan Kara <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11982; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0d5rnPV7pVlVsQkdQfvtcATDyqVhadACxbi50CfJHjQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs+8qeIn7YKC0elDSkyNmqHKOtzLAacbGp4v
 I8SQvGyWkOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PgAKCRAADmhBGVaC
 FUIND/4+bM27GMIH7hdk4878rF9hhrzxmbhM7DpBNAF3n5gK05X0Em8AYNtzIltF715nqHh3vOz
 9N314WfdBxXzrHhdoeiYviHZWIy4sI7tohFH2v0oLnmndUtmWQFPRiSUB8ihtboLAuNmAl+c50E
 kl/b3JCyGH7VoLeB5PaMV4g1eZk1hILKJk9n+EXbZyEgyNuswe1PjoU9nQn0O9Qv1WCe/cruB5f
 8Wm5oZwzNxK9ViWf+KOlnW955g1VR6m3lRdsET+yDV9O0zoppzKyoheh0axIBgDYl2+DUXqYv9W
 bZtMRHxRR2pQsi89fQrY7e/zdq5N7oM3UHirJI1fht5PC+5kYt6/e8dR30+gEnnXl1QazKDqzG7
 zZmcnIRxy9Bk7neZPD7OqQNtM/eEteNo3C7AGRSDUMyKhvJFYnsBQaJI7OfhZpenSUHRke5J9pW
 +Cu4o1Y1tHp+9drJnypDeOd2VEL+Geibs9ZWqutQIUsiHc1RFupuHqLN8grf6MbqhPxVA1OHGGa
 e1++85Ppnfst1JBy0C3CNZfuk2wjJ8eiDCdoye9/PEljOU798lcbCVA6NNMaAs14QhOcbnOL5uy
 WxTZptngzDGueQL7TasLsPCHf8MXc7sWRijDUbDRukJjn7bM5yBJPOO20bo7+uUwJ1JyFa6yKwq
 QNgCL8ZOS+gYsfw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/cifsglob.h |  1 -
 fs/smb/client/cifssmb.c  |  9 +++---
 fs/smb/client/file.c     | 75 ++++++++++++++++++++++++------------------------
 fs/smb/client/smb2file.c |  3 +-
 4 files changed, 43 insertions(+), 45 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index fcda4c77c649..20036fb16cec 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -26,7 +26,6 @@
 #include <uapi/linux/cifs/cifs_mount.h>
 #include "../common/smb2pdu.h"
 #include "smb2pdu.h"
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #define SMB_PATH_MAX 260
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index e19ecf692c20..aae4e9ddc59d 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -15,7 +15,6 @@
  /* want to reuse a stale file handle and only the caller knows the file info */
 
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/kernel.h>
 #include <linux/vfs.h>
@@ -2067,20 +2066,20 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		parm_data = (struct cifs_posix_lock *)
 			((char *)&pSMBr->hdr.Protocol + data_offset);
 		if (parm_data->lock_type == cpu_to_le16(CIFS_UNLCK))
-			pLockData->fl_type = F_UNLCK;
+			pLockData->fl_core.flc_type = F_UNLCK;
 		else {
 			if (parm_data->lock_type ==
 					cpu_to_le16(CIFS_RDLCK))
-				pLockData->fl_type = F_RDLCK;
+				pLockData->fl_core.flc_type = F_RDLCK;
 			else if (parm_data->lock_type ==
 					cpu_to_le16(CIFS_WRLCK))
-				pLockData->fl_type = F_WRLCK;
+				pLockData->fl_core.flc_type = F_WRLCK;
 
 			pLockData->fl_start = le64_to_cpu(parm_data->start);
 			pLockData->fl_end = pLockData->fl_start +
 				(le64_to_cpu(parm_data->length) ?
 				 le64_to_cpu(parm_data->length) - 1 : 0);
-			pLockData->fl_pid = -le32_to_cpu(parm_data->pid);
+			pLockData->fl_core.flc_pid = -le32_to_cpu(parm_data->pid);
 		}
 	}
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index dd87b2ef24dc..9a977ec0fb2f 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -9,7 +9,6 @@
  *
  */
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/backing-dev.h>
 #include <linux/stat.h>
@@ -1313,20 +1312,20 @@ cifs_lock_test(struct cifsFileInfo *cfile, __u64 offset, __u64 length,
 	down_read(&cinode->lock_sem);
 
 	exist = cifs_find_lock_conflict(cfile, offset, length, type,
-					flock->fl_flags, &conf_lock,
+					flock->fl_core.flc_flags, &conf_lock,
 					CIFS_LOCK_OP);
 	if (exist) {
 		flock->fl_start = conf_lock->offset;
 		flock->fl_end = conf_lock->offset + conf_lock->length - 1;
-		flock->fl_pid = conf_lock->pid;
+		flock->fl_core.flc_pid = conf_lock->pid;
 		if (conf_lock->type & server->vals->shared_lock_type)
-			flock->fl_type = F_RDLCK;
+			flock->fl_core.flc_type = F_RDLCK;
 		else
-			flock->fl_type = F_WRLCK;
+			flock->fl_core.flc_type = F_WRLCK;
 	} else if (!cinode->can_cache_brlcks)
 		rc = 1;
 	else
-		flock->fl_type = F_UNLCK;
+		flock->fl_core.flc_type = F_UNLCK;
 
 	up_read(&cinode->lock_sem);
 	return rc;
@@ -1402,16 +1401,16 @@ cifs_posix_lock_test(struct file *file, struct file_lock *flock)
 {
 	int rc = 0;
 	struct cifsInodeInfo *cinode = CIFS_I(file_inode(file));
-	unsigned char saved_type = flock->fl_type;
+	unsigned char saved_type = flock->fl_core.flc_type;
 
-	if ((flock->fl_flags & FL_POSIX) == 0)
+	if ((flock->fl_core.flc_flags & FL_POSIX) == 0)
 		return 1;
 
 	down_read(&cinode->lock_sem);
 	posix_test_lock(file, flock);
 
-	if (flock->fl_type == F_UNLCK && !cinode->can_cache_brlcks) {
-		flock->fl_type = saved_type;
+	if (flock->fl_core.flc_type == F_UNLCK && !cinode->can_cache_brlcks) {
+		flock->fl_core.flc_type = saved_type;
 		rc = 1;
 	}
 
@@ -1432,7 +1431,7 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 	struct cifsInodeInfo *cinode = CIFS_I(file_inode(file));
 	int rc = FILE_LOCK_DEFERRED + 1;
 
-	if ((flock->fl_flags & FL_POSIX) == 0)
+	if ((flock->fl_core.flc_flags & FL_POSIX) == 0)
 		return rc;
 
 	cifs_down_write(&cinode->lock_sem);
@@ -1582,7 +1581,7 @@ cifs_push_posix_locks(struct cifsFileInfo *cfile)
 
 	el = locks_to_send.next;
 	spin_lock(&flctx->flc_lock);
-	list_for_each_entry(flock, &flctx->flc_posix, fl_list) {
+	list_for_each_entry(flock, &flctx->flc_posix, fl_core.flc_list) {
 		if (el == &locks_to_send) {
 			/*
 			 * The list ended. We don't have enough allocated
@@ -1592,12 +1591,12 @@ cifs_push_posix_locks(struct cifsFileInfo *cfile)
 			break;
 		}
 		length = cifs_flock_len(flock);
-		if (flock->fl_type == F_RDLCK || flock->fl_type == F_SHLCK)
+		if (flock->fl_core.flc_type == F_RDLCK || flock->fl_core.flc_type == F_SHLCK)
 			type = CIFS_RDLCK;
 		else
 			type = CIFS_WRLCK;
 		lck = list_entry(el, struct lock_to_push, llist);
-		lck->pid = hash_lockowner(flock->fl_owner);
+		lck->pid = hash_lockowner(flock->fl_core.flc_owner);
 		lck->netfid = cfile->fid.netfid;
 		lck->length = length;
 		lck->type = type;
@@ -1664,42 +1663,43 @@ static void
 cifs_read_flock(struct file_lock *flock, __u32 *type, int *lock, int *unlock,
 		bool *wait_flag, struct TCP_Server_Info *server)
 {
-	if (flock->fl_flags & FL_POSIX)
+	if (flock->fl_core.flc_flags & FL_POSIX)
 		cifs_dbg(FYI, "Posix\n");
-	if (flock->fl_flags & FL_FLOCK)
+	if (flock->fl_core.flc_flags & FL_FLOCK)
 		cifs_dbg(FYI, "Flock\n");
-	if (flock->fl_flags & FL_SLEEP) {
+	if (flock->fl_core.flc_flags & FL_SLEEP) {
 		cifs_dbg(FYI, "Blocking lock\n");
 		*wait_flag = true;
 	}
-	if (flock->fl_flags & FL_ACCESS)
+	if (flock->fl_core.flc_flags & FL_ACCESS)
 		cifs_dbg(FYI, "Process suspended by mandatory locking - not implemented yet\n");
-	if (flock->fl_flags & FL_LEASE)
+	if (flock->fl_core.flc_flags & FL_LEASE)
 		cifs_dbg(FYI, "Lease on file - not implemented yet\n");
-	if (flock->fl_flags &
+	if (flock->fl_core.flc_flags &
 	    (~(FL_POSIX | FL_FLOCK | FL_SLEEP |
 	       FL_ACCESS | FL_LEASE | FL_CLOSE | FL_OFDLCK)))
-		cifs_dbg(FYI, "Unknown lock flags 0x%x\n", flock->fl_flags);
+		cifs_dbg(FYI, "Unknown lock flags 0x%x\n",
+		         flock->fl_core.flc_flags);
 
 	*type = server->vals->large_lock_type;
-	if (flock->fl_type == F_WRLCK) {
+	if (flock->fl_core.flc_type == F_WRLCK) {
 		cifs_dbg(FYI, "F_WRLCK\n");
 		*type |= server->vals->exclusive_lock_type;
 		*lock = 1;
-	} else if (flock->fl_type == F_UNLCK) {
+	} else if (flock->fl_core.flc_type == F_UNLCK) {
 		cifs_dbg(FYI, "F_UNLCK\n");
 		*type |= server->vals->unlock_lock_type;
 		*unlock = 1;
 		/* Check if unlock includes more than one lock range */
-	} else if (flock->fl_type == F_RDLCK) {
+	} else if (flock->fl_core.flc_type == F_RDLCK) {
 		cifs_dbg(FYI, "F_RDLCK\n");
 		*type |= server->vals->shared_lock_type;
 		*lock = 1;
-	} else if (flock->fl_type == F_EXLCK) {
+	} else if (flock->fl_core.flc_type == F_EXLCK) {
 		cifs_dbg(FYI, "F_EXLCK\n");
 		*type |= server->vals->exclusive_lock_type;
 		*lock = 1;
-	} else if (flock->fl_type == F_SHLCK) {
+	} else if (flock->fl_core.flc_type == F_SHLCK) {
 		cifs_dbg(FYI, "F_SHLCK\n");
 		*type |= server->vals->shared_lock_type;
 		*lock = 1;
@@ -1731,7 +1731,7 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 		else
 			posix_lock_type = CIFS_WRLCK;
 		rc = CIFSSMBPosixLock(xid, tcon, netfid,
-				      hash_lockowner(flock->fl_owner),
+				      hash_lockowner(flock->fl_core.flc_owner),
 				      flock->fl_start, length, flock,
 				      posix_lock_type, wait_flag);
 		return rc;
@@ -1748,7 +1748,7 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 	if (rc == 0) {
 		rc = server->ops->mand_lock(xid, cfile, flock->fl_start, length,
 					    type, 0, 1, false);
-		flock->fl_type = F_UNLCK;
+		flock->fl_core.flc_type = F_UNLCK;
 		if (rc != 0)
 			cifs_dbg(VFS, "Error unlocking previously locked range %d during test of lock\n",
 				 rc);
@@ -1756,7 +1756,7 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 	}
 
 	if (type & server->vals->shared_lock_type) {
-		flock->fl_type = F_WRLCK;
+		flock->fl_core.flc_type = F_WRLCK;
 		return 0;
 	}
 
@@ -1768,12 +1768,12 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 	if (rc == 0) {
 		rc = server->ops->mand_lock(xid, cfile, flock->fl_start, length,
 			type | server->vals->shared_lock_type, 0, 1, false);
-		flock->fl_type = F_RDLCK;
+		flock->fl_core.flc_type = F_RDLCK;
 		if (rc != 0)
 			cifs_dbg(VFS, "Error unlocking previously locked range %d during test of lock\n",
 				 rc);
 	} else
-		flock->fl_type = F_WRLCK;
+		flock->fl_core.flc_type = F_WRLCK;
 
 	return 0;
 }
@@ -1941,7 +1941,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 			posix_lock_type = CIFS_UNLCK;
 
 		rc = CIFSSMBPosixLock(xid, tcon, cfile->fid.netfid,
-				      hash_lockowner(flock->fl_owner),
+				      hash_lockowner(flock->fl_core.flc_owner),
 				      flock->fl_start, length,
 				      NULL, posix_lock_type, wait_flag);
 		goto out;
@@ -1951,7 +1951,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 		struct cifsLockInfo *lock;
 
 		lock = cifs_lock_init(flock->fl_start, length, type,
-				      flock->fl_flags);
+				      flock->fl_core.flc_flags);
 		if (!lock)
 			return -ENOMEM;
 
@@ -1990,7 +1990,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 		rc = server->ops->mand_unlock_range(cfile, flock, xid);
 
 out:
-	if ((flock->fl_flags & FL_POSIX) || (flock->fl_flags & FL_FLOCK)) {
+	if ((flock->fl_core.flc_flags & FL_POSIX) || (flock->fl_core.flc_flags & FL_FLOCK)) {
 		/*
 		 * If this is a request to remove all locks because we
 		 * are closing the file, it doesn't matter if the
@@ -1999,7 +1999,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 		 */
 		if (rc) {
 			cifs_dbg(VFS, "%s failed rc=%d\n", __func__, rc);
-			if (!(flock->fl_flags & FL_CLOSE))
+			if (!(flock->fl_core.flc_flags & FL_CLOSE))
 				return rc;
 		}
 		rc = locks_lock_file_wait(file, flock);
@@ -2020,7 +2020,7 @@ int cifs_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	xid = get_xid();
 
-	if (!(fl->fl_flags & FL_FLOCK)) {
+	if (!(fl->fl_core.flc_flags & FL_FLOCK)) {
 		rc = -ENOLCK;
 		free_xid(xid);
 		return rc;
@@ -2071,7 +2071,8 @@ int cifs_lock(struct file *file, int cmd, struct file_lock *flock)
 	xid = get_xid();
 
 	cifs_dbg(FYI, "%s: %pD2 cmd=0x%x type=0x%x flags=0x%x r=%lld:%lld\n", __func__, file, cmd,
-		 flock->fl_flags, flock->fl_type, (long long)flock->fl_start,
+		 flock->fl_core.flc_flags, flock->fl_core.flc_type,
+		 (long long)flock->fl_start,
 		 (long long)flock->fl_end);
 
 	cfile = (struct cifsFileInfo *)file->private_data;
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index cd225d15a7c5..53c855b3df5a 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -7,7 +7,6 @@
  *
  */
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
@@ -229,7 +228,7 @@ smb2_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
 			 * flock and OFD lock are associated with an open
 			 * file description, not the process.
 			 */
-			if (!(flock->fl_flags & (FL_FLOCK | FL_OFDLCK)))
+			if (!(flock->fl_core.flc_flags & (FL_FLOCK | FL_OFDLCK)))
 				continue;
 		if (cinode->can_cache_brlcks) {
 			/*

-- 
2.43.0


