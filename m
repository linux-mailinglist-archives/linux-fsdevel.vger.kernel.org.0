Return-Path: <linux-fsdevel+bounces-32974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9D9B10D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544701F23A3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEBE21314F;
	Fri, 25 Oct 2024 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RChp7dg8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F3218943
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889010; cv=none; b=OKJKETEPTboqXGm94UsBd9CY1gLjT7WsKAaV92ir4f6d8oFWpscaoNdCQwMXLl580mr0lT95qbOxNQUYV4nUFYglJJGwdDMI7f+KaCPmYyFe/YwDM+1qeQWQlCel8KJfVbqLN0vYUlJOEoYIenwwrmBcNHucmC4YkPdWdpSJAZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889010; c=relaxed/simple;
	bh=kWAw3zWgUBIDLXmj+j2EyLypdQLdqCkKRi/Jkf/SaaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUgZMDkcybnxtGTm7Yknrr1588S1trsCIfj/e5PljVCBPJcpmJQ2qSew6UUW3k1L4cfAjM9LGQ5Qs73uT79icBt7TAsh1qOv+pVfJRbu8GzomIag2DGzM9HjnP6wRwIty69ASWShCJm/mu5Q+6Z9uaTRgd3Joj/C3enlcYUTWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RChp7dg8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729889007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNBmYsisi11F4a9GdaB4+2hzkwarlQJLH0bImPjM4eE=;
	b=RChp7dg8pZEWkFaQV6EaI3SKJpfc883obXxNBof14tCNhY2QSKQM5irKs3+HaZCf6twDyB
	ks5bVnWwZhMO0oYrQtgXDTLIGPwqiwE/e5cJL6YQbBIYdxlxxnEpmuYpNojOJlL1eBEsol
	AtkNXQ290jUHxMCLA2EcZwi9mcBBFd0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-LBc8O0OjOoyLZPAMboBZnQ-1; Fri,
 25 Oct 2024 16:43:21 -0400
X-MC-Unique: LBc8O0OjOoyLZPAMboBZnQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3FE11955F3E;
	Fri, 25 Oct 2024 20:43:16 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 206F6300018D;
	Fri, 25 Oct 2024 20:43:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/31] afs: Make afs_mkdir() locally initialise a new directory's content
Date: Fri, 25 Oct 2024 21:39:54 +0100
Message-ID: <20241025204008.4076565-28-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Initialise a new directory's content when it is created by mkdir locally
rather than downloading the content from the server as we can predict what
it's going to look like.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c               |  3 +++
 fs/afs/dir_edit.c          | 48 ++++++++++++++++++++++++++++++++++++++
 fs/afs/internal.h          |  1 +
 include/trace/events/afs.h |  2 ++
 4 files changed, 54 insertions(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 4b1b25015573..aa589f0d55bf 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1258,6 +1258,7 @@ void afs_check_for_remote_deletion(struct afs_operation *op)
  */
 static void afs_vnode_new_inode(struct afs_operation *op)
 {
+	struct afs_vnode_param *dvp = &op->file[0];
 	struct afs_vnode_param *vp = &op->file[1];
 	struct afs_vnode *vnode;
 	struct inode *inode;
@@ -1277,6 +1278,8 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 
 	vnode = AFS_FS_I(inode);
 	set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
+	if (S_ISDIR(inode->i_mode))
+		afs_mkdir_init_dir(vnode, dvp->vnode);
 	if (!afs_op_error(op))
 		afs_cache_permit(vnode, op->key, vnode->cb_break, &vp->scb);
 	d_instantiate(op->dentry, inode);
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 71cce884e434..f4037973416e 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -556,3 +556,51 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 			   0, 0, 0, 0, "..");
 	goto out;
 }
+
+/*
+ * Initialise a new directory.  We need to fill in the "." and ".." entries.
+ */
+void afs_mkdir_init_dir(struct afs_vnode *dvnode, struct afs_vnode *parent_dvnode)
+{
+	union afs_xdr_dir_block *meta;
+	struct afs_dir_iter iter = { .dvnode = dvnode };
+	union afs_xdr_dirent *de;
+	unsigned int slot = AFS_DIR_RESV_BLOCKS0;
+	loff_t i_size;
+
+	i_size = i_size_read(&dvnode->netfs.inode);
+	if (i_size != AFS_DIR_BLOCK_SIZE) {
+		afs_invalidate_dir(dvnode, afs_dir_invalid_edit_add_bad_size);
+		return;
+	}
+
+	meta = afs_dir_get_block(&iter, 0);
+	if (!meta)
+		return;
+
+	afs_edit_init_block(meta, meta, 0);
+
+	de = &meta->dirents[slot];
+	de->u.valid  = 1;
+	de->u.vnode  = htonl(dvnode->fid.vnode);
+	de->u.unique = htonl(dvnode->fid.unique);
+	memcpy(de->u.name, ".", 2);
+	trace_afs_edit_dir(dvnode, afs_edit_dir_for_mkdir, afs_edit_dir_mkdir, 0, slot,
+			   dvnode->fid.vnode, dvnode->fid.unique, ".");
+	slot++;
+
+	de = &meta->dirents[slot];
+	de->u.valid  = 1;
+	de->u.vnode  = htonl(parent_dvnode->fid.vnode);
+	de->u.unique = htonl(parent_dvnode->fid.unique);
+	memcpy(de->u.name, "..", 3);
+	trace_afs_edit_dir(dvnode, afs_edit_dir_for_mkdir, afs_edit_dir_mkdir, 0, slot,
+			   parent_dvnode->fid.vnode, parent_dvnode->fid.unique, "..");
+
+	afs_set_contig_bits(meta, AFS_DIR_RESV_BLOCKS0, 2);
+	meta->meta.alloc_ctrs[0] -= 2;
+	kunmap_local(meta);
+
+	netfs_single_mark_inode_dirty(&dvnode->netfs.inode);
+	set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags);
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c7f0d75eab7f..3acf1445e444 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1074,6 +1074,7 @@ extern void afs_edit_dir_add(struct afs_vnode *, struct qstr *, struct afs_fid *
 extern void afs_edit_dir_remove(struct afs_vnode *, struct qstr *, enum afs_edit_dir_reason);
 void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_dvnode,
 				enum afs_edit_dir_reason why);
+void afs_mkdir_init_dir(struct afs_vnode *dvnode, struct afs_vnode *parent_vnode);
 
 /*
  * dir_silly.c
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 49a749672e38..020ab7302a6b 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -348,6 +348,7 @@ enum yfs_cm_operation {
 	EM(afs_dir_invalid_edit_add_no_slots,	"edit-add-no-slots") \
 	EM(afs_dir_invalid_edit_add_too_many_blocks, "edit-add-too-many-blocks") \
 	EM(afs_dir_invalid_edit_get_block,	"edit-get-block") \
+	EM(afs_dir_invalid_edit_mkdir,		"edit-mkdir") \
 	EM(afs_dir_invalid_edit_rem_bad_size,	"edit-rem-bad-size") \
 	EM(afs_dir_invalid_edit_rem_wrong_name,	"edit-rem-wrong_name") \
 	EM(afs_dir_invalid_edit_upd_bad_size,	"edit-upd-bad-size") \
@@ -369,6 +370,7 @@ enum yfs_cm_operation {
 	EM(afs_edit_dir_delete_error,		"d_err ") \
 	EM(afs_edit_dir_delete_inval,		"d_invl") \
 	EM(afs_edit_dir_delete_noent,		"d_nent") \
+	EM(afs_edit_dir_mkdir,			"mk_ent") \
 	EM(afs_edit_dir_update_dd,		"u_ddot") \
 	EM(afs_edit_dir_update_error,		"u_fail") \
 	EM(afs_edit_dir_update_inval,		"u_invl") \


