Return-Path: <linux-fsdevel+bounces-23345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D0592AEBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50A0B21B64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8891612C484;
	Tue,  9 Jul 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gu1CHuK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722464502B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495836; cv=none; b=IacpXGKOvzEZqvLCKxSMvVvuuPMcfBqlBgCjlwln/2+NNxQpF9iubuN+6bVD5snaB4tKp+zIyJ98O3HhIl0rsOQfqPRDHnFq/Riq1AyXg1ZBTfzTPbcFIDc//O3k0bS1kh75iU13E00gEauDFpgBej7+1i6m4nVIMmAfSDfkw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495836; c=relaxed/simple;
	bh=B93pKBCMwrta/cZfJ08CRHvHvzJunHpVHvZUnMVLT34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvlPnffBDV8bO28Td1eQnuWeKYgNbRUd9GkFGZspPff0jziZQBXe+pmXYtSEaslIn6IbwchYD6gSqrkA+Te2ZUyEUmcb3fRsEZeZ0HfhVM230A7/AUoMyZRDNsTrRBn/7rW+cMH5Wn79s0fyUeWZa7r/LNj4qjK3p+CsznMQ5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gu1CHuK1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/Y+PqX7MwRu1AeQN2mFg5ga0TpDmNlJByyAfOKwi7ck=; b=Gu1CHuK1hgQ8CSMqGAF9t4SNCT
	UaRnR8GZvv+JUYRlyE2bdB63Ew/oayfJSqsEGygpfIwmvZOB2Wtyjtk0LUi8OQYWBhk4vkE1jA3ml
	I6qu7dIaNovia4ToqUSX2h91rH2ewwzHk656dDIqA+6M8U0KgXYRUBoPKOamNHx1Lr/Ljr3uA/zU4
	sjl0I9vrrhd6lT0ZX7iD+kRM1zg7HRcMn72ZQGpmtQJY1SggNwWo81T2r2NbAYWKyDsZIzhQa5uq5
	Xjp/onyUVDBi1RcELPxEuV9hnchskkzZbfssI+Vd6VvfJHyvCEPLwJbzRIjTV75lmvTtdk/UK/TN+
	Oqyn/KGA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Ym-00000007QTQ-1S4t;
	Tue, 09 Jul 2024 03:30:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/10] ufs: Convert directory handling to kmap_local
Date: Tue,  9 Jul 2024 04:30:27 +0100
Message-ID: <20240709033029.1769992-11-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709033029.1769992-1-willy@infradead.org>
References: <20240709033029.1769992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove kmap use and use folio_release_kmap() instead of ufs_put_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/dir.c   | 30 ++++++++++++------------------
 fs/ufs/namei.c | 15 +++++----------
 2 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 71685491d5f6..3b3cd84f1f7f 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -66,12 +66,6 @@ static int ufs_handle_dirsync(struct inode *dir)
 	return err;
 }
 
-static inline void ufs_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 {
 	ino_t res = 0;
@@ -81,7 +75,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 	de = ufs_find_entry(dir, qstr, &folio);
 	if (de) {
 		res = fs32_to_cpu(dir->i_sb, de->d_ino);
-		ufs_put_page(&folio->page);
+		folio_release_kmap(folio, de);
 	}
 	return res;
 }
@@ -104,7 +98,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
 	ufs_commit_chunk(folio, pos, len);
-	ufs_put_page(&folio->page);
+	folio_release_kmap(folio, de);
 	if (update_times)
 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
@@ -197,7 +191,7 @@ static void *ufs_get_folio(struct inode *dir, unsigned long n,
 
 	if (IS_ERR(folio))
 		return ERR_CAST(folio);
-	kaddr = kmap(&folio->page);
+	kaddr = kmap_local_folio(folio, 0);
 	if (unlikely(!folio_test_checked(folio))) {
 		if (!ufs_check_folio(folio, kaddr))
 			goto fail;
@@ -206,7 +200,7 @@ static void *ufs_get_folio(struct inode *dir, unsigned long n,
 	return kaddr;
 
 fail:
-	ufs_put_page(&folio->page);
+	folio_release_kmap(folio, kaddr);
 	return ERR_PTR(-EIO);
 }
 
@@ -283,7 +277,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 					goto found;
 				de = ufs_next_entry(sb, de);
 			}
-			ufs_put_page(&(*foliop)->page);
+			folio_release_kmap(*foliop, kaddr);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -359,7 +353,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
 		}
 		folio_unlock(folio);
-		ufs_put_page(&folio->page);
+		folio_release_kmap(folio, kaddr);
 	}
 	BUG();
 	return -EINVAL;
@@ -390,7 +384,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	err = ufs_handle_dirsync(dir);
 	/* OFFSET_CACHE */
 out_put:
-	ufs_put_page(&folio->page);
+	folio_release_kmap(folio, de);
 	return err;
 out_unlock:
 	folio_unlock(folio);
@@ -468,13 +462,13 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 					       ufs_get_de_namlen(sb, de),
 					       fs32_to_cpu(sb, de->d_ino),
 					       d_type)) {
-					ufs_put_page(&folio->page);
+					folio_release_kmap(folio, de);
 					return 0;
 				}
 			}
 			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
 		}
-		ufs_put_page(&folio->page);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 0;
 }
@@ -531,7 +525,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	mark_inode_dirty(inode);
 	err = ufs_handle_dirsync(inode);
 out:
-	ufs_put_page(&folio->page);
+	folio_release_kmap(folio, kaddr);
 	UFSD("EXIT\n");
 	return err;
 }
@@ -624,12 +618,12 @@ int ufs_empty_dir(struct inode * inode)
 			}
 			de = ufs_next_entry(sb, de);
 		}
-		ufs_put_page(&folio->page);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 1;
 
 not_empty:
-	ufs_put_page(&folio->page);
+	folio_release_kmap(folio, kaddr);
 	return 0;
 }
 
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index a9b0c15de067..24bd12186647 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -306,23 +306,18 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (dir_de) {
 		if (old_dir != new_dir)
 			ufs_set_link(old_inode, dir_de, dir_folio, new_dir, 0);
-		else {
-			kunmap(&dir_folio->page);
-			folio_put(dir_folio);
-		}
+		else
+			folio_release_kmap(dir_folio, new_dir);
 		inode_dec_link_count(old_dir);
 	}
 	return 0;
 
 
 out_dir:
-	if (dir_de) {
-		kunmap(&dir_folio->page);
-		folio_put(dir_folio);
-	}
+	if (dir_de)
+		folio_release_kmap(dir_folio, dir_de);
 out_old:
-	kunmap(&old_folio->page);
-	folio_put(old_folio);
+	folio_release_kmap(old_folio, old_de);
 out:
 	return err;
 }
-- 
2.43.0


