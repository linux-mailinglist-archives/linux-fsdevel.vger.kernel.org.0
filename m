Return-Path: <linux-fsdevel+bounces-78288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHf4EH3XnWmFSQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:53:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D67EA18A1BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C049C3064BC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8783AE71A;
	Tue, 24 Feb 2026 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqHZPIvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0013A0EAA;
	Tue, 24 Feb 2026 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951154; cv=none; b=dENJ0C9yPt0z/Fe4RM1mxlThGj7jNXGbrDpRnONcW7K19StkXZ0onoh1XHKNKNV6qQlnXaqhUhYtENuRht8PaukXN0D6Ilsl8t2+5Z0SIvEZhmxByABG3XXIhjUun237CTDqnWNzktXvFJ9a0YRDjXZnjoV6FlyL48qz5nyIDZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951154; c=relaxed/simple;
	bh=SRXw5r0DNxoiGNo85P/BdKmiW9+p6kKaZFM13ivQvbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lg6Nm5I2gnV638kHRtBT/P0fJq1vzS2wPrzrlDlhGHt+wM+51eNySbL9tcvt1MWWRKg7uqVl+xbV/XB4kA3SZ1vlA1K6cPqnHakVeTxVucHsBfkH+WozKOQKTZbmjg5bO9Slpbu+7msN6F6uIGrjVV+PA3XXu/RkpHKkehPmrQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqHZPIvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928C3C19423;
	Tue, 24 Feb 2026 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771951154;
	bh=SRXw5r0DNxoiGNo85P/BdKmiW9+p6kKaZFM13ivQvbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqHZPIvkPZfHEKr1XV7omAH/GodtqeUl0sttNOYCbvWDHnDYqQQXZfoI9n+cDNx2R
	 oLQO9poDJNOOmAz5TMv4nC9Ufkt+h0SaJqsF4vZlWXH6tw2bm5KF9zRODR/za88Nvx
	 2T+Jf0x6IjV9oC+00LsBdPJZJLUXZOPjL1oY+sT9JTsf4+RGU3oE0VUinN1h6oUvJu
	 l7i0WdjIIFYQgwJJdJFY63ZkpTktv/vSHFXNVhGGODK5wI9WkocdZYMd6A7FJL5QuG
	 +9y6qkNSOvUhYXhSl398mybFYy6CfVWfg5bqYhlYswyyUOyeG5ASe+jIT+0HH+255K
	 4/cfnS1WuRIQA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 3/3] nfsd: close cached files on filesystem unmount
Date: Tue, 24 Feb 2026 11:39:08 -0500
Message-ID: <20260224163908.44060-4-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224163908.44060-1-cel@kernel.org>
References: <20260224163908.44060-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78288-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: D67EA18A1BB
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

When a filesystem is unmounted while NFS is exporting it, the
unmount can fail with EBUSY even after NFSv4 state has been revoked.
This occurs because the nfsd_file cache holds open NFSv2/3 file
handles that pin the filesystem.

Extend the mechanism that revokes NFSv4 state on unmount to also
close cached file handles. nfsd_file_close_sb() walks the nfsd_file
cache and disposes of entries belonging to the target superblock.
It runs after NFSv4 state revocation, handling NFSv2/3 file handles
that remain in the cache.

Entries under construction (nf_file not yet set) are skipped; these
have no open file to close.

The hashtable walk releases the mutex periodically to avoid blocking
other NFSD operations during large cache walks. Entries are disposed
incrementally in batches, keeping memory usage bounded and spreading
the I/O load.

A log message is emitted when cached file handles are closed during
unmount, informing administrators that NFS clients may receive stale
file handle errors.

A flush_workqueue() call is added to nfsd_sb_watch_shutdown() to
ensure that any work items still executing complete before shutdown
proceeds. Without this, if an unmount notification returns early
due to signal interruption while the work function is still running,
nfsd_file_cache_shutdown() could destroy the file cache slab while
nfsd_file_close_sb() is still disposing entries.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/sb_watch.c  | 10 ++++++++++
 3 files changed, 56 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1e2b38ed1d35..d1a6f7cf40b2 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -894,6 +894,51 @@ __nfsd_file_cache_purge(struct net *net)
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
+	unsigned int closed = 0;
+	LIST_HEAD(dispose);
+
+	if (!test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
+		return;
+
+	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
+	do {
+		rhashtable_walk_start(&iter);
+
+		nf = rhashtable_walk_next(&iter);
+		while (!IS_ERR_OR_NULL(nf)) {
+			if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
+			    nf->nf_file &&
+			    file_inode(nf->nf_file)->i_sb == sb) {
+				nfsd_file_cond_queue(nf, &dispose);
+				closed++;
+			}
+			nf = rhashtable_walk_next(&iter);
+		}
+
+		rhashtable_walk_stop(&iter);
+	} while (nf == ERR_PTR(-EAGAIN));
+	rhashtable_walk_exit(&iter);
+
+	nfsd_file_dispose_list(&dispose);
+
+	if (closed)
+		pr_info("nfsd: closed %u cached file handle%s on %s\n",
+			closed, closed == 1 ? "" : "s", sb->s_id);
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
diff --git a/fs/nfsd/sb_watch.c b/fs/nfsd/sb_watch.c
index 8f711956a12e..34e50afe566c 100644
--- a/fs/nfsd/sb_watch.c
+++ b/fs/nfsd/sb_watch.c
@@ -65,6 +65,7 @@ static void nfsd_sb_revoke_work(struct work_struct *work)
 	/* Errors are logged by lockd; no recovery is possible. */
 	(void)nlmsvc_unlock_all_by_sb(watch->sb);
 	nfsd4_revoke_states(nn, watch->sb);
+	nfsd_file_close_sb(watch->sb);
 
 	pr_info("nfsd: state revocation for %s complete\n", watch->sb->s_id);
 
@@ -257,6 +258,15 @@ void nfsd_sb_watch_shutdown(struct nfsd_net *nn)
 {
 	umount_unregister_notifier(&nn->nfsd_umount_notifier);
 	nfsd_sb_watches_destroy(nn);
+	/*
+	 * Ensure any work items still running complete before shutdown
+	 * proceeds. This handles the case where an unmount notification
+	 * returned early due to signal interruption but the work function
+	 * is still executing nfsd_file_close_sb(). Without this flush,
+	 * nfsd_file_cache_shutdown() could destroy the slab while the
+	 * work function is still disposing file cache entries.
+	 */
+	flush_workqueue(nfsd_sb_watch_wq);
 }
 
 int nfsd_sb_watch_init(void)
-- 
2.53.0


