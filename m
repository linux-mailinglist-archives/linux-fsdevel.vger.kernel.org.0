Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88D354591
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 18:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhDEQqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 12:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhDEQqS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:46:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 284FB610CB;
        Mon,  5 Apr 2021 16:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617641172;
        bh=vHWoc2JOnQ+CZItOE9VfRh/35PrGyBQ49qmG5ey4KhE=;
        h=From:To:Cc:Subject:Date:From;
        b=C/mU7B7b1mXQhr6Xk1FkFkJYwR92bks7lAsnqTY99WtmdM5wy/dq2B34LOhQIqROu
         Rc6DfTbt42GytYUZR0cSSlu3tI3uCTcLBlFEWg0/Ja3C2iXMnjB6OR7H2ytx++fVVB
         hfXznHLVxFWiMvZoH6PNaFMpNwb7CMWFFXXDmlIPALii4avML1MjKSL+ZCd8B4B53n
         GJ280HkYUcGlHgRgcYg5NM1afH/+li+KoB/L76yF4Ou2Nbw8r+AbO9eQt2uE0bo5Cy
         JEpEgMFch7MKyfJJAs5NEwqLm+Tg+anW6iVWYPUOLsX57BKc49Hs69ZgzXB+9t5r4i
         FVty4syNFc72g==
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] cachefiles: use private mounts in cache->mnt
Date:   Mon,  5 Apr 2021 18:46:03 +0200
Message-Id: <20210405164603.281189-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Since [1] we support creating private mounts from a given path's
vfsmount. This makes them very suitable for any filesystem or
filesystem functionality that piggybacks on paths of another filesystem.
Overlayfs and ecryptfs (which I'll port next) are just two such
examples.
Without trying to imply to many similarities cachefiles have one thing
in common with stacking filesystems namely that they also stack on top
of existing paths. These paths are then used as caches for a netfs.
Since private mounts aren't attached in the filesystem the aren't
affected by mount property changes after cachefiles makes use of them.
This seems a rather desirable property as the underlying path can't e.g.
suddenly go from read-write to read-only and in general it means that
cachefiles is always in full control of the underlying mount after the
user has allowed it to be used as a cache.
Besides that - and probably irrelevant from the perspective of a
cachefiles developer - it also makes things simpler for a variety of
other vfs features. One concrete example is fanotify. When the path->mnt
of the path that is used as a cache has been marked with FAN_MARK_MOUNT
the semantics get tricky as it isn't clear whether the watchers of
path->mnt should get notified about fsnotify events when files are
created by cachefilesd via path->mnt. Using a private mount let's us
elegantly handle this case too and aligns the behavior of stacks created
by overlayfs.

Reading through the codebase cachefiles currently takes path->mnt and
stashes it in cache->mnt. Everytime a cache object needs to be created,
looked-up, or in some other form interacted with cachefiles will create
a custom path comprised of cache->mnt and the relevant dentry it is
interested in:

struct path cachefiles_path = {
        .mnt = cache->mnt,
        .dentry = dentry,
};

So cachefiles already passes the cache->mnt through everywhere so
supporting private mounts with cachefiles is pretty simply. Instead of
recording path->mnt in cache->mnt we simply record a new private mount
we created as a copy of path->mnt via clone_private_mount() in
cache->mnt. The rest is cleanly handled by cachefiles already.

I have tested this patch with an nfs v4 export. Server on host:

/srv/nfs        10.103.182.1/24(rw,sync,crossmnt,fsid=0)
/srv/nfs/mnt 	10.103.182.1/24(rw,sync)

In a vm running a kernel with this patch I first created a separate
bind-mount for /var/cache/fscache:

mount --bind /var/cache/fscache /var/cache/fscache

Then I enabled and ran cachefilesd.

and mounted the server:

mount 10.103.182.1:/mnt /mnt

and the cache worked fine! I then tried

mount -o bind,remount,ro /var/cache/fscache

and the cache continued to be working fine due to the private mount. I
don't have access to a test-suite for cachefiles though and I haven't
found one so far. If someone has a local test-suite I would very much
appreciate a test-run.

[1]: c771d683a62e ("vfs: introduce clone_private_mount()")
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/cachefiles/bind.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index 38bb7764b454..ac03af93437b 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -81,7 +81,7 @@ int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 {
 	struct cachefiles_object *fsdef;
-	struct path path;
+	struct path path, cache_path;
 	struct kstatfs stats;
 	struct dentry *graveyard, *cachedir, *root;
 	const struct cred *saved_cred;
@@ -115,16 +115,22 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	if (ret < 0)
 		goto error_open_root;
 
-	cache->mnt = path.mnt;
-	root = path.dentry;
+	cache->mnt = clone_private_mount(&path);
+	if (IS_ERR(cache->mnt)) {
+		ret = PTR_ERR(cache->mnt);
+		cache->mnt = NULL;
+		pr_warn("Failed to create private mount for file cache\n");
+		goto error_unsupported;
+	}
 
 	ret = -EINVAL;
-	if (mnt_user_ns(path.mnt) != &init_user_ns) {
+	if (mnt_user_ns(cache->mnt) != &init_user_ns) {
 		pr_warn("File cache on idmapped mounts not supported");
 		goto error_unsupported;
 	}
 
 	/* check parameters */
+	root = path.dentry;
 	ret = -EOPNOTSUPP;
 	if (d_is_negative(root) ||
 	    !d_backing_inode(root)->i_op->lookup ||
@@ -144,8 +150,10 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	if (ret < 0)
 		goto error_unsupported;
 
+	cache_path = path;
+	cache_path.mnt = cache->mnt;
 	/* get the cache size and blocksize */
-	ret = vfs_statfs(&path, &stats);
+	ret = vfs_statfs(&cache_path, &stats);
 	if (ret < 0)
 		goto error_unsupported;
 
@@ -229,7 +237,12 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 
 	/* done */
 	set_bit(CACHEFILES_READY, &cache->flags);
-	dput(root);
+
+	/*
+	 * We've created a private mount and we've stashed our "cache" and
+	 * "graveyard" dentries so we don't need the path anymore.
+	 */
+	path_put(&path);
 
 	pr_info("File cache on %s registered\n", cache->cache.identifier);
 
@@ -242,11 +255,11 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	dput(cache->graveyard);
 	cache->graveyard = NULL;
 error_unsupported:
+	path_put(&path);
 	mntput(cache->mnt);
 	cache->mnt = NULL;
 	dput(fsdef->dentry);
 	fsdef->dentry = NULL;
-	dput(root);
 error_open_root:
 	kmem_cache_free(cachefiles_object_jar, fsdef);
 error_root_object:

base-commit: a5e13c6df0e41702d2b2c77c8ad41677ebb065b3
-- 
2.27.0

