Return-Path: <linux-fsdevel+bounces-60727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9147B50A8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 03:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1AE56375B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 01:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC173226CFC;
	Wed, 10 Sep 2025 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm38kS5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844A1FAC42
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469229; cv=none; b=WbG2D/EJVtkvKgqQSLO3BifUy1lnxFO7HFWzyfivwCQI3G0MP7EBdPgpu/WPy/nWbJly4gx9R8xih0kqjJHRzO8PKUiUVtKNT6T1ORt07Z4YJfyTeffL9rE8wtRL5ccKW/bmS9vbHm/7dRCO+ht75eb7OLW1dxOZRhui79ZDBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469229; c=relaxed/simple;
	bh=pZauyM11CntK8pSkJ8QNRjawZGUOvqDKEEB4FGp7yt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZykBBG6fZmcRVsw/Ic+LgkwA2QO1l4xA7EQrX3JpUrAbsamG7VvlFHP8jRgrN+fAJhKaJbk/LiWc13Eya8u6/uONMQfy5qbhYTQ9JhK9a8djQbyY/oMaogMI6IVq4ia54MXEsEozpSrMj00Z7JTwLpqPD7dHekcpJmW6AjJacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm38kS5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AD5C4CEFA;
	Wed, 10 Sep 2025 01:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757469227;
	bh=pZauyM11CntK8pSkJ8QNRjawZGUOvqDKEEB4FGp7yt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qm38kS5CEu7WlWy48Av+PhBhR8rQluIolDr6OIpi1OqR0lyipqVuBuDP+V0EKeVxj
	 Ln+F53CpxcKikwobc9G8FBsBEQGGZrSZHKFkfLjDmyCXsXH12J8HyWy9o7MhSRR3zP
	 URLCMDRO1fNrU01b+twgFc0knMBy3gylzdXwFZpVVEew89QJlCe4u7WWf/VxXkbbXA
	 l+ihRI2TFweAA1fE7LK2ca87t4PWd5YtGBGULLuV4Zjr6W20hgMSWuJwdwU1giYj+R
	 5BIQkiEpDY5mv6Kz2Sj+i1MHGJqdIOTExtPKNun4DVTJ+whcytpFaa/TB2u50H9uLa
	 AC3tEz/nNX/7A==
From: Trond Myklebust <trondmy@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH v5 3/3] NFS: Enable use of the RWF_DONTCACHE flag on the NFS client
Date: Tue,  9 Sep 2025 21:53:44 -0400
Message-ID: <3c81beb1e2ee8e56a86f0de4598507c8465613fa.1757177140.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757177140.git.trond.myklebust@hammerspace.com>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com> <cover.1757177140.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The NFS client needs to defer dropbehind until after any writes to the
folio have been persisted on the server. Since this may be a 2 step
process, use folio_end_writeback_no_dropbehind() to allow release of the
writeback flag, and then call folio_end_dropbehind() once the COMMIT is
done.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c     | 9 +++++----
 fs/nfs/nfs4file.c | 1 +
 fs/nfs/write.c    | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8059ece82468..9025c93bcaf1 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -361,6 +361,8 @@ static bool nfs_want_read_modify_write(struct file *file, struct folio *folio,
 
 	if (pnfs_ld_read_whole_page(file_inode(file)))
 		return true;
+	if (folio_test_dropbehind(folio))
+		return false;
 	/* Open for reading too? */
 	if (file->f_mode & FMODE_READ)
 		return true;
@@ -380,7 +382,6 @@ static int nfs_write_begin(const struct kiocb *iocb,
 			   loff_t pos, unsigned len, struct folio **foliop,
 			   void **fsdata)
 {
-	fgf_t fgp = FGP_WRITEBEGIN;
 	struct folio *folio;
 	struct file *file = iocb->ki_filp;
 	int once_thru = 0;
@@ -390,10 +391,8 @@ static int nfs_write_begin(const struct kiocb *iocb,
 		file, mapping->host->i_ino, len, (long long) pos);
 	nfs_truncate_last_folio(mapping, i_size_read(mapping->host), pos);
 
-	fgp |= fgf_set_order(len);
 start:
-	folio = __filemap_get_folio(mapping, pos >> PAGE_SHIFT, fgp,
-				    mapping_gfp_mask(mapping));
+	folio = write_begin_get_folio(iocb, mapping, pos >> PAGE_SHIFT, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 	*foliop = folio;
@@ -405,6 +404,7 @@ static int nfs_write_begin(const struct kiocb *iocb,
 	} else if (!once_thru &&
 		   nfs_want_read_modify_write(file, folio, pos, len)) {
 		once_thru = 1;
+		folio_clear_dropbehind(folio);
 		ret = nfs_read_folio(file, folio);
 		folio_put(folio);
 		if (!ret)
@@ -949,5 +949,6 @@ const struct file_operations nfs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= simple_nosetlease,
+	.fop_flags	= FOP_DONTCACHE,
 };
 EXPORT_SYMBOL_GPL(nfs_file_operations);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index c9a0d1e420c6..7f43e890d356 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -456,4 +456,5 @@ const struct file_operations nfs4_file_operations = {
 #else
 	.llseek		= nfs_file_llseek,
 #endif
+	.fop_flags	= FOP_DONTCACHE,
 };
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 647c53d1418a..a671de3dda07 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -296,7 +296,7 @@ static void nfs_folio_end_writeback(struct folio *folio)
 {
 	struct nfs_server *nfss = NFS_SERVER(folio->mapping->host);
 
-	folio_end_writeback(folio);
+	folio_end_writeback_no_dropbehind(folio);
 	if (atomic_long_dec_return(&nfss->writeback) <
 	    NFS_CONGESTION_OFF_THRESH) {
 		nfss->write_congested = 0;
@@ -745,6 +745,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
 		}
 		spin_unlock(&mapping->i_private_lock);
+
+		folio_end_dropbehind(folio);
 	}
 	nfs_page_group_unlock(req);
 
-- 
2.51.0


