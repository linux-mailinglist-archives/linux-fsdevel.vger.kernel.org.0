Return-Path: <linux-fsdevel+bounces-48993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C51D2AB7285
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487554C397F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D77B281364;
	Wed, 14 May 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oelmyfCe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F151DE3CA;
	Wed, 14 May 2025 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242800; cv=none; b=TOI3DigAhyV/RLKWS0F2HGb4JFmePu4WCiejSldX3qeWEx3ZHphFLL4tc9FxDybmzwLsrV+rR86d37qUk7z6yHM2J4pFHYuAtJaOHDyyVSCD6us9PPTW3QofXL7rX4mzV6OKEuH1V13tECC/l+kqnwfCZs79t+D1McjcfkPc4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242800; c=relaxed/simple;
	bh=/ajbg9YzJ+FTV0b8IS7khy5sjaDC+ROSSY1Eln7ioQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QObimpUX/W6Sd/jAanlY4swIWYy/6TcQ1mMRH41tuKKvN4rigFAMa+Onx7RNcd7kRDgxZZqqrWSsfjiJ3xcCgni2bCZZ/CWsVYB822vqtMegD9Kk0vypdWHGS1aLQngLWyXa3/Udu1LsOtWxagUXQ5yffAPajSNBx2VnVjnr3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oelmyfCe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/7hgdb8KdUY4HPMBxB/aj3IltbKgj6zTC2ID0FehOx4=; b=oelmyfCe6RwImPtsSpzWES0AwN
	SrhNexpGRJzF8KgrL63P5isxM3MHLXjA9j/MSTpawvfx/wF7VLvcfDO5D0a/XkpBMJJqlhg2MeGjO
	v9MugrpBgDOCJJkc5AtxSGahe9vM7PiJUfjXAUK1BzDtrmoiSciYm0y3NNMgve0lrfi2vc+bQIijK
	Tf0gq55EznkItPDrtxdZVJCq2wZRKOdc3W0O0ZJYY1sWPsrcQv33qGM7ONrjLjOfNEfxiO/QE/QIS
	0pcQTGwM3Vn+B01WQKkROPaQk9tsQYnab0LyrWiCvORfidYwhXTHQMb9x/cjiofGUX4b0CkSkB36v
	zSdUEGmA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFFfR-0000000CbCr-38Cv;
	Wed, 14 May 2025 17:13:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] fs: Pass a folio to page_put_link()
Date: Wed, 14 May 2025 18:13:14 +0100
Message-ID: <20250514171316.3002934-4-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514171316.3002934-1-willy@infradead.org>
References: <20250514171316.3002934-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers now have a folio.  Pass it to page_put_link(), saving a
hidden call to compound_head().  Also add kernel-doc for page_get_link()
and page_put_link().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/dir.c    |  2 +-
 fs/namei.c       | 30 +++++++++++++++++++++++++++---
 fs/nfs/symlink.c |  2 +-
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 83ac192e7fdd..33b82529cb6e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1676,7 +1676,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 		goto out_err;
 	}
 
-	set_delayed_call(callback, page_put_link, &folio->page);
+	set_delayed_call(callback, page_put_link, folio);
 
 	return folio_address(folio);
 
diff --git a/fs/namei.c b/fs/namei.c
index 8e82aa7ecb82..12d24f6da782 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5419,7 +5419,7 @@ static char *__page_get_link(struct dentry *dentry, struct inode *inode,
 		if (IS_ERR(folio))
 			return ERR_CAST(folio);
 	}
-	set_delayed_call(callback, page_put_link, &folio->page);
+	set_delayed_call(callback, page_put_link, folio);
 	BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
 	return folio_address(folio);
 }
@@ -5431,6 +5431,17 @@ const char *page_get_link_raw(struct dentry *dentry, struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(page_get_link_raw);
 
+/**
+ * page_get_link() - An implementation of the get_link inode_operation.
+ * @dentry: The directory entry which is the symlink.
+ * @inode: The inode for the symlink.
+ * @callback: Used to drop the reference to the symlink.
+ *
+ * Filesystems which store their symlinks in the page cache should use
+ * this to implement the get_link() member of their inode_operations.
+ *
+ * Return: A pointer to the NUL-terminated symlink.
+ */
 const char *page_get_link(struct dentry *dentry, struct inode *inode,
 					struct delayed_call *callback)
 {
@@ -5440,12 +5451,25 @@ const char *page_get_link(struct dentry *dentry, struct inode *inode,
 		nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
 	return kaddr;
 }
-
 EXPORT_SYMBOL(page_get_link);
 
+/**
+ * page_put_link() - Drop the reference to the symlink.
+ * @arg: The folio which contains the symlink.
+ *
+ * This is used internally by page_get_link().  It is exported for use
+ * by filesystems which need to implement a variant of page_get_link()
+ * themselves.  Despite the apparent symmetry, filesystems which use
+ * page_get_link() do not need to call page_put_link().
+ *
+ * The argument, while it has a void pointer type, must be a pointer to
+ * the folio which was retrieved from the page cache.  The delayed_call
+ * infrastructure is used to drop the reference count once the caller
+ * is done with the symlink.
+ */
 void page_put_link(void *arg)
 {
-	put_page(arg);
+	folio_put(arg);
 }
 EXPORT_SYMBOL(page_put_link);
 
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 004a8f6c568e..58146e935402 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -63,7 +63,7 @@ static const char *nfs_get_link(struct dentry *dentry,
 		if (IS_ERR(folio))
 			return ERR_CAST(folio);
 	}
-	set_delayed_call(done, page_put_link, &folio->page);
+	set_delayed_call(done, page_put_link, folio);
 	return folio_address(folio);
 }
 
-- 
2.47.2


