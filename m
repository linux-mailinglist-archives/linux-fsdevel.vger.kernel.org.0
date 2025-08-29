Return-Path: <linux-fsdevel+bounces-59670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F629B3C5A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDDD5A23D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C597311C22;
	Fri, 29 Aug 2025 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl+KK87F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1052D6E6D
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510794; cv=none; b=gvqv1x46P05IIfFC6E1xBqeIQxo/vJGoDpBzOm1PGwkF/MEdaVRaeOrvH5D+VhyYxpAH6BWPorZTDDVOi+ji6kAMUUu31W9xYbhkTgJ2o3j5TAyuc14VsMEpAV7ovuLRpU9vifjOBUiydvU0NTkJz0FiMZcAculEWypuZHecgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510794; c=relaxed/simple;
	bh=+y4NViVcyrnu4mfkTciikTBP7Wo/pLpUX/c6LOheJzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIitrs0/Lro6QCY+y8goEAWMzrIkR+jHO0QZRop79YseItyohaUGu3WDgZNXbd/oGEOm83pug696f1LBlN2evPlYWjviNCfLkPpYx9FteV12Rr/Ubiy6By3OjfwQ2pqrI+5stp/Scal8BtBAB2C/xIoH8OWh6lRNp/L9Ax4kdr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl+KK87F; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso1792793a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510793; x=1757115593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9yE6iUWv1HmTcycn2Kgovi0OD86opQK3HCN8NH31Dw=;
        b=Yl+KK87F1zDLjz5I2cb1QOeQd180L9sMvJR0z8qkflxCzyU2H8CL07WAzS1GBQJYay
         JbQlEoMnjPq+iJJnU7R5ZKhcQBZvqkz3jfqyZ9HRydeUYJP61wrGinfCeMAIqPXBCDGq
         cnXr2BUiucugQ8TyobHXOlE0bi+LtB6Apq+H+NZCyKaA1V7cDagesNTBxkbRKPCdeQOk
         9Ue3LbHDxPbMk/r0aqa/W4fkxw5YFUQQkP1JNzfcd7cR/ZeDXCt10muqrbpHmXlffOVK
         4enF9xnKbyoR4LXEQrf1Gc9gqllVn+jhVHgVDoZAJ9d6Gv8/9dPqKCQc0GczHaN9NlaX
         sO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510793; x=1757115593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9yE6iUWv1HmTcycn2Kgovi0OD86opQK3HCN8NH31Dw=;
        b=GS23VWQ9eD9jtRieFyfo84BHGM4TS7u8nbH/0pH3vEAP2KuZ+0vRPXrIjLGY1uVmX/
         /373+uYQJfK5ejpYdJydAD27708SSyKY8igXT12iFtWUc+QDkWrKGv6XxH+hnShiIcki
         RrxC9SLz0BL3YJzq3xGktnsEp/Ts2tk+4sVONJJuv0vhPdFJRCGYgF82gPfA6nKno4cs
         gRy1P870CdtWBDog4k4n3HRtt7kCaw+Ru1BilAMn7Ufb+MakPjIZ8nAG++rHrJAeDmjo
         Ab82esWcgl4p5Vz719uvS2LhjdGdgOVjZxJQnF9cZlZ3l7xfAn1YBBD8eDONittbH4Li
         H2UA==
X-Forwarded-Encrypted: i=1; AJvYcCU9p2DdAozsUfhDsxVZLFiN8JLdeW36/I5CxxlAGi+zHXjDc6JC/HjA/FtO1SJm3SNkoloTBRANrGhUK1xT@vger.kernel.org
X-Gm-Message-State: AOJu0YzJRnMDrCzhwWfzVSoZY5TGWVIYHpwWBtm/1wSrocdqtgXDnrl0
	DZz1Ad0S6DJEcwj9TLiQ7imceedlH969KoIkVtJ3uUg7DPsPRvC56dir
X-Gm-Gg: ASbGncsXwUaud2/8A6TG345mSKaF7f+0detGz2fnu4FgfaZ0dFGqTar7YNHU4mXzVKr
	6mEFa6njDkhbyRDAylfehAxluQ7GM8WSX2HK2bUmEF3iVg9zpLrIp4Vo4R0vX1NXfVP+Ug+K7y+
	m7eezG1S9PIknRYBodvmqoTsW1nZwZrUYG1RfsI8mF4QtxqNpfbUK2RJHNqBfB6v2kg9LCxffzQ
	XBXH9DQ9g4S4NCfi9ZJPnsl76A418fbDeOHFUA5ZOvXQIyCIgIhrM8qPPwg4bs0O4rc9FO3NDvm
	z+i1xhhbLW8HU+MzygM+pym/0yEMz8q/ubI9Ms/zsxWUrJmnICqnOyoetCz/NIWmEhiE/iJf1O8
	UNkm9qbXRwC0NoCkFYqS7TUcj3l1Y
X-Google-Smtp-Source: AGHT+IEakBzSU3WTPQcPaNKIo9o/oNQ5zQ/nTiRT9vUZAKzQVW1JTdcqtGnmIj7pMlDYZQjvOwwypw==
X-Received: by 2002:a17:90b:57cc:b0:31e:c8fc:e630 with SMTP id 98e67ed59e1d1-328156cc985mr554327a91.26.1756510792618;
        Fri, 29 Aug 2025 16:39:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d8f66f16sm3893578a91.0.2025.08.29.16.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:39:52 -0700 (PDT)
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
Subject: [PATCH v2 02/12] mm: pass number of pages to __folio_end_writeback()
Date: Fri, 29 Aug 2025 16:39:32 -0700
Message-ID: <20250829233942.3607248-3-joannelkoong@gmail.com>
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

Add an additional arg to __folio_end_writeback() that takes in the
number of pages that were written back.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/filemap.c        |  2 +-
 mm/internal.h       |  2 +-
 mm/page-writeback.c | 13 ++++++-------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 751838ef05e5..cbfb0f085eb6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1657,7 +1657,7 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
-	if (__folio_end_writeback(folio))
+	if (__folio_end_writeback(folio, folio_nr_pages(folio)))
 		folio_wake_bit(folio, PG_writeback);
 
 	filemap_end_dropbehind_write(folio);
diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..2eb156823d45 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -438,7 +438,7 @@ static inline vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
-bool __folio_end_writeback(struct folio *folio);
+bool __folio_end_writeback(struct folio *folio, long nr_pages);
 void deactivate_file_folio(struct folio *folio);
 void folio_activate(struct folio *folio);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d1b2c91f0619..65002552458a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3006,9 +3006,8 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
 	spin_unlock_irqrestore(&wb->work_lock, flags);
 }
 
-bool __folio_end_writeback(struct folio *folio)
+bool __folio_end_writeback(struct folio *folio, long nr_pages)
 {
-	long nr = folio_nr_pages(folio);
 	struct address_space *mapping = folio_mapping(folio);
 	bool ret;
 
@@ -3022,8 +3021,8 @@ bool __folio_end_writeback(struct folio *folio)
 		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
 					PAGECACHE_TAG_WRITEBACK);
 
-		wb_stat_mod(wb, WB_WRITEBACK, -nr);
-		__wb_writeout_add(wb, nr);
+		wb_stat_mod(wb, WB_WRITEBACK, -nr_pages);
+		__wb_writeout_add(wb, nr_pages);
 		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
 			wb_inode_writeback_end(wb);
 			if (mapping->host)
@@ -3035,9 +3034,9 @@ bool __folio_end_writeback(struct folio *folio)
 		ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
 	}
 
-	lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
-	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
-	node_stat_mod_folio(folio, NR_WRITTEN, nr);
+	lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr_pages);
+	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr_pages);
+	node_stat_mod_folio(folio, NR_WRITTEN, nr_pages);
 
 	return ret;
 }
-- 
2.47.3


