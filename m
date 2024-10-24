Return-Path: <linux-fsdevel+bounces-32770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DAA9AE7F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 16:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19741B28F90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E3F203717;
	Thu, 24 Oct 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5EEPZsC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6F2036E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778877; cv=none; b=Lxu8gV0aOHjbvGSCYfnACJNVOTtedVTZ5O9Bd3T7XZzTF+Gcb5XAvnCEOyk12h8AMybwIDg0v4/+fZneybTSV1O6myuKvilk3BPK9kkZ/DzMN4rO6P5eDxsCgBORItK4KJuWYGWdGHb0ANh+Dp3K9xTkL1tM6dUxL0DoqtLupOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778877; c=relaxed/simple;
	bh=90tmfXdOk7PUXqQduFPRhL3TyDiNo9WZvTnvimUkG4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO36LqOBgvX0fJn9igGMy3mFL1oMLIe2tZcwo5japuw80qlJXbEimNRpjvEJObugRbsQVoVvh746NxDmmEg8/gr0GqK7a6pL4RR7E02eKXLENrEyjT1dPx2dHEMRBqHXm1xUGuxjMCq20h30aSdcQMLoPXRVDIQwS5Gd7HUajTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5EEPZsC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpSYjRYWbFXxWDdh6eO8irNXCJzGx0/SlE83d2O2JK0=;
	b=Z5EEPZsCYMREXf/PZESb/g5Z5XvFpxSCc45mM557aRtwu8/+PZJ/E+bX4K65HGbM1kauw3
	49vG5e5a5QdIhRTMjb2DKsZ7nqlDGx/tjse0ypbqGYwrBWhul4NhThCR+yt8aAVBfhavtl
	IYiQmYlvwGJClrCgwv4mUvuDNGS31/w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-X2salaQqORGe0htRiH1TeQ-1; Thu,
 24 Oct 2024 10:07:53 -0400
X-MC-Unique: X2salaQqORGe0htRiH1TeQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 831B21955EAA;
	Thu, 24 Oct 2024 14:07:49 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C92C3196BB7D;
	Thu, 24 Oct 2024 14:07:43 +0000 (UTC)
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
Subject: [PATCH 15/27] netfs: Remove some extraneous directory invalidations
Date: Thu, 24 Oct 2024 15:05:13 +0100
Message-ID: <20241024140539.3828093-16-dhowells@redhat.com>
In-Reply-To: <20241024140539.3828093-1-dhowells@redhat.com>
References: <20241024140539.3828093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In the directory editing code, we shouldn't re-invalidate the directory
if it is already invalidated.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir_edit.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index fe223fb78111..13fb236a3f50 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -247,7 +247,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 		 */
 		index = b / AFS_DIR_BLOCKS_PER_PAGE;
 		if (nr_blocks >= AFS_DIR_MAX_BLOCKS)
-			goto error;
+			goto error_too_many_blocks;
 		if (index >= folio_nr_pages(folio0)) {
 			folio = afs_dir_get_folio(vnode, index);
 			if (!folio)
@@ -260,7 +260,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
-			goto invalidated;
+			goto already_invalidated;
 
 		_debug("block %u: %2u %3u %u",
 		       b,
@@ -348,9 +348,8 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	_leave("");
 	return;
 
-invalidated:
+already_invalidated:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_create_inval, 0, 0, 0, 0, name->name);
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	kunmap_local(block);
 	if (folio != folio0) {
 		folio_unlock(folio);
@@ -358,9 +357,10 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	}
 	goto out_unmap;
 
+error_too_many_blocks:
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 error:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_create_error, 0, 0, 0, 0, name->name);
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out_unmap;
 }
 
@@ -421,7 +421,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
-			goto invalidated;
+			goto already_invalidated;
 
 		if (b > AFS_DIR_BLOCKS_WITH_CTR ||
 		    meta->meta.alloc_ctrs[b] <= AFS_DIR_SLOTS_PER_BLOCK - 1 - need_slots) {
@@ -475,10 +475,9 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	_leave("");
 	return;
 
-invalidated:
+already_invalidated:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_inval,
 			   0, 0, 0, 0, name->name);
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	kunmap_local(block);
 	if (folio != folio0) {
 		folio_unlock(folio);
@@ -489,7 +488,6 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 error:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_error,
 			   0, 0, 0, 0, name->name);
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out_unmap;
 }
 
@@ -530,7 +528,7 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
-			goto invalidated;
+			goto already_invalidated;
 
 		slot = afs_dir_scan_block(block, &dotdot_name, b);
 		if (slot >= 0)
@@ -564,18 +562,16 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 	_leave("");
 	return;
 
-invalidated:
+already_invalidated:
 	kunmap_local(block);
 	folio_unlock(folio);
 	folio_put(folio);
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_inval,
 			   0, 0, 0, 0, "..");
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out;
 
 error:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_error,
 			   0, 0, 0, 0, "..");
-	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out;
 }


