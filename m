Return-Path: <linux-fsdevel+bounces-41958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3A7A39344
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08093B38BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B9E1D4335;
	Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UE29ImrU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA91B87D7
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857932; cv=none; b=C09G2vcd3+BZ97lASAf9XNyQaUJXKFUmvis7Wzx+vPM72dn5DjRio3Xzpnobo2zC1FK6mMykuOH+KKKdo85wcvPufD1VQvF7/MrgkGIwxmM5DAGI1vL3TIp15qI5mWfxt82uffvvuaOgds51IX7EB4MsxRAbj5uLId5qmPNIxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857932; c=relaxed/simple;
	bh=F/QF5u7fBXwQLvBCrcvdaiaEyWwU6V5R+CtmomCS0bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0tVbaDpdNz2oIvcY8hgGU9JW9E0mchOGppuFotaYS2g1k0Zd96vBn6wV8j0KYOwmBaEwWJS6oZbQ7qIZhdoyF5jLqb/gY5PHt5c/dix0srFTqBECEnq0KParA67PwYrqnShG/RmRv1Y4VGTtKqTIS2rxf3OJori7EYMpIyUV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UE29ImrU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=7OWCqEQSuyW3YDJH4zlFbHrnNTVKwf50bge0kn69gbA=; b=UE29ImrUER/K1iaAUcim3GyRZV
	RHPVNjrcNdCWjod5wi/ZCG5TvP5uNBu6cXISITlHBRO2HAy9Da3T2tpWKPEGbJIP4lMlUtYg5HSlp
	e3N6ZIs3PDDup+Myl7DOHjSxRcbpbAfrauMmMHo32Vn7uqqm4gn3qUCVxJzGE5WuI/qe1B6c1zojg
	AFvuhzGa0xsdXPeO0lSYok0MmCVoW7ydYc9kdRddzeEfEURIgvEcCXSaHSBoNzvB1KuFGAxmp4VeY
	czD9LgTZxlqaF/pcgfigcdukF2o5fUjCCz7Ld2VTWceXhi2Eh9PZdYG72WM+ZKqkPRH4i8sh7jZn0
	3vHNh99Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWf-00000002Ttl-08jb;
	Tue, 18 Feb 2025 05:52:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 25/27] f2fs: Convert gc_data_segment() to use a folio
Date: Tue, 18 Feb 2025 05:51:59 +0000
Message-ID: <20250218055203.591403-26-willy@infradead.org>
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

Use f2fs_get_read_data_folio() instead of f2fs_get_read_data_page().
Saves a hidden call to compound_head() in f2fs_put_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/gc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d0fffa2bd9f0..2b8f9239bede 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1542,7 +1542,6 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	entry = sum;
 
 	for (off = 0; off < usable_blks_in_seg; off++, entry++) {
-		struct page *data_page;
 		struct inode *inode;
 		struct node_info dni; /* dnode info for the data */
 		unsigned int ofs_in_node, nofs;
@@ -1585,6 +1584,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		ofs_in_node = le16_to_cpu(entry->ofs_in_node);
 
 		if (phase == 3) {
+			struct folio *data_folio;
 			int err;
 
 			inode = f2fs_iget(sb, dni.ino);
@@ -1635,15 +1635,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				continue;
 			}
 
-			data_page = f2fs_get_read_data_page(inode, start_bidx,
+			data_folio = f2fs_get_read_data_folio(inode, start_bidx,
 							REQ_RAHEAD, true, NULL);
 			f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			if (IS_ERR(data_page)) {
+			if (IS_ERR(data_folio)) {
 				iput(inode);
 				continue;
 			}
 
-			f2fs_put_page(data_page, 0);
+			f2fs_folio_put(data_folio, false);
 			add_gc_inode(gc_list, inode);
 			continue;
 		}
-- 
2.47.2


