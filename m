Return-Path: <linux-fsdevel+bounces-72700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AFDD007B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 01:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D85E23049C65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 00:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9291D88AC;
	Thu,  8 Jan 2026 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8PZwaok"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD81DDC2B;
	Thu,  8 Jan 2026 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832827; cv=none; b=FHPlhW7rlIwo/QIpWECdaS1mI9c2G2PPsujSECUgO7vv+Z4KkbC4EXqVH5n4d60NrJKJJMOEQCgmSLd98k2xPOi4fltdhiu2/ICEKe+k9wSwYjZT+gA9BJfYX+xwuZJynqxjYTB5h8aT0gYHJLtgYshWQMVFG0xaeg0p+EGg3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832827; c=relaxed/simple;
	bh=LEWc22QKDvMNiXz1wTH0K7d07On2oTZ0Cp/WKQzPESI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpHL3Q7EsZpcElon1SJAesZhc6ZZNVmq7jHjG40uTblC9pBGry0IcNve2W7WzOgDbri+yyg4wG+o+shlgMSAPcHnrhHf2x7aHAl1G1pxwMacsF30uBSEOC4KkuB+XEak4cq2VI8fTkQTahJsIaORTeFUmma+dj0HRv8KCBN+VCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8PZwaok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC998C2BC87;
	Thu,  8 Jan 2026 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767832826;
	bh=LEWc22QKDvMNiXz1wTH0K7d07On2oTZ0Cp/WKQzPESI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8PZwaokXe2kNwqnc2oqsOZc7/Twtsw52NOS9zbBPCS+zVyG5xHJlbZB3y8IDdBeD
	 qhFxX9/LXqqWNoVbxjXyXfcrsSL95RfkSz1uyxqSCftBey8NPbYmvYxMt5LL65KcTs
	 VhVL/yPeue9V4W1jP+bMAML/CZbhYMwBMk+u/PXbCiMOzD8tUTLCS84ElJ/oaZhN2A
	 QJG0ecH/yTTp69nXdviAEC7hoS4fN5+SRumQXYoHp1xXvySR44MGx5u5ijNmV49WKg
	 QcjWXhPeOEBMjOqciaBunnHGTWalzossoGsjUlOhgapU+qTn0611eBxYu9Hp4nTISX
	 jxGJmSgrwek+g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 6/6] nfsd: close cached files on filesystem unmount
Date: Wed,  7 Jan 2026 19:40:16 -0500
Message-ID: <20260108004016.3907158-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108004016.3907158-1-cel@kernel.org>
References: <20260108004016.3907158-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When a filesystem is unmounted while NFS is exporting it, the
unmount can fail with EBUSY even after NFSv4 state has been revoked.
This is because the nfsd_file cache can hold open NFSv2/3 file
handles that pin the filesystem, preventing the unmount from
completing.

Extend the mechanism that revokes NFSv4 state on unmount to also
close cached file handles. nfsd_file_close_sb() walks the nfsd_file
cache and disposes of entries belonging to the target superblock.
It runs after NFSv4 state revocation, so it handles only NFSv2/3
file handles that remain in the cache.

Entries still under construction (with nf_file not yet set) are
skipped; these have no open file to close.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/pin.c       |  6 ++++--
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 93798575b807..b921a9553f36 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -894,6 +894,50 @@ __nfsd_file_cache_purge(struct net *net)
 	nfsd_file_dispose_list(&dispose);
 }
 
+/**
+ * nfsd_file_close_sb - close GC-managed cached files for a superblock
+ * @sb: target superblock
+ *
+ * Walk the nfsd_file cache and close out GC-managed entries (those
+ * acquired via nfsd_file_acquire_gc) that belong to @sb. Called during
+ * filesystem unmount after NFSv4 state revocation to release remaining
+ * cached file handles that may be pinning the filesystem.
+ */
+void nfsd_file_close_sb(struct super_block *sb)
+{
+	struct rhashtable_iter iter;
+	struct nfsd_file *nf;
+	LIST_HEAD(dispose);
+
+	mutex_lock(&nfsd_mutex);
+	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 0) {
+		mutex_unlock(&nfsd_mutex);
+		return;
+	}
+
+	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
+	do {
+		rhashtable_walk_start(&iter);
+
+		nf = rhashtable_walk_next(&iter);
+		while (!IS_ERR_OR_NULL(nf)) {
+			if (test_bit(NFSD_FILE_GC, &nf->nf_flags) == 0)
+				goto next;
+			/* Skip entries under construction (nf_file not yet set) */
+			if (nf->nf_file && file_inode(nf->nf_file)->i_sb == sb)
+				nfsd_file_cond_queue(nf, &dispose);
+next:
+			nf = rhashtable_walk_next(&iter);
+		}
+
+		rhashtable_walk_stop(&iter);
+	} while (nf == ERR_PTR(-EAGAIN));
+	rhashtable_walk_exit(&iter);
+	mutex_unlock(&nfsd_mutex);
+
+	nfsd_file_dispose_list(&dispose);
+}
+
 static struct nfsd_fcache_disposal *
 nfsd_alloc_fcache_disposal(void)
 {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index b383dbc5b921..66ca7fc6189b 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -70,6 +70,7 @@ struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
+void nfsd_file_close_sb(struct super_block *sb);
 void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
diff --git a/fs/nfsd/pin.c b/fs/nfsd/pin.c
index eefa4baff82c..a404611c20a0 100644
--- a/fs/nfsd/pin.c
+++ b/fs/nfsd/pin.c
@@ -19,6 +19,7 @@
 #include "nfsd.h"
 #include "netns.h"
 #include "state.h"
+#include "filecache.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_PROC
 
@@ -49,8 +50,8 @@ static void nfsd_fs_pin_free_rcu(struct rcu_head *rcu)
 
 /*
  * Work function for nfsd_fs_pin - runs in process context.
- * Cancels async COPYs, releases NLM locks, and revokes NFSv4 state for
- * the superblock.
+ * Cancels async COPYs, releases NLM locks, revokes NFSv4 state, and closes
+ * cached NFSv2/3 files for the superblock.
  */
 static void nfsd_fs_pin_work(struct work_struct *work)
 {
@@ -63,6 +64,7 @@ static void nfsd_fs_pin_work(struct work_struct *work)
 	/* Errors are logged by lockd; no recovery is possible. */
 	(void)nlmsvc_unlock_all_by_sb(p->sb);
 	nfsd4_revoke_states(nn, p->sb);
+	nfsd_file_close_sb(p->sb);
 
 	pr_info("nfsd: state revocation for %s complete\n", p->sb->s_id);
 
-- 
2.52.0


