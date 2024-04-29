Return-Path: <linux-fsdevel+bounces-18175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F7F8B61BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37E42868CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1713AD2F;
	Mon, 29 Apr 2024 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcS4ErJs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3513A3E5;
	Mon, 29 Apr 2024 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417914; cv=none; b=pCAyk5Ie0fp9DKJRXTyUH4JKX24cS61BmHPIRbQ/fVbCm5Agav76SHlDEsHHXCE/Bv8gOWsFGRpGtYJiCC9x29/zMX6jtmKaWz8Y5pmmwvktkQL4OozGCYaiypYVDyyE7z/gY5duRsKIefAQqoJnii/en9jLbMywL87mq3vbDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417914; c=relaxed/simple;
	bh=aBlwHG+XSz2inbaFgGCXbG0yr6uY/trtijVmQNmku2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5wMI8c0A669c0cdX1r0aZiK4Ahux5KXCzes6kzNmnXGf5feI8huUIcXKN03klo5xwaEQ1rsXD0e6whfHcNQk5QibRGyQ1YJhTE/I7uQw488kwNFW2epLtX0vUgfx7qk3spZcb5pBrZ3NM0BELTztKdAqdP+0hZ2ceZsSWab2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcS4ErJs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso4028539b3a.0;
        Mon, 29 Apr 2024 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417912; x=1715022712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/1bORWOEMtQqR5EeJUVgL0AX3aI0603PhY0Dzu9DVzE=;
        b=IcS4ErJsjpy550acoJoLVe0uzHganOhk2s7EDEfUqDM+WzbntpTp6/ukob6/n0TvkM
         1jAdHlpdfesbTsmR06/xHMbbofY4ECH/7U+UG/jzB/ARt+n61Xht6gv2Bt6k1JO8VzQU
         rei8uXlOBarMQ3GSdnMTOvDyNeKT8mejVfKbhfvUCNo/CIxvIBoyU9BtFJcbbv/haVdc
         7svK4EZCIhe9EoUHQ9WhwnsWq4URAB67D83M3wzEzBcIYYN6YB+BsNDTdyxpxXadHmnS
         vqapbA8lyUbjHjU1OiPMXOtnz/8M/xnKFw3U10Uzlw0hWJYf8HlVlPphpv1n7jO+8V3f
         R3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417912; x=1715022712;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1bORWOEMtQqR5EeJUVgL0AX3aI0603PhY0Dzu9DVzE=;
        b=Sf3h//fxHy4BIfZoMWcsjlVcpfMkW8Um6iP6S9YA5xOWGpLMiSzIO8KmUFbjosKqvu
         l7UDf2gZtOT2eEHkXZDV1R9wAD4Z9SQBxP/972WT3vhYpLT1IQdub4cb2keYPAdUCZL/
         E+Br7JvZa9rdu3qhXsu96J5jA9bMtt9+E3TVtyHt2e150s733E5/7QpPuxS66/EZxwMG
         /jOKTE3zbxO3qFosgMXZN+U1nButWrFNFYdHybpX3dvhB6mN59L7ersbEAs2QfJAd4e+
         NOIWxeMR/qy/qpBzlEhiCgatKd3h1sdM8Murw2T4nNvCNoiwv5yUOmeiC+RrUAo7ibVG
         DdiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNW5p5hBSvUY+D8IJHknE1GV+07QaVpTkl7lsJGhE3dBAS+4XnfkXzJmouJ8nK7fRNpYYkaGDYRBjlOxwXNQpUh3mRhxk0CEFDwmgbtWRizIY5xdBpwcMEU9Y2+S9W3TMPzBFKQo1ljaL3hw==
X-Gm-Message-State: AOJu0YzbGT8c+ebb8xSTVyihUga99Krw/fzmWkpkmxrr/d39VvJq+Bdp
	zFYdQF3NYmHh802exOzb3WiYeMWQEmxj0XaxShzAjUULcwyV/N49
X-Google-Smtp-Source: AGHT+IGx8aY8FR50gdhXj18Vz7j7jddJ8qW0aYfCyeOPPSYXuiUjoJ/c7FOQYDIpxGDCtkTEqeM7Ww==
X-Received: by 2002:a05:6a00:2186:b0:6ed:cd4c:cc11 with SMTP id h6-20020a056a00218600b006edcd4ccc11mr431263pfi.25.1714417912024;
        Mon, 29 Apr 2024 12:11:52 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006ed38291aebsm20307988pfl.178.2024.04.29.12.11.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:11:51 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 08/12] nfs: drop usage of folio_file_pos
Date: Tue, 30 Apr 2024 03:11:34 +0800
Message-ID: <20240429191138.34123-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

folio_file_pos is only needed for mixed usage of page cache and
swap cache, for pure page cache usage, the caller can just use
folio_pos instead.

After commit e1209d3a7a67 ("mm: introduce ->swap_rw and use it for
reads from SWP_FS_OPS swap-space"), swap cache is never exposed to
nfs and it can't be a swap cache page here, so just drop it and
use folio_pos instead.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 fs/nfs/file.c     | 2 +-
 fs/nfs/nfstrace.h | 4 ++--
 fs/nfs/write.c    | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 407c6e15afe2..02741c32e114 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -588,7 +588,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%lu), offset %lld)\n",
 		 filp, filp->f_mapping->host->i_ino,
-		 (long long)folio_file_pos(folio));
+		 (long long)folio_pos(folio));
 
 	sb_start_pagefault(inode->i_sb);
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index afedb449b54f..d249741452e1 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -960,7 +960,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
-			__entry->offset = folio_file_pos(folio);
+			__entry->offset = folio_pos(folio);
 			__entry->count = nfs_folio_length(folio);
 		),
 
@@ -1008,7 +1008,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
-			__entry->offset = folio_file_pos(folio);
+			__entry->offset = folio_pos(folio);
 			__entry->count = nfs_folio_length(folio);
 			__entry->ret = ret;
 		),
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 5de85d725fb9..fc782d889449 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -281,7 +281,7 @@ static void nfs_grow_file(struct folio *folio, unsigned int offset,
 	end_index = ((i_size - 1) >> folio_shift(folio)) << folio_order(folio);
 	if (i_size > 0 && folio_index(folio) < end_index)
 		goto out;
-	end = folio_file_pos(folio) + (loff_t)offset + (loff_t)count;
+	end = folio_pos(folio) + (loff_t)offset + (loff_t)count;
 	if (i_size >= end)
 		goto out;
 	trace_nfs_size_grow(inode, end);
@@ -1362,7 +1362,7 @@ int nfs_update_folio(struct file *file, struct folio *folio,
 	nfs_inc_stats(inode, NFSIOS_VFSUPDATEPAGE);
 
 	dprintk("NFS:       nfs_update_folio(%pD2 %d@%lld)\n", file, count,
-		(long long)(folio_file_pos(folio) + offset));
+		(long long)(folio_pos(folio) + offset));
 
 	if (!count)
 		goto out;
@@ -2073,7 +2073,7 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
  */
 int nfs_wb_folio(struct inode *inode, struct folio *folio)
 {
-	loff_t range_start = folio_file_pos(folio);
+	loff_t range_start = folio_pos(folio);
 	loff_t range_end = range_start + (loff_t)folio_size(folio) - 1;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
-- 
2.44.0


