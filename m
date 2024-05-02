Return-Path: <linux-fsdevel+bounces-18486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DCF8B96D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34407B236E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141D4E1D2;
	Thu,  2 May 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aofk9iud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F047772;
	Thu,  2 May 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639822; cv=none; b=FoTeih46n+TURkw99wbdN8fAlCF/ngrrijSt1+0uIPqyTmZyFZclyTCQyOdhiHzmN+fSqHSQIbFagUuXHmrT4Iu7QT8HaeuGKoKDh0s/Qap7RRXSdi2nv16AiOYxzhold1ufPEKabZSOUWxc580OIIdR/UdjdjyzV+pKvpe9LZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639822; c=relaxed/simple;
	bh=h0/SRsAe2O/iKK/puk0MgmyOeDjetRM9hjyClQBU5Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AquZgpHBhEZRlbPMfHGVPJxuq0B5CyNAgwaqg9bTuRoY8h2IOeL0fS04XfahEA9OePZukISQqnBugqH9d2+JQ82/9ZwOaljZZUggQWK3Qt8vz8RX2wohtI5liAgdiLl18nnyLX5NaJhbFiDJcgasJcM6UeP+mSy8YUD34COoq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aofk9iud; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso62731915ad.3;
        Thu, 02 May 2024 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639821; x=1715244621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7HU2SkQDR4mMrV58+lW5U65TL0KC+HX+uRYg6Mar4vo=;
        b=Aofk9iudXc7tkJNZ/CKQ+FNcAHOJaHny4Q+XPOVaD9dJu0hlwMEsIHEsw/d8mFajCt
         m9Eb5SYGJeh1FwMsfIXDF9ucB9orMQx2KN3qhxWXDs2+vOOFh2pi0CdSfXFgMK4JcIUQ
         O2EogDGThdjRaT0rOfDw5A2vLyoaA2B4jjO6l5dDlBkziG5WU6GhwoTAaIXivInj9Fk3
         fnqi2FZVgSCcyJA+esWOACnJEejhNH40hxTktZ9naLwraDinjCwF/XXhSSfJi/d5GbZT
         M05v/dwZgJoF5snagff001jyESoFFzIMWOonWgGi4j8Of7ljpmYEAwprlglet2O57zK8
         MtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639821; x=1715244621;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HU2SkQDR4mMrV58+lW5U65TL0KC+HX+uRYg6Mar4vo=;
        b=P75QyQRo966DO8Dm4UgEsqCyQ1/j6AbND3PfmdVqEKQMmvR156MtznkI9AMmeoHcep
         2NQUcJNKplG0K/BZ67vilYVEW86F/WQHcs7fEktIb+vsSHfvzV1ftHcQ5iUscCzZTqMc
         mD5V6OrDuV/nPvdLAqNIhO+MrRT6XNaJqqOcRFSTFNajX8sa6cPdEUR4fhJy6g6nqwTG
         qIqnsX79aCyAG9lp/0FLQ5yLD7iSQLM6TMgeJrTKgvDeJhx9y8CwALU+bsQ8n2sIIim7
         O4msXUpXO6u3wLymQL9xVXNDSiFu9hteiI+Taq8gnclysWGdZOvG4vU49Lv5gdRcapoM
         npqg==
X-Forwarded-Encrypted: i=1; AJvYcCXZM3I66d06cucypUuhi/g92hy9KIhklMWdPfWt0Tf8FPu0iAmCaALlbA3yNwqADjMrcATTbFENblAno4HWRamgH56V/gC/7GGZ45kPpCV/DvbvUgPPJxhbJrl5zj9qf9STWdBx+76HVyEVUtZ711q4Z9X3uXgUZNBHNbqORHhvZWTDnE2aXw==
X-Gm-Message-State: AOJu0YyFu0uBFFqFWUPwzOTZ3uLZkNB+gjj1BY4e+6d8NqTqBuKzaxXT
	B23ZWdsbn28+dIel2vTZ+zD/gkdShBUdVJurMaAMZ8YhRDWsSAVk
X-Google-Smtp-Source: AGHT+IEum/YkVi3jfWr1OA1pFH3dJL22MujEcP594sYqp7lP92G8EsNoWMfK9ZCNtKjcgZkH0nMekg==
X-Received: by 2002:a17:902:c402:b0:1ec:c7af:881b with SMTP id k2-20020a170902c40200b001ecc7af881bmr3321063plk.54.1714639820550;
        Thu, 02 May 2024 01:50:20 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001e43576a7a1sm737712plh.222.2024.05.02.01.50.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:50:19 -0700 (PDT)
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
	Kairui Song <kasong@tencent.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 08/12] nfs: drop usage of folio_file_pos
Date: Thu,  2 May 2024 16:49:35 +0800
Message-ID: <20240502084939.30250-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502084609.28376-1-ryncsn@gmail.com>
References: <20240502084609.28376-1-ryncsn@gmail.com>
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
2.44.0


