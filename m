Return-Path: <linux-fsdevel+bounces-41953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82328A3933D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA03616F986
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD2B1CD215;
	Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X0ySKVfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9E1B3922
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857932; cv=none; b=jlJksUZpjkWtls3zvtSm4tg16gdQzqJBYgtFpjP3dXvykMgebN1AazFDbIm2SwwzYFpNKzKHPu0/yUXn5R/NyHN3myQkbOZAkknAWpMx1MJ1tr0ClKGy5M4u+iyHcnbfBmALrJzj1IENoOc7fB5Oo25kl2dUdaQiYyFWHcxu0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857932; c=relaxed/simple;
	bh=7yArhLXg/cB0mkCxxv1Qykn2L4Q0d+OZ7RCwaQrE4FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjdjhHXXFdtIENJ5lSienth1SyJVnZJhdktKJ0z1bNcm78wCsNxuk5smcVEac4JN1g0BXHOACE3PlacltScaR16iODMPcWzs1sU/LHJHCSBdhmRI+ouVOlDFfQta3lm7NRciLmENLDvu/oHP47eb9UR5k+5dYKe+Os7f1gWSQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X0ySKVfv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+DXT/7jgKhUnDWqt8Mtbn1jWwn4NhU9BvgnRZLnP7oI=; b=X0ySKVfv41IZznMQtusWy7gBIZ
	wpoe37tHDKtafHvjPDLFSbzN+kgAtnt1DnRjeDMXNnMWLOI1g7/ZLgRkuayEhuu659MYURymOmoaF
	0r95q15LolTymW7dgBW+jHPw3FJSB2QwI4PpF6SRNMmH71YpQGhnVZ+lEAjkUveVynKBzvlAiWuKL
	WiyeZK7vYmFzvRzK2QKWbieHg4gQ1aHLvH9ZbqANfn3B1CzH9FPO7tQYVdevLbn1tORTFjqPAsL0A
	0len7Lgj/GvMOPK98pi2WHsFz2TyAk2TmvFbN30S6H4TDOSwSbEQWqY0fMLPM9ujeCc3d/6eU/yXO
	CwWQGsww==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWd-00000002Tsg-2p0c;
	Tue, 18 Feb 2025 05:52:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/27] f2fs: Convert f2fs_in_warm_node_list() to take a folio
Date: Tue, 18 Feb 2025 05:51:50 +0000
Message-ID: <20250218055203.591403-17-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All its callers now have access to a folio, so pass it in.  Removes
an access to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c    | 2 +-
 fs/f2fs/f2fs.h    | 3 ++-
 fs/f2fs/node.c    | 8 ++++----
 fs/f2fs/segment.c | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5ec4395ef06d..d297e9ae6391 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -358,7 +358,7 @@ static void f2fs_write_end_io(struct bio *bio)
 				folio->index != nid_of_node(&folio->page));
 
 		dec_page_count(sbi, type);
-		if (f2fs_in_warm_node_list(sbi, &folio->page))
+		if (f2fs_in_warm_node_list(sbi, folio))
 			f2fs_del_fsync_node_entry(sbi, &folio->page);
 		clear_page_private_gcing(&folio->page);
 		folio_end_writeback(folio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a941a0750712..bbaa61da83a8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3667,7 +3667,8 @@ struct node_info;
 
 int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid);
 bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type);
-bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct page *page);
+bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi,
+		const struct folio *folio);
 void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi);
 void f2fs_del_fsync_node_entry(struct f2fs_sb_info *sbi, struct page *page);
 void f2fs_reset_fsync_node_info(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index db97624e30b3..da28e295c701 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -310,10 +310,10 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
 							start, nr);
 }
 
-bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct page *page)
+bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, const struct folio *folio)
 {
-	return NODE_MAPPING(sbi) == page->mapping &&
-			IS_DNODE(page) && is_cold_node(page);
+	return NODE_MAPPING(sbi) == folio->mapping &&
+			IS_DNODE(&folio->page) && is_cold_node(&folio->page);
 }
 
 void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi)
@@ -1694,7 +1694,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
 	/* should add to global list before clearing PAGECACHE status */
-	if (f2fs_in_warm_node_list(sbi, page)) {
+	if (f2fs_in_warm_node_list(sbi, folio)) {
 		seq = f2fs_add_fsync_node_entry(sbi, page);
 		if (seq_id)
 			*seq_id = seq;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 088b4ad81771..0c5fdb58ade3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3916,7 +3916,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		if (fscrypt_inode_uses_fs_layer_crypto(folio->mapping->host))
 			fscrypt_finalize_bounce_page(&fio->encrypted_page);
 		folio_end_writeback(folio);
-		if (f2fs_in_warm_node_list(fio->sbi, fio->page))
+		if (f2fs_in_warm_node_list(fio->sbi, folio))
 			f2fs_del_fsync_node_entry(fio->sbi, fio->page);
 		goto out;
 	}
-- 
2.47.2


