Return-Path: <linux-fsdevel+bounces-58308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E684DB2C6D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA127B9596
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ACD273D67;
	Tue, 19 Aug 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyWff3P3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F63261B83;
	Tue, 19 Aug 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613116; cv=none; b=VUrxPmR61MsuOdW0uRROeZ0cySnE++FcKuoxvLi4wFEHoQENqU/f0yHHQB3g5uNKFwUXdHyH/7T3UsscnTL4TPmkpfHMjobiDSDgFt8eH2WBgRbX44/HRVO3uHv8B25hiPwToEyEWQTy9W+hzn65w8gPBSHd+OCJoTkU1dJtcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613116; c=relaxed/simple;
	bh=mtm5HbCBd3FqFCroYpzH2HpC/bYgiBxPSPJwcCzl1Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2IXhxuAWV9hPpnirB6+Iml9EehiEEVP1Fygho7kTGDoEBJcu4AomPMi11+ijEnbUjxfGPVJGKu9jdHOO936wl+tYC2kczFYVEIIxKvBOlI9zJeO6w1OJfJqCGqDlYgFB6rsYIxh+EgWEyO+Ohfzk6uPEkjipUa1e8erH/s7aFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyWff3P3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89FDC113CF;
	Tue, 19 Aug 2025 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613116;
	bh=mtm5HbCBd3FqFCroYpzH2HpC/bYgiBxPSPJwcCzl1Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyWff3P3C2+K8c1WfVlk2xebTiCMaxA3T+Txb6GXdeJDNNijHjxPAEbJEKSvBasCG
	 nn+EkifpVtMyDNvEsGUvKhXRQmqZ0qcYKkNKoe9ey3N9WKellHb1HRNta7dU189IBS
	 ueXNHsSyP9zmU8wzR4DGmFcK4HWLT5g/mdAJjifnYhq5vswD6qApmN8bHFAqF8/HU+
	 zQ1RCtfI/cV/9hNBaF6lrYQ4QOYAs8P3Yxrt04I5x+WR1RUYZFpK8lcHLbcdGcmIET
	 AzQSH3xYUh3waNyF4nOQj3MVgGusduyr3sm0btCTpEAcEqKKRWqDyf/uQQSj34YFpV
	 WFcg1W/XvfYLw==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 3/3] NFS: Enable use of the RWF_DONTCACHE flag on the NFS client
Date: Tue, 19 Aug 2025 07:18:32 -0700
Message-ID: <4eaf9697341fc5970f27e2f8eb3d9c94d2c05d03.1755612705.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755612705.git.trond.myklebust@hammerspace.com>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com>
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
index 86e36c630f09..90610629862a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -329,6 +329,8 @@ static bool nfs_want_read_modify_write(struct file *file, struct folio *folio,
 
 	if (pnfs_ld_read_whole_page(file_inode(file)))
 		return true;
+	if (folio_test_dropbehind(folio))
+		return false;
 	/* Open for reading too? */
 	if (file->f_mode & FMODE_READ)
 		return true;
@@ -348,7 +350,6 @@ static int nfs_write_begin(const struct kiocb *iocb,
 			   loff_t pos, unsigned len, struct folio **foliop,
 			   void **fsdata)
 {
-	fgf_t fgp = FGP_WRITEBEGIN;
 	struct folio *folio;
 	struct file *file = iocb->ki_filp;
 	int once_thru = 0;
@@ -357,10 +358,8 @@ static int nfs_write_begin(const struct kiocb *iocb,
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
@@ -372,6 +371,7 @@ static int nfs_write_begin(const struct kiocb *iocb,
 	} else if (!once_thru &&
 		   nfs_want_read_modify_write(file, folio, pos, len)) {
 		once_thru = 1;
+		folio_clear_dropbehind(folio);
 		ret = nfs_read_folio(file, folio);
 		folio_put(folio);
 		if (!ret)
@@ -915,5 +915,6 @@ const struct file_operations nfs_file_operations = {
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
index 8b7c04737967..079fc1af928f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -338,7 +338,7 @@ static void nfs_folio_end_writeback(struct folio *folio)
 {
 	struct nfs_server *nfss = NFS_SERVER(folio->mapping->host);
 
-	folio_end_writeback(folio);
+	folio_end_writeback_no_dropbehind(folio);
 	if (atomic_long_dec_return(&nfss->writeback) <
 	    NFS_CONGESTION_OFF_THRESH) {
 		nfss->write_congested = 0;
@@ -787,6 +787,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
 		}
 		spin_unlock(&mapping->i_private_lock);
+
+		folio_end_dropbehind(folio);
 	}
 	nfs_page_group_unlock(req);
 
-- 
2.50.1


