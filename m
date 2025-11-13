Return-Path: <linux-fsdevel+bounces-68353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B4C59B11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 20:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8AB3BAE22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017D831A551;
	Thu, 13 Nov 2025 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjYcinjb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05F31A051
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061213; cv=none; b=C87/Ngcn7xFjci0fBFRf659UQWgHdpYib1k7q1H98AahayEWK07j3TcuOwK7JhZt9HN1gzTu7GwgqWqe3hw0EEMX05/dthsYZx5je1ytn4/cMmdu0UCKFd0Q6hNM32uanynWEadri9EOdMliuUU49tc/p0b+GkOKoWBr/OLigso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061213; c=relaxed/simple;
	bh=t379PNNDtgqAq91+E+L22RFtXrzOjTEW/ORV3+9ulwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yk61CRwoiamOpM9v3w/vvDz0amYBpaYkcY/ux8DzDktcwwFjVhhhHHir/xQpqdGmGV1sbHANtGLUonbofgUTAzh6pytperHe6aMyEUsAlETju1s2cpDUeMRAsuMecsgBNYEVX/ehSccYq4gO0sbCrmNBdUB3mQevdt65URIoisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjYcinjb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763061209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TyHzdpDFZ+y9Xq3UcqZS1nBRZScwrGk9PLsYYKXTicQ=;
	b=JjYcinjbeb/+TokCga9KKqbeiHL0a3Fd/OxgsR7MiGePH2DS89aR++UDRkbGj1kIW5LH72
	uogn3PD/e2dVhjCVk+TL5TCpdUUbVO3FmUl0brd9F/EMR7Rv92fma1HKqw+4NR9ij1Vth9
	CEhvBsuTPNGDu/+qYrutlvkW7FlcRQQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-15YijcbmNi2ii0LkA0cgSg-1; Thu,
 13 Nov 2025 14:13:26 -0500
X-MC-Unique: 15YijcbmNi2ii0LkA0cgSg-1
X-Mimecast-MFC-AGG-ID: 15YijcbmNi2ii0LkA0cgSg_1763061204
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2DD719560A1;
	Thu, 13 Nov 2025 19:13:23 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 097331800451;
	Thu, 13 Nov 2025 19:13:15 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Andrew Price <anprice@redhat.com>
Subject: [PATCH] gfs2: Prevent recursive memory reclaim
Date: Thu, 13 Nov 2025 19:13:14 +0000
Message-ID: <20251113191314.1679300-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Function new_inode() returns a new inode with inode->i_mapping->gfp_mask
set to GFP_HIGHUSER_MOVABLE.  This value includes the __GFP_FS flag, so
allocations in that address space can recurse into filesystem memory
reclaim.  We don't want that to happen because it can consume a
significant amount of stack memory.

Worse than that is that it can also deadlock: for example, in several
places, gfs2_unstuff_dinode() is called inside filesystem transactions.
This calls calls filemap_grab_folio(), which can allocate a new folio,
which can trigger memory reclaim.  If memory reclaim recurses into the
filesystem and starts another transaction, a deadlock will ensue.

To fix these kinds of problems, prevent memory reclaim from recursing
into filesystem code by making sure that the gfp_mask of inode address
spaces doesn't include __GFP_FS.

The "meta" and resource group address spaces were already using GFP_NOFS
as their gfp_mask (which doesn't include __GFP_FS).  Inodes allocated by
new_inode() will have their inode->i_mapping->gfp_mask set to
GFP_HIGHUSER_MOVABLE, which is less restrictive than GFP_NOFS, though.
To avoid being overly limiting, use the default value and only knock off
the __GFP_FS flag.  I'm not sure if this will actually make a
difference, but it also shouldn't hurt.

This patch is loosely based on commit ad22c7a043c2 ("xfs: prevent stack
overflows from page cache allocation").

Fixes xfstest generic/273.

Reviewed-by: Andrew Price <anprice@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      |  5 ++++-
 fs/gfs2/inode.c      | 15 +++++++++++++++
 fs/gfs2/inode.h      |  1 +
 fs/gfs2/ops_fstype.c |  2 +-
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b677c0e6b9ab..9f2eb7e38569 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1211,10 +1211,13 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 
 	mapping = gfs2_glock2aspace(gl);
 	if (mapping) {
+		gfp_t gfp_mask;
+
                 mapping->a_ops = &gfs2_meta_aops;
 		mapping->host = sdp->sd_inode;
 		mapping->flags = 0;
-		mapping_set_gfp_mask(mapping, GFP_NOFS);
+		gfp_mask = mapping_gfp_mask(sdp->sd_inode->i_mapping);
+		mapping_set_gfp_mask(mapping, gfp_mask);
 		mapping->i_private_data = NULL;
 		mapping->writeback_index = 0;
 	}
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8a7ed80d9f2d..d7e35a05c161 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -89,6 +89,19 @@ static int iget_set(struct inode *inode, void *opaque)
 	return 0;
 }
 
+void gfs2_setup_inode(struct inode *inode)
+{
+	gfp_t gfp_mask;
+
+	/*
+	 * Ensure all page cache allocations are done from GFP_NOFS context to
+	 * prevent direct reclaim recursion back into the filesystem and blowing
+	 * stacks or deadlocking.
+	 */
+	gfp_mask = mapping_gfp_mask(inode->i_mapping);
+	mapping_set_gfp_mask(inode->i_mapping, gfp_mask & ~__GFP_FS);
+}
+
 /**
  * gfs2_inode_lookup - Lookup an inode
  * @sb: The super block
@@ -132,6 +145,7 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 		struct gfs2_glock *io_gl;
 		int extra_flags = 0;
 
+		gfs2_setup_inode(inode);
 		error = gfs2_glock_get(sdp, no_addr, &gfs2_inode_glops, CREATE,
 				       &ip->i_gl);
 		if (unlikely(error))
@@ -752,6 +766,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	error = -ENOMEM;
 	if (!inode)
 		goto fail_gunlock;
+	gfs2_setup_inode(inode);
 	ip = GFS2_I(inode);
 
 	error = posix_acl_create(dir, &mode, &default_acl, &acl);
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index e43f08eb26e7..2fcd96dd1361 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -86,6 +86,7 @@ static inline int gfs2_check_internal_file_size(struct inode *inode,
 	return -EIO;
 }
 
+void gfs2_setup_inode(struct inode *inode);
 struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned type,
 			        u64 no_addr, u64 no_formal_ino,
 			        unsigned int blktype);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index aa15183f9a16..1a2db8053da0 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1183,7 +1183,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	mapping = gfs2_aspace(sdp);
 	mapping->a_ops = &gfs2_rgrp_aops;
-	mapping_set_gfp_mask(mapping, GFP_NOFS);
+	gfs2_setup_inode(sdp->sd_inode);
 
 	error = init_names(sdp, silent);
 	if (error)
-- 
2.51.0


