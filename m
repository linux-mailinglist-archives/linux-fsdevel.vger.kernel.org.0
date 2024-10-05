Return-Path: <linux-fsdevel+bounces-31066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A12F991925
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF40B21AF8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C051591FC;
	Sat,  5 Oct 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uTkkLliv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89DE4503C
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151347; cv=none; b=J3/zRjpWAFlsTtwW0/RHGZNvzq4LmcPJEKs5Aw+gOVG4oEj+yx075OO8FaXM32oemLvB3F+2exZW8EcfzU+inJJll2ctkGzwX2pmbkkCJM7GLDchxaLyIY6UGTcBlbEETZU+ZFfIiKbAYPRNGhfaJThxvKuVMHC8pyGBbnChxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151347; c=relaxed/simple;
	bh=Tu7UwD9PNYOt8IAlg5OZCWlTZonRsTphFhlVorigUFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6TF0ZLUaz23IC42xA+WmsZTEYc5HKRVemYtHDrkwnuNIXVvO8ysrHmsP2C+5Lx5jb/ruVPnvdE08OWaRVFPLHmQvVH96gfjaWekijTe3t9WEJU18q3OHllEBq5QWz9NwW8s0FcMZy+0j3XKvqay1xJ6yLoW07yH5kA8LzSpiWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uTkkLliv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fCirP0wIga6EITsKYr6mGFcZ2l1MjEpoNINKdhUakD4=; b=uTkkLlivVipkYHGNqb6WGR5Fh+
	xWR95nZo3ZQfJgPiSFeX68/Kg9ZAhvL3klTAboh6ABwuw6nHpwQxVEaN5JEAwiR5W+XozlkeMB4HE
	jkh4WUWQqWeSLkWXJuRKiqpkgBI6lZPQMhYIAYDGGGKE2pmodpWeKlUk5DVMRJKbL7atHGgb5Now5
	aoVxSFqH91DPU4LBCHsn8oLafSk/5XVJMEWOBTg6fKAVDLv/EP49TAMUzIQ4RMyCKiYXbCxk5Ck2Y
	xFuiM3AFe26kaYgg8hIHFQdGBOMdx7ue0BYHdnH4y9Fp5epji4zWtZfLxaEhXfXgCK3H4el86uK0O
	zDbCbiVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx96f-0000000DLlH-2Tb7;
	Sat, 05 Oct 2024 18:02:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] ufs: Convert ufs_extend_tail() to take a folio
Date: Sat,  5 Oct 2024 19:02:05 +0100
Message-ID: <20241005180214.3181728-3-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241005180214.3181728-1-willy@infradead.org>
References: <20241005180214.3181728-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass bh->b_folio instead of bh->b_page.  They're in a union, so no
code change expected.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index aad3bdd4422f..937d3b787d1e 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -220,7 +220,7 @@ static u64 ufs_frag_map(struct inode *inode, unsigned offsets[4], int depth)
  */
 static bool
 ufs_extend_tail(struct inode *inode, u64 writes_to,
-		  int *err, struct page *locked_page)
+		  int *err, struct folio *locked_folio)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -239,7 +239,7 @@ ufs_extend_tail(struct inode *inode, u64 writes_to,
 	p = ufs_get_direct_data_ptr(uspi, ufsi, block);
 	tmp = ufs_new_fragments(inode, p, lastfrag, ufs_data_ptr_to_cpu(sb, p),
 				new_size - (lastfrag & uspi->s_fpbmask), err,
-				locked_page);
+				&locked_folio->page);
 	return tmp != 0;
 }
 
@@ -433,7 +433,7 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 		unsigned tailfrags = lastfrag & uspi->s_fpbmask;
 		if (tailfrags && fragment >= lastfrag) {
 			if (!ufs_extend_tail(inode, fragment,
-					     &err, bh_result->b_page))
+					     &err, bh_result->b_folio))
 				goto out;
 		}
 	}
-- 
2.43.0


