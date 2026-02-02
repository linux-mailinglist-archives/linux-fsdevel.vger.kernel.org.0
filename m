Return-Path: <linux-fsdevel+bounces-76017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDq7MqE/gGk65QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:09:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF6AC885F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24322301DB9B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 06:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099F2F3C07;
	Mon,  2 Feb 2026 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xNYEGZzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609E2DF6F6;
	Mon,  2 Feb 2026 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012495; cv=none; b=niXfihAyF5Arr/zRiH4HppVzS3giQ47XFEqv/cj2JUur0+ojDvN6C0IfAs7f7OSjKZsdq3NqR+VwyzDxwZfibY4d1KcSGCwKv5bJurSGOd1lqn3mEPJezHelOD+R/lJXzGlAlP/SLInpqJq1oxuCzjY2JnrIcU6UTlu9jCEshhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012495; c=relaxed/simple;
	bh=+hBeoRUvkMJdO/ySPxKpGl8BIHeb8hYFU71EBg9GUJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beH2P7OJLEqd3+XIxWI7K3yDE1YgPIvgoKN1PGZmPI6zpL2ChrzGOwq7EiqhMKsXuFq1TDAkRhGSSILZoYvTKfrQsBAAhyUNzL1ThKMdkGfRVfyCCscvCOtJ9QfKCezLWWhRhQmRy00EiyMIQ4Dorpl0kADix32t/5mHeGxPjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xNYEGZzM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=c3k3Gwc9ZRSVczER0BPphb8Viyntpzl9iwL7l9oD3eA=; b=xNYEGZzMos/EePCVcAUn10byLj
	Cyxg2rz279L3rnpqpL/xOqmt8y8kpTV1GdbD9NVa1PdS6q3Vg4pZUZMaWbQ/zN/9po6BcSygreMJ6
	svvJMiyi/fMjzaihxLWQBYgPo+cusTsxvtO5CKKAqEjeL1eENye6vbEh/AI7qWLNZHhFg3bAnMIre
	ubcsar7OMYj0/+OXgy8LrgM+NSC4RySN6H0zldaYKzD2tksLXehS3Fi2I0s9OATJZrZXfexu0HKYQ
	JjnlppFCI22UsvoMI5ZHwnjzcVpyJvYOp2IzkCt9tfPN6fWHNrtHBCEZfsCdoINrHZ+P8sm4v5WSC
	gjbaaabA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmn6X-00000004Ujb-2kox;
	Mon, 02 Feb 2026 06:08:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 02/11] readahead: push invalidate_lock out of page_cache_ra_unbounded
Date: Mon,  2 Feb 2026 07:06:31 +0100
Message-ID: <20260202060754.270269-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202060754.270269-1-hch@lst.de>
References: <20260202060754.270269-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76017-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 2FF6AC885F
X-Rspamd-Action: no action

Require the invalidate_lock to be held over calls to
page_cache_ra_unbounded instead of acquiring it in this function.

This prepares for calling page_cache_ra_unbounded from ->readahead for
fsverity read-ahead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/file.c        |  2 ++
 fs/verity/pagecache.c |  7 +++++--
 mm/readahead.c        | 13 ++++++++-----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index da029fed4e5a..c9b9fcdd0cae 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4418,7 +4418,9 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 	pgoff_t redirty_idx = page_idx;
 	int page_len = 0, ret = 0;
 
+	filemap_invalidate_lock_shared(mapping);
 	page_cache_ra_unbounded(&ractl, len, 0);
+	filemap_invalidate_unlock_shared(mapping);
 
 	do {
 		folio = read_cache_folio(mapping, page_idx, NULL, NULL);
diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
index 1a88decace53..8e0d6fde802f 100644
--- a/fs/verity/pagecache.c
+++ b/fs/verity/pagecache.c
@@ -26,10 +26,13 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
 	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 
-		if (!IS_ERR(folio))
+		if (!IS_ERR(folio)) {
 			folio_put(folio);
-		else if (num_ra_pages > 1)
+		} else if (num_ra_pages > 1) {
+			filemap_invalidate_lock_shared(inode->i_mapping);
 			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
+			filemap_invalidate_unlock_shared(inode->i_mapping);
+		}
 		folio = read_mapping_folio(inode->i_mapping, index, NULL);
 	}
 	if (IS_ERR(folio))
diff --git a/mm/readahead.c b/mm/readahead.c
index b415c9969176..25f81124beb6 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -204,7 +204,8 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
  * not the function you want to call.  Use page_cache_async_readahead()
  * or page_cache_sync_readahead() instead.
  *
- * Context: File is referenced by caller.  Mutexes may be held by caller.
+ * Context: File is referenced by caller, and ractl->mapping->invalidate_lock
+ * must be held by the caller in shared mode.  Mutexes may be held by caller.
  * May sleep, but will not reenter filesystem to reclaim memory.
  */
 void page_cache_ra_unbounded(struct readahead_control *ractl,
@@ -228,9 +229,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 */
 	unsigned int nofs = memalloc_nofs_save();
 
+	lockdep_assert_held_read(&mapping->invalidate_lock);
+
 	trace_page_cache_ra_unbounded(mapping->host, index, nr_to_read,
 				      lookahead_size);
-	filemap_invalidate_lock_shared(mapping);
 	index = mapping_align_index(mapping, index);
 
 	/*
@@ -300,7 +302,6 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 * will then handle the error.
 	 */
 	read_pages(ractl);
-	filemap_invalidate_unlock_shared(mapping);
 	memalloc_nofs_restore(nofs);
 }
 EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
@@ -314,9 +315,9 @@ EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
 static void do_page_cache_ra(struct readahead_control *ractl,
 		unsigned long nr_to_read, unsigned long lookahead_size)
 {
-	struct inode *inode = ractl->mapping->host;
+	struct address_space *mapping = ractl->mapping;
 	unsigned long index = readahead_index(ractl);
-	loff_t isize = i_size_read(inode);
+	loff_t isize = i_size_read(mapping->host);
 	pgoff_t end_index;	/* The last page we want to read */
 
 	if (isize == 0)
@@ -329,7 +330,9 @@ static void do_page_cache_ra(struct readahead_control *ractl,
 	if (nr_to_read > end_index - index)
 		nr_to_read = end_index - index + 1;
 
+	filemap_invalidate_lock_shared(mapping);
 	page_cache_ra_unbounded(ractl, nr_to_read, lookahead_size);
+	filemap_invalidate_unlock_shared(mapping);
 }
 
 /*
-- 
2.47.3


