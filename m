Return-Path: <linux-fsdevel+bounces-32711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C239AE09D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA5E284B8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD81C07EB;
	Thu, 24 Oct 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnCnjP0h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF1C1B392C;
	Thu, 24 Oct 2024 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761982; cv=none; b=d8SHuF+UMMSE//sTg6WWyJIaHo3voTNp7jalIjgiLX9pSuVoDer/PYo+5ICpdFgptTyCUTS7qRLcxeTwbX5s2YEEj1xQTnWCnKf0h2GnPD2VfnG1TmnYlgcCwBwV8qXhW98hFuf0XB9tjM0l7e8qZWtUisooIwKzlBAqzkhNEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761982; c=relaxed/simple;
	bh=ApXolRjbW7uPTaPug2xagYT5GraWeA47lhyoOlE59ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BV+PGQwia7szxguJr+YO/TIiqZxeMeyV5SNfz5RDj64+GlWOn4JomFy0bAamhyLvBCkBnBARjkJ7w06qfRS0+XpSB7LJOhPPlBqm5CDeem2taJe87Hj5FYLfWV0p45Nx2I0ty43AikrBXtCa3R/neVIVTfEiqTSF+bT/snOt240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnCnjP0h; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so760322276.2;
        Thu, 24 Oct 2024 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761980; x=1730366780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbcwrjGS6D/wxYkZ0FTx8Zm+DfXe52iNpdOWPXiGeb8=;
        b=BnCnjP0hxHdq15qS25E/+fCngmBNLN0b7M/yqwGNpPkHknxWhJUDAELsmyldbMBsLV
         DJoYOunGkvFggT2B6KIlOnj6LPJ5TE3pHdcjeQ0a7l8g7DZvo/7ituhMb7Fg3H5vACfJ
         g5ghA8aMaN3OsAHgTz+VymXbY3iaFLEhtIyvDHFTX+QMtQzoBimVHwD7tkQqfjzhfs20
         ODPmkjvdOeTpQhMRqGHCGt34WvK9pNinGqPOJ4by9Vb/r9f6fF0ahfefS26ebLRVH56V
         3jtVMH2I/E39Q+WJTn5j99xpHyxKZJyhWfxllCb3odlpB3TxmSmgUDv+EiC24aVLAZB7
         wFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761980; x=1730366780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbcwrjGS6D/wxYkZ0FTx8Zm+DfXe52iNpdOWPXiGeb8=;
        b=bZrrEL2Qx9vTXAkrxxxbsTQSV0Q6icL8PiGRBrCV1VlxRASOtpsLyuaiYMzNT1MtAE
         zCqArs748GOTk3uYDpcxZ2hDNs7NjaMK1IA71T4Ee3R7P3uXUPvOXTjAfPYevce3vmNG
         tKEFbBxbKbwtuURXLs+B7WY+DnYS7eVKkGxJZHTShqoOvbvWQxGpblZBMfprAWjBG25H
         IwFxKdyhWbiDEot4MMdFurJC5asoQQJWZSPxHDJipykbylBoxRch28sUX0BmIMdz4/r8
         5hcrM57WD5epr33iYWa4hnJLh27PknIMUBOcuzHo3qtLdnSL9JM1ALAMjTmrwbRnJVV7
         sE+A==
X-Forwarded-Encrypted: i=1; AJvYcCWT472z3Gy001sOfX8vTaf7RKqhHREfdbWtylNmbXhZc5HdP8DZFdQiGFo8VTrCEsDiPhZD/uoIzxTengU=@vger.kernel.org, AJvYcCWlZKmeL3oxQUA3sXZsK+Yg09a2EvLj2P4h25HnnweMkdymZQNr2jfRk+5sV04DFoUmKOvKWXmPhiU2zuTy@vger.kernel.org, AJvYcCXF6VsjLHMg075wgft8DumnyPmpFX8Szioc1T3wN64OhsbgXB77cGF8dk5Nxh0YuYSVt4I0AhCGYXgsAuzo@vger.kernel.org
X-Gm-Message-State: AOJu0YxaeHXcemuSEa9342LgMMCJlqUVdaPPxWFk+I4RSrMvYe9hqKJ8
	xx+Z6Qn7sUbV80+jS857lm131u0NMOr2OraME+eWjQ4KhRF9/hcP
X-Google-Smtp-Source: AGHT+IH1X684ycjGALsbCCbZeWy+0hqSVcdj1UUI/CHecNEAZasCF34CQe4RPljVk4H0QDHz6QLoKg==
X-Received: by 2002:a05:6902:c06:b0:e2b:e286:b60e with SMTP id 3f1490d57ef6-e2e3a6c7cd7mr5322784276.42.1729761979744;
        Thu, 24 Oct 2024 02:26:19 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:19 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/12] nilfs2: convert inode file to be folio-based
Date: Thu, 24 Oct 2024 18:25:39 +0900
Message-ID: <20241024092602.13395-6-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
References: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the page-based implementation of ifile, a metadata file that
manages inodes, to folio-based.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/ifile.c | 10 +++++-----
 fs/nilfs2/ifile.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index 1e86b9303b7c..e7339eb3c08a 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -98,7 +98,7 @@ int nilfs_ifile_delete_inode(struct inode *ifile, ino_t ino)
 		.pr_entry_nr = ino, .pr_entry_bh = NULL
 	};
 	struct nilfs_inode *raw_inode;
-	void *kaddr;
+	size_t offset;
 	int ret;
 
 	ret = nilfs_palloc_prepare_free_entry(ifile, &req);
@@ -113,11 +113,11 @@ int nilfs_ifile_delete_inode(struct inode *ifile, ino_t ino)
 		return ret;
 	}
 
-	kaddr = kmap_local_page(req.pr_entry_bh->b_page);
-	raw_inode = nilfs_palloc_block_get_entry(ifile, req.pr_entry_nr,
-						 req.pr_entry_bh, kaddr);
+	offset = nilfs_palloc_entry_offset(ifile, req.pr_entry_nr,
+					   req.pr_entry_bh);
+	raw_inode = kmap_local_folio(req.pr_entry_bh->b_folio, offset);
 	raw_inode->i_flags = 0;
-	kunmap_local(kaddr);
+	kunmap_local(raw_inode);
 
 	mark_buffer_dirty(req.pr_entry_bh);
 	brelse(req.pr_entry_bh);
diff --git a/fs/nilfs2/ifile.h b/fs/nilfs2/ifile.h
index 625545cc2a98..5d116a566d9e 100644
--- a/fs/nilfs2/ifile.h
+++ b/fs/nilfs2/ifile.h
@@ -21,9 +21,9 @@
 static inline struct nilfs_inode *
 nilfs_ifile_map_inode(struct inode *ifile, ino_t ino, struct buffer_head *ibh)
 {
-	void *kaddr = kmap_local_page(ibh->b_page);
+	size_t __offset_in_folio = nilfs_palloc_entry_offset(ifile, ino, ibh);
 
-	return nilfs_palloc_block_get_entry(ifile, ino, ibh, kaddr);
+	return kmap_local_folio(ibh->b_folio, __offset_in_folio);
 }
 
 static inline void nilfs_ifile_unmap_inode(struct nilfs_inode *raw_inode)
-- 
2.43.0


