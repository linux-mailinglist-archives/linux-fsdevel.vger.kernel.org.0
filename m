Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7833C6F41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhGMLSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235709AbhGMLSa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:18:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F5A66127C;
        Tue, 13 Jul 2021 11:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174941;
        bh=hidsKq1SmHOo5r8gQbPSJ5AaAhsbxGQWW2F55p9V0tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMvS0QIJn9lXrW5yjBfiOT9mbKHlYK+0JvK9PBdA5xKQa82t2g3nUpCAhmHrs/weL
         4QZFb/o5dANPNej2JF3a5kbKMqvHKXHYOaWO16BgPGwko1/o90N+LkYdAhlOVDs0K0
         sQ+YNfi8bXRUTFWUg56bqlO7Y+bZcUF0xc/EmONwYQbaHR0z7Q4a9tKmaqVW689Px6
         P1uaS2acoljNgtb3gce+mj6xL/nfJ6cOu6vajDYo6w/M4/vxfnEkXMzlANa/Z2YR5+
         0cwW7oQVHcp7fgEvMsWRylpTgRuhHrC5CLh1QlCOsQN9+JCaYVLQyxorz3cckoRZK/
         pJwRxAjCb53MA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 04/24] namei: handle mappings in try_lookup_one_len()
Date:   Tue, 13 Jul 2021 13:13:24 +0200
Message-Id: <20210713111344.1149376-5-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3230; h=from:subject; bh=GvOAx5y8ei8ICCoYDPc3ZZ1DfOkJ7Me2qIkoQsneRhA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY2Y/TWUObNq+/+AWWzT0hc9261W15r39VLF2eJmHcYa vpb7HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJ8WT4K+4adP2Pm5RpSIXr9LhTk1 fOryrIW/OKyVCZ4fPq55WhGxkZ5v5hsNv67eaOP7mpRin6scbZrt8uhe4t7z4U97j6aZoUCwA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Various filesystems use the try_lookup_one_len() helper to lookup a single path
component relative to a well-known starting point. Allow such filesystems to
support idmapped mounts by enabling try_lookup_one_len() to take the idmap into
account when calling inode_permission(). This change is a required to let btrfs
(and other filesystems) support idmapped mounts.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/afs/dynroot.c      | 2 +-
 fs/namei.c            | 7 +++++--
 include/linux/namei.h | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 6b89d68c8e44..9e96840e6952 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -315,7 +315,7 @@ void afs_dynroot_rmdir(struct afs_net *net, struct afs_cell *cell)
 	inode_lock(root->d_inode);
 
 	/* Don't want to trigger a lookup call, which will re-add the cell */
-	subdir = try_lookup_one_len(cell->name, root, cell->name_len);
+	subdir = try_lookup_one_len(&init_user_ns, cell->name, root, cell->name_len);
 	if (IS_ERR_OR_NULL(subdir)) {
 		_debug("lookup %ld", PTR_ERR(subdir));
 		goto no_dentry;
diff --git a/fs/namei.c b/fs/namei.c
index 68489c23bc44..0866b88628b9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2610,6 +2610,7 @@ static int lookup_one_len_common(struct user_namespace *mnt_userns,
 
 /**
  * try_lookup_one_len - filesystem helper to lookup single pathname component
+ * @mnt_userns:	user namespace of the mount the lookup is performed from
  * @name:	pathname component to lookup
  * @base:	base directory to lookup from
  * @len:	maximum length @len should be interpreted to
@@ -2622,14 +2623,16 @@ static int lookup_one_len_common(struct user_namespace *mnt_userns,
  *
  * The caller must hold base->i_mutex.
  */
-struct dentry *try_lookup_one_len(const char *name, struct dentry *base, int len)
+struct dentry *try_lookup_one_len(struct user_namespace *mnt_userns,
+				  const char *name, struct dentry *base,
+				  int len)
 {
 	struct qstr this;
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
 
-	err = lookup_one_len_common(&init_user_ns, name, base, len, &this);
+	err = lookup_one_len_common(mnt_userns, name, base, len, &this);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index c177edfb2364..206ea4702d62 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -64,7 +64,8 @@ extern struct dentry *user_path_create(int, const char __user *, struct path *,
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
 
-extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
+extern struct dentry *try_lookup_one_len(struct user_namespace *, const char *,
+					 struct dentry *, int);
 extern struct dentry *lookup_one_len(struct user_namespace *mnt_userns,
 				     const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(struct user_namespace *,
-- 
2.30.2

