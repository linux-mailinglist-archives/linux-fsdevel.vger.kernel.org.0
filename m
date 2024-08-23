Return-Path: <linux-fsdevel+bounces-26938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCFB95D357
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451A11F2307F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9B18C330;
	Fri, 23 Aug 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQID47pu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454918E022
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430468; cv=none; b=tASkmpUY3w862DW6c3x8V6YLq99YPHpdNWRawmDihH2YbDjFB0XUX42UuOfQEg2P4knVCQiKiBEgWsnEdZen8X8/L14wjQNv7ZHkwWF1JIC1BxY/8LFIQbafiRrzZDW0OPJHrfgmAxBm0i5kYJOhEjdXA6NzSgSZmyxgYiW0QD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430468; c=relaxed/simple;
	bh=Fr310KpdfEiwRi78xJDDOcgs0wlrFL4uDgrebaR3HTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z13RmHbXMGNamvN4F9hZKh4dPaqYCTf4Vin79hLYe9t32K5S8aBOHtypBlAVcejvtkhXdEvZkUCAjvZ/UAhBTZBtHh2QsiyUUtZxINX6jTgmNqohskerLjcUf+UCzAcspmgsyZhkf7cj6RiAH+LGk1W7YGwLuOcGLgve3n7KwJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQID47pu; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b747f2e2b7so20584047b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724430465; x=1725035265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXRc53IcYY7VACycZ4VyUa0QB5NcTdDD31/jr4+UwJg=;
        b=aQID47puekQrm4E/c2kRUAK/Zbbs1FM3JPRc6n7yfcd5HrU7U0p1m5USNG/dag++xB
         DnpxBtZ+Ue69tjEcLrMYrHkQv7NQ4LB13NYxEx6GOmII40eeSCGzv9RDeQtg83MQ+Bl1
         TsIvSQ9E/TdAt+/+p57t0sm7M3D6sPSHXkzDLxZT8a3W4qmvPPxMk1P3fpk5u7ngg7d3
         bFb/ilkD5zfg0VttzlQip6OutgDkLyGVE2u6zTkcTPzhSd3dSl2BAxVR2b59N19WiQAd
         M+lMQdw4AlWIYnLrae6+/oztu0CyD9ChEnYTEWPfVYsS6zzKylb25QGOzdKBqaZn79S/
         z8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430465; x=1725035265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXRc53IcYY7VACycZ4VyUa0QB5NcTdDD31/jr4+UwJg=;
        b=DDYJUuJDaNizz6cfYa50hxuSjKVoXrtyb3eeDPdPHK1/OO+7Opu3wvdKaBjNv0mqQM
         AHbzfoeSKL0ZL9FKJcsF85kbmioxS94a0H65OOomF/OsXMzih5mhxIKh58zjYDSJcW7g
         Q543YXOTA15ALfYlDZ9bYf23lcu/jwWMwvAlT+DcslNgrvFGLmO5VTXFAsiLV776sW1w
         hhI8GBsCIYvwnp0X3R2rgTvSHQaCT4dDepF2C5vrTEguvLRL+uUT1rwr8YaWtVbOmo4N
         I0jp3rZ9S8wArHXpxLv1axU2uGZ6hU7katHZTMGyGNMOXbrPHi7dbHZrWT/5yXl0F+lX
         XylQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcesgsiGrd0ZUgDocq4ovB8YxZM3ipCmdQFl6Ngw2Cx2/R0g9EAigtlJVGKZ55s3UDwFJjukjKs2IGKYrz@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIUSZdmrKEsPru3oRvbktK8zys7JupoYjrPiUHHGkz+ZdHEEn
	s79bg499KneMJCGi4UcfrTLr1rFF5qjb+0uaBu33VfUxipRVSmZ1Df9NEA==
X-Google-Smtp-Source: AGHT+IG+IYMOOv1hRsXsrbFY0Sb9vTejv1Bhi7btumeWDIcT8NhMW6tSTVMI8MHJh9Pa0GOCD5htFg==
X-Received: by 2002:a05:690c:fce:b0:6ad:ac4f:a1a6 with SMTP id 00721157ae682-6c624bd7e28mr32258737b3.12.1724430465609;
        Fri, 23 Aug 2024 09:27:45 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c399cb4e6dsm5967037b3.9.2024.08.23.09.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:27:45 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 7/9] fuse: move folio_start_writeback to after the allocations in fuse_writepage_locked()
Date: Fri, 23 Aug 2024 09:27:28 -0700
Message-ID: <20240823162730.521499-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823162730.521499-1-joannelkoong@gmail.com>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Start writeback on the folio after allocating the fuse_writepage_args
and temporary folio, instead of before the allocations.

This change is to pave the way for a following patch which will refactor
out the shared logic in fuse_writepages_fill() and fuse_writepage_locked().

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 905b202a7acd..3d84cbb1a2d9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2060,12 +2060,9 @@ static int fuse_writepage_locked(struct folio *folio)
 	struct folio *tmp_folio;
 	int error = -ENOMEM;
 
-	folio_start_writeback(folio);
-
 	wpa = fuse_writepage_args_alloc();
 	if (!wpa)
 		goto err;
-	ap = &wpa->ia.ap;
 
 	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
 	if (!tmp_folio)
@@ -2079,16 +2076,20 @@ static int fuse_writepage_locked(struct folio *folio)
 	fuse_writepage_add_to_bucket(fc, wpa);
 	fuse_write_args_fill(&wpa->ia, wpa->ia.ff, folio_pos(folio), 0);
 
-	folio_copy(tmp_folio, folio);
 	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
 	wpa->next = NULL;
+	wpa->inode = inode;
+
+	ap = &wpa->ia.ap;
 	ap->args.in_pages = true;
 	ap->num_pages = 1;
+	ap->args.end = fuse_writepage_end;
+
+	folio_start_writeback(folio);
+	folio_copy(tmp_folio, folio);
 	ap->pages[0] = &tmp_folio->page;
 	ap->descs[0].offset = 0;
 	ap->descs[0].length = PAGE_SIZE;
-	ap->args.end = fuse_writepage_end;
-	wpa->inode = inode;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
@@ -2109,7 +2110,6 @@ static int fuse_writepage_locked(struct folio *folio)
 	kfree(wpa);
 err:
 	mapping_set_error(folio->mapping, error);
-	folio_end_writeback(folio);
 	return error;
 }
 
-- 
2.43.5


