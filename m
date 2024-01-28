Return-Path: <linux-fsdevel+bounces-9245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC283F6BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 17:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A931F24ECC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F151C4B;
	Sun, 28 Jan 2024 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbpsERd0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830E51C2C;
	Sun, 28 Jan 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458324; cv=none; b=EhyHzDIDtDVrmpPgNtfM9C3EKeqCPmz+zJSJqcb6AlDNgwDugx51l8S2AogGta3ruBjBkMKrT5HOi8/D/D+o48rjQpWIT35+VIw7ehdaK06ahVixIU36j4QIT+/Kfxi4Ew5IjKfhKJBkfaZ7ZEQincADZorbUE2CtzaL/mqdMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458324; c=relaxed/simple;
	bh=lMQxen8ayWc8dQIzI8+sWw3n7L1wyUX4yT5wSLxfHNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYdou8hCZA5pDiWqYNv7qd0H9BK4nUS5XGb2g4vwQ3QlH22dPYZfhv89IxaEdytOOeBSe31xKBvG2vSFZgkmFkQ/EZI+OHWO6sY1ioIVMQvMf0LpDH/LBJXH3160gyvzx1B1U8Sh6W8WCYJ3rO8XenoBpzLysOMYCoLIuEogdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbpsERd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39414C43399;
	Sun, 28 Jan 2024 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458323;
	bh=lMQxen8ayWc8dQIzI8+sWw3n7L1wyUX4yT5wSLxfHNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AbpsERd0/LH4S77meQzAx6iv6SGjZ83XwiTuOZZ34T7DJbOs9JdZg8Xy46cBhVSpi
	 0go1dC14ysKK19miulLWL5VLN0Oinnvc1t6dnSILA/UEeadYvX+raNSqGnC6SbJAIX
	 op5UJmS7eVyRcNzgbknz9zGA3LSyAOA5PUZLUXe2IpixvZSNzVqOXQcFYoGQ9eHf8O
	 LR18aLAdQ6b59l3MXmuZLdpMP6OkLJq3MAChBfep6q4uE6FGz/OABDoDTsxtsFVbbI
	 TCJu/fpWs4DY1FYyyuRuXg+lXP0WRztZbDJ8ymrwF2E3lShGkikbfp0HajnvkLVnVK
	 5AdlTeZdsa8Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.7 18/39] 9p: Fix initialisation of netfs_inode for 9p
Date: Sun, 28 Jan 2024 11:10:38 -0500
Message-ID: <20240128161130.200783-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

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
index 731e3d14b67d..0e8418066a48 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -42,6 +42,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb);
 void v9fs_free_inode(struct inode *inode);
 struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode,
 			     dev_t rdev);
+void v9fs_set_netfs_context(struct inode *inode);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b845ee18a80b..90dc5ef75516 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -246,7 +246,7 @@ void v9fs_free_inode(struct inode *inode)
 /*
  * Set parameters for the netfs library
  */
-static void v9fs_set_netfs_context(struct inode *inode)
+void v9fs_set_netfs_context(struct inode *inode)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
 	netfs_inode_init(&v9inode->netfs, &v9fs_req_ops);
@@ -326,8 +326,6 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		err = -EINVAL;
 		goto error;
 	}
-
-	v9fs_set_netfs_context(inode);
 error:
 	return err;
 
@@ -359,6 +357,7 @@ struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode, dev_t rdev)
 		iput(inode);
 		return ERR_PTR(err);
 	}
+	v9fs_set_netfs_context(inode);
 	return inode;
 }
 
@@ -464,6 +463,7 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 		goto error;
 
 	v9fs_stat2inode(st, inode, sb, 0);
+	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	unlock_new_inode(inode);
 	return inode;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c7319af2f471..d0636b99f05b 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -128,6 +128,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 		goto error;
 
 	v9fs_stat2inode_dotl(st, inode, 0);
+	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	retval = v9fs_get_acl(inode, fid);
 	if (retval)
-- 
2.43.0


