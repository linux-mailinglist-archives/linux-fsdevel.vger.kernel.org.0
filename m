Return-Path: <linux-fsdevel+bounces-9774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED49844C92
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0317329E0F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3B14E2ED;
	Wed, 31 Jan 2024 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPLBHQ4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71E14A0BE;
	Wed, 31 Jan 2024 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742311; cv=none; b=PMYDmvteHZ2VX/TGaL/23xsi0nlzapQDjeW5Pb5idEin/9QcCgoUkNOtrhUKO+omALJDnTcaiukt+Bb7Yw0mXA+016DbjVRE8TMHtRdS25S0iulYgPS6eCdrVS2IQcwuCa/alPutmAxRx0LYWFXmFbRyr1Q4kDbe9+szMT+8pnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742311; c=relaxed/simple;
	bh=6TRsPHkP+hgakQVPPACkJWHtX7ARsn3aeCI+cvaknc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thP3owCCJmP+VwBgzJu9VxKD5wP6a/kgOPWy4QJzT6rHKMEnC7gOy+6XD8G4sRtKwl88s8OfuJhYymb1/aaXYKbsSibdkS8TXHKEMuMu71EJR+Hz1rMO1Y7GvsmQFZTJ6PSHH3QUkdRRyLbEgMavPKdbkohvzITXsilqexdHuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPLBHQ4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F22CC433C7;
	Wed, 31 Jan 2024 23:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742311;
	bh=6TRsPHkP+hgakQVPPACkJWHtX7ARsn3aeCI+cvaknc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iPLBHQ4/vVcoV3tMkuzTVbvT/286U0X3uQO52HV+QqlUh5Qq0YzdQSMDpmaMRx3qo
	 z4WMOr+5YXFmUCyO38EfpfntE5/jS9JXgMsvgQupvyf/PCHV5tZs6brPYp0VNwunef
	 8P42rsZwkv51wBdOW8QjV9EOtCK3M3FKpjbs2v6WhvsjVGLYprgRVemXDOjIUyZVHj
	 2vhB56Edi23op0d62OlvEx8+cA9Nx6PORzDeRGbrQpve6ZBIz8l1/hASc6GZToiokt
	 W1WTUqYzBZQVThXT6OUSzQ0ytOdLPPLeiywCV9owjLmi58R/uMpXCDhi5JPKu17LlY
	 4MVHEAyZxXR4A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:25 -0500
Subject: [PATCH v3 44/47] smb/client: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-44-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
In-Reply-To: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11222; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6TRsPHkP+hgakQVPPACkJWHtX7ARsn3aeCI+cvaknc4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFzcSTNSRUVOiah+9xovh2hHSBXSyNZTGUdM
 LfxW0ly5Z6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcwAKCRAADmhBGVaC
 FRMJEACo6pYhjJzfL7xHxzTHG2bxxIvYdT5pO3VTRph1cJMvFCV48/8ZJ+Y18X3Zzrte2DHcsay
 bQNZX+iMc7Yx7E5OUyTNrWjRB5m+7ziPEOQZr1H9XbXxflqpkkS62y/gJP5EgdPCzQ4sV3CpxEU
 GHZU7bMpPmeef8FKqsjiR8YVBadm9K3xLfeHNay0au8uPtotpBdib1uZfnhhtWs3mDzwYqLw9b0
 zUsL2y5DAHGagt/+b/JxpJ5mOTqx1MicRgzT+nU3tFUbeSVVSx3x4bokgM2lwHF+hSgiwrWSiLI
 mCzNsbMf1rYIwpZ6MKK27Obb+5pEMJFnvr7LT6oxYKeZ6U2xjUVhHD9FOTsXcmtRfSIsMnr4ZlI
 0d1fNmF5tYY8dFIy3GawDPdEMe18KgG9nszcCIt01b1byU0Xz/KHz6gjbDnNwuEipFUPB1diOy4
 wi0AEwWTj00BFuQRDILnnkFsUxj8TTMQeK/qUMDQdBL0nujFCmSx3MgV9ERy5jrSCcDZb73/34g
 KrC6M4fyYzQklHsqiSjPG8ID8CZbFtxh0/HO500zoagI2qOttvTQ7tqk+heYoZMDC/3IbnZqLV7
 hxer/fi+q+gScdIX9cXcLeIumT/RwQl0cIFXRYAOgDO10Y3b3UBkzOAF+v8R4s0jieJj5Mu9Js1
 pOgvPvM0cp3wA1Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/cifsglob.h |  1 -
 fs/smb/client/cifssmb.c  |  9 +++----
 fs/smb/client/file.c     | 67 +++++++++++++++++++++++++-----------------------
 fs/smb/client/smb2file.c |  3 +--
 4 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 78a994caadaf..16befff4cbb4 100644
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
index e19ecf692c20..5eb83bafc7fd 100644
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
+			pLockData->c.flc_type = F_UNLCK;
 		else {
 			if (parm_data->lock_type ==
 					cpu_to_le16(CIFS_RDLCK))
-				pLockData->fl_type = F_RDLCK;
+				pLockData->c.flc_type = F_RDLCK;
 			else if (parm_data->lock_type ==
 					cpu_to_le16(CIFS_WRLCK))
-				pLockData->fl_type = F_WRLCK;
+				pLockData->c.flc_type = F_WRLCK;
 
 			pLockData->fl_start = le64_to_cpu(parm_data->start);
 			pLockData->fl_end = pLockData->fl_start +
 				(le64_to_cpu(parm_data->length) ?
 				 le64_to_cpu(parm_data->length) - 1 : 0);
-			pLockData->fl_pid = -le32_to_cpu(parm_data->pid);
+			pLockData->c.flc_pid = -le32_to_cpu(parm_data->pid);
 		}
 	}
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 32d3a27236fc..6c4df0d2b641 100644
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
+					flock->c.flc_flags, &conf_lock,
 					CIFS_LOCK_OP);
 	if (exist) {
 		flock->fl_start = conf_lock->offset;
 		flock->fl_end = conf_lock->offset + conf_lock->length - 1;
-		flock->fl_pid = conf_lock->pid;
+		flock->c.flc_pid = conf_lock->pid;
 		if (conf_lock->type & server->vals->shared_lock_type)
-			flock->fl_type = F_RDLCK;
+			flock->c.flc_type = F_RDLCK;
 		else
-			flock->fl_type = F_WRLCK;
+			flock->c.flc_type = F_WRLCK;
 	} else if (!cinode->can_cache_brlcks)
 		rc = 1;
 	else
-		flock->fl_type = F_UNLCK;
+		flock->c.flc_type = F_UNLCK;
 
 	up_read(&cinode->lock_sem);
 	return rc;
@@ -1402,16 +1401,16 @@ cifs_posix_lock_test(struct file *file, struct file_lock *flock)
 {
 	int rc = 0;
 	struct cifsInodeInfo *cinode = CIFS_I(file_inode(file));
-	unsigned char saved_type = flock->fl_type;
+	unsigned char saved_type = flock->c.flc_type;
 
-	if ((flock->fl_flags & FL_POSIX) == 0)
+	if ((flock->c.flc_flags & FL_POSIX) == 0)
 		return 1;
 
 	down_read(&cinode->lock_sem);
 	posix_test_lock(file, flock);
 
 	if (lock_is_unlock(flock) && !cinode->can_cache_brlcks) {
-		flock->fl_type = saved_type;
+		flock->c.flc_type = saved_type;
 		rc = 1;
 	}
 
@@ -1432,7 +1431,7 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 	struct cifsInodeInfo *cinode = CIFS_I(file_inode(file));
 	int rc = FILE_LOCK_DEFERRED + 1;
 
-	if ((flock->fl_flags & FL_POSIX) == 0)
+	if ((flock->c.flc_flags & FL_POSIX) == 0)
 		return rc;
 
 	cifs_down_write(&cinode->lock_sem);
@@ -1583,6 +1582,8 @@ cifs_push_posix_locks(struct cifsFileInfo *cfile)
 	el = locks_to_send.next;
 	spin_lock(&flctx->flc_lock);
 	for_each_file_lock(flock, &flctx->flc_posix) {
+		unsigned char ftype = flock->c.flc_type;
+
 		if (el == &locks_to_send) {
 			/*
 			 * The list ended. We don't have enough allocated
@@ -1592,12 +1593,12 @@ cifs_push_posix_locks(struct cifsFileInfo *cfile)
 			break;
 		}
 		length = cifs_flock_len(flock);
-		if (lock_is_read(flock) || flock->fl_type == F_SHLCK)
+		if (ftype == F_RDLCK || ftype == F_SHLCK)
 			type = CIFS_RDLCK;
 		else
 			type = CIFS_WRLCK;
 		lck = list_entry(el, struct lock_to_push, llist);
-		lck->pid = hash_lockowner(flock->fl_owner);
+		lck->pid = hash_lockowner(flock->c.flc_owner);
 		lck->netfid = cfile->fid.netfid;
 		lck->length = length;
 		lck->type = type;
@@ -1664,22 +1665,23 @@ static void
 cifs_read_flock(struct file_lock *flock, __u32 *type, int *lock, int *unlock,
 		bool *wait_flag, struct TCP_Server_Info *server)
 {
-	if (flock->fl_flags & FL_POSIX)
+	if (flock->c.flc_flags & FL_POSIX)
 		cifs_dbg(FYI, "Posix\n");
-	if (flock->fl_flags & FL_FLOCK)
+	if (flock->c.flc_flags & FL_FLOCK)
 		cifs_dbg(FYI, "Flock\n");
-	if (flock->fl_flags & FL_SLEEP) {
+	if (flock->c.flc_flags & FL_SLEEP) {
 		cifs_dbg(FYI, "Blocking lock\n");
 		*wait_flag = true;
 	}
-	if (flock->fl_flags & FL_ACCESS)
+	if (flock->c.flc_flags & FL_ACCESS)
 		cifs_dbg(FYI, "Process suspended by mandatory locking - not implemented yet\n");
-	if (flock->fl_flags & FL_LEASE)
+	if (flock->c.flc_flags & FL_LEASE)
 		cifs_dbg(FYI, "Lease on file - not implemented yet\n");
-	if (flock->fl_flags &
+	if (flock->c.flc_flags &
 	    (~(FL_POSIX | FL_FLOCK | FL_SLEEP |
 	       FL_ACCESS | FL_LEASE | FL_CLOSE | FL_OFDLCK)))
-		cifs_dbg(FYI, "Unknown lock flags 0x%x\n", flock->fl_flags);
+		cifs_dbg(FYI, "Unknown lock flags 0x%x\n",
+		         flock->c.flc_flags);
 
 	*type = server->vals->large_lock_type;
 	if (lock_is_write(flock)) {
@@ -1695,11 +1697,11 @@ cifs_read_flock(struct file_lock *flock, __u32 *type, int *lock, int *unlock,
 		cifs_dbg(FYI, "F_RDLCK\n");
 		*type |= server->vals->shared_lock_type;
 		*lock = 1;
-	} else if (flock->fl_type == F_EXLCK) {
+	} else if (flock->c.flc_type == F_EXLCK) {
 		cifs_dbg(FYI, "F_EXLCK\n");
 		*type |= server->vals->exclusive_lock_type;
 		*lock = 1;
-	} else if (flock->fl_type == F_SHLCK) {
+	} else if (flock->c.flc_type == F_SHLCK) {
 		cifs_dbg(FYI, "F_SHLCK\n");
 		*type |= server->vals->shared_lock_type;
 		*lock = 1;
@@ -1731,7 +1733,7 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 		else
 			posix_lock_type = CIFS_WRLCK;
 		rc = CIFSSMBPosixLock(xid, tcon, netfid,
-				      hash_lockowner(flock->fl_owner),
+				      hash_lockowner(flock->c.flc_owner),
 				      flock->fl_start, length, flock,
 				      posix_lock_type, wait_flag);
 		return rc;
@@ -1748,7 +1750,7 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 	if (rc == 0) {
 		rc = server->ops->mand_lock(xid, cfile, flock->fl_start, length,
 					    type, 0, 1, false);
-		flock->fl_type = F_UNLCK;
+		flock->c.flc_type = F_UNLCK;
 		if (rc != 0)
 			cifs_dbg(VFS, "Error unlocking previously locked range %d during test of lock\n",
 				 rc);
@@ -1756,7 +1758,7 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 	}
 
 	if (type & server->vals->shared_lock_type) {
-		flock->fl_type = F_WRLCK;
+		flock->c.flc_type = F_WRLCK;
 		return 0;
 	}
 
@@ -1768,12 +1770,12 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 	if (rc == 0) {
 		rc = server->ops->mand_lock(xid, cfile, flock->fl_start, length,
 			type | server->vals->shared_lock_type, 0, 1, false);
-		flock->fl_type = F_RDLCK;
+		flock->c.flc_type = F_RDLCK;
 		if (rc != 0)
 			cifs_dbg(VFS, "Error unlocking previously locked range %d during test of lock\n",
 				 rc);
 	} else
-		flock->fl_type = F_WRLCK;
+		flock->c.flc_type = F_WRLCK;
 
 	return 0;
 }
@@ -1941,7 +1943,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 			posix_lock_type = CIFS_UNLCK;
 
 		rc = CIFSSMBPosixLock(xid, tcon, cfile->fid.netfid,
-				      hash_lockowner(flock->fl_owner),
+				      hash_lockowner(flock->c.flc_owner),
 				      flock->fl_start, length,
 				      NULL, posix_lock_type, wait_flag);
 		goto out;
@@ -1951,7 +1953,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 		struct cifsLockInfo *lock;
 
 		lock = cifs_lock_init(flock->fl_start, length, type,
-				      flock->fl_flags);
+				      flock->c.flc_flags);
 		if (!lock)
 			return -ENOMEM;
 
@@ -1990,7 +1992,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 		rc = server->ops->mand_unlock_range(cfile, flock, xid);
 
 out:
-	if ((flock->fl_flags & FL_POSIX) || (flock->fl_flags & FL_FLOCK)) {
+	if ((flock->c.flc_flags & FL_POSIX) || (flock->c.flc_flags & FL_FLOCK)) {
 		/*
 		 * If this is a request to remove all locks because we
 		 * are closing the file, it doesn't matter if the
@@ -1999,7 +2001,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 		 */
 		if (rc) {
 			cifs_dbg(VFS, "%s failed rc=%d\n", __func__, rc);
-			if (!(flock->fl_flags & FL_CLOSE))
+			if (!(flock->c.flc_flags & FL_CLOSE))
 				return rc;
 		}
 		rc = locks_lock_file_wait(file, flock);
@@ -2020,7 +2022,7 @@ int cifs_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	xid = get_xid();
 
-	if (!(fl->fl_flags & FL_FLOCK)) {
+	if (!(fl->c.flc_flags & FL_FLOCK)) {
 		rc = -ENOLCK;
 		free_xid(xid);
 		return rc;
@@ -2071,7 +2073,8 @@ int cifs_lock(struct file *file, int cmd, struct file_lock *flock)
 	xid = get_xid();
 
 	cifs_dbg(FYI, "%s: %pD2 cmd=0x%x type=0x%x flags=0x%x r=%lld:%lld\n", __func__, file, cmd,
-		 flock->fl_flags, flock->fl_type, (long long)flock->fl_start,
+		 flock->c.flc_flags, flock->c.flc_type,
+		 (long long)flock->fl_start,
 		 (long long)flock->fl_end);
 
 	cfile = (struct cifsFileInfo *)file->private_data;
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index cd225d15a7c5..c23478ab1cf8 100644
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
+			if (!(flock->c.flc_flags & (FL_FLOCK | FL_OFDLCK)))
 				continue;
 		if (cinode->can_cache_brlcks) {
 			/*

-- 
2.43.0


