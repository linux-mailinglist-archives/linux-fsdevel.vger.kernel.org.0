Return-Path: <linux-fsdevel+bounces-15441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2831288E970
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 16:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72AAB27BBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC3143C6A;
	Wed, 27 Mar 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEon+zyb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D6143887
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548819; cv=none; b=dBhzpqkwtBUgBWc3N7Nv0YTSNgoAwKM+ZpfdNEYf94CuNXKr7xYgjxEoDm6/SwhMrhk1SmFyAWMmFy7sF338rLOyXwOkWUcUPiBesh2nQqLG/2QGQIc3HhLqSTkJULYQViEzB+yW1vz+wTwDjmF1LYgaqO8zZXpoojORces7Pj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548819; c=relaxed/simple;
	bh=7stkxD8LcUkgd6MZgtGDEXBV8+4CKxCvxSZFtRvHSQ8=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=BqE3NPy4C2SD3v+jb/P1pOQ/vRV6Rd8dv8muS6eCudYnOY1C5j+6LSnwaf1pF7M0kyC9JGEHwunsqNFCS0ErDk3Q7UJso6Pp/RFUx3BnRR15YAmpNIpOTaj6z/VE/n5y2s0hlqRKzhovJgQu/2CnMfcFmwvOIAP3zjYOEfXEDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NEon+zyb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711548816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qut9wqKpTNwmM2gET59mhKtRBrovobZzNxOyH6sbgc8=;
	b=NEon+zybF5/2vniV4mhoq4ZYdYZPIqpgdpn/eyOnKbrCnyhwy0Y5TR9UuyhPK2qvIcRRjS
	2DLQfYTgzUjUQXcRzZ+JYzDk6AvEc7Lr3CVx9UMhV2r7lbMjnEbclnKlomC0iFGlfvU6aw
	3SiNAQG6v5Thc3pGh6yoCBjXDUbMkXI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-10nbk4m5PIa1cEig9JI9nw-1; Wed,
 27 Mar 2024 10:13:31 -0400
X-MC-Unique: 10nbk4m5PIa1cEig9JI9nw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EDB928000A0;
	Wed, 27 Mar 2024 14:13:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0CA0D492BC8;
	Wed, 27 Mar 2024 14:13:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix duplicate fscache cookie warnings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2305514.1711548804.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Mar 2024 14:13:24 +0000
Message-ID: <2305515.1711548804@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

fscache emits a lot of duplicate cookie warnings with cifs because the
index key for the fscache cookies does not include everything that the
cifs_find_inode() function does.  The latter is used with iget5_locked() t=
o
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
 fs/smb/client/fscache.c |   16 +++++++++++++++-
 fs/smb/client/inode.c   |    2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index c4a3cb736881..340efce8f052 100644
--- a/fs/smb/client/fscache.c
+++ b/fs/smb/client/fscache.c
@@ -12,6 +12,16 @@
 #include "cifs_fs_sb.h"
 #include "cifsproto.h"
 =

+/*
+ * Key for fscache inode.  [!] Contents must match comparisons in cifs_fi=
nd_inode().
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
@@ -97,15 +107,19 @@ void cifs_fscache_release_super_cookie(struct cifs_tc=
on *tcon)
 void cifs_fscache_get_inode_cookie(struct inode *inode)
 {
 	struct cifs_fscache_inode_coherency_data cd;
+	struct cifs_fscache_inode_key key;
 	struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb =3D CIFS_SB(inode->i_sb);
 	struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
 =

+	key.uniqueid	=3D cpu_to_le64(cifsi->uniqueid);
+	key.createtime	=3D cpu_to_le64(cifsi->createtime);
+	key.type	=3D (inode->i_mode & S_IFMT) >> 12;
 	cifs_fscache_fill_coherency(&cifsi->netfs.inode, &cd);
 =

 	cifsi->netfs.cache =3D
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
 	struct cifs_fattr *fattr =3D opaque;
 =

+	/* [!] The compared values must be the same in struct cifs_fscache_inode=
_key. */
+
 	/* don't match inode with different uniqueid */
 	if (CIFS_I(inode)->uniqueid !=3D fattr->cf_uniqueid)
 		return 0;


