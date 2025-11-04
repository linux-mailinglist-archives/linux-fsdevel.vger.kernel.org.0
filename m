Return-Path: <linux-fsdevel+bounces-66994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF95C32F8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F9DC4ED5C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE32EB84A;
	Tue,  4 Nov 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWVFaYw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C762E92C0
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289507; cv=none; b=ZFPjl/ORyaQFM4SjsuK3J/FDl3DgCOg+MMkf/2KAWP98tSmMlllaq5gtcU7mttaf9BUMsvDsyW12/NKZnF6HS+ZmrpypDhbsYSdlnqwtKsQXlHlsSTetOZVTYl08fus1Q6CqE3LfS7wqGfcYUj82GZQBC38egqqhwxkBE3LpXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289507; c=relaxed/simple;
	bh=Oh9+LkdaodRC67xfDuKV3e0gFGEl5lZntUtaqXNYdJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQgJR32hlpJUQeQsiTWDteEbe6ADNRYRh3YJDPTXhwEPwMpxHtbJsfK/ckOyv599azSg2s8T+oG9NLy0wtGYVEdd+1bw/ly2vSNQWykVYHJRkr/e/CbzQJkeme671qDaudLW9nHPCdnUpGdTvTVEaAlhq4YHrXAnCYbZp7Dwk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWVFaYw8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3401314d845so7952995a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 12:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762289505; x=1762894305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJmrlkLUjMakY3tvNSPG6Ts4P7UQKav3iP0c8y2qt9g=;
        b=MWVFaYw8YZq+LOOINIeykdMzCRCcwIN4j+nOtx2HOGaJJ+K8gXZxEiJpXvF4lRfS6o
         7xV9l251jgqBzpkUqf1jWlupH2lQuhNspdFqvDPUG+K1H+9sBbdWCq6dpj3D9aglGflx
         lsvF4G3qz4gQAfmWspAGvcfMzwSfGZvIVQ7GyyYoUNvE10xXEsanOm7bXd5/SG6yOsCE
         miQG/h97wWTUgRQWTsHLNfuBxeU8TH/F6f8Ogc4unJoguPNjPa95YaU5+tpVH7NthKP9
         ZwvqLrP87ma49S4B/iS54hPVRMUvFaU1bdZGCWxj5m0OoITUBfyEP98vs+jU2VSAhBEi
         1zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762289505; x=1762894305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJmrlkLUjMakY3tvNSPG6Ts4P7UQKav3iP0c8y2qt9g=;
        b=YF62LTRamMFjkstLCMXFvxt+qrpv6RiYKvbhmTEjn+C1jjimqszoNLtLXxPtrD0tuz
         /MTlNke5EZ3KS12lj9QIg2pz39Nln88mT9DWGVKJw4adY13VVd2+HaATuuYNtG0KuC+H
         5fLE+x2nusxIA3DuBfUtSVWyTofpfXK7VrcR3BfE0WQCfBA7Isjb6aHI0ymnWzO6x+8M
         EUW0fpqExyxnG06GHpX0aq0MGXMjfcTZgzqVRFc9etPxFNab+DFy69GX3HiQt8FNThTy
         L2/psz/1aD80Egbkk36Tp7mdwv/LQleQKQ2hcdCJEoJB26U4O9XsN+1WyNbJmb/DVW8w
         WORw==
X-Forwarded-Encrypted: i=1; AJvYcCW2woZrZt6bgIgIJRbExErD6APnS7Ld73PvOZU9W9F2QnoN9Dh9tGqh+kUKD6p1aszt5TUA1Rz+9g6Dzpcc@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdBre78fHiQZJTX20YS+0b70VGyM8Lyu5wqFQ0Shbjq4Hfzkt
	fQlp6c5ScQt8+yEch+VpZu90eDfKpr2MH53knVwtH/oay8U03V/teqYAU6AK8Q==
X-Gm-Gg: ASbGncv+cxz/3BUEkNpVgF+Q2Fq2Bzx55xDec9Sr+uPBlWvzdoMXSjR2vhKwTfE7FEv
	I0xqO0oV6nsS+M2zXOT9enqXVKvbp88AvY71OGAAVDqM4mwUmwxtbzUuWKMPvLfYOharF4lr7vX
	GcCi1Mx5ozcvUtcm9pujm28YrW/F5LqF/8kACs+kcgriZfLUrPMZHGtmMN3a181nzht75HzFduJ
	8GY6nzJxsEjnuTZjftyfDU+dMT6+7ALGZG3QgT/gqeZh97baCDkwl0gofujGga2jbAhepctGmIe
	0/Z8vprAw3Nn61mY8TqO9Veg+Le6hOvDhuRWPdTJzzVaDL4Cxw35BB2eih8Kdpb3mmHi8UeQ9Rw
	Oz/+wseZHIMkO9v9Pa5YipuiuXNoBh0HvSN9MSAPSi3+NbVSU+SvBGfi41YWetjL5gY6tZEPftP
	vbd9N3WfRz4fft2m0xICmhViXWJhC2lM1EiFfL
X-Google-Smtp-Source: AGHT+IH5Od91tBm5U7o5lBtemW3PRmyL1py5zFukTOI0JX8azudl8WiD+lz60US7ObMxtIKYopedPg==
X-Received: by 2002:a17:90b:55cb:b0:341:315:f4ec with SMTP id 98e67ed59e1d1-341a6bfeeefmr689330a91.7.1762289505471;
        Tue, 04 Nov 2025 12:51:45 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a6155sm3270464a12.29.2025.11.04.12.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 12:51:45 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 3/8] iomap: optimize pending async writeback accounting
Date: Tue,  4 Nov 2025 12:51:14 -0800
Message-ID: <20251104205119.1600045-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104205119.1600045-1-joannelkoong@gmail.com>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pending writebacks must be accounted for to determine when all requests
have completed and writeback on the folio should be ended. Currently
this is done by atomically incrementing ifs->write_bytes_pending for
every range to be written back.

Instead, the number of atomic operations can be minimized by setting
ifs->write_bytes_pending to the folio size, internally tracking how many
bytes are written back asynchronously, and then after sending off all
the requests, decrementing ifs->write_bytes_pending by the number of
bytes not written back asynchronously. Now, for N ranges written back,
only N + 2 atomic operations are required instead of 2N + 2.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/fuse/file.c         |  4 +--
 fs/iomap/buffered-io.c | 58 +++++++++++++++++++++++++-----------------
 fs/iomap/ioend.c       |  2 --
 include/linux/iomap.h  |  2 --
 4 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8275b6681b9b..b343a6f37563 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1885,7 +1885,8 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 		 * scope of the fi->lock alleviates xarray lock
 		 * contention and noticeably improves performance.
 		 */
-		iomap_finish_folio_write(inode, ap->folios[i], 1);
+		iomap_finish_folio_write(inode, ap->folios[i],
+					 ap->descs[i].length);
 
 	wake_up(&fi->page_waitq);
 }
@@ -2221,7 +2222,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		ap = &wpa->ia.ap;
 	}
 
-	iomap_start_folio_write(inode, folio, 1);
 	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios,
 				      offset, len);
 	data->nr_bytes += len;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c79b59e52a49..e3171462ba08 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1641,16 +1641,25 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-void iomap_start_folio_write(struct inode *inode, struct folio *folio,
-		size_t len)
+static void iomap_writeback_init(struct inode *inode, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 
 	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
-	if (ifs)
-		atomic_add(len, &ifs->write_bytes_pending);
+	if (ifs) {
+		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
+		/*
+		 * Set this to the folio size. After processing the folio for
+		 * writeback in iomap_writeback_folio(), we'll subtract any
+		 * ranges not written back.
+		 *
+		 * We do this because otherwise, we would have to atomically
+		 * increment ifs->write_bytes_pending every time a range in the
+		 * folio needs to be written back.
+		 */
+		atomic_set(&ifs->write_bytes_pending, folio_size(folio));
+	}
 }
-EXPORT_SYMBOL_GPL(iomap_start_folio_write);
 
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len)
@@ -1667,7 +1676,7 @@ EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
-		bool *wb_pending)
+		size_t *bytes_submitted)
 {
 	do {
 		ssize_t ret;
@@ -1681,11 +1690,11 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		pos += ret;
 
 		/*
-		 * Holes are not be written back by ->writeback_range, so track
+		 * Holes are not written back by ->writeback_range, so track
 		 * if we did handle anything that is not a hole here.
 		 */
 		if (wpc->iomap.type != IOMAP_HOLE)
-			*wb_pending = true;
+			*bytes_submitted += ret;
 	} while (rlen);
 
 	return 0;
@@ -1756,7 +1765,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
-	bool wb_pending = false;
+	size_t bytes_submitted = 0;
 	int error = 0;
 	u32 rlen;
 
@@ -1776,14 +1785,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 			iomap_set_range_dirty(folio, 0, end_pos - pos);
 		}
 
-		/*
-		 * Keep the I/O completion handler from clearing the writeback
-		 * bit until we have submitted all blocks by adding a bias to
-		 * ifs->write_bytes_pending, which is dropped after submitting
-		 * all blocks.
-		 */
-		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
-		iomap_start_folio_write(inode, folio, 1);
+		iomap_writeback_init(inode, folio);
 	}
 
 	/*
@@ -1798,13 +1800,13 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
 		error = iomap_writeback_range(wpc, folio, pos, rlen, end_pos,
-				&wb_pending);
+				&bytes_submitted);
 		if (error)
 			break;
 		pos += rlen;
 	}
 
-	if (wb_pending)
+	if (bytes_submitted)
 		wpc->nr_folios++;
 
 	/*
@@ -1822,12 +1824,20 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	 * bit ourselves right after unlocking the page.
 	 */
 	if (ifs) {
-		if (atomic_dec_and_test(&ifs->write_bytes_pending))
-			folio_end_writeback(folio);
-	} else {
-		if (!wb_pending)
-			folio_end_writeback(folio);
+		/*
+		 * Subtract any bytes that were initially accounted to
+		 * write_bytes_pending but skipped for writeback.
+		 */
+		size_t bytes_not_submitted = folio_size(folio) -
+				bytes_submitted;
+
+		if (bytes_not_submitted)
+			iomap_finish_folio_write(inode, folio,
+					bytes_not_submitted);
+	} else if (!bytes_submitted) {
+		folio_end_writeback(folio);
 	}
+
 	mapping_set_error(inode->i_mapping, error);
 	return error;
 }
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index b49fa75eab26..86f44922ed3b 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -194,8 +194,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
-	iomap_start_folio_write(wpc->inode, folio, map_len);
-
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
 	 * file size updates in the ioend completion are byte-accurate.
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index a5032e456079..b49e47f069db 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -478,8 +478,6 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 
 void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		int error);
-void iomap_start_folio_write(struct inode *inode, struct folio *folio,
-		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 
-- 
2.47.3


