Return-Path: <linux-fsdevel+bounces-57587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89EB23AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C61AA49E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689BC2D73A9;
	Tue, 12 Aug 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKrxnxaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A342D738D;
	Tue, 12 Aug 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034816; cv=none; b=dp4v8oYApvWbSVC+IUIS7KXO/1x/jESlewQttE7ZH5LxaZBf5zDaxHVyuRm57t8ukBZApBdYRohS87LR5Y5csHHcFvl/nuOmKMqxVo8CmEkuC9vD+HUu3aibF0BKCghxCjN1xEe5mrdnEuqQdOfjJdpfM4zIVpx+qnpsy62JmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034816; c=relaxed/simple;
	bh=8TW0eXZP92s+XC5I+VYEbzJtei48JcvXtRyPtrxqQic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMUsku/oU0Pv4utUUcFFxAcAiTm7xV8TpzsXZKpKFIL9ZbLqK+slvzwI+w3BWyMmMlssKvfJOT34n6r2zoE3GrWxlworM3gwWYxC2iM5uH12MYRz+EXrMlFcI79oMLlTxGeflanVJ/C2z/GZgTRwL6lLDoaNMlI6PSmOZs/5yQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKrxnxaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C1DC4CEF8;
	Tue, 12 Aug 2025 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755034815;
	bh=8TW0eXZP92s+XC5I+VYEbzJtei48JcvXtRyPtrxqQic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKrxnxazGoBOFlW1w70c6XEETb2O4UCgjZqea90Tw2zaQdZ13A3VJfWbbyM0sZID6
	 +1HWAX37COoRPwqwQwVkrPoAOHDb14uCqDQeSbtR8J3HO+5NTVN6DJVs1AelNmaNu+
	 TLDCPLq1jU06TAylJcwS/ZHT3J6KM9JRyqr3ifVCJnKytUz2UHeWsUtLIOkXIjJVJK
	 auCB880pGWue3qjy81NUdG1lapv7yTHr1e81Oxl0A718WCQ1qqeu52GNlGGNpptUvo
	 +uQqm7QJic2jhaCe2CWq+YdA3jdVal5HLKxFotWN9yXu5OIcPgzIEfRJMplfZBAciY
	 X+99D/LXoFFyw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 2/2] NFS: Enable the RWF_DONTCACHE flag for the NFS client
Date: Tue, 12 Aug 2025 14:40:07 -0700
Message-ID: <3100a108d35c0a79803a4ded1e93916150c350d7.1755034536.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755034536.git.trond.myklebust@hammerspace.com>
References: <cover.1755034536.git.trond.myklebust@hammerspace.com>
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
 fs/nfs/file.c            |  7 +++----
 fs/nfs/nfs4file.c        |  2 ++
 fs/nfs/write.c           | 12 +++++++++++-
 include/linux/nfs_page.h |  1 +
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 86e36c630f09..fffb536bfcdd 100644
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
@@ -915,5 +912,7 @@ const struct file_operations nfs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= simple_nosetlease,
+
+	.fop_flags	= FOP_DONTCACHE,
 };
 EXPORT_SYMBOL_GPL(nfs_file_operations);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1d6b5f4230c9..70f6887ded0e 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -454,4 +454,6 @@ const struct file_operations nfs4_file_operations = {
 #else
 	.llseek		= nfs_file_llseek,
 #endif
+
+	.fop_flags	= FOP_DONTCACHE,
 };
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index fa5c41d0989a..e6b1f69058cf 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -359,8 +359,12 @@ static void nfs_folio_end_writeback(struct folio *folio)
 static void nfs_page_end_writeback(struct nfs_page *req)
 {
 	if (nfs_page_group_sync_on_bit(req, PG_WB_END)) {
+		struct folio *folio = nfs_page_to_folio(req);
+
+		if (folio_test_clear_dropbehind(folio))
+			set_bit(PG_DROPBEHIND, &req->wb_flags);
 		nfs_unlock_request(req);
-		nfs_folio_end_writeback(nfs_page_to_folio(req));
+		nfs_folio_end_writeback(folio);
 	} else
 		nfs_unlock_request(req);
 }
@@ -797,6 +801,9 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
 		}
 		spin_unlock(&mapping->i_private_lock);
+
+		if (test_bit(PG_DROPBEHIND, &req->wb_flags))
+			folio_end_dropbehind(folio);
 	}
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
@@ -2077,6 +2084,7 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 		.range_start = range_start,
 		.range_end = range_start + len - 1,
 	};
+	bool dropbehind = folio_test_clear_dropbehind(folio);
 	int ret;
 
 	trace_nfs_writeback_folio(inode, range_start, len);
@@ -2097,6 +2105,8 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 			goto out_error;
 	}
 out_error:
+	if (dropbehind)
+		folio_set_dropbehind(folio);
 	trace_nfs_writeback_folio_done(inode, range_start, len, ret);
 	return ret;
 }
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 169b4ae30ff4..1a017b5b476f 100644
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


