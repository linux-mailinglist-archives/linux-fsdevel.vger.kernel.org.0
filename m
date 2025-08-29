Return-Path: <linux-fsdevel+bounces-59677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA8BB3C5AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7717C3D4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0264530F7FD;
	Fri, 29 Aug 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrL/89/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913E3148CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510805; cv=none; b=HG6MQ8B2kPW0r3Ui4VbrsMS6QYVhF9Y4jQUHk0D/8XbDuz1Do7GX4/MAighPVVfq+2/wCXCmq+eWderwGyLE1MNxjzSsv22YhwSnBlSkVvzN05svFxgcIssVizU5aYQfh8txXUh9LBX2vS8UcWBMcynHzk3SqhjlCk9TqYK3J5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510805; c=relaxed/simple;
	bh=gbovNzPq1yDJ1RfZzzNt05274RSG+sAHDMdtFW6IT2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcQ0lWJf9eGl6OW/ry1rB09praME4lf5kn2YSwd2mrHT+IM3U3A8BqhWN1U2fTj4agMP4c6WrTJXgnnzwMvQEdoc1qMJJ3pXYqKtPVJLBGAcombsSty4lRyVakr0ze87f3d5g7Q+htFc3HePUywfOxBgufQUe3Bz34OM/2oL2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrL/89/R; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso1792854a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510803; x=1757115603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqkXwnI3JgfLupCk8pn/b3nuyLdeqqb8x+Tb7fP5PEI=;
        b=WrL/89/Rl3VDnVYVC0mKHmnivGpwU35DAJmgm3xk/6Qpa2znIftyo35sT4axvbOT6S
         ScMSdnmCsG8GyHeHjx+MOwOZypZGUMr4Ika+4csmr6rzXSbH/mso3YphybpW6TWO5NuI
         059VQ/SvTPiiEtoXiqYFt302QHxlZgK2s/b79sisZom6bAPLzfkrnHzXfnFMCgM3ry2F
         TEfc0DBC8d/NSkdh903k8HvXlJqd3MysjwlNyIp527ifSS0BX9avTLgpHyeKJ9v61Ju7
         ziW4AU/G6/VNvmSXjyKXURA5IYgxM1/b2rEj9bKW3E3/iNyu1YFxGmY+K8WGtLxAzqA7
         jNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510803; x=1757115603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqkXwnI3JgfLupCk8pn/b3nuyLdeqqb8x+Tb7fP5PEI=;
        b=inPDNxV1+GvlKeFisKd9N8FQNqvdDIkQE5PzndAg2+nhrHbTvfi//I94DLlwaHK86n
         DTWjGry5DXESVnAss28K6udh8M3FiTWbu/yClngB0u+Hp8zPtf0DEyQTuQiQYOx5iLqX
         Fw4omWbx1TGFzHqYybYVgSUpr7tOAj69c7ljMBGFv4EjDRfO97bl7kVjGU4wCV4Ok/X1
         ad2+pq6s4kC6K9joFkImWTsCp2NE5eUjWUEBeDuxr1GfDJI7UfuDXzwQeBeZw5+zH5Xy
         Ik9JG1VrPIbBrEZvn/dHvddVWsuaC3GIWhBT1eOebul1705lz2x+Zy0/NmCoshUkY6kD
         Xo+w==
X-Forwarded-Encrypted: i=1; AJvYcCV6rXs7wQ3Ito6FPcIKZzTZvhnptxmV1QHx80iD3YnKZ0t9cKlYeeawsfG9KgmgV73F84vPbJ/MyyZaPuyb@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjzFvJIE2OMQQCN1wFYMmltwwE9Xu2YG7skrnO9rin0Igtoz1
	6QlQsr422x9cjQyhzwl9YD71zhB/Em8JvqtjX+G6+kIKAY/ELqIrX0VjwcFX1g==
X-Gm-Gg: ASbGncsjrIW1lBX+cVjZsHEP6YKiRe2Dfme9Ph9G6rtXj3bYRMDrSJlsWbPgpHqI5cL
	6zgCUarW/wMkxVTl4+jb5FWqBr6Yq/hEZkRy7UhPPOKoMXhh7OsKdq8jvz9QQ9IQO04fVNPjf6o
	v46923gVrsdybFxeZNOGA7mph/huKFhbQU6q1wyS9SG+yG7NNVzOHcvXf2POgBcvB4lCxCC4WIh
	MfsRkXqt6kITgSljfb4UTICky38HQbEFQRX7qwL1AW9JSNBriF4EBcSlKgsb0mKE26Vp6Xz87e6
	TcdM82aokR/A4vtAoZuCi+ttMzZoaNxXiGLVw+udbhZbDBafc2zokkJaBoyB5WUjZ7Lzhp1L4fM
	TwYHet9ZubDkLU8Bs3A==
X-Google-Smtp-Source: AGHT+IEy5ad1gcp2NQjvD6GIoyd4Xk1IGsyA1OtBH8eJw+FIwHlx6V0pvax8TukX/YXSq6cGEXLrNA==
X-Received: by 2002:a17:90b:1a8f:b0:325:ce00:fcb4 with SMTP id 98e67ed59e1d1-328156e1719mr529443a91.31.1756510803321;
        Fri, 29 Aug 2025 16:40:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4ba1d8sm3509155b3a.51.2025.08.29.16.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:40:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 09/12] mm: add clear_dirty_for_io_stats() helper
Date: Fri, 29 Aug 2025 16:39:39 -0700
Message-ID: <20250829233942.3607248-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829233942.3607248-1-joannelkoong@gmail.com>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clear_dirty_for_io_stats() which clears dirty stats corresponding to
a folio.

The main use case for this is for filesystems that implement granular
dirty writeback for large folios. This allows them (after setting the
wbc no_stats_accounting bitfield) to update dirty writeback stats only
for the pages in the folio that are written back instead of for the
entire folio, which helps enforce more accurate / less conservative
dirty page balancing.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/writeback.h |  1 +
 mm/page-writeback.c       | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index f63a52b56dff..2ae0bea03d48 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -375,6 +375,7 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void writeback_set_ratelimit(void);
+void clear_dirty_for_io_stats(struct folio *folio, long nr_pages);
 void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e0410cfbe480..726da7611cce 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2709,6 +2709,22 @@ static void __clear_dirty_for_io_stats(struct folio *folio,
 	wb_stat_mod(wb, WB_RECLAIMABLE, -nr_pages);
 }
 
+void clear_dirty_for_io_stats(struct folio *folio, long nr_pages)
+{
+	struct address_space *mapping = folio_mapping(folio);
+	struct bdi_writeback *wb;
+	struct wb_lock_cookie cookie = {};
+	struct inode *inode;
+
+	if (!mapping || !mapping_can_writeback(mapping))
+		return;
+
+	inode = mapping->host;
+	wb = unlocked_inode_to_wb_begin(inode, &cookie);
+	__clear_dirty_for_io_stats(folio, wb, nr_pages);
+	unlocked_inode_to_wb_end(inode, &cookie);
+}
+
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
-- 
2.47.3


