Return-Path: <linux-fsdevel+bounces-21870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E85890C823
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 13:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C17288B22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466381D5415;
	Tue, 18 Jun 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ynnvl1W/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF551581E4
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jun 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703425; cv=none; b=msWWR2mUDv9e565H7NbvzUdtKGvjhj8pS0iKDfN+DS6hajP/Ia48b78GiJ0K+6/Y+cKHmit6915W9qnY3ThMML48LHfsoTLQ+Viyp7bPg6mu2VsRilb6UV+lbecO2JEIh/ZESTCwA4VmOdYONXT0EVPwngPN9EWDw+VL3uU80rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703425; c=relaxed/simple;
	bh=mpeSJ8fJ7wtK033GVI5zWN+gAxDW49LWmwr1VOj3LjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qD7rYOQLBQNijwNZlvmH6VDcdWY/tWltqfmwjvyK01erRXgxWTdo2d2xPFzgEaK8nnh9fhhBMCyd8gf4R3hLt2e7iw2lnnNO2kYGNn7yNNsUDCW1OBtarZDEcvn/R6kexki6XgVBxIqN6zf40lnk1zvbfhKSx4p5W4dW6X1FG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ynnvl1W/; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-250671a1bc7so2495241fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jun 2024 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718703423; x=1719308223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yO5Ag6TkgQi37C9WOmZH4DbdT66+5TaN0dgl3GOdIjM=;
        b=Ynnvl1W/CxPRXFlUjD8Fvq5KI/1Z1IW9Y6oPaSoV7QS2Wnz9VIpHz487UbcrUBD3gr
         4M5QbpsNmd8hxmh84TTxrnOWZss0f7UWCbr/Y0C7pIW2eOeTlu793Tdum3fnl/UhA8xH
         GTro3Ml34vISoWNUpKwW8p4NWpZ84HBCCnqrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718703423; x=1719308223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yO5Ag6TkgQi37C9WOmZH4DbdT66+5TaN0dgl3GOdIjM=;
        b=AaOO6GiYC9PF5m9uCz0Rc0wRwFnzfpfp/cmEYm1Uq2IGPGIst7Nr7uOHbqeDUmu6vb
         EysMwOSEqqXHi7/rF48qPet1GeerHPUTd02vdJwIfYQ62mPOfDObepGn2wglqZLc3y5B
         HRK8pq+wCGk2vuEDAy8cKHBHk605RSlY5Dle+2+pTcefFPlDkuBMXd8Oos7meJxx5sag
         H6F2/yVewuZrw2E9JVfxrl6ZyxUyUKDxuxWwiSPf7dMye5uCVTC86glxw5wfvFvRVIM+
         46DVVDNzmeJi8uOSas4oZm/T6ro4o0sYYd3eSoNuo3D1iJbGNEWcrLwt3DdkLAIv0uPy
         INqA==
X-Forwarded-Encrypted: i=1; AJvYcCUTv4d5ldvwiZ1sVn7iZdt/ShFas87Yz4AxT4WKBXjadcNPvWA/fp7+Tw5jIAv+WHgoIEagsCxv1pnUWT6Xb+nR+xkre+TXapGJp5O0oA==
X-Gm-Message-State: AOJu0YyVAObm9G+teZNFr5z5vEDXZsNpud6IaqXiEe0SYjtbf3WzCMFo
	8G0d3mmVOGCYOItzxav31WOY1yLNbbPt0sAOVzOmUrpBmc9tUZo/BqzcY5Ih
X-Google-Smtp-Source: AGHT+IFjGk/o+lwl7K/bIc/tHdxoPP+pTmgqlmCZ6lEWgXKCgTfp4wm0qZkGTYoC1vTxxK5H8+Ha1w==
X-Received: by 2002:a05:6870:c1d4:b0:24f:dd11:4486 with SMTP id 586e51a60fabf-25842ba209bmr14156507fac.36.1718703423087;
        Tue, 18 Jun 2024 02:37:03 -0700 (PDT)
Received: from localhost (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-705d8fc3dbdsm6995546b3a.1.2024.06.18.02.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 02:37:02 -0700 (PDT)
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
Subject: [PATCH] filemap: add trace events for get_pages, map_pages, and fault
Date: Tue, 18 Jun 2024 09:36:56 +0000
Message-ID: <20240618093656.1944210-1-takayas@chromium.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
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
---
 include/trace/events/filemap.h | 84 ++++++++++++++++++++++++++++++++++
 mm/filemap.c                   |  4 ++
 2 files changed, 88 insertions(+)

diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index 46c89c1e460c..68c705572c4f 100644
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
+		"dev %d:%d ino %lx ofs=%lu max_ofs=%lu",
+		MAJOR(__entry->s_dev),
+		MINOR(__entry->s_dev), __entry->i_ino,
+		__entry->index << PAGE_SHIFT,
+		__entry->last_index << PAGE_SHIFT
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
+		"dev %d:%d ino %lx ofs=%lu",
+		MAJOR(__entry->s_dev),
+		MINOR(__entry->s_dev), __entry->i_ino,
+		__entry->index << PAGE_SHIFT
+	)
+);
+
 TRACE_EVENT(filemap_set_wb_err,
 		TP_PROTO(struct address_space *mapping, errseq_t eseq),
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 876cc64aadd7..39f9d7fb3d2c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2556,6 +2556,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			goto err;
 	}
 
+	trace_mm_filemap_get_pages(mapping, index, last_index);
 	return 0;
 err:
 	if (err < 0)
@@ -3286,6 +3287,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
+	trace_mm_filemap_fault(mapping, index);
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -3652,6 +3655,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
 	add_mm_counter(vma->vm_mm, folio_type, rss);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	trace_mm_filemap_map_pages(mapping, start_pgoff, end_pgoff);
 out:
 	rcu_read_unlock();
 
-- 
2.45.2.627.g7a2c4fd464-goog


