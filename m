Return-Path: <linux-fsdevel+bounces-16361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA80F89C179
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 15:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6FCB27006
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F5D81745;
	Mon,  8 Apr 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z0j1ILcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8B7A15C;
	Mon,  8 Apr 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582069; cv=none; b=Rt11RtjuqhvpDSia8WPI5h3Atk+ATLZYSBp7YpVmbj5fvvkR/irBIDFBgKQpIFCUb0lQmin7mc8YB8ZR5/C3HQSTJOiOspwi3e+c3E+661x8Bj+Gl1Fjiw5ZuM2JQCC4Kszwxm2rYyjtnib3uZf45IVCzDRkHLdp6HtZbBzy5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582069; c=relaxed/simple;
	bh=KVVH/6mRI716M5uJlDS5Ou9WITiJtYKXES+jHkpQgJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkQsVLQJJyGRZaFbi2E6XyADhMeu7wBQxLtkUyZeDJnOR4JTCsIIbd3kjCkxgc9MhPd0G9woyjRhyoZRYZKcyQcHuYk/bYbQh1Fj3p65HQKhmX+FCmVETE8bCbsNJ90P3NJWi3j8t3LigHdoZTggdDn6ou8cJAT+TrtrK05Wn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z0j1ILcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD44BC433C7;
	Mon,  8 Apr 2024 13:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582069;
	bh=KVVH/6mRI716M5uJlDS5Ou9WITiJtYKXES+jHkpQgJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0j1ILcBdpNmuveFGh5j2SWEhHmG0fLWvkDTwmtP9obq33LeXC+zylSKD2PWnyQCb
	 Gtt3D4ilvZWZZnbqo98vWl9cMgH7LvVtF4S6mrR5J9ubIwhjLxsVwTdtwqjPhKg3nr
	 f03wWlZ3q3Z2eouDLEwpOhZZRt2Wcx3EJPRHJzPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 044/273] cifs: Fix duplicate fscache cookie warnings
Date: Mon,  8 Apr 2024 14:55:19 +0200
Message-ID: <20240408125310.667062546@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 8876a37277cb832e1861c35f8c661825179f73f5 ]

fscache emits a lot of duplicate cookie warnings with cifs because the
index key for the fscache cookies does not include everything that the
cifs_find_inode() function does.  The latter is used with iget5_locked() to
distinguish between inodes in the local inode cache.

Fix this by adding the creation time and file type to the fscache cookie
key.

Additionally, add a couple of comments to note that if one is changed the
other must be also.

Signed-off-by: David Howells <dhowells@redhat.com>
Fixes: 70431bfd825d ("cifs: Support fscache indexing rewrite")
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/fscache.c | 16 +++++++++++++++-
 fs/smb/client/inode.c   |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index c4a3cb736881a..340efce8f0529 100644
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
index 7f28edf4b20f3..4c3dec384f922 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1414,6 +1414,8 @@ cifs_find_inode(struct inode *inode, void *opaque)
 {
 	struct cifs_fattr *fattr = opaque;
 
+	/* [!] The compared values must be the same in struct cifs_fscache_inode_key. */
+
 	/* don't match inode with different uniqueid */
 	if (CIFS_I(inode)->uniqueid != fattr->cf_uniqueid)
 		return 0;
-- 
2.43.0




