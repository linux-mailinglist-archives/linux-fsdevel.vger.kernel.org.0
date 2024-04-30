Return-Path: <linux-fsdevel+bounces-18354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B858B7907
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438FD1C228D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DFD181CEB;
	Tue, 30 Apr 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZksq0DH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBF181B95
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486199; cv=none; b=IIbP2qbZsQoxHrGbfmTgS6Pz5HShcI3Jzv7o71fGHT93sm2KZtb/dDcK3DYFVjH0lmrEptRb8cySfhzWi4Z0vX0yeMZOxWEfbQWqsmRY7zqpnoAot37qHXlbPptYpXqMIQNn3wEVfMG/7Wu+PqnXnz4Nur4FemBdU5lcxK9OQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486199; c=relaxed/simple;
	bh=HMeaWIIbP8Duad4JIc8SLSR2g4WvY59LHadNwgSKYgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOdwBI2hk3mk2NJpfy9ebjOc1KsWRy5ABHuY5A5160b+2vDC+f5W53S9PQOT0QkLYw62Y4CCaGl/Arwrm5ZDV+qLo1cdEC/vOhC+FgllmflInQe7Nk8iIgwehjmsbx/PuCO79uliX/qMbTRYSzEj2a8IXfJQwyfZbB4M9NGNvIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZksq0DH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714486196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0yMtPOxQEnCTmo6Bl1feVRvQTsBseZ0ZhvttmbbIWE=;
	b=KZksq0DHgL+ZYL//exGRJl3v7pUkeREuoMNIdTIKdI8p7PRtlJCoTn5y3DCLt1bx5W1LT6
	qX/cOjCfdwhp1Xh8AOCQm+iCXbPYLvPSDKUyv8ehXWw6KQTJa8+k0OU9M/ABQkQ5CyJonk
	O2MB6/a0IupVGoKgG0Qruis/JwHqeo4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-0xnDheX7Oma_dsQLKrK2EQ-1; Tue, 30 Apr 2024 10:09:53 -0400
X-MC-Unique: 0xnDheX7Oma_dsQLKrK2EQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71F7D902386;
	Tue, 30 Apr 2024 14:09:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A1C19C01595;
	Tue, 30 Apr 2024 14:09:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v7 07/16] cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c
Date: Tue, 30 Apr 2024 15:09:19 +0100
Message-ID: <20240430140930.262762-8-dhowells@redhat.com>
In-Reply-To: <20240430140930.262762-1-dhowells@redhat.com>
References: <20240430140930.262762-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c so that
they are colocated with similar functions rather than being split with
cifsfs.c.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsfs.c | 55 ------------------------------------------
 fs/smb/client/cifsfs.h |  2 ++
 fs/smb/client/file.c   | 53 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 39277c37185c..847df5152835 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -986,61 +986,6 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 	return root;
 }
 
-
-static ssize_t
-cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
-{
-	ssize_t rc;
-	struct inode *inode = file_inode(iocb->ki_filp);
-
-	if (iocb->ki_flags & IOCB_DIRECT)
-		return cifs_user_readv(iocb, iter);
-
-	rc = cifs_revalidate_mapping(inode);
-	if (rc)
-		return rc;
-
-	return generic_file_read_iter(iocb, iter);
-}
-
-static ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-	struct cifsInodeInfo *cinode = CIFS_I(inode);
-	ssize_t written;
-	int rc;
-
-	if (iocb->ki_filp->f_flags & O_DIRECT) {
-		written = cifs_user_writev(iocb, from);
-		if (written > 0 && CIFS_CACHE_READ(cinode)) {
-			cifs_zap_mapping(inode);
-			cifs_dbg(FYI,
-				 "Set no oplock for inode=%p after a write operation\n",
-				 inode);
-			cinode->oplock = 0;
-		}
-		return written;
-	}
-
-	written = cifs_get_writer(cinode);
-	if (written)
-		return written;
-
-	written = generic_file_write_iter(iocb, from);
-
-	if (CIFS_CACHE_WRITE(CIFS_I(inode)))
-		goto out;
-
-	rc = filemap_fdatawrite(inode->i_mapping);
-	if (rc)
-		cifs_dbg(FYI, "cifs_file_write_iter: %d rc on %p inode\n",
-			 rc, inode);
-
-out:
-	cifs_put_writer(cinode);
-	return written;
-}
-
 static loff_t cifs_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct cifsFileInfo *cfile = file->private_data;
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 1ab7e5998c58..1acf6bfc06de 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -99,6 +99,8 @@ extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
 extern ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
+ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 extern int cifs_flock(struct file *pfile, int cmd, struct file_lock *plock);
 extern int cifs_lock(struct file *, int, struct file_lock *);
 extern int cifs_fsync(struct file *, loff_t, loff_t, int);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 7f2ce68d2a2a..331446fc3d22 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4250,6 +4250,59 @@ ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to)
 	return __cifs_readv(iocb, to, false);
 }
 
+ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	ssize_t rc;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return cifs_user_readv(iocb, iter);
+
+	rc = cifs_revalidate_mapping(inode);
+	if (rc)
+		return rc;
+
+	return generic_file_read_iter(iocb, iter);
+}
+
+ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct cifsInodeInfo *cinode = CIFS_I(inode);
+	ssize_t written;
+	int rc;
+
+	if (iocb->ki_filp->f_flags & O_DIRECT) {
+		written = cifs_user_writev(iocb, from);
+		if (written > 0 && CIFS_CACHE_READ(cinode)) {
+			cifs_zap_mapping(inode);
+			cifs_dbg(FYI,
+				 "Set no oplock for inode=%p after a write operation\n",
+				 inode);
+			cinode->oplock = 0;
+		}
+		return written;
+	}
+
+	written = cifs_get_writer(cinode);
+	if (written)
+		return written;
+
+	written = generic_file_write_iter(iocb, from);
+
+	if (CIFS_CACHE_WRITE(CIFS_I(inode)))
+		goto out;
+
+	rc = filemap_fdatawrite(inode->i_mapping);
+	if (rc)
+		cifs_dbg(FYI, "cifs_file_write_iter: %d rc on %p inode\n",
+			 rc, inode);
+
+out:
+	cifs_put_writer(cinode);
+	return written;
+}
+
 ssize_t
 cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 {


