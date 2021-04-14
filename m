Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF535F40A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbhDNMjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 08:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347245AbhDNMjK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:39:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1E306120E;
        Wed, 14 Apr 2021 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618403928;
        bh=IZI+OSslCaIWFEk2NoXBygcF3OFFNuy5fzwoNm+dsZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCbE6SQ5uwUBpXZ1RzP3iEGX80CUPIwZpcffam6h0dXXLrSjY4wIQy9c68rnrXrNI
         Q4C2GpRngJhYYfh2Dvv0bQZG2F2wVCOzSIUdGC2we0X36kC1NC0cLmgBzzwbdaAM5g
         QemtoLY98MzCIF90JDW/h6U8Cl4MWln131O7EcxkLNt3F/b65G4yIOaN55AnNjUe2k
         KEq7dm8O3XrhT89NQgMwnTBWQn6eEAct/hreP/qNPSXXYuMqbHeKcK7bVkJp91LHJg
         m6R6p8h2zzfDmiv9QjQ0a5ioxtUwtIeDlFaqpqN7NdcaDmL+4FwsNw4FffiKCu5i/J
         oOS5kNFykdD6Q==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-cachefs@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 4/7] cachefiles: switch to using a private mount
Date:   Wed, 14 Apr 2021 14:37:48 +0200
Message-Id: <20210414123750.2110159-5-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414123750.2110159-1-brauner@kernel.org>
References: <20210414123750.2110159-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=hwgEpKcxUilZoaiqT+JyzcfGZMf0soWkM4bdQYDkDvg=; m=a96r3v8RwrL4g/1sNPrC4UOIIAEXCc3CS0b2sRZc7RU=; p=XSHAjaTFwV7pvjIGkKhBUdgpl7JgMk4Nu6tl4Wc2ihs=; g=a078b6b4a1967b5b7c037666db37f7e1bb3fbf08
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHbh3wAKCRCRxhvAZXjcovMtAP0fOOS sfiJHpJFidXGpKFaz7TF3d0dQVdFZeNLrC7XQ3wD/Ucs2xBHxI30BSsyuxfTXI6WrzKNW4uv7hMiW 2ksOCAk=
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
user has allowed it to be used as a cache (apart from operations that
affect the superblock of course).

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

I have tested this patch with afs:

systemctl stop cachefilesd
sudo mount --bind /var/cache/fscache /var/cache/fscache
systemctl start cachefilesd

sudo apt install kafs-client
systemctl start afs.mount
ls -al /afs
ls -al /afs/grand.central.org/software/openafs/1.9.0
md5sum /afs/grand.central.org/software/openafs/1.9.0/openafs-1.9.0-doc.tar.bz2

cat /proc/fs/fscache/stats | grep [1-9]
  Cookies: idx=148 dat=35 spc=0
  Objects: alc=41 nal=0 avl=41 ded=0
  Pages  : mrk=934 unc=0
  Acquire: n=183 nul=0 noc=0 ok=183 nbf=0 oom=0
  Lookups: n=41 neg=41 pos=0 crt=41 tmo=0
  Retrvls: n=19 ok=0 wt=1 nod=19 nbf=0 int=0 oom=0
  Retrvls: ops=19 owt=0 abt=0
  Stores : n=934 ok=934 agn=0 nbf=0 oom=0
  Stores : ops=62 run=996 pgs=934 rxd=934 olm=0
  Ops    : pend=0 run=81 enq=996 can=0 rej=0
  Ops    : ini=953 dfr=0 rel=953 gc=0

umount /afs/grand.central.org
md5sum /afs/grand.central.org/software/openafs/1.9.0/openafs-1.9.0-doc.tar.bz2

cat /proc/fs/fscache/stats | grep [1-9]
  Cookies: idx=152 dat=60 spc=0
  Objects: alc=70 nal=0 avl=70 ded=39
  ChkAux : non=0 ok=25 upd=0 obs=0
  Pages  : mrk=1868 unc=934
  Acquire: n=212 nul=0 noc=0 ok=212 nbf=0 oom=0
  Lookups: n=70 neg=41 pos=29 crt=41 tmo=0
  Relinqs: n=39 nul=0 wcr=0 rtr=0
  Retrvls: n=38 ok=19 wt=2 nod=19 nbf=0 int=0 oom=0
  Retrvls: ops=38 owt=0 abt=0
  Stores : n=934 ok=934 agn=0 nbf=0 oom=0
  Stores : ops=62 run=996 pgs=934 rxd=934 olm=0
  Ops    : pend=0 run=100 enq=996 can=0 rej=0
  Ops    : ini=972 dfr=0 rel=972 gc=0

[1]: c771d683a62e ("vfs: introduce clone_private_mount()")
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/cachefiles/bind.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index 38bb7764b454..7ef572d698f0 100644
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
@@ -115,16 +115,23 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	if (ret < 0)
 		goto error_open_root;
 
-	cache->mnt = path.mnt;
-	root = path.dentry;
-
-	ret = -EINVAL;
 	if (mnt_user_ns(path.mnt) != &init_user_ns) {
+		ret = -EINVAL;
+		cache->mnt = NULL;
 		pr_warn("File cache on idmapped mounts not supported");
 		goto error_unsupported;
 	}
 
+	cache->mnt = clone_private_mount(&path);
+	if (IS_ERR(cache->mnt)) {
+		ret = PTR_ERR(cache->mnt);
+		cache->mnt = NULL;
+		pr_warn("Failed to create private mount for file cache\n");
+		goto error_unsupported;
+	}
+
 	/* check parameters */
+	root = path.dentry;
 	ret = -EOPNOTSUPP;
 	if (d_is_negative(root) ||
 	    !d_backing_inode(root)->i_op->lookup ||
@@ -144,8 +151,10 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	if (ret < 0)
 		goto error_unsupported;
 
+	cache_path.dentry = path.dentry;
+	cache_path.mnt = cache->mnt;
 	/* get the cache size and blocksize */
-	ret = vfs_statfs(&path, &stats);
+	ret = vfs_statfs(&cache_path, &stats);
 	if (ret < 0)
 		goto error_unsupported;
 
@@ -229,7 +238,12 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 
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
 
@@ -242,11 +256,11 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	dput(cache->graveyard);
 	cache->graveyard = NULL;
 error_unsupported:
-	mntput(cache->mnt);
+	path_put(&path);
+	kern_unmount(cache->mnt);
 	cache->mnt = NULL;
 	dput(fsdef->dentry);
 	fsdef->dentry = NULL;
-	dput(root);
 error_open_root:
 	kmem_cache_free(cachefiles_object_jar, fsdef);
 error_root_object:
@@ -270,7 +284,7 @@ void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 	}
 
 	dput(cache->graveyard);
-	mntput(cache->mnt);
+	kern_unmount(cache->mnt);
 
 	kfree(cache->rootdirname);
 	kfree(cache->secctx);
-- 
2.27.0

