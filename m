Return-Path: <linux-fsdevel+bounces-64136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D6BD9C29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8E1250175C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 13:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28DE314B95;
	Tue, 14 Oct 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8wQ3QsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E15314B74
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448987; cv=none; b=BEqfCWJn6/N2db5/qdLc/COzoakr5b7BZgGobIXzND49xerE3x9Z5o6YwzY0z4l2Go3JVwqS+ZZJRPr6W0PP/4/qXZkWbnYrMKyWKHBAz8uRCleBTW/g/gloy2pIx0cS+8bQNxGCDz+UIOL6aHB1UvHvGvslQDe+ZqP/7Jo00fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448987; c=relaxed/simple;
	bh=MP6O4WylNJRHM817gAfb4Gr4IpPxmM7B6JGjx42Za1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KH/I+3Qd1E51SWNC8unVxRQHL9BuscHVxk2Y0qpuALmLA00dVBdMPw4Lxe4jFZ2XJWgzu1kTxRAO764NkJjnTZtyUnIpb9bk6/+YqyqDFeEJosebApRyeBkhTSldmbtJW37J3uRtNW2Zp2yRDQeMCYhU4qY8sN73WZ9d9vrc7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8wQ3QsA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760448983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ax+OGvPsV3Rcqb769YH1pdhsbkM5VZE99I8gaYhOm9E=;
	b=Z8wQ3QsAh/jkhapYznis+axGhqo8iK6VbnrXYYQi7IaNH6C7F6d/gv4TcN5vE3gWmel+Ft
	qFabuKhWgR2+uhJ6cUgpzcTj9cUPu/tFdven+14KfY7T0sx5jvcFLgle4QXBjr3wxVUtxe
	wri1AeispDpq5E25gRP/IObOXn2hlKg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-XwZURVbRNpCpzx21gsjT3Q-1; Tue,
 14 Oct 2025 09:36:20 -0400
X-MC-Unique: XwZURVbRNpCpzx21gsjT3Q-1
X-Mimecast-MFC-AGG-ID: XwZURVbRNpCpzx21gsjT3Q_1760448975
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B23C1800577;
	Tue, 14 Oct 2025 13:36:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.157])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 573B919560A2;
	Tue, 14 Oct 2025 13:36:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Steve French <sfrench@samba.org>,
	linux-afs@lists.infradead.org,
	openafs-devel@openafs.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Chet Ramey <chet.ramey@case.edu>,
	Cheyenne Wills <cwills@sinenomine.net>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 2/2] afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
Date: Tue, 14 Oct 2025 14:35:45 +0100
Message-ID: <20251014133551.82642-3-dhowells@redhat.com>
In-Reply-To: <20251014133551.82642-1-dhowells@redhat.com>
References: <20251014133551.82642-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Since version 1.11 (January 1992) Bash has a work around in redir_open()
that causes open(O_CREAT) of a file to be retried without O_CREAT if open()
fails with an EACCES error if bash was built with AFS workarounds
configured:

        #if defined (AFS)
              if ((fd < 0) && (errno == EACCES))
            {
              fd = open (filename, flags & ~O_CREAT, mode);
              errno = EACCES;    /* restore errno */
            }

        #endif /* AFS */

The ~O_CREAT fallback logic was introduced to workaround a bug[1] in the
IBM AFS 3.1 cache manager and server which can return EACCES in preference
to EEXIST if the requested file exists but the caller is neither granted
explicit PRSFS_READ permission nor is the file owner and is granted
PRSFS_INSERT permission on the directory.  IBM AFS 3.2 altered the cache
manager permission checks but failed to correct the permission checks in
the AFS server.  As of this writing, all IBM AFS derived servers continue
to return EACCES in preference to EEXIST when these conditions are met.
Bug reports have been filed with all implementations.

As an unintended side effect, the Bash fallback logic also undermines the
Linux kernel protections against O_CREAT opening FIFOs and regular files
not owned by the user in world writeable sticky directories - unless the
owner is the same as that of the directory - as was added in commit
30aba6656f61e ("namei: allow restricted O_CREAT of FIFOs and regular
files").

As a result the Bash fallback logic masks an incompatibility between the
ownership checks performed by may_create_in_sticky() and network
filesystems such as AFS where the uid namespace is disjoint from the uid
namespace of the local system.

However, the bash work around is going to be removed[2].

Fix this in the kernel by using a preceding patch that allows the user ID
comparisons to be overridden by:

 (1) Implement the ->is_owned_by_me() inode op for kafs to determine if the
     caller owns the file by checking to see if the server indicated the
     ADMINISTER bit was set in the access rights returned by the
     FS.FetchStatus and suchlike instead of checking the i_uid to
     current_fsuid().

     Unfortunately, this check doesn't work for directories, but none of
     the ops should require that.

     Note that anonymous accesses to AFS will never see the ADMINISTER bit
     being set and so will not be perceived as owning an anonymously-owned
     file.

 (2) Implement the ->have_same_owner() inode op, for kafs to compare the
     AFS owner IDs retrieved by FS.FetchStatus (which are 64-bit integers
     with AuriStor's YFS server and, as such, won't fit in a kuid_t).

     Note that whilst an anonymously-owned file will match an
     anonymously-owned parent directory, an anonymously-owned directory
     cannot have the sticky bit set.

This can be tested by creating a sticky directory (the user must have a
token to do this) and creating a file in it.  Then strace bash doing "echo
foo >>file" and look at whether bash does a single, successful O_CREAT open
on the file or whether that one fails and then bash does one without
O_CREAT that succeeds.

Fixes: 30aba6656f61 ("namei: allow restricted O_CREAT of FIFOs and regular files")
Reported-by: Etienne Champetier <champetier.etienne@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Chet Ramey <chet.ramey@case.edu>
cc: Cheyenne Wills <cwills@sinenomine.net>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: linux-afs@lists.infradead.org
cc: openafs-devel@openafs.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://groups.google.com/g/gnu.bash.bug/c/6PPTfOgFdL4/m/2AQU-S1N76UJ [1]
Link: https://git.savannah.gnu.org/cgit/bash.git/tree/redir.c?h=bash-5.3-rc1#n733 [2]
---
 fs/afs/dir.c      |  2 ++
 fs/afs/file.c     |  2 ++
 fs/afs/internal.h |  3 +++
 fs/afs/security.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 89d36e3e5c79..2c0d1d5d4703 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -65,6 +65,8 @@ const struct inode_operations afs_dir_inode_operations = {
 	.permission	= afs_permission,
 	.getattr	= afs_getattr,
 	.setattr	= afs_setattr,
+	.is_owned_by_me	= afs_is_owned_by_me,
+	.have_same_owner = afs_have_same_owner,
 };
 
 const struct address_space_operations afs_dir_aops = {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index f66a92294284..399a40c45d0a 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -47,6 +47,8 @@ const struct inode_operations afs_file_inode_operations = {
 	.getattr	= afs_getattr,
 	.setattr	= afs_setattr,
 	.permission	= afs_permission,
+	.is_owned_by_me	= afs_is_owned_by_me,
+	.have_same_owner = afs_have_same_owner,
 };
 
 const struct address_space_operations afs_file_aops = {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a45ae5c2ef8a..b9210637e8d7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1517,6 +1517,9 @@ extern struct key *afs_request_key(struct afs_cell *);
 extern struct key *afs_request_key_rcu(struct afs_cell *);
 extern int afs_check_permit(struct afs_vnode *, struct key *, afs_access_t *);
 extern int afs_permission(struct mnt_idmap *, struct inode *, int);
+int afs_is_owned_by_me(struct mnt_idmap *idmap, struct inode *inode);
+int afs_have_same_owner(struct mnt_idmap *idmap, struct inode *inode1,
+			struct inode *inode2);
 extern void __exit afs_clean_up_permit_cache(void);
 
 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 6a7744c9e2a2..19b11c7cb1ff 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -477,6 +477,52 @@ int afs_permission(struct mnt_idmap *idmap, struct inode *inode,
 	return ret;
 }
 
+/*
+ * Determine if an inode is owned by 'me' - whatever that means for the
+ * filesystem.  In the case of AFS, this means that the file is owned by the
+ * AFS user represented by the Rx Security Class token held in a key.  Returns
+ * 0 if owned by me, 1 if not; can also return an error.
+ */
+int afs_is_owned_by_me(struct mnt_idmap *idmap, struct inode *inode)
+{
+	struct afs_vnode *vnode = AFS_FS_I(inode);
+	afs_access_t access;
+	struct key *key;
+	int ret;
+
+	if (S_ISDIR(inode->i_mode))
+		return 1; /* The ADMIN right check doesn't work for directories. */
+
+	key = afs_request_key(vnode->volume->cell);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	/* Get the access rights for the key on this file. */
+	ret = afs_check_permit(vnode, key, &access);
+	if (ret < 0)
+		goto error;
+
+	/* We get the ADMINISTER bit if we own the file. */
+	ret = (access & AFS_ACE_ADMINISTER) ? 0 : 1;
+error:
+	key_put(key);
+	return ret;
+}
+
+/*
+ * Determine if a file has the same owner as its parent - whatever that means
+ * for the filesystem.  In the case of AFS, this means comparing their AFS
+ * UIDs.  Returns 0 if same, 1 if not same; can also return an error.
+ */
+int afs_have_same_owner(struct mnt_idmap *idmap, struct inode *inode1,
+			struct inode *inode2)
+{
+	const struct afs_vnode *vnode1 = AFS_FS_I(inode1);
+	const struct afs_vnode *vnode2 = AFS_FS_I(inode2);
+
+	return vnode1->status.owner != vnode2->status.owner;
+}
+
 void __exit afs_clean_up_permit_cache(void)
 {
 	int i;


