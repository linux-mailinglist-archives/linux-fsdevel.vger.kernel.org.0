Return-Path: <linux-fsdevel+bounces-10117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AB68480C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 05:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2809D1C2230F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 04:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4497318C36;
	Sat,  3 Feb 2024 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y+PJhn8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19518AF6;
	Sat,  3 Feb 2024 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933438; cv=none; b=gh1SbAUVVHGN0cQzUZibVqRUbYOiX7c97hAplSOw2s6U5LUWl4amV0njCGEMnAir8ec5EF12ouBxFVD8AkfVIQQd3Xzm103Q493DrCit3FNbw5XB8YAgxu2/jiB6IpXexUS/tBb0iDR0RqbpOSWXIKd9hoEXobVFixw7rFiqHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933438; c=relaxed/simple;
	bh=zIf1TwFvbLVoKt9klxpOgV40/Ty2Swa3EUG6joyUFHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rM1yBfhQ9s4pVWpS2+u8uE7zz7oK8YoJSsocTbeqDauwq+ld/Mcwrsoxhg49IUj0uHtccuWfXE3YTjJ9ArCzrMvAgsoY/a3PTadCXjGAqaXv5bkUgK2t8KI2F/dY3XIwQdBmU/SdhnQHovAo26B5h3OpaLi1231FJOTh40weYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y+PJhn8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCCFC433F1;
	Sat,  3 Feb 2024 04:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933438;
	bh=zIf1TwFvbLVoKt9klxpOgV40/Ty2Swa3EUG6joyUFHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+PJhn8TTZ/H00Sz1fjP2LsOlVBmUAHlwLOvVujxS/vZQePnFpE5fTkDN2XkenIvV
	 XmWqKQdoL/5llIBkeQXChw7vw4G7olRlHOpwbgLtHZO+YGg1p4jrtPka2/qBAbrAg4
	 N8XiPnUF/Fh714v1N8UHINTnimBkxAl2fK0xETCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Dionne <marc.dionne@auristor.com>,
	David Howells <dhowells@redhat.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 168/219] 9p: Fix initialisation of netfs_inode for 9p
Date: Fri,  2 Feb 2024 20:05:41 -0800
Message-ID: <20240203035340.210209579@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
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

[ Upstream commit 9546ac78b232bac56ff975072b1965e0e755ebd4 ]

The 9p filesystem is calling netfs_inode_init() in v9fs_init_inode() -
before the struct inode fields have been initialised from the obtained file
stats (ie. after v9fs_stat2inode*() has been called), but netfslib wants to
set a couple of its fields from i_size.

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Dominique Martinet <asmadeus@codewreck.org>
Acked-by: Dominique Martinet <asmadeus@codewreck.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/v9fs_vfs.h       | 1 +
 fs/9p/vfs_inode.c      | 6 +++---
 fs/9p/vfs_inode_dotl.c | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index bc417da7e9c1..633fe4f527b8 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -46,6 +46,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb);
 void v9fs_free_inode(struct inode *inode);
 struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode,
 			     dev_t rdev);
+void v9fs_set_netfs_context(struct inode *inode);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 4d1a4a8d9277..5e2657c1dbbe 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -250,7 +250,7 @@ void v9fs_free_inode(struct inode *inode)
 /*
  * Set parameters for the netfs library
  */
-static void v9fs_set_netfs_context(struct inode *inode)
+void v9fs_set_netfs_context(struct inode *inode)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
 	netfs_inode_init(&v9inode->netfs, &v9fs_req_ops);
@@ -344,8 +344,6 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		err = -EINVAL;
 		goto error;
 	}
-
-	v9fs_set_netfs_context(inode);
 error:
 	return err;
 
@@ -377,6 +375,7 @@ struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode, dev_t rdev)
 		iput(inode);
 		return ERR_PTR(err);
 	}
+	v9fs_set_netfs_context(inode);
 	return inode;
 }
 
@@ -479,6 +478,7 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 		goto error;
 
 	v9fs_stat2inode(st, inode, sb, 0);
+	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	unlock_new_inode(inode);
 	return inode;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 5cfa4b4f070f..e15ad46833e0 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -130,6 +130,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 		goto error;
 
 	v9fs_stat2inode_dotl(st, inode, 0);
+	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	retval = v9fs_get_acl(inode, fid);
 	if (retval)
-- 
2.43.0




