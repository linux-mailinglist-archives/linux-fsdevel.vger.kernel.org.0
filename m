Return-Path: <linux-fsdevel+bounces-19279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BE8C23F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2E9288A0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5E5172761;
	Fri, 10 May 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyck0n/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C216171E67;
	Fri, 10 May 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341828; cv=none; b=JSoVr4FeK/r4fgBM52e9n+qZUfwx9tNzEMbxqRB12jiu3pfsvLi22WUzVCVW13Bu6DJfxm98i7rMdKmXjPQWVd6yqYfcDYlq/+qpKsXlYMC4elJdIPV6WHI4fLnKaLaO5iOsHHE2+9PCipZ8HPNb/wxY5fF+Ohlalntw/LK6BHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341828; c=relaxed/simple;
	bh=YN2lXIAdW+FIH+nlJ+O6gfCsXaVYNXGhOvEJxPri7UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgWS29FQ+4U0VDHQY1j5VCHNUiITMaFWxKC4ruXyZBFmrdOPMrpUx53pRrGkzez5TZf6ldNkiK/Vjx1ZV8oZRxRDieskD7uWBLpyfw1iQsAfzLckL+wrkLp483l95Ov+v66Tw+s+7zQlZEoAEUbhBfbLLL3GqdBrNXsbreKsQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oyck0n/5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1edfc57ac0cso15524825ad.3;
        Fri, 10 May 2024 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341826; x=1715946626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mIIbTsUqC47TgpII0qMr2P678NC38ZS92LaHNxc/VvU=;
        b=Oyck0n/5EI/1+xwbwCILzdtRloIzTloqLbIeCuIRtW+eigpYNV4v+7qgKvMw1xXkRn
         D85nl7w+pORHzKxw1tsGjWwqOvsqHVMvFPooT7c0GAR2E38lOXSDMx8kWgpDIJZwJpCj
         JYGgauz9Ao6Ys9CneB1lhfhCjes90ajQwJiOi0HsysdtQrz15bpoeejQosW4BlnuMPvd
         HWS3qA6PtS/WDtFxciQdEoUnoMntAIeQRyZCPVwn4qM/Wjd/QAOHB1Tm6aErArXXpyv+
         0TNIZsODBz6pE6lJ6BVPS29F0SkgfjA+6pyDJ0ohpqQL/+s7dAqDkRil84qtIxLYm4Il
         B0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341826; x=1715946626;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIIbTsUqC47TgpII0qMr2P678NC38ZS92LaHNxc/VvU=;
        b=TIFYfM/WjpbYUOEESYH7uZqF/4GRIxd5CrMt1+79kJ4bXMTkygdAiwtPZ9E7VCSsNq
         sBqFjCMPt04CHgGiTHg94aMUExW12Yfbv770OWUjvPjGFKy/A9pnS3Ti1v9M3Ten8+WV
         mhFZG3hZz3ikumy/VT1YCTzuTdTxgkFt1VCxmmkIZ9w2YOV3XXB8FQghUtCaCcJK7JOw
         fv8TSiDXxJ1skiHT/GdCcQLok86pSuCrIZIA7tZhRpQ117JklDUNdgo7KaMHyyzmrVRT
         4X1LQUSjT6oNN/wEeMpBYbF4+2r6XdAVlAuCZkrf4ubZfv5ipODOXU2fX3Rr15RFUhL8
         oInQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0+TVr+mipHzgKwybi1TCY5NyF9pZBJ3Nv8CQndbDwEpl2l8FhJDmm+AfT4X9Bc+SK7pGwStvfrEgopXpNH9UFFjdGcVlPDvLC3Y90gxrLBDAOtnYLJ/qftGidPWIOcbgot4rXxQrKObZXoSkm9vCacAw7EirZV5nkBg1I9Wf8mzxgMQ27BA==
X-Gm-Message-State: AOJu0YxqED87/4GhoA+5kjiM4v2F3JswwXq9hVkreiTVjtLc5HDd7OUY
	7c8BRlQB7VxfQo+A0RTjlvGmOyEIPvvo9Bj1mT4EyqNtS1wKyXHG
X-Google-Smtp-Source: AGHT+IEqWWlYE0LaQa+qtHe47sVQ58jjdkZuIoCJG8MKrxdZVoUXsASGJ68twijEqsRcGHoHUXZc2w==
X-Received: by 2002:a17:902:d4c4:b0:1eb:7ba:a4bc with SMTP id d9443c01a7336-1ef43f43106mr25708225ad.51.1715341826460;
        Fri, 10 May 2024 04:50:26 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.50.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:50:26 -0700 (PDT)
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
Subject: [PATCH v5 08/12] nfs: drop usage of folio_file_pos
Date: Fri, 10 May 2024 19:47:43 +0800
Message-ID: <20240510114747.21548-9-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510114747.21548-1-ryncsn@gmail.com>
References: <20240510114747.21548-1-ryncsn@gmail.com>
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
2.45.0


