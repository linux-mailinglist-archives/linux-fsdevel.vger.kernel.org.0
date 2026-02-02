Return-Path: <linux-fsdevel+bounces-76016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DWxjKlI/gGk65QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:08:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7BC879A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C20D3001A7F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 06:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A5B2F5311;
	Mon,  2 Feb 2026 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nRVYCOsC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4F2DF6F6;
	Mon,  2 Feb 2026 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012491; cv=none; b=m6risrQjBMHlt+87NfdSLHCzE/FvbZuKTlO7m1XIymgdj5oQ288wTo3RMhcQLyyBNaIQx30NvfC8fr/FGXYWFpP/gioqQMaFt3Y1vP3AeSAa8LC0au6AK5Mr05Jyobwqasl1IxxITPxjIYqPr0npIxMvd/gUAxBBuDYHBTNf4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012491; c=relaxed/simple;
	bh=hINZKSc0WL6xjn0IntVnzLyE9bprABM/rl9WuYdEspQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlcIeHEOzbZxbC4pCUm3q+jpNlEzgtvX+O8TDAT7huCAv5P2tef+7u2PFF40jnIrKHmRUfgLvYI0+chcFtRxW6T8DTmy0sapyRvYmEPPn0+feqb/WArdA870lW5Z0PNUj7c/yfV5AQM7BkNPY4ixs0Al/pNmzy/bHzk9LTjt7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nRVYCOsC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YWN+VHgLHA7lSBgQ5h+w3PztFroaZ/qPS01ONtrKeFI=; b=nRVYCOsCyM39hl+6ILs2GEYLPL
	6DAGkvBFjf8bgItYzWTS5e407MJMyVnpzR785nmwUaGp8nN794tt8j4L6ekaD6RncEV/ztggVPxMI
	VofnVVxG1R8OmA61M0AjIT9f3S3pCjSBVhVHjhKN5CCMwezB3Vitlz7ybCZOLvuTA1ETguAheU3AU
	hDbVrLRPBzWQlunIRBoeuSnvorgWN5C+LEAzfGa7xlgBk2qkG9A1RRWVcq1zH4gEq/YnVb1SsTR5C
	tgkuotIzfXdTR2IopHijKalm+GFDq/o/39GDbkQ+LueTpngp4TnK/0Pjii2K9bsB9kXCIN+KiL8uU
	sX7+nHOw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmn6S-00000004UjL-3XZf;
	Mon, 02 Feb 2026 06:08:05 +0000
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
Subject: [PATCH 01/11] fsverity: don't issue readahead for non-ENOENT errors from __filemap_get_folio
Date: Mon,  2 Feb 2026 07:06:30 +0100
Message-ID: <20260202060754.270269-2-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76016-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7B7BC879A
X-Rspamd-Action: no action

Issuing more reads on errors is not a good idea, especially when the
most common error here is -ENOMEM.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/verity/pagecache.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
index 01c652bc802f..1a88decace53 100644
--- a/fs/verity/pagecache.c
+++ b/fs/verity/pagecache.c
@@ -22,7 +22,8 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
 	struct folio *folio;
 
 	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+	if (folio == ERR_PTR(-ENOENT) ||
+	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 
 		if (!IS_ERR(folio))
@@ -30,9 +31,9 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
 		else if (num_ra_pages > 1)
 			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
 		folio = read_mapping_folio(inode->i_mapping, index, NULL);
-		if (IS_ERR(folio))
-			return ERR_CAST(folio);
 	}
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
 	return folio_file_page(folio, index);
 }
 EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
-- 
2.47.3


