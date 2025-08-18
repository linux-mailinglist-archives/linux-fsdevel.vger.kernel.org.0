Return-Path: <linux-fsdevel+bounces-58183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B62B2ABA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5364E1BA83EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F46E223DEE;
	Mon, 18 Aug 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJhGIGTP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7190D1F8722;
	Mon, 18 Aug 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527993; cv=none; b=gv+G8AV8KMAa7LISGhxQbbuPkB/rNcfGa/jzU7C3c9feXWxYMU/EvX54B4ZIrhCzin1w5X2GarHw4Se7pGbrPSy4UJjnG0nEy2k87L1Gfww8qDAWTvjtyX6bhxsotrBFNmX3s/Dwfgha4FVrBn5/7nn4yA+phHdcGpZXmIuBkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527993; c=relaxed/simple;
	bh=4q7taRm6RzFKFmS0y5//ZpjNkjV1RJyUc0pmEyDzvc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3Hzsf+EFuRhNPMo2vnwATmQ3J+BvhC4XtW0IHN/2Tmw6orpPOY92o13LAFnK5thOwhyZn9fB9zVNGU86xH5TnksXtF7egkeo3DWCbjHzYAF5gh5e4piWZySIra6gaA8qTmi3XxJDH3ZALT4htzrkHmOpMvjuBlJhMvQH4kBnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJhGIGTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1357C113D0;
	Mon, 18 Aug 2025 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755527993;
	bh=4q7taRm6RzFKFmS0y5//ZpjNkjV1RJyUc0pmEyDzvc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJhGIGTPefK6CCA/irFaOhKg5UtZ8C6EqukuNzSrxgO4H7ao0hwrAt5F2Ej//8gnE
	 TiyWNSAlnGdlCUI2lEkiN8srcOVtXyG0TcIjTOsgq3p72wfMZgwCtMxh8XfoxW62ae
	 eZtsiqw2TeCrOlhNbpmciMTO8SZviyFXKUnFvxtIQo+MQ1lFI9RLx8xpRuqqI/r3w6
	 BbNFfm8+ZoaK0BJH/PdQwkNDhZS7qHCgPuwI9jS37colau1vl0PhMhDiQd335C0MMB
	 /brPQd5k2kH5NBHQrIrwvGjBrT+K1apJrK4LCml/1YAFuArLNNq5d2HcA8xkOdHBWt
	 NTMm8C5wWJw3w==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v3 2/2] NFS: Enable the RWF_DONTCACHE flag for the NFS client
Date: Mon, 18 Aug 2025 07:39:50 -0700
Message-ID: <001e5575d7ddbcdb925626151a7dcc7353445543.1755527537.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755527537.git.trond.myklebust@hammerspace.com>
References: <cover.1755527537.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

While the NFS readahead code has no problems using the generic code to
manage the dropbehind behaviour enabled by RWF_DONTCACHE, the write code
needs to deal with the fact that NFS writeback uses a 2 step process
(UNSTABLE write followed by COMMIT).
This commit replaces the use of the folio dropbehind flag with a local
NFS request flag that triggers the dropbehind behaviour once the data
has been written to stable storage.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Link: https://lore.kernel.org/all/ec165b304a7b56d1fa4c6c2b1ad1c04d4dcbd3f6.1745381692.git.trond.myklebust@hammerspace.com/
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/file.c            |  6 ++----
 fs/nfs/nfs4file.c        |  1 +
 fs/nfs/write.c           | 20 +++++++++++++++++---
 include/linux/nfs_page.h |  1 +
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 86e36c630f09..f771bd92d61e 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -348,7 +348,6 @@ static int nfs_write_begin(const struct kiocb *iocb,
 			   loff_t pos, unsigned len, struct folio **foliop,
 			   void **fsdata)
 {
-	fgf_t fgp = FGP_WRITEBEGIN;
 	struct folio *folio;
 	struct file *file = iocb->ki_filp;
 	int once_thru = 0;
@@ -357,10 +356,8 @@ static int nfs_write_begin(const struct kiocb *iocb,
 	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
 
-	fgp |= fgf_set_order(len);
 start:
-	folio = __filemap_get_folio(mapping, pos >> PAGE_SHIFT, fgp,
-				    mapping_gfp_mask(mapping));
+	folio = write_begin_get_folio(iocb, mapping, pos >> PAGE_SHIFT, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 	*foliop = folio;
@@ -915,5 +912,6 @@ const struct file_operations nfs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= simple_nosetlease,
+	.fop_flags	= FOP_DONTCACHE,
 };
 EXPORT_SYMBOL_GPL(nfs_file_operations);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1d6b5f4230c9..654fda6f362c 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -454,4 +454,5 @@ const struct file_operations nfs4_file_operations = {
 #else
 	.llseek		= nfs_file_llseek,
 #endif
+	.fop_flags	= FOP_DONTCACHE,
 };
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8b7c04737967..f0fd5162154f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -349,8 +349,12 @@ static void nfs_folio_end_writeback(struct folio *folio)
 static void nfs_page_end_writeback(struct nfs_page *req)
 {
 	if (nfs_page_group_sync_on_bit(req, PG_WB_END)) {
+		struct folio *folio = nfs_page_to_folio(req);
+
+		if (folio_test_clear_dropbehind(folio))
+			set_bit(PG_DROPBEHIND, &req->wb_head->wb_flags);
 		nfs_unlock_request(req);
-		nfs_folio_end_writeback(nfs_page_to_folio(req));
+		nfs_folio_end_writeback(folio);
 	} else
 		nfs_unlock_request(req);
 }
@@ -787,8 +791,15 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
 		}
 		spin_unlock(&mapping->i_private_lock);
-	}
-	nfs_page_group_unlock(req);
+		nfs_page_group_unlock(req);
+
+		if (test_and_clear_bit(PG_DROPBEHIND,
+				       &req->wb_head->wb_flags)) {
+			folio_set_dropbehind(folio);
+			folio_end_dropbehind(folio);
+		}
+	} else
+		nfs_page_group_unlock(req);
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		atomic_long_dec(&nfsi->nrequests);
@@ -2068,6 +2079,7 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 		.range_start = range_start,
 		.range_end = range_start + len - 1,
 	};
+	bool dropbehind = folio_test_clear_dropbehind(folio);
 	int ret;
 
 	trace_nfs_writeback_folio(inode, range_start, len);
@@ -2088,6 +2100,8 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 			goto out_error;
 	}
 out_error:
+	if (dropbehind)
+		folio_set_dropbehind(folio);
 	trace_nfs_writeback_folio_done(inode, range_start, len, ret);
 	return ret;
 }
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 9aed39abc94b..32ab7a590098 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -37,6 +37,7 @@ enum {
 	PG_REMOVE,		/* page group sync bit in write path */
 	PG_CONTENDED1,		/* Is someone waiting for a lock? */
 	PG_CONTENDED2,		/* Is someone waiting for a lock? */
+	PG_DROPBEHIND,		/* Implement RWF_DONTCACHE */
 };
 
 struct nfs_inode;
-- 
2.50.1


