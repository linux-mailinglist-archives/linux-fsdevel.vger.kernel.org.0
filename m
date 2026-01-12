Return-Path: <linux-fsdevel+bounces-73247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 439E2D1359D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1635F30D4D1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637022DF146;
	Mon, 12 Jan 2026 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXTXWuSH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8n1o7XT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9F2DEA8C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229434; cv=none; b=BwqEBPwcvQrCZQUt7ak6ixwuCvGqQPLZnf5xINRZP1l2bqjymst8ol+wyWm3KqrgAV3D8K5SOimFVK8K0qGJbTwvxQylqU3s7+3imi9z72M9szn6cUx0ae6iC0VXi2PK7jhLX4INsqXqPdjQJkTu8qJ6qVr8z4rpHTNgZYP+tCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229434; c=relaxed/simple;
	bh=3384MX6zXSIApStU5JP/fZm7FYVREy8tDDE1SfwQbZ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQMpJ+U/6G0Yt0hNmArcKfLF1Yh9OTUb1GB4Tw0DmFPoQaZSzWgxTo3NvgTttqkLO+rKD05h3ndkLabczMtDsyXVldB08O9brIcVDX97D3PlgAB4qRG6QWA9WfhJ4Ax16aMG5ndeghjD25SPOqx0VDeS6b1Q5QxJwf+IshiUAq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXTXWuSH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8n1o7XT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LD1s0aFQaY6k/iWg5eXUZs+8qWPLWbjMvZxwOxc5JxY=;
	b=cXTXWuSHZ5rIKR8zjRTBaXwRwNLs4xFKyhnulCbf7MtpvnJ83twuvGQQKn4X3w3T36mS01
	gbGtKIl8Eb66arrRIY20ONgg1oc5UBSNeWT6oEAmA8sx1CfeLW/gBxFvAwSvkZBTU/YrRg
	OdWuwW+D39xoXIVEqtRW6438s84DfaI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-RG4A0FMLMEuf6urHZbPJrQ-1; Mon, 12 Jan 2026 09:50:30 -0500
X-MC-Unique: RG4A0FMLMEuf6urHZbPJrQ-1
X-Mimecast-MFC-AGG-ID: RG4A0FMLMEuf6urHZbPJrQ_1768229428
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8701569041so246410966b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229428; x=1768834228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LD1s0aFQaY6k/iWg5eXUZs+8qWPLWbjMvZxwOxc5JxY=;
        b=Y8n1o7XThtFfq2W0xTS/+xKgRv8BjsBjrjtK3updjadBc+t8F9dEozbyLfPWrQHCb8
         ysA185c/g4zbJSk/u3K3z/dZFsZdB+X3CwqwVLca902BcPqUZlXlVjkvXQR2kFUfrFLE
         MmNBkBI5Ia2ejUE6YPJV1FxwYhtUX7E20IjZTfwW2ZX6WQ6Xb0U2OuxH1SnLEC0TZ5qp
         RH4AnCIE2C6AZScGnCYUMZMMj7thxJeclNJMV/vEf4ozfFHKGE+yeIK5kU1XEw7oZN5M
         YycRP7DiuiuWNfg81834m0L9Ol1vkhEMtWbe9vL5EbelIALmxSo4wejqm4gEOuUJ18Hf
         ymkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229428; x=1768834228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LD1s0aFQaY6k/iWg5eXUZs+8qWPLWbjMvZxwOxc5JxY=;
        b=v7QLhnrH422r069RFl4ZD/t4znVZNj/Zkk3UBLj78xXv1OeCnIsE5kC/Iqe6XkTKUy
         uyUY6Hi4j7xTMR4QPjdupZlan3+rXrMams/5HHZlH1PCHfQUb13vOBmP6bkpe2edYfFH
         Hz34WwScM7L16Gp5iSKRf/VGl+pDPMnxYcUBz/zA1frERg9ODDWXXoOduv9UKLyV+lTP
         /4De7PUfyTl+wVMw7Wq/AFTAKNQp0yxezAdUFiEkigc4QFYj0akYTvak8Dqds6nLoYNJ
         uipqEQqaLUNI3NC1iTNreigr9aT44zGPQfqGLh1evbdFoIqyuKfJlgFRi3mk8PDcCamv
         93aA==
X-Forwarded-Encrypted: i=1; AJvYcCUm3rwHTB8J0SmvN8OCQ7eLGp6QOupgx5IhG/Xltw9UcIVYkZODXccwHOECw6rvC1UkjOEsmZbu3yMC5Mrb@vger.kernel.org
X-Gm-Message-State: AOJu0YxckhEhsBLhBt8vXWGdojKeFqHUgnA89sa/WBVYJcFZ164gTOsj
	+cROagMSgN3wqBt2dERe4ROC/SA7jVd4i1uu6zyVaNxVDjChnX7ZZajDcri3HRac4VjOc1Hftzp
	fKR6tMNKOdTYG945utwCJzHLbasjPIXNVZh5lMs/nbds52Jqz88Ra4RcJ3XIhfS7ShA==
X-Gm-Gg: AY/fxX7Y/hBvRMB5SyAoMJIp2hlskp6YeHl5RDed3o2fMtZEQCYbNs3SPhlObSjCUtJ
	Artd78WmZolVtuj0Uo+ybWhuFX354jvg4LqIY6ItTMb1sP0Ilz3QsRrZqACFvHnAYMCKr8var0v
	BiHh4MwbtuGurI5vcdof6XxaMFDDws6iIFvcLgggdFXIoFJ1UPln+yOyY3Y7eqRgQPGD8U30SGH
	79CfredSRr8gpBciyddirbxv8aBVzq8tfrQc2WyzTtGrbj1jxFGkYMv9eid4uy3C5ClR8meOUcs
	/Dg/BJ9HRIjDZBLq6bt1M4CZWF8tUOy35CHlYilITzndP6RWFUlWvZgXZMqeXjOLsnmqMgWP5Ys
	=
X-Received: by 2002:a17:906:d54d:b0:b84:200d:15b5 with SMTP id a640c23a62f3a-b8445179fd0mr2009470566b.31.1768229427759;
        Mon, 12 Jan 2026 06:50:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgf2rNb0nwbU234Uvl4tcrsdm0xI956tFs+HVTMG9EpCfOOEbkI00Z9C9XD5sHcMxrpH/5KA==
X-Received: by 2002:a17:906:d54d:b0:b84:200d:15b5 with SMTP id a640c23a62f3a-b8445179fd0mr2009467166b.31.1768229427158;
        Mon, 12 Jan 2026 06:50:27 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f61d2774sm723855366b.41.2026.01.12.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:50:26 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:50:26 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 5/22] iomap: integrate fs-verity verification into iomap's
 read path
Message-ID: <fm6mhsjqpa4tgpubffqp6rdeinvjkp6ugdmpafzelydx6sxep2@vriwphnloylb>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

This patch adds fs-verity verification into iomap's read path. After
BIO's io operation is complete the data are verified against
fs-verity's Merkle tree. Verification work is done in a separate
workqueue.

The read path ioend iomap_read_ioend are stored side by side with
BIOs if FS_VERITY is enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/bio.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/iomap/buffered-io.c | 12 ++++++++-
 fs/iomap/ioend.c       | 41 +++++++++++++++++++++++++++++++-
 include/linux/iomap.h  | 11 ++++++++
 4 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index fc045f2e4c..ac6c16b1f8 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -5,6 +5,7 @@
  */
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
+#include <linux/fsverity.h>
 #include "internal.h"
 #include "trace.h"
 
@@ -18,6 +19,60 @@
 	bio_put(bio);
 }
 
+#ifdef CONFIG_FS_VERITY
+static void
+iomap_read_fsverify_end_io_work(struct work_struct *work)
+{
+	struct iomap_fsverity_bio *fbio =
+		container_of(work, struct iomap_fsverity_bio, work);
+
+	fsverity_verify_bio(&fbio->bio);
+	iomap_read_end_io(&fbio->bio);
+}
+
+static void
+iomap_read_fsverity_end_io(struct bio *bio)
+{
+	struct iomap_fsverity_bio *fbio =
+		container_of(bio, struct iomap_fsverity_bio, bio);
+
+	INIT_WORK(&fbio->work, iomap_read_fsverify_end_io_work);
+	fsverity_enqueue_verify_work(&fbio->work);
+}
+
+static struct bio *
+iomap_fsverity_read_bio_alloc(struct inode *inode, struct block_device *bdev,
+			    int nr_vecs, gfp_t gfp)
+{
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(bdev, nr_vecs, REQ_OP_READ, gfp,
+			iomap_fsverity_bioset);
+	if (bio)
+		bio->bi_end_io = iomap_read_fsverity_end_io;
+	return bio;
+}
+
+#else
+# define iomap_fsverity_read_bio_alloc(...)	(NULL)
+# define iomap_fsverity_tree_end_align(...)	(false)
+#endif /* CONFIG_FS_VERITY */
+
+static struct bio *iomap_read_bio_alloc(struct inode *inode,
+		const struct iomap *iomap, int nr_vecs, gfp_t gfp)
+{
+	struct bio *bio;
+	struct block_device *bdev = iomap->bdev;
+
+	if (!(iomap->flags & IOMAP_F_BEYOND_EOF) && fsverity_active(inode))
+		return iomap_fsverity_read_bio_alloc(inode, bdev, nr_vecs, gfp);
+
+	bio = bio_alloc(bdev, nr_vecs, REQ_OP_READ, gfp);
+	if (bio)
+		bio->bi_end_io = iomap_read_end_io;
+	return bio;
+}
+
 static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->read_ctx;
@@ -42,26 +97,27 @@
 	    !bio_add_folio(bio, folio, plen, poff)) {
 		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
 		if (bio)
 			submit_bio(bio);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
-				     gfp);
+		bio = iomap_read_bio_alloc(iter->inode, iomap,
+				bio_max_segs(DIV_ROUND_UP(length, PAGE_SIZE)),
+				gfp);
+
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
 		 * what do_mpage_read_folio does.
 		 */
 		if (!bio)
-			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
+			bio = iomap_read_bio_alloc(iter->inode, iomap, 1,
+						   orig_gfp);
 		if (ctx->rac)
 			bio->bi_opf |= REQ_RAHEAD;
 		bio->bi_iter.bi_sector = sector;
-		bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(bio, folio, plen, poff);
 		ctx->read_ctx = bio;
 	}
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 79d1c97f02..481f7e1cff 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -8,6 +8,7 @@
 #include <linux/writeback.h>
 #include <linux/swap.h>
 #include <linux/migrate.h>
+#include <linux/fsverity.h>
 #include "internal.h"
 #include "trace.h"
 
@@ -532,10 +533,19 @@
 		if (plen == 0)
 			return 0;
 
+		/* end of fs-verity region*/
+		if ((iomap->flags & IOMAP_F_BEYOND_EOF) && (iomap->type == IOMAP_HOLE)) {
+			folio_zero_range(folio, poff, plen);
+			iomap_set_range_uptodate(folio, poff, plen);
+		}
 		/* zero post-eof blocks as the page may be mapped */
-		if (iomap_block_needs_zeroing(iter, pos) &&
+		else if (iomap_block_needs_zeroing(iter, pos) &&
 		    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
 			folio_zero_range(folio, poff, plen);
+			if (fsverity_active(iter->inode) &&
+			    !fsverity_verify_blocks(folio, plen, poff)) {
+				return -EIO;
+			}
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
 			if (!*bytes_submitted)
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 86f44922ed..30c0de3c75 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -9,6 +9,8 @@
 #include "internal.h"
 #include "trace.h"
 
+#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
+
 struct bio_set iomap_ioend_bioset;
 EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
 
@@ -423,9 +425,46 @@
 }
 EXPORT_SYMBOL_GPL(iomap_split_ioend);
 
+#ifdef CONFIG_FS_VERITY
+struct bio_set *iomap_fsverity_bioset;
+EXPORT_SYMBOL_GPL(iomap_fsverity_bioset);
+int iomap_fsverity_init_bioset(void)
+{
+	struct bio_set *bs, *old;
+	int error;
+
+	bs = kzalloc(sizeof(*bs), GFP_KERNEL);
+	if (!bs)
+		return -ENOMEM;
+
+	error = bioset_init(bs, IOMAP_POOL_SIZE,
+			    offsetof(struct iomap_fsverity_bio, bio),
+			    BIOSET_NEED_BVECS);
+	if (error) {
+		kfree(bs);
+		return error;
+	}
+
+	/*
+	 * This has to be atomic as readaheads can race to create the
+	 * bioset.  If someone set the pointer before us, we drop ours.
+	 */
+	old = cmpxchg(&iomap_fsverity_bioset, NULL, bs);
+	if (old) {
+		bioset_exit(bs);
+		kfree(bs);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iomap_fsverity_init_bioset);
+#else
+# define iomap_fsverity_init_bioset(...)	(-EOPNOTSUPP)
+#endif
+
 static int __init iomap_ioend_init(void)
 {
-	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
+	return bioset_init(&iomap_ioend_bioset, IOMAP_POOL_SIZE,
 			   offsetof(struct iomap_ioend, io_bio),
 			   BIOSET_NEED_BVECS);
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 7a7e31c499..b451ab3426 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -342,6 +342,17 @@
 		iter->srcmap.type == IOMAP_MAPPED;
 }
 
+#ifdef CONFIG_FS_VERITY
+extern struct bio_set *iomap_fsverity_bioset;
+
+struct iomap_fsverity_bio {
+	struct work_struct	work;
+	struct bio		bio;
+};
+
+int iomap_fsverity_init_bioset(void);
+#endif
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);

-- 
- Andrey


