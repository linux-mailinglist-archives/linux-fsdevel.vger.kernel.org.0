Return-Path: <linux-fsdevel+bounces-20586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ABF8D53C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65F31C24671
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEE41649D1;
	Thu, 30 May 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G6+lGuEb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91E158DCD
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100483; cv=none; b=eewN9QQCIRNUHourvLxHC7Fnt9qP8Cs2OAKnAEoeSv+S6kSGX3CTH1oB3p6rJIg07HF2LI2GoYQ6AKWD4XliRNKlt3koECGJIzqPNDfI3Oq90riUr4PauYu/+85Smgv6PBduUTmEcc7u39386CkWgc3ReJhRgCTJthZaVLToNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100483; c=relaxed/simple;
	bh=CgkORveIcAvhNacBC7kPYVAqzTYlPPqni/6Vscfx2dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtGQRWvkNx/O2fd6ZSEN+ll+X8jvXqswe9bnL7sJIWuEfnWuiV1xC1s7EuBtEDnpuBGD5LTPJDU/+U9Yq4Yhhj8ZXMKUOgpBYzwz+KCTVTfVwHSZ1USUN8fVAmSPG07Sj8SdCIMkw9xdAxCU/rm60TSK/KEG/JTOQ0SxoZJF1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G6+lGuEb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6Zwj6o5e9GCXPyUfI1AfjNmWw9pmdltYh5Ep8mr94ps=; b=G6+lGuEbY6O31LkxmLLui14ZfG
	a3wJKQYx79zctoj+Ft5IDtZMJc9NnsZ+MRDkgxPU8Zh4farwAuW9aOg3vGho9NVDoqVT1JjebUUeH
	rMA4qgHoqdkY0E3H9fpydQZWLNDucEds6V+UODjfoScCfs+9uUDzgugwMRQO+Iqkv6w8zsV4dq6zn
	OhneTjRjawuUVK2eGx76FWOAT8qrPnbNyP5O5Cvqz/1ImSpr/5kYuJRzKzoCI4R4LRPIZHAee+SNf
	sy9BYb09X9D7tvybKyhq603idw8PhLK+ZEQjz9naUrDfCMuSyVxbvFTYCY4cLGceWnnp8w9BDa0+o
	SSjWjNAg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmH0-0000000B8Lk-3I4D;
	Thu, 30 May 2024 20:21:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 14/16] vboxsf: Convert vboxsf_read_folio() to use a folio
Date: Thu, 30 May 2024 21:21:06 +0100
Message-ID: <20240530202110.2653630-15-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove conversion to a page and use folio APIs throughout.  This includes
a removal of setting the error flag as nobody checks the error flag on
vboxsf folios.  This does not include large folio support as we would
have to map each page individually.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 fs/vboxsf/file.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 118dedef8ebe..fdb4da24d662 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -228,26 +228,19 @@ const struct inode_operations vboxsf_reg_iops = {
 
 static int vboxsf_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	struct vboxsf_handle *sf_handle = file->private_data;
-	loff_t off = page_offset(page);
+	loff_t off = folio_pos(folio);
 	u32 nread = PAGE_SIZE;
 	u8 *buf;
 	int err;
 
-	buf = kmap(page);
+	buf = kmap_local_folio(folio, 0);
 
 	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
-	if (err == 0) {
-		memset(&buf[nread], 0, PAGE_SIZE - nread);
-		flush_dcache_page(page);
-		SetPageUptodate(page);
-	} else {
-		SetPageError(page);
-	}
+	buf = folio_zero_tail(folio, nread, buf + nread);
 
-	kunmap(page);
-	unlock_page(page);
+	kunmap_local(buf);
+	folio_end_read(folio, err == 0);
 	return err;
 }
 
@@ -295,7 +288,6 @@ static int vboxsf_writepage(struct page *page, struct writeback_control *wbc)
 	kref_put(&sf_handle->refcount, vboxsf_handle_release);
 
 	if (err == 0) {
-		ClearPageError(page);
 		/* mtime changed */
 		sf_i->force_restat = 1;
 	} else {
-- 
2.43.0


