Return-Path: <linux-fsdevel+bounces-17165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E48A8886
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A811F24877
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D331315E215;
	Wed, 17 Apr 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aowM79hZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10B15E200;
	Wed, 17 Apr 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370209; cv=none; b=GkAvRT+/+BxHtML5IHEi3XkF28IrFyVD6fWmLXIW26YaWyyZt1d+D88syOuhOUalyBKon2Bd9gNFRzVspdb0wPSpD+Mam1wZhfI8/tOP9F33nOvq/LuM+bu5bUQaJ7lOtFrP1UQyqiVN18IJP8jN2bZXgZeZZWwW0oa35CUDiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370209; c=relaxed/simple;
	bh=Z6E2pCl6gh7/PPQWEZWXuOAcVWTT82yYaNSwyTRO5yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXqif7ruL/oEutgjEkgcf4RGMGpEAbfwh7LNhSMEskEWpgFzOj5aVu0YsbnqdUvMyDKrVBRoMEiuS914oYQdRpzSu7RqwGLcuQGl/IhehFFUUJqJ/pHbHhJEvAtGqTiSB6vRHCgQ06d91N5xSXkgdA2/txjGznumhkAdzv45YOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aowM79hZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ead4093f85so4895104b3a.3;
        Wed, 17 Apr 2024 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370207; x=1713975007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Srg4dA9RNSDxQazS93yF50nbI2bCxfJ5XfNZ+0IFk1c=;
        b=aowM79hZL9Ruw+wtsOLqgQPAhm4DjRKPKSwAhaHaMJzDnNWVyyQyAcnhXEQo8bDP9v
         sOKFhgllOodLknAFGJjEuprMnW8IlfpzybMwPrzvuQSL0ww3wgOuh1Rt8H4xmjFkFWfk
         WMn9RDotpQ8gonm3ArqVn2M97R4wGL8/ISE5GBp16nxtW9nOnE0y2OAeYkLGlElYtmru
         uJoUUGqnmoEJXFy3NdPPFRG1swlY/XYLGhduMFrfjrwwpm1FG8wVo+s6ASN8rUvy69Vf
         voEdPNj0JhwV4uNtjpULgWDafF/2spBjuoxm64lX/u+QxEc/637hQl5lP45dpXh95/nA
         lxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370207; x=1713975007;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Srg4dA9RNSDxQazS93yF50nbI2bCxfJ5XfNZ+0IFk1c=;
        b=bQKTN38OyqV7NyvR3FKSa0or3LwsP9jTrhUfz3Wqgl8WHDGNnj5NuQmNvxBLOLmZea
         sSh0Xx3GCtFCpeptcz+sXnXbDojMmUpn/nvXCu4c/sD0hyOfofTtqGuyqn/6QCe1sPMt
         igQPBz7IVwGw/rNw0gYCkCmas8xCou3h8oGOeZWJFcRZlvFlzESt1Aa80dwsMke8zTqh
         YAnUDYqnJq49umB+0lNDBQ7DdFxdayhE4WBsx5ermpZifPp1pEo1OTWFEkJMy7Iqz3vr
         yAcrrTW5/0Dm7BkeLnXB0vQvrU7DVaweQ3c6W6YU3lbW7eOsCSB1fKM+fHHvLWKmIk/e
         yNIA==
X-Forwarded-Encrypted: i=1; AJvYcCVGymZQd9t7MKzwyWaDArZ0KY3/l31ZN1EYfTf8f9Y8ZtSR9K6rnCvDa0gkcTRbR7jrKnBNtd+/vzhVqDnqQ30TmAtxiVDlUtK2lQJik5zVSM1fq07SQS9Q9zRDvteSou8YjriLYuLWxyXGYA==
X-Gm-Message-State: AOJu0YzJbwV1SlX/45pxCzMcoQCHXizoFDw2kI5e27X6WTJ02hc9hgJh
	MMnjzCOxvD+a2HJJEL2CJMvq8VtbT1EDWYivBC75wME+30IsrYNm
X-Google-Smtp-Source: AGHT+IE91IYOeoH7Co4FQPgzNtFkiFYWeecE7d0F5J2GxZaKlBCPwnRQBB9VWoRDd1SCyPSrNH5WaQ==
X-Received: by 2002:a05:6a20:3ca4:b0:1a8:2cd1:e437 with SMTP id b36-20020a056a203ca400b001a82cd1e437mr102832pzj.11.1713370207249;
        Wed, 17 Apr 2024 09:10:07 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id h189-20020a6383c6000000b005f75cf4db92sm5708366pge.82.2024.04.17.09.10.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 09:10:06 -0700 (PDT)
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
Subject: [PATCH 6/8] mm/swap: get the swap file offset directly
Date: Thu, 18 Apr 2024 00:08:40 +0800
Message-ID: <20240417160842.76665-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417160842.76665-1-ryncsn@gmail.com>
References: <20240417160842.76665-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

folio_file_pos and page_file_offset are for mixed usage of swap cache
and page cache, it can't be page cache here, so introduce a new helper
to get the swap offset in swap file directly.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/page_io.c | 6 +++---
 mm/swap.h    | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index ae2b49055e43..93de5aadb438 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -279,7 +279,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 		 * be temporary.
 		 */
 		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
-				   ret, page_file_offset(page));
+				   ret, swap_file_pos(page_swap_entry(page)));
 		for (p = 0; p < sio->pages; p++) {
 			page = sio->bvec[p].bv_page;
 			set_page_dirty(page);
@@ -298,7 +298,7 @@ static void swap_writepage_fs(struct folio *folio, struct writeback_control *wbc
 	struct swap_iocb *sio = NULL;
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
 	struct file *swap_file = sis->swap_file;
-	loff_t pos = folio_file_pos(folio);
+	loff_t pos = swap_file_pos(folio->swap);
 
 	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
@@ -429,7 +429,7 @@ static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
 	struct swap_iocb *sio = NULL;
-	loff_t pos = folio_file_pos(folio);
+	loff_t pos = swap_file_pos(folio->swap);
 
 	if (plug)
 		sio = *plug;
diff --git a/mm/swap.h b/mm/swap.h
index fc2f6ade7f80..2de83729aaa8 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -7,6 +7,11 @@ struct mempolicy;
 #ifdef CONFIG_SWAP
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
+static inline loff_t swap_file_pos(swp_entry_t entry)
+{
+	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
+}
+
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
-- 
2.44.0


