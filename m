Return-Path: <linux-fsdevel+bounces-51196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB2AD4439
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF613A5C0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC726773C;
	Tue, 10 Jun 2025 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+DWX38E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C254685;
	Tue, 10 Jun 2025 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589061; cv=none; b=FqH91zEgDUfEq9E57yrTZN6UgmBhyhleRuNJCJD85+wGFGfxeKnm4O9IxUc6xBrW9Rq5zMpDoktaSpSSxUOWGb8GT/lcYyPW+MZpz5Ipseu0Ue3pcEvOcyiJyvCtB4GV01YRybAJzseLqzHT7Y2oDlqfog9D3WohlbCub0x0kSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589061; c=relaxed/simple;
	bh=+APwfZfaW7Qr1G1/a5vOatWQidolYhJf4lpzJfZSris=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPlXRWwqz0h22uxIWBZs+vinPkW2iSgfUKG63ftByC0ZYamyRySvDpRPSkwxb9GcQiIy6s17aS9+Gbc+oQCjX5sRieCYmAfPCB5ymSuDMYRttiNchlPu3xi0UUDw9vDiv544VzkZutiMBEbXveuGdMgzTcMwMDOls7iFUdbsE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+DWX38E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118A2C4CEF0;
	Tue, 10 Jun 2025 20:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589061;
	bh=+APwfZfaW7Qr1G1/a5vOatWQidolYhJf4lpzJfZSris=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+DWX38E53ZK4GnVkDYCJeV/6Z0RhJq7p2GhZU52CBSEyD7+aAAznSWKg6mxA5BXH
	 REftVSkaZlP1A+nnnVsWAqGWELT9uzhMvEtVT6v1+cspj+IXJqmhqZxq3ArMghBD8e
	 71h0u3hJ11qHmUjXGt/m6Uh83ZZfL9UoWwXt+eQUkddOrddopPgRT49FYOcLNRQ6vR
	 CV2hgVwt5LA26nGoRYlMAJ/7eAcigR5YZyMIQpvldebZ9dj5ERada23vRms+gaSHVz
	 J8DLjIp5UnHVpv5bh4J0ryHPULuU+JiztcTqY3XB7eJo4pyxA6piiajbXYFJgAu19G
	 F+Lq6C+uYLkXQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
Date: Tue, 10 Jun 2025 16:57:33 -0400
Message-ID: <20250610205737.63343-3-snitzer@kernel.org>
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

Use STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store DIO
alignment attributes from underlying filesystem in associated
nfsd_file.  This is done when the nfsd_file is first opened for
a regular file.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/filecache.c | 32 ++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h |  4 ++++
 fs/nfsd/vfs.c       | 17 +++++++++++++++++
 fs/nfsd/vfs.h       | 15 ++-------------
 4 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 0acad9c35b3f..01598e7b0071 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -231,6 +231,9 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 	refcount_set(&nf->nf_ref, 1);
 	nf->nf_may = need;
 	nf->nf_mark = NULL;
+	nf->nf_dio_mem_align = 0;
+	nf->nf_dio_offset_align = 0;
+	nf->nf_dio_read_offset_align = 0;
 	return nf;
 }
 
@@ -1069,6 +1072,33 @@ nfsd_file_is_cached(struct inode *inode)
 	return ret;
 }
 
+static __be32
+nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
+{
+	struct inode *inode = file_inode(nf->nf_file);
+	struct kstat stat;
+	__be32 status;
+
+	/* Currently only need to get DIO alignment info for regular files */
+	if (!S_ISREG(inode->i_mode))
+		return nfs_ok;
+
+	status = fh_getattr(fhp, &stat);
+	if (status != nfs_ok)
+		return status;
+
+	if (stat.result_mask & STATX_DIOALIGN) {
+		nf->nf_dio_mem_align = stat.dio_mem_align;
+		nf->nf_dio_offset_align = stat.dio_offset_align;
+	}
+	if (stat.result_mask & STATX_DIO_READ_ALIGN)
+		nf->nf_dio_read_offset_align = stat.dio_read_offset_align;
+	else
+		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
+
+	return status;
+}
+
 static __be32
 nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 		     struct svc_cred *cred,
@@ -1187,6 +1217,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 			}
 			status = nfserrno(ret);
 			trace_nfsd_file_open(nf, status);
+			if (status == nfs_ok)
+				status = nfsd_file_getattr(fhp, nf);
 		}
 	} else
 		status = nfserr_jukebox;
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 722b26c71e45..237a05c74211 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -54,6 +54,10 @@ struct nfsd_file {
 	struct list_head	nf_gc;
 	struct rcu_head		nf_rcu;
 	ktime_t			nf_birthtime;
+
+	u32			nf_dio_mem_align;
+	u32			nf_dio_offset_align;
+	u32			nf_dio_read_offset_align;
 };
 
 int nfsd_file_cache_init(void);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index bba3e6f4f56b..8dccbb4d78f9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2672,3 +2672,20 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+__be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
+{
+	u32 request_mask = STATX_BASIC_STATS;
+	struct path p = {.mnt = fh->fh_export->ex_path.mnt,
+			 .dentry = fh->fh_dentry};
+	struct inode *inode = d_inode(p.dentry);
+
+	if (nfsd_enable_dontcache && S_ISREG(inode->i_mode))
+		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
+
+	if (fh->fh_maxsize == NFS4_FHSIZE)
+		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
+
+	return nfserrno(vfs_getattr(&p, stat, request_mask,
+				    AT_STATX_SYNC_AS_STAT));
+}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index eff04959606f..e3de3a295704 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -160,6 +160,8 @@ __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 void		nfsd_filp_close(struct file *fp);
 
+__be32          fh_getattr(const struct svc_fh *fh, struct kstat *stat);
+
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
@@ -180,17 +182,4 @@ static inline void fh_drop_write(struct svc_fh *fh)
 	}
 }
 
-static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
-{
-	u32 request_mask = STATX_BASIC_STATS;
-	struct path p = {.mnt = fh->fh_export->ex_path.mnt,
-			 .dentry = fh->fh_dentry};
-
-	if (fh->fh_maxsize == NFS4_FHSIZE)
-		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
-
-	return nfserrno(vfs_getattr(&p, stat, request_mask,
-				    AT_STATX_SYNC_AS_STAT));
-}
-
 #endif /* LINUX_NFSD_VFS_H */
-- 
2.44.0


