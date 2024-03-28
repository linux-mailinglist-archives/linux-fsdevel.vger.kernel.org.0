Return-Path: <linux-fsdevel+bounces-15554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA9589054B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0914BB249D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D783D3B6;
	Thu, 28 Mar 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqM+F1xJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A13B2A2
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643691; cv=none; b=KmHH1RXRgULvFkXNmQfezEbmfo15qQR6Gkudvksd0rnbT7fXrkb4BFjtyEosSFHTXdp0yDvdKPm6tPIZ9xxOusnZ41QWa8goXnrPM9Z5RWaqpPoIzLokL5XdiUpjN3xxPmv6Y0iDZuMbcVPyW90twZBUY6CRkb/9I1FyCeULaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643691; c=relaxed/simple;
	bh=+8ZDgsWPyPdZyeuS7QhzhZ8T1ds652XhSpy7jeivk6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aghdCwjof6hbJ80Q4FBi8/9gxWbzmZ0+PoVyiqtdl/F0xQB7099f9LYq8OefDz95CUYCoNRajIEu2hmDLzrKlPv932tSGiKp69cvq2lCvqzL9Ax+QsPZ6mA3aCHP6133399Pg555OzTsUE45Gp/5wtHhWT1Tl3k3GQXOH2JvF60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqM+F1xJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UGun0xTYAiYXpHAgnS9fdzLLkhmr8x7z9WYy+PlL9DM=;
	b=iqM+F1xJaTyHfaj9yu6guNQUUXYDpIMF/nzptsKM2bWwJa9sl8ap7sZt2ewYv4LOM+51IX
	o8c93O7mUpbZOkd2A4EK6S9JOD2tp6sTncHoHpwrkizvMVsiGmdZwhumXQZTvthJRx9cW3
	aLoOIsEacmd26iFfiquwooUe+ibYLac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-6uNN7mfqOreex-w6B3hmWQ-1; Thu, 28 Mar 2024 12:34:44 -0400
X-MC-Unique: 6uNN7mfqOreex-w6B3hmWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C30E185A781;
	Thu, 28 Mar 2024 16:34:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CA93D17AAE;
	Thu, 28 Mar 2024 16:34:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
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
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH 01/26] cifs: Fix duplicate fscache cookie warnings
Date: Thu, 28 Mar 2024 16:33:53 +0000
Message-ID: <20240328163424.2781320-2-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

fscache emits a lot of duplicate cookie warnings with cifs because the
index key for the fscache cookies does not include everything that the
cifs_find_inode() function does.  The latter is used with iget5_locked() to
distinguish between inodes in the local inode cache.

Fix this by adding the creation time and file type to the fscache cookie
key.

Additionally, add a couple of comments to note that if one is changed the
other must be also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/fscache.c | 16 +++++++++++++++-
 fs/smb/client/inode.c   |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index c4a3cb736881..340efce8f052 100644
--- a/fs/smb/client/fscache.c
+++ b/fs/smb/client/fscache.c
@@ -12,6 +12,16 @@
 #include "cifs_fs_sb.h"
 #include "cifsproto.h"
 
+/*
+ * Key for fscache inode.  [!] Contents must match comparisons in cifs_find_inode().
+ */
+struct cifs_fscache_inode_key {
+
+	__le64  uniqueid;	/* server inode number */
+	__le64  createtime;	/* creation time on server */
+	u8	type;		/* S_IFMT file type */
+} __packed;
+
 static void cifs_fscache_fill_volume_coherency(
 	struct cifs_tcon *tcon,
 	struct cifs_fscache_volume_coherency_data *cd)
@@ -97,15 +107,19 @@ void cifs_fscache_release_super_cookie(struct cifs_tcon *tcon)
 void cifs_fscache_get_inode_cookie(struct inode *inode)
 {
 	struct cifs_fscache_inode_coherency_data cd;
+	struct cifs_fscache_inode_key key;
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 
+	key.uniqueid	= cpu_to_le64(cifsi->uniqueid);
+	key.createtime	= cpu_to_le64(cifsi->createtime);
+	key.type	= (inode->i_mode & S_IFMT) >> 12;
 	cifs_fscache_fill_coherency(&cifsi->netfs.inode, &cd);
 
 	cifsi->netfs.cache =
 		fscache_acquire_cookie(tcon->fscache, 0,
-				       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
+				       &key, sizeof(key),
 				       &cd, sizeof(cd),
 				       i_size_read(&cifsi->netfs.inode));
 	if (cifsi->netfs.cache)
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d28ab0af6049..91b07ef9e25c 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1351,6 +1351,8 @@ cifs_find_inode(struct inode *inode, void *opaque)
 {
 	struct cifs_fattr *fattr = opaque;
 
+	/* [!] The compared values must be the same in struct cifs_fscache_inode_key. */
+
 	/* don't match inode with different uniqueid */
 	if (CIFS_I(inode)->uniqueid != fattr->cf_uniqueid)
 		return 0;


