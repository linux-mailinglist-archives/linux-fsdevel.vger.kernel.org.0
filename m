Return-Path: <linux-fsdevel+bounces-23496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F335F92D59A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF092289B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5761B194AD5;
	Wed, 10 Jul 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NSDrukkx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF5194A75
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627192; cv=none; b=aQh9AM6Ly5xb7dmFtp+lgPQ2n0xGazd2fv9YcU8Qt8J0C/FC2AWxfU2yiwAbwt7BZgTX9GD9IV3dtvMAAOkD1T4qlVSPv5P45IUf3NMngypWB7r7dhV7ml2sZ0FgDjwtvxG9g/rGbqh0K9KXKM3Wdjg2dmzFj1yQL2VIuerF6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627192; c=relaxed/simple;
	bh=yqHUA7x1s5s3NCkgK/Q3LA12WJVRfQ2M8gjJKI7jnOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5mZs6r6a8aUhgFh29Ma6erS0Qd2CmT/z0ScDee8UounePcvTEMT/jrOrm+7yc9qIvnI6v5w7BS14mczoxivBBxaBVKsOwUe5Wsiz00PgFsMuo+KRzd+yZjCh+zQ9NhEQiIOuCYP6QW5Ae97OOERwIvOPS4GYAxv8ULMMkJIIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NSDrukkx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hvtquNoO+hu0AK2h/7B1xiPH1/JJ0I6seWn5T073mDY=; b=NSDrukkxYdDUgwOrQ8dr4EbULj
	VOron2Qkm3EnYJLj4qUZHTfdnOXkNMtoj/MfDOtILEFfnFCSOg+RlRPeprcPxo9copjDDskjXAUMx
	8FljgPpNKq+dAwhp+x2Il+YIlyXo/nrqlHJ8ZQfedBwUvidQugtFYb7ZTo3vKcEHnDfUtKjYSkND+
	CYE9aXvt4f2FEazW1LII9c1i1WQhV0QsZy7dbGgfNneJXGzbKl1mhyAzjZWx2edbD79b+fAcdoHsW
	TgoXzTX12UBCujTo4U9nkcwcLF7oSKYZYpAue228hGHj/Vq75XXF4BNS90rqBsoN87//zxESQhdiM
	TUVlLkyw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRZjR-00000009TEh-2Fz9;
	Wed, 10 Jul 2024 15:59:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6/6] qnx6: Convert directory handling to use kmap_local
Date: Wed, 10 Jul 2024 16:59:44 +0100
Message-ID: <20240710155946.2257293-7-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710155946.2257293-1-willy@infradead.org>
References: <20240710155946.2257293-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminates qnx6_put_page() and a few hidden calls to compound_head().
---
 fs/qnx6/dir.c  | 22 +++++++++++-----------
 fs/qnx6/qnx6.h |  6 ------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
index 0de2a047a174..b4d10e45f2e4 100644
--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -32,7 +32,7 @@ static void *qnx6_get_folio(struct inode *dir, unsigned long n,
 	if (IS_ERR(folio))
 		return folio;
 	*foliop = folio;
-	return kmap(&folio->page);
+	return kmap_local_folio(folio, 0);
 }
 
 static unsigned last_entry(struct inode *inode, unsigned long page_nr)
@@ -59,7 +59,7 @@ static struct qnx6_long_filename *qnx6_longname(struct super_block *sb,
 		return ERR_CAST(folio);
 	offs = offset_in_folio(folio, s << sb->s_blocksize_bits);
 	*foliop = folio;
-	return kmap(&folio->page) + offs;
+	return kmap_local_folio(folio, offs);
 }
 
 static int qnx6_dir_longfilename(struct inode *inode,
@@ -90,7 +90,7 @@ static int qnx6_dir_longfilename(struct inode *inode,
 	if (lf_size > QNX6_LONG_NAME_MAX) {
 		pr_debug("file %s\n", lf->lf_fname);
 		pr_err("Filename too long (%i)\n", lf_size);
-		qnx6_put_page(&folio->page);
+		folio_release_kmap(folio, lf);
 		return 0;
 	}
 
@@ -103,11 +103,11 @@ static int qnx6_dir_longfilename(struct inode *inode,
 	pr_debug("qnx6_readdir:%.*s inode:%u\n",
 		 lf_size, lf->lf_fname, de_inode);
 	if (!dir_emit(ctx, lf->lf_fname, lf_size, de_inode, DT_UNKNOWN)) {
-		qnx6_put_page(&folio->page);
+		folio_release_kmap(folio, lf);
 		return 0;
 	}
 
-	qnx6_put_page(&folio->page);
+	folio_release_kmap(folio, lf);
 	/* success */
 	return 1;
 }
@@ -168,7 +168,7 @@ static int qnx6_readdir(struct file *file, struct dir_context *ctx)
 				}
 			}
 		}
-		qnx6_put_page(&folio->page);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 0;
 }
@@ -190,14 +190,14 @@ static unsigned qnx6_long_match(int len, const char *name,
 
 	thislen = fs16_to_cpu(sbi, lf->lf_size);
 	if (len != thislen) {
-		qnx6_put_page(&folio->page);
+		folio_release_kmap(folio, lf);
 		return 0;
 	}
 	if (memcmp(name, lf->lf_fname, len) == 0) {
-		qnx6_put_page(&folio->page);
+		folio_release_kmap(folio, lf);
 		return fs32_to_cpu(sbi, de->de_inode);
 	}
-	qnx6_put_page(&folio->page);
+	folio_release_kmap(folio, lf);
 	return 0;
 }
 
@@ -256,7 +256,7 @@ unsigned qnx6_find_ino(int len, struct inode *dir, const char *name)
 				} else
 					pr_err("undefined filename size in inode.\n");
 			}
-			qnx6_put_page(&folio->page);
+			folio_release_kmap(folio, de - i);
 		}
 
 		if (++n >= npages)
@@ -266,7 +266,7 @@ unsigned qnx6_find_ino(int len, struct inode *dir, const char *name)
 
 found:
 	ei->i_dir_start_lookup = n;
-	qnx6_put_page(&folio->page);
+	folio_release_kmap(folio, de);
 	return ino;
 }
 
diff --git a/fs/qnx6/qnx6.h b/fs/qnx6/qnx6.h
index 43da5f91c3ff..56ed1367499e 100644
--- a/fs/qnx6/qnx6.h
+++ b/fs/qnx6/qnx6.h
@@ -126,10 +126,4 @@ static inline __fs16 cpu_to_fs16(struct qnx6_sb_info *sbi, __u16 n)
 extern struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s,
 						    int silent);
 
-static inline void qnx6_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 unsigned qnx6_find_ino(int len, struct inode *dir, const char *name);
-- 
2.43.0


