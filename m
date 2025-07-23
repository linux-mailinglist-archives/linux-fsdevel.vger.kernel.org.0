Return-Path: <linux-fsdevel+bounces-55878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0A9B0F6FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C8117FDED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27E62F5C41;
	Wed, 23 Jul 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWybjLIP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6A2F5312
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284471; cv=none; b=CnOZ+MSuAPlwYxKCtBMyPSixClpnNfBB2rMtvpvTq2yiV7NJBaxOJ9XtD5ZAVeDFyXqPIrz8BhkMgdYH+CeSUbz9dbecLEHaTGJQgajN3TASCHTxFcqeJrvAkmhm7miVIBjepa/Vrs7j9mLHMp7cBCMZqVGqFPT5LMoq6j3KM5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284471; c=relaxed/simple;
	bh=H8WZHyhCUziFa4JF7H4Sba2/4Obs4rqDf/EcYsGK9xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1RjspW8VvSNkXJXqOG96rHsv9Mim1AqVnDAPm1rBq3PQ8c3x0Sq3gkzsLPSqm37qe8xWgL/5fCm0qDHqZpMeYKFXF4q+jzR02m/XEd+Yazo5l1qNKiAhe1eu5Te5Sx1Iw19yj3XizEJuYmx6daCHaXN/qSGZvgVoxw+WA6+E3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWybjLIP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753284468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWN6l3G7ppInAFjyNR6+62lMchBicZsgF1zHbx0Hv9Q=;
	b=iWybjLIPDFytnN7aJ22FH6Y1xq2aOm5gvrDozqeeIQFxpJFEv3I2NBR7iKVypxsJAHJGUc
	0wHnbDhjGObzNLzlJnPejnllpi9D7K3EcmyCmyN+GYBzsPeCQef+/Vn1sWuqLGlL0yKjtE
	E/F5EhYLE6skjEE4bsWmzMupe547RL8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60--ryxfrpCPpyQie6smZlMjw-1; Wed,
 23 Jul 2025 11:27:45 -0400
X-MC-Unique: -ryxfrpCPpyQie6smZlMjw-1
X-Mimecast-MFC-AGG-ID: -ryxfrpCPpyQie6smZlMjw_1753284463
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E07218004A7;
	Wed, 23 Jul 2025 15:27:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 262AC180049D;
	Wed, 23 Jul 2025 15:27:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Steve French <SteveFrenchsfrench@samba.org>,
	linux-afs@lists.infradead.org,
	openafs-devel@openafs.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Chet Ramey <chet.ramey@case.edu>,
	Cheyenne Wills <cwills@sinenomine.net>,
	Christian Brauner <brauner@kernel.org>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 2/2] afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
Date: Wed, 23 Jul 2025 16:26:51 +0100
Message-ID: <20250723152709.256768-3-dhowells@redhat.com>
In-Reply-To: <20250723152709.256768-1-dhowells@redhat.com>
References: <20250723152709.256768-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
index bfb69e066672..644782a416d7 100644
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
index fc15497608c6..0317f0a36cf2 100644
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
index 1124ea4000cb..8c2ca00ac237 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1515,6 +1515,9 @@ extern struct key *afs_request_key(struct afs_cell *);
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


