Return-Path: <linux-fsdevel+bounces-26334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E727957B66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 04:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD37284720
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 02:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5962725757;
	Tue, 20 Aug 2024 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKyN+GzP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245617FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724120812; cv=none; b=YGhheYRRHCvTXwruqlzjNUAU7hCWtzX7h9Ofq9ejooGHmHZwLThWRR1M54f7VdZLEFS+ZyDiIgZC7SeK7jd0cUG31JRvCdjeJCm1ProN9XHf+z2iZEnZoiXU7Wwj+8Indy6qOpBCO5IpSamuw5F7A0bZlRgDe10MAahFvQMrEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724120812; c=relaxed/simple;
	bh=aZX0l7kbw/6bmpbpv/AyD+3pZV9zURy0ryKQyeBLwPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tWF9LJ5QX9zYJwQ7Ri7ZMYkUog42q4Ofg60ryLFBFRmkiFIsvUZFi2VIUTtEq3e7itbyNsnkclrPYdG5Y/kDbm3V6MqFjn9tmVa/qrRduxzw/qyexV+e5D16YIWaWCCoCiG9Llmb969FhmtascInJGkYJWyvF3yOWDV6LEiBEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKyN+GzP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710ce81bf7dso3644254b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 19:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724120810; x=1724725610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sFseQwei+CiGkTUDpQHHUk/qFnB9cNwQ5rhI0xvQcg=;
        b=GKyN+GzPaVXIpyT3yN4JROC8NPu6wSVhhkYLvAoxQeOUF9O7PongSjt6GHap5N7HZC
         G52a3cARW+rRSXI0PJaEIUd4RW8LI2IRlLi7EGiwNaUCiEE11zZhtYv6XsuABUBW+ZsL
         zYLOXtAnWt+NacFQqXynksGXCZC1jeyMm58oyvZV++GaH/38PVV7BaSSzwHi8sEdM5HH
         GBTn/L1k9IQBKADGVu3r9il1if3TZPYP0C6BRt9VmctJHyjwosinwUf1xkyDQwvJbm/x
         0m8vkA5trms5bCfhNFzEYQswtSRr+wQzfw6pgfSQRZf2gSvhtSLNy6ZXcJhm8BK5AO9I
         xP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724120810; x=1724725610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sFseQwei+CiGkTUDpQHHUk/qFnB9cNwQ5rhI0xvQcg=;
        b=AhP7X2efGS7iH9Spp0C1++3nDedLMEpuTQCRXajUiRMXboL2iVuWp0mJ1WtpUb9u8/
         AYDJkkKTbWj+MLMILFJPgx4dwc7hZgK9pT1Pz18CtHGzSrPO4ley1nyxvcSOGtP9FB2T
         FVwBRkbGVUERoHosmvlpMC9xuvKhIJRO5i6W+7OcOgkE4wL6szsXjFfYEeNk32XzCWt9
         o3Z1vOWmxoCNA++/ZSUmeY5M3UfYLrSbqs5Mg4KWeHFoi0xdQvUnNH5Fb2TTztq+leni
         Q18S7hjoXQj0XbO0MQX11eED8a33GTyTs+aU3+B6q54iXeiCbEOB/P+lJvDDfYGaOO0d
         a0yQ==
X-Gm-Message-State: AOJu0Ywn5CqekciXC4Hks8SPZNJuIFlDb6xBYhOiTBC0+vafa9UHwoNY
	4X6/qjLBEoeJ2d5xyIwO28F6lCe7dwhUUq+7QCqQNpjYGzYWQD7n
X-Google-Smtp-Source: AGHT+IFvxhZMY4v69L+gXdvO6693YPauuZyNg9TnvE1QwtbUBHrltGSIl16MuBx9yuIdNVxyKhA7YQ==
X-Received: by 2002:a05:6a20:ce48:b0:1c3:ea28:3c0e with SMTP id adf61e73a8af0-1c90502fa13mr13595284637.33.1724120810400;
        Mon, 19 Aug 2024 19:26:50 -0700 (PDT)
Received: from localhost.localdomain ([39.144.244.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0379048sm68094175ad.143.2024.08.19.19.26.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2024 19:26:49 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	david@fromorbit.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] mm: allow read-ahead with IOCB_NOWAIT set
Date: Tue, 20 Aug 2024 10:26:39 +0800
Message-Id: <20240820022639.89562-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Readahead support for IOCB_NOWAIT was introduced in commit 2e85abf053b9
("mm: allow read-ahead with IOCB_NOWAIT set"). However, this implementation
broke the semantics of IOCB_NOWAIT by potentially causing it to wait on I/O
during memory reclamation. This behavior was later modified in commit
efa8480a8316 ("fs: RWF_NOWAIT should imply IOCB_NOIO").

To resolve the blocking issue during memory reclamation, we can
use memalloc_noio_{save,restore} to ensure non-blocking behavior. This
change restores the original functionality, allowing preadv2(IOCB_NOWAIT)
to trigger readahead if the file content is not present in the page cache.

While this process may trigger direct memory reclamation, the __GFP_NORETRY
flag is set in the readahead GFP flags, ensuring it won't block.

A use case for this change is when we want to trigger readahead in the
preadv2(2) syscall if the file cache is absent, but without waiting for
certain filesystem locks, like xfs_ilock. A simple example is as follows:

retry:
    if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
        do_other_work();
        goto retry;
    }

Link: https://lore.gnuweeb.org/io-uring/20200624164127.GP21350@casper.infradead.org/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 1 -
 mm/filemap.c       | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..ced74b1b350d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3455,7 +3455,6 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 	if (flags & RWF_NOWAIT) {
 		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
 			return -EOPNOTSUPP;
-		kiocb_flags |= IOCB_NOIO;
 	}
 	if (flags & RWF_ATOMIC) {
 		if (rw_type != WRITE)
diff --git a/mm/filemap.c b/mm/filemap.c
index 657bcd887fdb..fe325c2ea626 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -46,6 +46,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/splice.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/sched/mm.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -2514,6 +2515,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
+	unsigned int flags;
 	int err = 0;
 
 	/* "last_index" is the index of the page beyond the end of the read */
@@ -2526,8 +2528,12 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			flags = memalloc_noio_save();
 		page_cache_sync_readahead(mapping, ra, filp, index,
 				last_index - index);
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			memalloc_noio_restore(flags);
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	}
 	if (!folio_batch_count(fbatch)) {
-- 
2.43.5


