Return-Path: <linux-fsdevel+bounces-16359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4787A89C001
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 15:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7F11F24A45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36527C086;
	Mon,  8 Apr 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T+KT8TTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5564CF2;
	Mon,  8 Apr 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581437; cv=none; b=FJU1eIUF9183cmgDNKPVNWIlJGT3+Zwd9b4v+z6G/REXl3cT0zLopkzOzH/y2ubCOmIEQPO9cEbsKbJxOfx3NAMWJM/s7akSePdfy++DUVa4mm+26F2aDuRrBm+ZkVQeP0o2W6IOvXJfhKTtMy/dkaykHL0slAfVWpiw3YQbIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581437; c=relaxed/simple;
	bh=Nx84nNful3EhSCX9GDP3HZbAXgF2FzEiBKfHlDAeiw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+kwZYvBA0e/WeiPWdrCtqiIdsXl5lW3NXwwJZNw35pY3kmiNxwu2zxRHPJVPQLgjWMM9IyiabmCd7rbo1UBV73hlk7zFkInw2E8xUVWnAkpjY9ohy1TlGC3Tprv4e1SNjOBGbNPvD2d6r8iTJBuo/hCKSww0lH8yvYLokWQ1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T+KT8TTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10DFC433C7;
	Mon,  8 Apr 2024 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581437;
	bh=Nx84nNful3EhSCX9GDP3HZbAXgF2FzEiBKfHlDAeiw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+KT8TTLx84PkHk8YMW5QmyJFiQm6emyaGbV+Pl+nyLjK9pDCjkp2KsFng2UdHs3x
	 uD9TznLOaPcjzgwD0fNO7Y624EIzCwiZDCUVMv4Q6J+sAxMxp9ZQUnVdAu/C375Ybb
	 DXcAqzE0hrQzsWAwdYir8EznKR5K7IoOEBC9IJEA=
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
Subject: [PATCH 6.1 019/138] cifs: Fix duplicate fscache cookie warnings
Date: Mon,  8 Apr 2024 14:57:13 +0200
Message-ID: <20240408125256.827989943@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index f64bad513ba6d..6df4ab2a6e5dc 100644
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
index 5343898bac8a6..634f28f0d331e 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1274,6 +1274,8 @@ cifs_find_inode(struct inode *inode, void *opaque)
 {
 	struct cifs_fattr *fattr = opaque;
 
+	/* [!] The compared values must be the same in struct cifs_fscache_inode_key. */
+
 	/* don't match inode with different uniqueid */
 	if (CIFS_I(inode)->uniqueid != fattr->cf_uniqueid)
 		return 0;
-- 
2.43.0




