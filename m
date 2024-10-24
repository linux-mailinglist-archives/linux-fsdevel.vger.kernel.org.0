Return-Path: <linux-fsdevel+bounces-32717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D119AE0B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B281C22AF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01821B6D17;
	Thu, 24 Oct 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj6FDRhi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BA1CB9E6;
	Thu, 24 Oct 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761997; cv=none; b=syWXVaIuno2rTOD6YK8r4ONaiTciiBjHPCsrlCTN+YxJXtok6doOa8+z3IFYolKY8MWspzBxSPvsHdksQSskwevuO2euqXE0gsNSAloUKLULzsEX5hQxeJeego/kTYr7mye6f6W95MiILlcpRdwUJTWsFfEROytQ10p8a8UEr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761997; c=relaxed/simple;
	bh=FFT2XXK09KhKi7sc/MPEDIljixwaNgFnEqinLBMTJS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKPSPZUK+BHyYlpr9WXrxlUEK0U0MRnCs77Teniq3QpZadztj3P9kFaEsTxsRidH39MoeAoSdbkMyJI/EFu88lkrJxeIvBZAq1MFnTOTs1i90MUuJ6M5KXvXJqTBCyWNqtE8qKG3YlQhR9CpjVeMAy3DP91D9DtAK3I62PS/8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xj6FDRhi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7db54269325so418383a12.2;
        Thu, 24 Oct 2024 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761994; x=1730366794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRl7nYlKQVTtZPOf3bc0DgwCB2RgytmZgZRN7PTGqn8=;
        b=Xj6FDRhiGP+mnqByzW7pJ0asmO4K9+amHZ6b70jo8XByIedo5AZkBXO2AVRhCIVEJ1
         QcUg6Zg0sGMAutHGMko+iL3vzWuF/xx4x4Qf1gJmrO9K1ghtI+V4PJMGuAsUbK/SdzYP
         0UEy7twm1u7IGCIeBnxeYAs9ZpFj62PazDsce0R6Qa1oUAr18OaXfnsx+dEco5T4IH/0
         GTeBPDBPDJTr3MngsKkeMSJ0SsT9TDxiPNjN8BDP+51I0yXp6Iwhe4Gv+RxRbObj+VTc
         uTeMpD7i53HU3K8CQaDBjCYZC/ki3JWTQWon354H56cIoBP2NksjAMY4NO8txD1AkFun
         ESaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761994; x=1730366794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRl7nYlKQVTtZPOf3bc0DgwCB2RgytmZgZRN7PTGqn8=;
        b=stWgXDaldEaSLmOC/qqOxzbkSORz+ZSfG1PZ3QOvNKCRZshFq1eybNpCTU/9gkNPYv
         kidwZle9MKtcz2VTisCWt8UBvSdsqd+hbTUShJ+1Va2WJXhQSpNzm+J+hrlVKeSgZ+6a
         AYwM8r4hkUV3e0djT4VlPnBZbfBuQ+EoC8EGANciqxfkwuWIVnlBfkTkcoiEw656u2Qb
         EBOtj706XcCIVe3VP2rgU1Veb7gGYSwqPrFlUgt/i3/k0Af2kKiuhlhjXXHo/49KXScK
         gu99FUpb8I+oZoWfBMrNdiAZvr9sZSX6tBxykq2q64QYuq8pocgBpSktZnnC4BODalA1
         qHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvXNqpFw11113fYvlHUO0nM4i5XUL0g5+7AxiFWoQcZFEUTIb50aA5zZOGfL1zWMCu9MQolz52+kPhaLqW@vger.kernel.org, AJvYcCWXzwYiGDroLVpRboEwKkFNCuT+9FRB1qQCYDs4jDQDcDRp2FxKTaq8vLpDGR0r7KRcHcLbZm7+pMV6t/g=@vger.kernel.org, AJvYcCWkMfW+YWX0YeZGWn9Vn/8Xo32v/hzqrjQljpfatbJwmVMWZReJJ+aZljCqxfzVC4HP7c/+rkzUiJ7c+U99@vger.kernel.org
X-Gm-Message-State: AOJu0YxgS3kZpJ1ipGROt1bE8dCm8s8mbOOhOw6P+mVcnCaLd3esc205
	szIhcaIqv2xqrmsRKDdkcqEPXuIsI7LI6Iky/aTQJijEMwLNYC5EU5pggQ==
X-Google-Smtp-Source: AGHT+IHeGa1Aq2n+f8LUC5Q289Qpqye10iLPUl7E6EQKyPtmyMJKXcM+BBLXwoHkgLyq6xdnBsiGFw==
X-Received: by 2002:a05:6a20:b40a:b0:1d9:261c:5937 with SMTP id adf61e73a8af0-1d978ba06eemr6078349637.33.1729761994202;
        Thu, 24 Oct 2024 02:26:34 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:33 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/12] nilfs2: Convert nilfs_recovery_copy_block() to take a folio
Date: Thu, 24 Oct 2024 18:25:45 +0900
Message-ID: <20241024092602.13395-12-konishi.ryusuke@gmail.com>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use memcpy_to_folio() instead of open-coding it, and use offset_in_folio()
in case anybody wants to use nilfs2 on a device with large blocks.

[ konishi.ryusuke: added label name change ]
Link: https://lkml.kernel.org/r/20241002150036.1339475-4-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/recovery.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 21d81097a89f..e43405bf521e 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -481,19 +481,16 @@ static int nilfs_prepare_segment_for_recovery(struct the_nilfs *nilfs,
 
 static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 				     struct nilfs_recovery_block *rb,
-				     loff_t pos, struct page *page)
+				     loff_t pos, struct folio *folio)
 {
 	struct buffer_head *bh_org;
-	size_t from = pos & ~PAGE_MASK;
-	void *kaddr;
+	size_t from = offset_in_folio(folio, pos);
 
 	bh_org = __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksize);
 	if (unlikely(!bh_org))
 		return -EIO;
 
-	kaddr = kmap_local_page(page);
-	memcpy(kaddr + from, bh_org->b_data, bh_org->b_size);
-	kunmap_local(kaddr);
+	memcpy_to_folio(folio, from, bh_org->b_data, bh_org->b_size);
 	brelse(bh_org);
 	return 0;
 }
@@ -531,13 +528,13 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 			goto failed_inode;
 		}
 
-		err = nilfs_recovery_copy_block(nilfs, rb, pos, &folio->page);
+		err = nilfs_recovery_copy_block(nilfs, rb, pos, folio);
 		if (unlikely(err))
-			goto failed_page;
+			goto failed_folio;
 
 		err = nilfs_set_file_dirty(inode, 1);
 		if (unlikely(err))
-			goto failed_page;
+			goto failed_folio;
 
 		block_write_end(NULL, inode->i_mapping, pos, blocksize,
 				blocksize, folio, NULL);
@@ -548,7 +545,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 		(*nr_salvaged_blocks)++;
 		goto next;
 
- failed_page:
+ failed_folio:
 		folio_unlock(folio);
 		folio_put(folio);
 
-- 
2.43.0


