Return-Path: <linux-fsdevel+bounces-51195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B7CAD4437
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D64B1892F5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD90267709;
	Tue, 10 Jun 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYAvYXzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3A2673B0;
	Tue, 10 Jun 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589060; cv=none; b=F073qlw2t4S/R6tQvslZcDUoww/nNTdcjHpssDWOROIPqgjAqGgjTbPNbKfZKEqo1Vw6eO/+bW2NLX5AZOTNwvImhz33HX7PnMZt0nvDJ3JzB+8rWITaJ/w6oachkg+LfGkBDehI3Y5U0tPKQmEBFfA/lhiAN0zeSercwRZCkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589060; c=relaxed/simple;
	bh=ha/q8D75YU4sKsRE/pnPzaX2dxT+lzfZ2QDnI+JwVtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ip7r6RSfo+pL0KghcvVMIJSRmbOQjodRrqJf/pf79ACHxwcZjHTre7rfTjbXB3WilVfWXejWnQaryw4onJdUGC6cRgzDp8MI1Drmkkje6jVQaesu6E7WgBr5DlFdYJzdCtefUDdUJCfKm97esd5N2zbP8vNhWPTdCndmSN+bBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYAvYXzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD75C4CEED;
	Tue, 10 Jun 2025 20:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589059;
	bh=ha/q8D75YU4sKsRE/pnPzaX2dxT+lzfZ2QDnI+JwVtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYAvYXzOM9j5P9ivIiMIQYfI+3KZ45zPss7gF+QoURWU/x3sGfJsunO9pQ7lhWYyv
	 7+e2wjGYhu8nTneIkp0NUJsmI8CUlW3OqJckQathwI5TmSkmSRKFBh6qHGNMGlhfDQ
	 HVl7pbgFzN5jjSSm1sCgfpU/KPqZej477vT3GR6erJ1am0qze8deoJQ6y3jmh7477Z
	 dL42x9VotR28nbm2HuDyGgqAHLVx7W6gjCDH+WGJ8yXgHbhJfHtC+OyfbXn8E2deQE
	 p6LcfO+CNa/dSuOtqohEch7a+FF8D5Zu5yJ2O4XsEWGbklSEXDjimHYWzqsDbbP/fA
	 yacCw61jMraIQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO
Date: Tue, 10 Jun 2025 16:57:32 -0400
Message-ID: <20250610205737.63343-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250610205737.63343-1-snitzer@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
read or written by NFSD will either not be cached (thanks to O_DIRECT)
or will be removed from the page cache upon completion (DONTCACHE).

enable-dontcache is 0 by default.  It may be enabled with:
  echo 1 > /sys/kernel/debug/nfsd/enable-dontcache

FOP_DONTCACHE must be advertised as supported by the underlying
filesystem (e.g. XFS), otherwise if/when 'enable-dontcache' is 1
all IO flagged with RWF_DONTCACHE will fail with -EOPNOTSUPP.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/debugfs.c | 39 +++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  1 +
 fs/nfsd/vfs.c     | 12 +++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 84b0c8b559dc..8decdec60a8e 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -32,6 +32,42 @@ static int nfsd_dsr_set(void *data, u64 val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
 
+/*
+ * /sys/kernel/debug/nfsd/enable-dontcache
+ *
+ * Contents:
+ *   %0: NFS READ and WRITE are not allowed to use dontcache
+ *   %1: NFS READ and WRITE are allowed to use dontcache
+ *
+ * NFSD's dontcache support reserves the right to use O_DIRECT
+ * if it chooses (instead of dontcache's usual pagecache-based
+ * dropbehind semantics).
+ *
+ * The default value of this setting is zero (dontcache is
+ * disabled). This setting takes immediate effect for all NFS
+ * versions, all exports, and in all NFSD net namespaces.
+ */
+
+static int nfsd_dontcache_get(void *data, u64 *val)
+{
+	*val = nfsd_enable_dontcache ? 1 : 0;
+	return 0;
+}
+
+static int nfsd_dontcache_set(void *data, u64 val)
+{
+	if (val > 0) {
+		/* Must first also disable-splice-read */
+		nfsd_disable_splice_read = true;
+		nfsd_enable_dontcache = true;
+	} else
+		nfsd_enable_dontcache = false;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dontcache_fops, nfsd_dontcache_get,
+			 nfsd_dontcache_set, "%llu\n");
+
 void nfsd_debugfs_exit(void)
 {
 	debugfs_remove_recursive(nfsd_top_dir);
@@ -44,4 +80,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
 			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
+
+	debugfs_create_file("enable-dontcache", S_IWUSR | S_IRUGO,
+			    nfsd_top_dir, NULL, &nfsd_dontcache_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1bfd0b4e9af7..00546547eae6 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -155,6 +155,7 @@ static inline void nfsd_debugfs_exit(void) {}
 #endif
 
 extern bool nfsd_disable_splice_read __read_mostly;
+extern bool nfsd_enable_dontcache __read_mostly;
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7d94fae1dee8..bba3e6f4f56b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,7 @@
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
 bool nfsd_disable_splice_read __read_mostly;
+bool nfsd_enable_dontcache __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1086,6 +1087,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned long v, total;
 	struct iov_iter iter;
 	loff_t ppos = offset;
+	rwf_t flags = 0;
 	ssize_t host_err;
 	size_t len;
 
@@ -1103,7 +1105,11 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
-	host_err = vfs_iter_read(file, &iter, &ppos, 0);
+
+	if (nfsd_enable_dontcache)
+		flags |= RWF_DONTCACHE;
+
+	host_err = vfs_iter_read(file, &iter, &ppos, flags);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
@@ -1209,6 +1215,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+
+	if (nfsd_enable_dontcache)
+		flags |= RWF_DONTCACHE;
+
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
-- 
2.44.0


