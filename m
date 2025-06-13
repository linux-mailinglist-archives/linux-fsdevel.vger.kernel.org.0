Return-Path: <linux-fsdevel+bounces-51633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E49AD97C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58AE1BC2549
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D936628ECE8;
	Fri, 13 Jun 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2EqahGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857728ECD0;
	Fri, 13 Jun 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851470; cv=none; b=u2qztLTpTDBHkzMgXtzzOFeCsnUoz2BSxi4eAL1NY8wOXtWpHB2F9Ko8jSCWedLrUdiwkdhlemTUj06xVzIm3Z1fL95+s1vX18i2mlI9+YpuFWebrZO57OJFntESC6Utf2XqC2edq3hyddHGasZFnzBZ2iWMd6gF8P5uO+N6+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851470; c=relaxed/simple;
	bh=FBU/r+UGSIYVcOv4aGcnqI7TBaozKu2GNJwcf0KPNaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c61BqfCs+DCjdAtfCTKta5K7CLTAc9GSGFQmDgQBJgZxmHvA5O0cHDDVze10+UiX5GlEAwWibZ2PEWp7+141UPiBpZ4YKF2CW4ZVP7qcsMnhmtJ0zUv+KtFHMkg1kSbzjXGAg6wtSrTcZ/Yn4Dsi4kJOiWc0PkUf2Hzz/y1qvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2EqahGm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2f0faeb994so2887829a12.0;
        Fri, 13 Jun 2025 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851468; x=1750456268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVdqm9e2xEI8RLKg2POV+oIOY/RF1sJ8HefuwXSz8yo=;
        b=Z2EqahGm0FXtUDHj5sLYvq98C3NMQ0B9HjGhQmeWPji8zUfSBgKova32dpDPlcxGAS
         j508HJQtoYI/UAPrnu1GUO6sX3BUdcm5WFDb9I/gnedJabvwUGuDr0hxWHIPmreFhT9Z
         hhGRkj28UGjZTyWwNmThCffn4JDiIVFj4u7zAD+GPWafWrZfKFkoi9Je6gMFnCURgG0l
         sDlHrIwjxiNj12+s+lyDxjBub31j2rjndbyRodH+9ttiy3TKsruxX8AX28VavGRlUcyG
         PzZIrEwqUfYDnQtmHkC68jBsSGfY82X1PvmRUk03V7bBhGcMYJoDHIWhk6BUEdGsahJf
         1j7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851468; x=1750456268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVdqm9e2xEI8RLKg2POV+oIOY/RF1sJ8HefuwXSz8yo=;
        b=tJSTkQQFidjUHd7+t7/bvwIiQ17BN3cohMAuRKu7nvUaCaTmRSzHLjnrFRDAofLy2E
         lkhc5hzDZeX/EqZq61RAsiza8F3Q62wf+QXOC/WMcE5AdY5UURi9zMD0bySTySITAFNn
         t3tPDv2nWsO1T+7HKgbCm6St0NbNLgUxbFLUWyJSXjoQiHkIwkk8QeoNxB4i3C1JOhB6
         hUDT0awglXAl7qdfwYlofxvkfiCl8F20i8quYiZLBxURhlCO3r6N1k0hI4cxy/DeSbLg
         NWcloGQs8qLcsA5laTlmXQ6n6RDlgQkgWL9Z2TXOgdlPdX+LFzAZyeoLv54VCLp+Lf2M
         7x4g==
X-Forwarded-Encrypted: i=1; AJvYcCVBmXlroQsfEaxLUUQCE3ubTK4WyplYLyk8QL8Oi6O/7VllY6gF23Ked35HpmWne6UZWBTPCwDQURk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJhz9qIMoqMhZmF1Mw1SzwZmARyVZF9hh5D6tp7vLHlLIV8K1d
	aK8N6EFCoOP+ViE2uBUnPi2vS1mOU+GLhD8GS5Ug/ds5KZJ/g+N6NIRuDKQtNA==
X-Gm-Gg: ASbGnctxXOSC61xDSmy5yotevMzhkb7fmRCQE3cFuJoeHNdLY/BvHPjS1zDJ1Sl/VCQ
	4FhQWXcfpyHYX/dF2GXJeb2OV+5aN+8ZM0juxh8S2Cv4xKpc33rpxPuy1EUE6MGLlLc0C3aRWQD
	qrs0WR668IjssmX/vhQVmsLDkvJwP4Ybuh+PdUJzSO1Mq2pyIZVfnUYc/HEKRKYU4PKT4i496HQ
	PMgUzZrqqfvUW+lMirqQCYTJaJN4DWxE0A3BzJZ98sZUXkHREjJ2lSgjPw+rovYaVEccezaVqNP
	fQVcPfkC4Bzz6lMJOaI3iWPhoKoeD2Zd7dBZpEdRslVdezVZ5+vFgN8ojQ==
X-Google-Smtp-Source: AGHT+IFoIgpOtysqnMc+m5QXMBqa6mQ5VhY9ZK7PbT7PXwePnBQra9/O5TiSTjrdAvYabVEFb0Ft9A==
X-Received: by 2002:a05:6a20:6f8e:b0:21e:f2b5:30de with SMTP id adf61e73a8af0-21fbd55aec5mr1343218637.12.1749851468072;
        Fri, 13 Jun 2025 14:51:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca87sm2149661b3a.2.2025.06.13.14.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:51:07 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 13/16] iomap: add iomap_writeback_dirty_folio()
Date: Fri, 13 Jun 2025 14:46:38 -0700
Message-ID: <20250613214642.2903225-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iomap_writeback_dirty_folio() for writing back a dirty folio.
One use case of this is for laundering a folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 27 +++++++++++++++++++--------
 include/linux/iomap.h  |  3 +++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 25ae1d53eccb..d47abeefe92b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1518,7 +1518,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
+static int iomap_writeback(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1541,10 +1541,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 
 	trace_iomap_writepage(inode, pos, folio_size(folio));
 
-	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
-		folio_unlock(folio);
+	if (!iomap_writepage_handle_eof(folio, inode, &end_pos))
 		return 0;
-	}
 	WARN_ON_ONCE(end_pos <= pos);
 
 	if (i_blocks_per_folio(inode, folio) > 1) {
@@ -1602,9 +1600,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * But we may end up either not actually writing any blocks, or (when
 	 * there are multiple blocks in a folio) all I/O might have finished
 	 * already at this point.  In that case we need to clear the writeback
-	 * bit ourselves right after unlocking the page.
+	 * bit ourselves.
 	 */
-	folio_unlock(folio);
 	if (ifs) {
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
@@ -1633,12 +1630,26 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 		return -EIO;
 
 	wpc->ops = ops;
-	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
-		error = iomap_writepage_map(wpc, wbc, folio);
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		error = iomap_writeback(wpc, wbc, folio);
+		folio_unlock(folio);
+	}
 	return iomap_writeback_complete(wpc, error);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
 
+int iomap_writeback_dirty_folio(struct folio *folio,
+		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
+		const struct iomap_writeback_ops *ops)
+{
+	int error;
+
+	wpc->ops = ops;
+	error = iomap_writeback(wpc, wbc, folio);
+	return iomap_writeback_complete(wpc, error);
+}
+EXPORT_SYMBOL_GPL(iomap_writeback_dirty_folio);
+
 void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 		size_t len)
 {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3115b00ff410..95646346dff5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -478,6 +478,9 @@ void iomap_sort_ioends(struct list_head *ioend_list);
 int iomap_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops);
+int iomap_writeback_dirty_folio(struct folio *folio,
+		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
+		const struct iomap_writeback_ops *ops);
 
 /*
  * Flags for direct I/O ->end_io:
-- 
2.47.1


