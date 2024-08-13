Return-Path: <linux-fsdevel+bounces-25765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00F79501F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19456B29825
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7866119AD85;
	Tue, 13 Aug 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gB7aL9K8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9819AD81
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543401; cv=none; b=WxxRM/UhV+JHAgk5C9z3cMMuA0l2zW3+6DaXA002IzQ7cOAPHxSO1RE14sxa0C+xYQG4mopCZRiAfhleGnhGf8+S8E2KRAnNtWqhIVYgS4ypfaJoKDbt8z7RT+y23/I0yQ5yhtMR4prsscbWD3OR+lunydMJcTTRa5o6x5Xhv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543401; c=relaxed/simple;
	bh=ZaRZPIKMb9tT1bgJXnZN+jAzi+AtsUj/jTsR+EdbRoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gv2oe8XuKp0IiSQyh3cmG0MH8Mq9AooWkL4AcsLRCnY4LWoMNLA8d9kgyr3fc7VrrVhxyeCfICyROVgjTMbJcKFoDK9BzkOGih49InR2orERsRzeXBH3lFQZO94QGMNOh/vMAtWHpZzB4hRU7X9l4D4dzKwFv/bnt0rgLNBGwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gB7aL9K8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a10b293432so3740408a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723543399; x=1724148199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NoxN63bBPaM/wCd8ZvlEoxvS8xfn7jCuCDDPzEXx9AA=;
        b=gB7aL9K8rxT92KTPA0kUHFxVnq8g92F1/0AKw6e+zNZQ1SNqtgs+5iCbJPK89PagJa
         YQF478bmuSxDbkLlx5Qq1QqS0aH740VuEc7k8iTU5Yrjj61C/lmA74GZIHLWGEM+7FuR
         AA1zaADBs8Ye7lXJUM/vy2HwYIvJ9E2jt4A3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543399; x=1724148199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoxN63bBPaM/wCd8ZvlEoxvS8xfn7jCuCDDPzEXx9AA=;
        b=dAjP/fjWI+CZyQog6dYB4DbOC6SAfkYT71GufDr+RyS/k9Zn9qmQqn8//TsQ/sNgQt
         iH9Z1YXgWfQs1DBmHgwsFwiseFiz4itHH/mK/NJzkyz6M4TBr/2+gmozFnvXxUSA38FC
         wbT8FdW9uTmWE5TRL6qOQwflG4/L8EWg+xN+jqiD1GsuFOOdcGyTkxQN1y3zTJ6AiLVb
         7jwPVS+EQ4drsy4u9dHh7B26WGtltvnCvqh1yGSMFc7JjRiPapwRAXVPsmH84W9VjAaj
         4smLkVasdL9KFDUNPuafsB+kxZHL6V7HKGniP2mdlTu/KJ3YoSIHVfEa45y5cuLxJ6RA
         37lg==
X-Forwarded-Encrypted: i=1; AJvYcCUxtT3TAI4AZcZAsexM7/nqKlD+0WprhP1d/igKyjN0MEa5xBWSl+8PFCsgF5vDB0f5O1MICyWkbwyM1KyafilVsMjihTjsE/JXOLNBOQ==
X-Gm-Message-State: AOJu0YwztC229d7RHOdty38KoRB3xn2vK4Tu4CoCexZjr6UzeUZd/HE6
	vzQVbclOq8hPY+nOwAOWTLZ2phY5H/cQcsVaraEx63JkDGoQYjaigfF4+Lk6
X-Google-Smtp-Source: AGHT+IFosWR7zkd7jgDT2HviKT6vEjybZ5RhsLylZWQSu4p1a07i1ADAXGsNcDrKZxIxqrj/LlkKPw==
X-Received: by 2002:a05:6a20:96c8:b0:1c8:d7b7:dcbd with SMTP id adf61e73a8af0-1c8d7b7dcf2mr2811688637.1.1723543399534;
        Tue, 13 Aug 2024 03:03:19 -0700 (PDT)
Received: from localhost (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7c697a549d8sm944650a12.67.2024.08.13.03.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 03:03:18 -0700 (PDT)
From: Takaya Saeki <takayas@chromium.org>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Junichi Uekawa <uekawa@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Takaya Saeki <takayas@chromium.org>
Subject: [PATCH v3] filemap: add trace events for get_pages, map_pages, and fault
Date: Tue, 13 Aug 2024 10:03:12 +0000
Message-ID: <20240813100312.3930505-1-takayas@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow precise tracking of page caches accessed, add new tracepoints
that trigger when a process actually accesses them.

The ureadahead program used by ChromeOS traces the disk access of
programs as they start up at boot up. It uses mincore(2) or the
'mm_filemap_add_to_page_cache' trace event to accomplish this. It stores
this information in a "pack" file and on subsequent boots, it will read
the pack file and call readahead(2) on the information so that disk
storage can be loaded into RAM before the applications actually need it.

A problem we see is that due to the kernel's readahead algorithm that
can aggressively pull in more data than needed (to try and accomplish
the same goal) and this data is also recorded. The end result is that
the pack file contains a lot of pages on disk that are never actually
used. Calling readahead(2) on these unused pages can slow down the
system boot up times.

To solve this, add 3 new trace events, get_pages, map_pages, and fault.
These will be used to trace the pages are not only pulled in from disk,
but are actually used by the application. Only those pages will be
stored in the pack file, and this helps out the performance of boot up.

With the combination of these 3 new trace events and
mm_filemap_add_to_page_cache, we observed a reduction in the pack file
by 7.3% - 20% on ChromeOS varying by device.

Signed-off-by: Takaya Saeki <takayas@chromium.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changelog between v3 and v2
- Use a range notation in the printf format 

Changelog between v2 and v1
- Fix a file offset type usage by casting pgoff_t to loff_t
- Fix format string of dev and inode

 include/trace/events/filemap.h | 84 ++++++++++++++++++++++++++++++++++
 mm/filemap.c                   |  4 ++
 2 files changed, 88 insertions(+)

V2:https://lore.kernel.org/all/20240620161903.3176859-1-takayas@chromium.org/
V1:https://lore.kernel.org/all/20240618093656.1944210-1-takayas@chromium.org/

diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index 46c89c1e460c..f48fe637bfd2 100644
--- a/include/trace/events/filemap.h
+++ b/include/trace/events/filemap.h
@@ -56,6 +56,90 @@ DEFINE_EVENT(mm_filemap_op_page_cache, mm_filemap_add_to_page_cache,
 	TP_ARGS(folio)
 	);
 
+DECLARE_EVENT_CLASS(mm_filemap_op_page_cache_range,
+
+	TP_PROTO(
+		struct address_space *mapping,
+		pgoff_t index,
+		pgoff_t last_index
+	),
+
+	TP_ARGS(mapping, index, last_index),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(unsigned long, index)
+		__field(unsigned long, last_index)
+	),
+
+	TP_fast_assign(
+		__entry->i_ino = mapping->host->i_ino;
+		if (mapping->host->i_sb)
+			__entry->s_dev =
+				mapping->host->i_sb->s_dev;
+		else
+			__entry->s_dev = mapping->host->i_rdev;
+		__entry->index = index;
+		__entry->last_index = last_index;
+	),
+
+	TP_printk(
+		"dev=%d:%d ino=%lx ofs=%lld-%lld",
+		MAJOR(__entry->s_dev),
+		MINOR(__entry->s_dev), __entry->i_ino,
+		((loff_t)__entry->index) << PAGE_SHIFT,
+		((((loff_t)__entry->last_index + 1) << PAGE_SHIFT) - 1)
+	)
+);
+
+DEFINE_EVENT(mm_filemap_op_page_cache_range, mm_filemap_get_pages,
+	TP_PROTO(
+		struct address_space *mapping,
+		pgoff_t index,
+		pgoff_t last_index
+	),
+	TP_ARGS(mapping, index, last_index)
+);
+
+DEFINE_EVENT(mm_filemap_op_page_cache_range, mm_filemap_map_pages,
+	TP_PROTO(
+		struct address_space *mapping,
+		pgoff_t index,
+		pgoff_t last_index
+	),
+	TP_ARGS(mapping, index, last_index)
+);
+
+TRACE_EVENT(mm_filemap_fault,
+	TP_PROTO(struct address_space *mapping, pgoff_t index),
+
+	TP_ARGS(mapping, index),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(unsigned long, index)
+	),
+
+	TP_fast_assign(
+		__entry->i_ino = mapping->host->i_ino;
+		if (mapping->host->i_sb)
+			__entry->s_dev =
+				mapping->host->i_sb->s_dev;
+		else
+			__entry->s_dev = mapping->host->i_rdev;
+		__entry->index = index;
+	),
+
+	TP_printk(
+		"dev=%d:%d ino=%lx ofs=%lld",
+		MAJOR(__entry->s_dev),
+		MINOR(__entry->s_dev), __entry->i_ino,
+		((loff_t)__entry->index) << PAGE_SHIFT
+	)
+);
+
 TRACE_EVENT(filemap_set_wb_err,
 		TP_PROTO(struct address_space *mapping, errseq_t eseq),
 
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..925eef5e16f0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2556,6 +2556,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			goto err;
 	}
 
+	trace_mm_filemap_get_pages(mapping, index, last_index);
 	return 0;
 err:
 	if (err < 0)
@@ -3287,6 +3288,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
+	trace_mm_filemap_fault(mapping, index);
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -3653,6 +3656,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
 	add_mm_counter(vma->vm_mm, folio_type, rss);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	trace_mm_filemap_map_pages(mapping, start_pgoff, end_pgoff);
 out:
 	rcu_read_unlock();
 
-- 
2.46.0.76.ge559c4bf1a-goog


