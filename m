Return-Path: <linux-fsdevel+bounces-7235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC3E823018
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 16:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18A41C21711
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885F1C68A;
	Wed,  3 Jan 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbIVdre/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F21C288
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704294006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUPriBHgZCe048XAouZ6FVZlUrGVgRcZGkDmJ6vhI+o=;
	b=WbIVdre/77BYAs7VnmULYmFKFJtIZgm28xhi+FQbOnzkgc+eDT1o0psUmkZusvQm2uqw+J
	TUAjVHJg2k54XZ0Nzo7IbsEyS68AJR7ls2rSU1wKWFGMVQpKIr1q+g643FhQewC9MzFAEw
	ZRciCyrgsWf4PBK4IAeW0SbHsvLtaXU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-mFIdXobHMneufCW3dOaAMw-1; Wed, 03 Jan 2024 10:00:04 -0500
X-MC-Unique: mFIdXobHMneufCW3dOaAMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FA74185A780;
	Wed,  3 Jan 2024 15:00:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0074C3C30;
	Wed,  3 Jan 2024 14:59:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH 3/5] 9p: Do a couple of cleanups
Date: Wed,  3 Jan 2024 14:59:27 +0000
Message-ID: <20240103145935.384404-4-dhowells@redhat.com>
In-Reply-To: <20240103145935.384404-1-dhowells@redhat.com>
References: <20240103145935.384404-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Do a couple of cleanups to 9p:

 (1) Remove a couple of unused variables.

 (2) Turn a BUG_ON() into a warning, consolidate with another warning and
     make the warning message include the inode number rather than
     whatever's in i_private (which will get hashed anyway).

Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/r/ZZULNQAZ0n0WQv7p@codewreck.org/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index d8fb407189a0..f7f83eec3bcc 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -28,8 +28,6 @@
 
 static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
 {
-	struct inode *inode = subreq->rreq->inode;
-	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
 	int err;
 
@@ -98,15 +96,13 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 
 	if (file) {
 		fid = file->private_data;
-		BUG_ON(!fid);
+		if (!fid)
+			goto no_fid;
 		p9_fid_get(fid);
 	} else {
 		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
-		if (!fid) {
-			WARN_ONCE(1, "folio expected an open fid inode->i_private=%p\n",
-				  rreq->inode->i_private);
-			return -EINVAL;
-		}
+		if (!fid)
+			goto no_fid;
 	}
 
 	/* we might need to read from a fid that was opened write-only
@@ -115,6 +111,11 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 	WARN_ON(rreq->origin == NETFS_READ_FOR_WRITE && !(fid->mode & P9_ORDWR));
 	rreq->netfs_priv = fid;
 	return 0;
+
+no_fid:
+	WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
+		  rreq->inode->i_ino);
+	return -EINVAL;
 }
 
 /**


