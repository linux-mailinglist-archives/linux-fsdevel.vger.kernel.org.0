Return-Path: <linux-fsdevel+bounces-63889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA1BBD14CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867303C1901
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 02:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4883B2F3615;
	Mon, 13 Oct 2025 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eczotvSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF0280035;
	Mon, 13 Oct 2025 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324351; cv=none; b=M175i+69UAudxIkFZOsHHxC2zmLs+Xr/sR0vU1CYNcGw8gJnWFPt5a9+wd4BgRxQHAsPB9pH8BLZLwBp2m0ZquQRYqcEtD9EEd3qvKXU0V4KURcIKSl3CEIvSN5NdKYJ647RfZpUFh+5ZGSYGcC2TIEgsvCGcbHAFcgCf+C8bBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324351; c=relaxed/simple;
	bh=gVURG8C4bkJi6cpx9d6eayli/okoLDUuwhdQRKLQCnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2lCtjorKXeSVAmoQsBe/obFUob9PCwP0+K9PHQGEAv2XoTD2+0Z/wfKTb5w1e8+dXBOENs7/sg6hAHNul02j4rJyv/MqQcDhlfT0JxW43hWulGUy7+XOGeDR5aWWDxPCDh7zMOH0t7FVMiOtMHu1SCjqrBagxNImTt9mb8OlJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eczotvSA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=F6XqMAl0hhgv+pueu+gPbmnZHJ+gIOipzSWvNzlnECE=; b=eczotvSAlwu9quTnO/DHd+Ag+q
	DnbNC2oa4pQsv0UhWV82c22oGnj8ZQvOU9Ny7pVSGhaTdQUNQ9gaJf4DH6EA2NkxYsxSsgVC4RGhk
	4mI0tevqB4kMZWCEwwJUrTZZNR0VGEonrbk0um8sxEwW2nWsoNZLMmmwNeMn5xlxhrBpb6YlUcWCF
	HLQ/8hvGThOcLJzWWHEOdUUPsC/3HANOdQgKpzHkh+5ZBcreCg34O06/bKvGmO9JR9brsqAc4zk1p
	c61ey5nUKVM9rQ2DBsvZ/rmOvw9MmP+BAwSEyrsv+x/t0AfsERkTSNA4RR7R+i8m0j1XBx8NK3pcp
	8GNbRUeA==;
Received: from [220.85.59.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88mA-0000000C8J0-1o3a;
	Mon, 13 Oct 2025 02:59:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/10] mm: remove __filemap_fdatawrite
Date: Mon, 13 Oct 2025 11:58:02 +0900
Message-ID: <20251013025808.4111128-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013025808.4111128-1-hch@lst.de>
References: <20251013025808.4111128-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

And rewrite filemap_fdatawrite to use filemap_fdatawrite_range instead
to have a simpler call chain.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b95e71774131..bbd5d5eaa661 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -422,25 +422,19 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 	return filemap_fdatawrite_wbc(mapping, &wbc);
 }
 
-static inline int __filemap_fdatawrite(struct address_space *mapping,
-	int sync_mode)
+int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
+		loff_t end)
 {
-	return __filemap_fdatawrite_range(mapping, 0, LLONG_MAX, sync_mode);
+	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
 }
+EXPORT_SYMBOL(filemap_fdatawrite_range);
 
 int filemap_fdatawrite(struct address_space *mapping)
 {
-	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
+	return filemap_fdatawrite_range(mapping, 0, LONG_MAX);
 }
 EXPORT_SYMBOL(filemap_fdatawrite);
 
-int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
-				loff_t end)
-{
-	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
-}
-EXPORT_SYMBOL(filemap_fdatawrite_range);
-
 /**
  * filemap_fdatawrite_range_kick - start writeback on a range
  * @mapping:	target address_space
@@ -470,7 +464,7 @@ EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
  */
 int filemap_flush(struct address_space *mapping)
 {
-	return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
+	return filemap_fdatawrite_range_kick(mapping, 0, LLONG_MAX);
 }
 EXPORT_SYMBOL(filemap_flush);
 
-- 
2.47.3


