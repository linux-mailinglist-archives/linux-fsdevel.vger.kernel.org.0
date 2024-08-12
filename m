Return-Path: <linux-fsdevel+bounces-25658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C353594E94D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 11:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B111F23E2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF3316C6BD;
	Mon, 12 Aug 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2voe+MA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560B167DA4
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453696; cv=none; b=RMdm48MUAhqFJWVG1fi/lrGKyCBDXP+VsBc2uAySgIFOao/A2lgRDXjoXqu0ditUVNETfE4HYaJ5eGpywdvrFyXg39VyuKuzGt8GJhnoxrZuNlvcgKuYk5AItmnrIiyHhTT7GzXyVIvyL2DjIiavNBjZlQ7D9wagthfOUtfKwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453696; c=relaxed/simple;
	bh=aG2IOC/NSR8hEeAgo4ZVK1ay0cBZYElEa30dPJq8EzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7udNz/3y9dkgSrRFoCuoyOdjveQGEjDRywCV3cUz9ACvljsL/ViG87o65Bic13MfxOGljcMNYmivAJAgsOtmNtqKUJKwIRMxM60oa0XnTKFpfOz+cCOoNsu2lB0A3nyIzCOOKmJHQx3M/CaJR0QOHGgubD2D2vQUDNg2gBUpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2voe+MA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c3e0a3c444so809084a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723453694; x=1724058494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NACQ7ELOlfYjhnP0zeg6TZ0yzINb3WcQXKg7nf5cJS8=;
        b=M2voe+MAmJyNYajyE0n3eBpJmmb3ykKClC85e9dBtgfWTHiJqxfRWRhqrZDjcrRTtI
         kY0SRvYTPtHT/VyebEaU4kATlkdoaxAc2b4s/UAnEny7zzYwXuxI05LK2tRcBEdYcvXx
         YvN8WytuSoikvthHU2S1MtixGGIyYk+hRdW5oz4ueHLkEIoxqH6UXKHhB7SCwNQDbJP2
         r5Fxv9UaxrM6LE40WJw65vCEz1V6ABisKMv+2beDq5qnEeEyltGUVfv3goeGur2C3y/F
         KBywXss8SdqafCUeaLl4eJ7LwwnDH6M0SVK76tezLg1fnBxlAWmrTd0wjhdNpNfKIO4K
         roIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453694; x=1724058494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NACQ7ELOlfYjhnP0zeg6TZ0yzINb3WcQXKg7nf5cJS8=;
        b=uBMq2O3OuF49PMsmJ9J/9pquA7QPiJp04r9K2rStYLf2+ywnTzdhtJGyy+az4ZVeR1
         gRG17lR8rmMf8SO/NMO24ndgYHiwq/AWD//GsZj1SGWdFsw1YSmkCLQTp0ECd/W7gIzm
         WvuT71XtUdDibznM+VOk+znA9piGb23oycIpPcVa/Ewi/WFFwNpK33IRsuEEjG086ifk
         wZds+maaHXE4OEIrKmHG2a/JZ/EUlQwUtQphoZo14CUwgzm8Db0sDj94tBccAtO52fE3
         lmyCppzYPxYkeMq2ugkhTDgEa7PElp+BEBxGsfIT3o6sKTN0Vr8WhMmeWdr9ZvUyaqLY
         XycA==
X-Gm-Message-State: AOJu0YxAAdJxzpOFKprKegkK4geRNxEfKLHdBksn4dHFJqpr9M200o6n
	P6mfHLmsu84qtO07s9VQy6I/MUNEw0N3E1cw7ddZJrrVyuW2y7WG
X-Google-Smtp-Source: AGHT+IGJZX9ZcwD3zVcDl0RfaEongQHdZrDxDKxiWRmiIqWGUKGPjJtJ672FdIkDuHFOVdmglMnrhw==
X-Received: by 2002:a17:90a:55c3:b0:2d1:c9f9:e871 with SMTP id 98e67ed59e1d1-2d1e7f07945mr14004654a91.8.1723453693692;
        Mon, 12 Aug 2024 02:08:13 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fce6cfc1sm4450262a91.6.2024.08.12.02.08.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:08:13 -0700 (PDT)
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
Subject: [PATCH 2/2] mm: allow read-ahead with IOCB_NOWAIT set
Date: Mon, 12 Aug 2024 17:05:25 +0800
Message-Id: <20240812090525.80299-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240812090525.80299-1-laoar.shao@gmail.com>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Readahead support for IOCB_NOWAIT was introduced in commit 2e85abf053b9
("mm: allow read-ahead with IOCB_NOWAIT set"). However, this behavior was
altered in commit efa8480a8316 ("fs: RWF_NOWAIT should imply IOCB_NOIO") to
prevent potential blocking during memory reclamation.

To address the blocking issue during memory reclamation, we can use
memalloc_nowait_{save,restore} to ensure non-blocking behavior. With this
change, we can restore the original functionality, allowing
preadv2(IOCB_NOWAIT) to read data directly from the disk if it's not
already in the page cache.

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
index 657bcd887fdb..93c690e1d1fd 100644
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
+			flags = memalloc_nowait_save();
 		page_cache_sync_readahead(mapping, ra, filp, index,
 				last_index - index);
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			memalloc_nowait_restore(flags);
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	}
 	if (!folio_batch_count(fbatch)) {
-- 
2.43.5


