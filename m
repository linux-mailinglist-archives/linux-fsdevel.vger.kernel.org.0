Return-Path: <linux-fsdevel+bounces-17179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A774F8A89F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25EC1C20893
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34B171667;
	Wed, 17 Apr 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YivVIEb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726417279D;
	Wed, 17 Apr 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373795; cv=none; b=CkaY795JOmZ0Qz3cxG3sxFkDAe4m8WFrvVbk8zGiKYp424/HW2sqXikK5koXONM4OVpoCv2J1VuBlomrbF/+jiSHe1AmNQVZezR0g8/Xw8pPE65ZrThi/4Vug4imnh8vKOjh3iue+QKj5wh6i0X54+KihCtqQ7gMZ2syZNaNwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373795; c=relaxed/simple;
	bh=CDnMjQ0eIq/BOOB5K1hTv1DH3NrskCdniKfZmQlYmrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdiYl61vPOdoaGe+BLYBqZ1Xv3LCPYbJ5oeinHpa4WO47vPvFC3/dbSWUJMJcvcJp/zZdZhdlhkHpH5+MBoPVFYQNPp6XqMJa23HgqQtmxm6c3AukZOmUV6pNoPToC+MR2nyGhO7eOG3fV4svKGMcGQ8CqX7S2XDsHyPuQrHRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YivVIEb7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IjoxSp91HE+rrlkrHRhOXkk1Xtc4SU3NQ66FrwDSlT8=; b=YivVIEb77nAuMVs0588t8biM4m
	agxqI/Y+JUqlmRci4OggVPS6gON2+dllcOQW1+ewlr8zavTpfYoBgLu+pA8oQAyr5Vki6wy3IzT0o
	wVRhFhvFAEz9TzCcQZ37ffGpKPR1cupyV4YgWPndiX+a958lugKZ0rTikc+Q366dvXFcExppJl+7H
	qsdnwX9GNKvKVNxpCNVXgldKkgQO//bptvxJiv0SNwvsWQZV0cRsR3Sy3JnGh2KVhywzW2obrzTr5
	KJT//l21Kv1e3nAOZAuwq/3sbTlTK448SNHUFD5dQG41x8PP9N02YFEz+5BhYnPZo5FgDEAVmyA0T
	z/QWou4w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8n9-00000003LNe-0oFB;
	Wed, 17 Apr 2024 17:09:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/10] ntfs3: Convert attr_make_nonresident to use a folio
Date: Wed, 17 Apr 2024 18:09:34 +0100
Message-ID: <20240417170941.797116-7-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417170941.797116-1-willy@infradead.org>
References: <20240417170941.797116-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fetch a folio from the page cache instead of a page and operate on it.
Take advantage of the new helpers to avoid handling highmem ourselves,
and combine the uptodate + unlock operations into folio_end_read().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/attrib.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 64b526fd2dbc..1972213a663e 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -285,22 +285,20 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			if (err)
 				goto out2;
 		} else if (!page) {
-			char *kaddr;
-
-			page = grab_cache_page(ni->vfs_inode.i_mapping, 0);
-			if (!page) {
-				err = -ENOMEM;
+			struct address_space *mapping = ni->vfs_inode.i_mapping;
+			struct folio *folio;
+
+			folio = __filemap_get_folio(mapping, 0,
+					FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					mapping_gfp_mask(mapping));
+			if (IS_ERR(folio)) {
+				err = PTR_ERR(folio);
 				goto out2;
 			}
-			kaddr = kmap_atomic(page);
-			memcpy(kaddr, data, rsize);
-			memset(kaddr + rsize, 0, PAGE_SIZE - rsize);
-			kunmap_atomic(kaddr);
-			flush_dcache_page(page);
-			SetPageUptodate(page);
-			set_page_dirty(page);
-			unlock_page(page);
-			put_page(page);
+			folio_fill_tail(folio, 0, data, rsize);
+			folio_mark_dirty(folio);
+			folio_end_read(folio, true);
+			folio_put(folio);
 		}
 	}
 
-- 
2.43.0


