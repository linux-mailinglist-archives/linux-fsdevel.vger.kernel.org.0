Return-Path: <linux-fsdevel+bounces-30745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA498E13B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865601F23B72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBEC1D150E;
	Wed,  2 Oct 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEXy3jKh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F01D14EE
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888124; cv=none; b=qZiFnz5l57HCsJzQJOx/S6cTc0l/VvWsPO9cJAStz3y5ggnSSjhFrf8QeES0XENnRjykfXga+ZVC9Smk0Xw0py/L8Nuo0Jp43v8s/uEj4jti35O7O3gQXUdSxO3drBJFgkBGsO3wORsOL6Tvhhh3Sh3HugrWVVm/pVqESHldZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888124; c=relaxed/simple;
	bh=ssN7tBE8lYbB+5aGnRMVsR8M6WaI6EOggCrrcQBOdtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6CRAPJQ70ZPgeNvQS6f5eRvrZovc1yPmpcfA8A+MMjKKWFuc6bky3BHt9803ZEMSDrHftb7NyU4P+JbbfTCGZJYPSfQkxajxw0IOwjP2A4IthcrO9Z54w7QJe41tP9aVHocMPpvDAWRYepR/p1/YnRJtWTe971o9vP1GtTabX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEXy3jKh; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e25cf3c7278so6561546276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888122; x=1728492922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2Q3GPbgR3UjdeQnqUixUH/X5MDsikJgv+rC31/FUNg=;
        b=SEXy3jKhed1Kkt4qaGowTIBAMp8s/pHPpSDaHv3zosPEdpbiyl/xhfch6MtC+NaWkl
         2tc2KXOVS+4qZSIWD9QqUAgDh66nIwTRFK14m87DRlC85jy2034ReVXSVS7AR7gQPW+S
         4307HLgm0YrdIyDJ4VpCbYwn1LXRiq12xoa0IyXWo6ub3uxXM6H1n6KgORfo67xlwZ+K
         rHwU9jdDcYOM6p9dF699O8qRv5KmTQEackxZXA2ChXH1tFSx7jVY/HZofba4pvCY4+0y
         9A6KOahbgYzwRJXKTtr3U9aC5akDMun8WPVWMw76H696crQXEGaeZMDhFS2jnRxiswYz
         Oblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888122; x=1728492922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2Q3GPbgR3UjdeQnqUixUH/X5MDsikJgv+rC31/FUNg=;
        b=WVFAkrOB3KMmCMHC6Lo6ywuuKz+cP2C4MJxCXVQb4IRAuPU04ZntGE9QRzRKR2IkoL
         Q0DQyHC0KkyO/eiPyg+tNeeM8rrbSCzyyyew02433JUHVH5v8AvGZyxgy1I1akuPWJ/Y
         /HwsMx0qDTuo4Ys58HWrc5XyH7cBcFbkqpU3dGMd7SQIlwBc/ImdnAKJltqJtSLllF9B
         5qLniDU1d3BAXgI1SPLurP0WIQ/KcaYO487RdmUiljipM5H1G//Zsk0HrPpxTDzmfue2
         7iLB7fkx9psNvDEWx79KSHd126BIwJi9PD5ov/cb5DWFntBij1MWRkTr3fbnsQGwHldm
         +gUA==
X-Forwarded-Encrypted: i=1; AJvYcCVMveZUgi2Zr+a1UHSh1tKZWgZbIrLzV1s1u+8Hln4WeQbT27RYmv/60sMiy+/qMRb3iQw72tTnd3dNCqje@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RzllaippfL0AyMSGMQNdUlFeIP5qIKR5WJUC1IW+Lvmc03HM
	KXJNpjB7o15s/dm2oFsHeR+TLzfQlho8DNrQhiVj2Qgd//Lnk7ow
X-Google-Smtp-Source: AGHT+IEeO9DTfllnXAI4QYhhcSnZgXZ0VEqDQ3zuVsqim0iA2j62cPAvIWSg8AzrtWwwBQW7pW22iA==
X-Received: by 2002:a05:6902:a81:b0:e1d:2fce:1612 with SMTP id 3f1490d57ef6-e26383b0f78mr3366829276.22.1727888122215;
        Wed, 02 Oct 2024 09:55:22 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e6c32b25sm3837085276.60.2024.10.02.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:22 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 07/13] fuse: convert writes (non-writeback) to use folios
Date: Wed,  2 Oct 2024 09:52:47 -0700
Message-ID: <20241002165253.3872513-8-joannelkoong@gmail.com>
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

Convert non-writeback write requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c   | 49 ++++++++++++++++++++++++------------------------
 fs/fuse/fuse_i.h |  2 +-
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ad419fafbd5d..0f01b4fa324c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1190,8 +1190,8 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	bool short_write;
 	int err;
 
-	for (i = 0; i < ap->num_pages; i++)
-		fuse_wait_on_page_writeback(inode, ap->pages[i]->index);
+	for (i = 0; i < ap->num_folios; i++)
+		fuse_wait_on_folio_writeback(inode, ap->folios[i]);
 
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
@@ -1203,10 +1203,10 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 		err = -EIO;
 
 	short_write = ia->write.out.size < count;
-	offset = ap->descs[0].offset;
+	offset = ap->folio_descs[0].offset;
 	count = ia->write.out.size;
-	for (i = 0; i < ap->num_pages; i++) {
-		struct folio *folio = page_folio(ap->pages[i]);
+	for (i = 0; i < ap->num_folios; i++) {
+		struct folio *folio = ap->folios[i];
 
 		if (err) {
 			folio_clear_uptodate(folio);
@@ -1220,7 +1220,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 			}
 			offset = 0;
 		}
-		if (ia->write.page_locked && (i == ap->num_pages - 1))
+		if (ia->write.folio_locked && (i == ap->num_folios - 1))
 			folio_unlock(folio);
 		folio_put(folio);
 	}
@@ -1228,10 +1228,10 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	return err;
 }
 
-static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
-				     struct address_space *mapping,
-				     struct iov_iter *ii, loff_t pos,
-				     unsigned int max_pages)
+static ssize_t fuse_fill_write_folios(struct fuse_io_args *ia,
+				      struct address_space *mapping,
+				      struct iov_iter *ii, loff_t pos,
+				      unsigned int max_folios)
 {
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
@@ -1240,7 +1240,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	int err;
 
 	ap->args.in_pages = true;
-	ap->descs[0].offset = offset;
+	ap->folio_descs[0].offset = offset;
 
 	do {
 		size_t tmp;
@@ -1276,9 +1276,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		}
 
 		err = 0;
-		ap->pages[ap->num_pages] = &folio->page;
-		ap->descs[ap->num_pages].length = tmp;
-		ap->num_pages++;
+		ap->folios[ap->num_folios] = folio;
+		ap->folio_descs[ap->num_folios].length = tmp;
+		ap->num_folios++;
 
 		count += tmp;
 		pos += tmp;
@@ -1293,19 +1293,19 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (folio_test_uptodate(folio)) {
 			folio_unlock(folio);
 		} else {
-			ia->write.page_locked = true;
+			ia->write.folio_locked = true;
 			break;
 		}
 		if (!fc->big_writes)
 			break;
 	} while (iov_iter_count(ii) && count < fc->max_write &&
-		 ap->num_pages < max_pages && offset == 0);
+		 ap->num_folios < max_folios && offset == 0);
 
 	return count > 0 ? count : err;
 }
 
-static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
-				     unsigned int max_pages)
+static inline unsigned int fuse_wr_folios(loff_t pos, size_t len,
+					  unsigned int max_pages)
 {
 	return min_t(unsigned int,
 		     ((pos + len - 1) >> PAGE_SHIFT) -
@@ -1330,16 +1330,17 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 		ssize_t count;
 		struct fuse_io_args ia = {};
 		struct fuse_args_pages *ap = &ia.ap;
-		unsigned int nr_pages = fuse_wr_pages(pos, iov_iter_count(ii),
-						      fc->max_pages);
+		unsigned int nr_folios = fuse_wr_folios(pos, iov_iter_count(ii),
+							fc->max_pages);
 
-		ap->pages = fuse_pages_alloc(nr_pages, GFP_KERNEL, &ap->descs);
-		if (!ap->pages) {
+		ap->uses_folios = true;
+		ap->folios = fuse_folios_alloc(nr_folios, GFP_KERNEL, &ap->folio_descs);
+		if (!ap->folios) {
 			err = -ENOMEM;
 			break;
 		}
 
-		count = fuse_fill_write_pages(&ia, mapping, ii, pos, nr_pages);
+		count = fuse_fill_write_folios(&ia, mapping, ii, pos, nr_folios);
 		if (count <= 0) {
 			err = count;
 		} else {
@@ -1356,7 +1357,7 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 					err = -EIO;
 			}
 		}
-		kfree(ap->pages);
+		kfree(ap->folios);
 	} while (!err && iov_iter_count(ii));
 
 	fuse_write_update_attr(inode, pos, res);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 2533313502de..52492c9bb264 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1090,7 +1090,7 @@ struct fuse_io_args {
 		struct {
 			struct fuse_write_in in;
 			struct fuse_write_out out;
-			bool page_locked;
+			bool folio_locked;
 		} write;
 	};
 	struct fuse_args_pages ap;
-- 
2.43.5


