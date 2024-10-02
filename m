Return-Path: <linux-fsdevel+bounces-30744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6FA98E139
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08951C235A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB501D12E3;
	Wed,  2 Oct 2024 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw/vIq7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449A1D131E
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888124; cv=none; b=W59S/NYhCJYI/R1LiRuhcgt4pjSNY6Tjk8YiYT68o6FU4vtaMwVEaBJJQc0iQRh5hw2LT1mBsRsnrIyOICvzMv5fPYvL/Wp4JfvGl6EHs1BWwyw5SjsOoyyVYPd9qFcEnRL/btfhc5NfGD09jlNNNG3ZkBbIomeMOsRx3aug83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888124; c=relaxed/simple;
	bh=eN0rhtgVv7C7GuC4XxHR1gXtGFCimqLE80XFinNEwDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZVL0Nw/HcKxYAX2gPFoqwsNvDSBrYRtxR741WDY1XPZwDQeFwkYgYHuoj/WJintxXahhBQ2Xns0UPlO0rDfDGCGgywsH57BGIXg3TDNbyofXIsQ3GJeBPj7qd418ivC3LgcakgWpKjfkYbt/0tfZq9j68DClv3cKygcooJrE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw/vIq7S; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e03caab48a2so54229276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888121; x=1728492921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIde6yOsCwAUMHUcgWr+HW/rlfP3c104DpK/nsufetg=;
        b=jw/vIq7ScjO+keVtJNVZBTPkjVxXEoSh/Vj6rxTGBOf4eP2kIWD+PnSErWMrG3p3PT
         3ROwKylrc1m1nw+WxHWn9HvYH7FlwPWvQo1/t4nPAGR0dYS0ZDQDUNVByNYu/slnePoU
         n+fsS0v64QVXblqMc2SK3qZOxIphTQSHjCYbAjmBRHZWnowDLmsxtvxT4p8u+794CMi8
         1mKIK0Dzf6QiJxV7zTW73cG/6X8OorFoEHfI2IctUC6evsLGqsSXxdPU8dNmLOG4yKBV
         alE2mHvM1qceaIqMANFQxDmB2dT8cMWq4/xDv3otoWkkzNnEPFbo2NkShe0sXXK846pv
         ri+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888121; x=1728492921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIde6yOsCwAUMHUcgWr+HW/rlfP3c104DpK/nsufetg=;
        b=c0gp+aendFJZS/8X47Jk2LObhVTyxS3ctduSJ24ugOipKmrM2F88dBT2YKNWXKnKqt
         UpO72eqNIcxNEXkImoFPfGnJecLDL0dDiOdUET9l8f5FpvLsXQACzypjy/KttqyLofg6
         /u8r2+aIqC7sZZzf5bT6XKEN4SW9W0zBnHpAVZjvtvgrdtimw+6PFYwwcX/IQd7eIKp8
         4ZqDUPNGZhL71tdXF73Zngm9VHqJE+95Fe0OtbssaQrL8/KCfdfVnt7F8zuAkh5HbVZh
         BP2NAQhW9XGEWaUopWODuhAp1m4nWUl8GCszvvd1PE+XiyCSvYIkWNasMq7EPesGCg1v
         f4qg==
X-Forwarded-Encrypted: i=1; AJvYcCWFum00EuQl6dfwNU3wwQKb1ECvm0bT5ftl2gVhUbWqUw7KNBuy7SoGjXIUV+6nT5Bt2ywK1nqxi//xsX6g@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6wO4Y92yYVDfrtCoXlclam8FuZ230e/a7JTELYtjdrfPEh7Q3
	uBa8gBsYtTujGI0GHYdyd2eBT6HSXQTFANBCqdQOsfojQmrFIjZH
X-Google-Smtp-Source: AGHT+IFKgoroPgGATCu1wxW2wZPDjb4LW9rH8NCdL5lOYH11Uor9VrQfHMW1nVFTBPKS5Ic3DdaIxg==
X-Received: by 2002:a05:6902:188f:b0:e03:5505:5b5b with SMTP id 3f1490d57ef6-e286f5d86f8mr344170276.0.1727888120953;
        Wed, 02 Oct 2024 09:55:20 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e401b436sm3976189276.24.2024.10.02.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:20 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 06/13] fuse: convert reads to use folios
Date: Wed,  2 Oct 2024 09:52:46 -0700
Message-ID: <20241002165253.3872513-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002165253.3872513-1-joannelkoong@gmail.com>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert read requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c   | 67 ++++++++++++++++++++++++++++++++----------------
 fs/fuse/fuse_i.h | 12 +++++++++
 2 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index dc701fa94c58..ad419fafbd5d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -757,12 +757,37 @@ static struct fuse_io_args *fuse_io_alloc(struct fuse_io_priv *io,
 	return ia;
 }
 
+static struct fuse_io_args *fuse_io_folios_alloc(struct fuse_io_priv *io,
+						 unsigned int nfolios)
+{
+	struct fuse_io_args *ia;
+
+	ia = kzalloc(sizeof(*ia), GFP_KERNEL);
+	if (ia) {
+		ia->io = io;
+		ia->ap.uses_folios = true;
+		ia->ap.folios = fuse_folios_alloc(nfolios, GFP_KERNEL,
+						  &ia->ap.folio_descs);
+		if (!ia->ap.folios) {
+			kfree(ia);
+			ia = NULL;
+		}
+	}
+	return ia;
+}
+
 static void fuse_io_free(struct fuse_io_args *ia)
 {
 	kfree(ia->ap.pages);
 	kfree(ia);
 }
 
+static void fuse_io_folios_free(struct fuse_io_args *ia)
+{
+	kfree(ia->ap.folios);
+	kfree(ia);
+}
+
 static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
 				  int err)
 {
@@ -858,7 +883,7 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	 * reached the client fs yet.  So the hole is not present there.
 	 */
 	if (!fc->writeback_cache) {
-		loff_t pos = page_offset(ap->pages[0]) + num_read;
+		loff_t pos = folio_pos(ap->folios[0]) + num_read;
 		fuse_read_update_size(inode, pos, attr_ver);
 	}
 }
@@ -868,14 +893,14 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	loff_t pos = folio_pos(folio);
-	struct fuse_page_desc desc = { .length = PAGE_SIZE };
-	struct page *page = &folio->page;
+	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
-		.ap.num_pages = 1,
-		.ap.pages = &page,
-		.ap.descs = &desc,
+		.ap.uses_folios = true,
+		.ap.num_folios = 1,
+		.ap.folios = &folio,
+		.ap.folio_descs = &desc,
 	};
 	ssize_t res;
 	u64 attr_ver;
@@ -934,8 +959,8 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	size_t num_read = args->out_args[0].size;
 	struct address_space *mapping = NULL;
 
-	for (i = 0; mapping == NULL && i < ap->num_pages; i++)
-		mapping = ap->pages[i]->mapping;
+	for (i = 0; mapping == NULL && i < ap->num_folios; i++)
+		mapping = ap->folios[i]->mapping;
 
 	if (mapping) {
 		struct inode *inode = mapping->host;
@@ -949,15 +974,12 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		fuse_invalidate_atime(inode);
 	}
 
-	for (i = 0; i < ap->num_pages; i++) {
-		struct folio *folio = page_folio(ap->pages[i]);
-
-		folio_end_read(folio, !err);
-	}
+	for (i = 0; i < ap->num_folios; i++)
+		folio_end_read(ap->folios[i], !err);
 	if (ia->ff)
 		fuse_file_put(ia->ff, false);
 
-	fuse_io_free(ia);
+	fuse_io_folios_free(ia);
 }
 
 static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
@@ -965,8 +987,9 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
 	struct fuse_args_pages *ap = &ia->ap;
-	loff_t pos = page_offset(ap->pages[0]);
-	size_t count = ap->num_pages << PAGE_SHIFT;
+	loff_t pos = folio_pos(ap->folios[0]);
+	/* Currently, all folios in FUSE are one page */
+	size_t count = ap->num_folios << PAGE_SHIFT;
 	ssize_t res;
 	int err;
 
@@ -977,7 +1000,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 	/* Don't overflow end offset */
 	if (pos + (count - 1) == LLONG_MAX) {
 		count--;
-		ap->descs[ap->num_pages - 1].length--;
+		ap->folio_descs[ap->num_folios - 1].length--;
 	}
 	WARN_ON((loff_t) (pos + count) < 0);
 
@@ -1038,16 +1061,16 @@ static void fuse_readahead(struct readahead_control *rac)
 			 */
 			break;
 
-		ia = fuse_io_alloc(NULL, cur_pages);
+		ia = fuse_io_folios_alloc(NULL, cur_pages);
 		if (!ia)
 			return;
 		ap = &ia->ap;
 
-		while (ap->num_pages < cur_pages &&
+		while (ap->num_folios < cur_pages &&
 		       (folio = readahead_folio(rac)) != NULL) {
-			ap->pages[ap->num_pages] = &folio->page;
-			ap->descs[ap->num_pages].length = folio_size(folio);
-			ap->num_pages++;
+			ap->folios[ap->num_folios] = folio;
+			ap->folio_descs[ap->num_folios].length = folio_size(folio);
+			ap->num_folios++;
 		}
 		fuse_send_readpages(ia, rac->file);
 		nr_pages -= cur_pages;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index dcc0ab4bea78..2533313502de 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1023,6 +1023,18 @@ static inline struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 	return pages;
 }
 
+static inline struct folio **fuse_folios_alloc(unsigned int nfolios, gfp_t flags,
+					       struct fuse_folio_desc **desc)
+{
+	struct folio **folios;
+
+	folios = kzalloc(nfolios * (sizeof(struct folio *) +
+				    sizeof(struct fuse_folio_desc)), flags);
+	*desc = (void *) (folios + nfolios);
+
+	return folios;
+}
+
 static inline void fuse_page_descs_length_init(struct fuse_page_desc *descs,
 					       unsigned int index,
 					       unsigned int nr_pages)
-- 
2.43.5


