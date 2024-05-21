Return-Path: <linux-fsdevel+bounces-19927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6968CB33A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F991C21A75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C006149E13;
	Tue, 21 May 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONr8ZiI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C899149E0A;
	Tue, 21 May 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314376; cv=none; b=Ng4HTDChqJag1R0119Rd5cIcsGlrvt0nSRs44LmYU42FeECGBfrypoqNRVnrhrInyKbMEz5wQoFeI5Ee1ijtAuMowyZ4W3eYK1T4WJhmlPRv96lBqnj3PuGkllVJK5Hpx3y7mCdktqM2baHebpydmm0YkhuqGUjOGz49z9Sws7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314376; c=relaxed/simple;
	bh=FFy+LiTwedpRsIyT68peUiF1eFVcwa9s+FW1r2ahYc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhjSuyj5xzostL2YYLt+fNZTUrtw4V7HCI0ozWLN4aOsxaSZUdcn6i8KcuHTzNkV5p30YeEOBfNcLJfj6xkdf/uFiFjKqCw28hvy5KVlxAz0xhvh03vqBaAc0EoDJOSHE8CDGa5ecOHfLeeBisTx1qtSFAFkXOUWGVHWd57JzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONr8ZiI5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecddf96313so94013695ad.2;
        Tue, 21 May 2024 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314374; x=1716919174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vrfVlxH6/yrMp6Vv9D3jm93+yp0/ZPJ6N0ZTxwsTE5E=;
        b=ONr8ZiI5O3OxDZkAjSR8dOwxsI+xG9sJZ4seyyS2xLAr1XQSQIy2waK4qxNmh6bZE5
         18b5mMaOJ/ICcI8LPr+IVlk4pCOzrmY7i1QhgFLj9FokafC3f5z2RcUnZEVl7RzCd2e7
         YiRyF6BojwJWZsA0TiTBHqmI2SVrIHKuQsZCGL5ebvZ6KZAeCve2kfIQJYhDc+E+qS/3
         OjLxn2SQ3ketIPU9GkUQzGV3Em1sMtRdrzpZsLTCrU1M/wkLg2VpI8matrZy86E2uvlm
         LHJc3JHuEQz/rNNAS6LGzLsEXy4Mxc/xlLPlWPj11kudQPaPeKXIlBpUUWjcWsouzThY
         08BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314374; x=1716919174;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrfVlxH6/yrMp6Vv9D3jm93+yp0/ZPJ6N0ZTxwsTE5E=;
        b=DOT7Fs8l7r3/TLhBUWo8Zxh+E0LbXwjRdCpWSEbFUlrBNA4hDFqI8CyJJyUpV/22Rz
         wtmxajUQvWnG7m6Kn0LDQmnCpq9/VKA+a9WreFXHQAODK6okTQXeqa+3+2+uGNJ3XzVU
         C5DVzDuOEApJmZQWSY7RbtxdAtD5iaJaDQV3x91hcElJ3ddxtgN+4pWFohmQw9D6LmwR
         IlZWMKDrd+Dc6PsXHs2nb9NjnhXKQqxgcy48tJgnD2xRrWB46Lgyi/diNxX84ozunusQ
         C7vgKK+fLSVEVa9yb82HheMhmNwU6vxgXuMQ6mUuBLT60TAWgRBLZQoUcm6C+XrKX+b/
         x+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/GkfsLLq3YiF+8woKuQM4hRonoVYtbdTh457TyjSk1b1NaGDr0gqFZXgXP+JMVg5KKoOIduAnuxyRT2eR5QYNYkXHsb3vWQlew92SSpPL/4a4SggQxJ9/vwsocJ8MxZz4w100Nr0/DVaUW188TxWjNWnFIDKhUkzXzuTP5e+nDx9g1rFQBg==
X-Gm-Message-State: AOJu0Yzg7fyfuIycjeXVQzdaqaRccVMt220xU9UBqgILgJcRt8qrklEN
	32PngBE0Ktjq2G+Pkdwa+DMFVCREVJ4UUfDFBdLJe8ARf8B6iuw8
X-Google-Smtp-Source: AGHT+IH54wg5eRYpZnCkwQreGAMbgDD/WonVhjZ99mB7DacBqGVRwQ0mpsTZPZ18Q+815AsjuwwFeQ==
X-Received: by 2002:a17:902:7845:b0:1e2:a807:7159 with SMTP id d9443c01a7336-1ef43c09602mr364690065ad.6.1716314374422;
        Tue, 21 May 2024 10:59:34 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:34 -0700 (PDT)
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
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 07/11] nfs: drop usage of folio_file_pos
Date: Wed, 22 May 2024 01:58:49 +0800
Message-ID: <20240521175854.96038-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521175854.96038-1-ryncsn@gmail.com>
References: <20240521175854.96038-1-ryncsn@gmail.com>
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
reads from SWP_FS_OPS swap-space"), swap cache should never be exposed
to nfs.

So remove the usage of folio_file_pos in following NFS functions / helpers:

- nfs_vm_page_mkwrite

  It's only used by nfs_file_vm_ops.page_mkwrite

- trace event helper: nfs_folio_event
- trace event helper: nfs_folio_event_done

  These two are used through DEFINE_NFS_FOLIO_EVENT and
  DEFINE_NFS_FOLIO_EVENT_DONE, which defined following events:

  - trace_nfs_aop_readpage{_done}: only called by nfs_read_folio
  - trace_nfs_writeback_folio: only called by nfs_wb_folio
  - trace_nfs_invalidate_folio: only called by nfs_invalidate_folio
  - trace_nfs_launder_folio_done: only called by nfs_launder_folio

  None of them could possibly be used on swap cache folio,
  nfs_read_folio only called by:
  .write_begin -> nfs_read_folio
  .read_folio

  nfs_wb_folio only called by nfs mapping:
  .release_folio -> nfs_wb_folio
  .launder_folio -> nfs_wb_folio
  .write_begin -> nfs_read_folio -> nfs_wb_folio
  .read_folio -> nfs_wb_folio
  .write_end -> nfs_update_folio -> nfs_writepage_setup -> nfs_setup_write_request -> nfs_try_to_update_request -> nfs_wb_folio
  .page_mkwrite -> nfs_update_folio -> nfs_writepage_setup -> nfs_setup_write_request -> nfs_try_to_update_request -> nfs_wb_folio
  .write_begin -> nfs_flush_incompatible -> nfs_wb_folio
  .page_mkwrite -> nfs_vm_page_mkwrite -> nfs_flush_incompatible -> nfs_wb_folio

  nfs_invalidate_folio is only called by .invalidate_folio.
  nfs_launder_folio is only called by .launder_folio

- nfs_grow_file
- nfs_update_folio

  nfs_grow_file is only called by nfs_update_folio, and all
  possible callers of them are:

  .write_end -> nfs_update_folio
  .page_mkwrite -> nfs_update_folio

- nfs_wb_folio_cancel

  .invalidate_folio -> nfs_wb_folio_cancel

Also, seeing from the swap side, swap_rw is now the only interface calling
into fs, the offset info is always in iocb.ki_pos now.

So we can remove all these folio_file_pos call safely.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfs/file.c     | 2 +-
 fs/nfs/nfstrace.h | 4 ++--
 fs/nfs/write.c    | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 6bd127e6683d..cebddf36b923 100644
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
index 2329cbb0e446..3573cdc4b28f 100644
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
2.45.0


