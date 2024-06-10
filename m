Return-Path: <linux-fsdevel+bounces-21346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136A4902655
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 18:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACEDB2A268
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C161487F1;
	Mon, 10 Jun 2024 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8K05pxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B74314658E;
	Mon, 10 Jun 2024 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035241; cv=none; b=B2xmRyovmeFDfmyeaTTvvf4stuZkCEy7PjIUmpiayuc/iOqbI6u34YholMzPewyYhRP6m7w0Z3nB3lARGrjqDMzYRxAdgiqqjOI4UfqWAGpNZRSJ+UPntQ1wzAu/U2NZIPbpNJkP0PQhvHxYydeWIIIYEaBXoUYF1Gv2DRnHR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035241; c=relaxed/simple;
	bh=+MIiiCbdWxNTXrUyRNbG+b13pi9WFUp7fmDjl+ZCGnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nWf/2rmH8mAwHPiO6PGxUnEjR9ktU4obntlJEu1FsXajt2MVshS/Adz9JYXT2DF2yx0/kyCv5UKRrKl/EceDMYkiUX9OoaDRgEr8cPZgChVrkXzEMzypgtBphTnQ+xmuAL3vnWNFYrCPZ1v6XCYkK4YeeCBXmcXVM+r/+cpc4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8K05pxP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7046211e455so878373b3a.3;
        Mon, 10 Jun 2024 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718035240; x=1718640040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e55PJUTGJquoA8apS39Yj2O1Aiis5PKLgqTtAScEy6s=;
        b=G8K05pxP7qfddRf97gAxXyjPOPgh2EQlsCEFOFhOwjI4js9s5/GR3CqhthitS8VofR
         47wwbsTd6sqc4XUN+A3k9K2EuxL7Mcdv79hiomWj/lPCuUTa2FoCcBfMjPUwrDfFfgKs
         zQgJhDFqEh0bnLrSg9cgn1cwB/OVWG6zbQ3DtLQTbH3eziMDIhZ8nMEqgJDiWNBker0F
         7XdCswziBADBEpJ9QhELct9qYRUYNMeNhvl5BuG4PuKylQar1bXLzAAXhtCNUXzwZOb4
         IGicMInAV9yJG0GwgUKzBIRs28nv8gAylX1u61KNhgPfTVA2ywJcojpDihhfrfHkMROb
         sJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718035240; x=1718640040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e55PJUTGJquoA8apS39Yj2O1Aiis5PKLgqTtAScEy6s=;
        b=D6LZgqdIh5ow8/Za5V3KBDzgrnWbNSe+tJUhs/VnOSwrIiPUgYE6X0aX9Jx1YO4j6c
         c+PIyQNNYJ3zG/wnC+d8qTmDXOCgYNYnIT0GL4QlxDkoWdFYL06hlgO13d/S6oxh2z4R
         n0kMltMA8tQEGyi81LMIdtBPMOgVo+PQ59dJGHu54rD3gJZXxh4mPlVQCmbRh059H9Gb
         tXc7c1vsEL9nI95WVZG9vyrfvoQopue+1jrjw64KqvT8EqTuZIJDV3sHRsyANoKc8jMt
         VaRjGkEcdYcI9j6YsBCbPXdasIzJRnZKPe38emaHQgaeGeANoojQbR/4z22BUjZlzkkS
         N6bg==
X-Forwarded-Encrypted: i=1; AJvYcCWzVmvu6ZFxar0H/29tp3LwL67X1id4sXMzbw3bEu69MRI2uSwuyVLENRgaI42MieEj056RrFyrrgl4jlA1QMRPwsfvM5AdNLLNCQssLUCMgtgdhFthWlIWpa3fs/Ivm3Y2H5165kYy6KLj9Q==
X-Gm-Message-State: AOJu0Yw27Z8/83RjxCdCTjkElu2PVoBYU4K7zqWeqYoWNfWeUPVfnIvL
	vi1lnQZwQyTOnGBoE2TBDYLzxHqGUtvCCcBjaNCPJTFExmHqPWaW
X-Google-Smtp-Source: AGHT+IGiEFs8Aut7LobpCXj5NsxQBIaxTqD/6/qlgjEDxm9l2MYyHo4ZKuqutmqOKYkGm7uexbY4WQ==
X-Received: by 2002:a05:6a20:3948:b0:1b7:edea:e36 with SMTP id adf61e73a8af0-1b7edea118dmr2333039637.22.1718035239641;
        Mon, 10 Jun 2024 09:00:39 -0700 (PDT)
Received: from carrot.. (i223-217-185-141.s42.a014.ap.plala.or.jp. [223.217.185.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e4532507casm4872411a12.62.2024.06.10.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:00:39 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH -mm 2/2] nilfs2: do not call inode_attach_wb() directly
Date: Tue, 11 Jun 2024 01:00:29 +0900
Message-Id: <20240610160029.7673-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610160029.7673-1-konishi.ryusuke@gmail.com>
References: <20240610160029.7673-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call mark_buffer_dirty() for segment summary and super root block
buffers on the backing device's page cache, thereby indirectly calling
inode_attach_wb().

Then remove the no longer needed call to inode_attach_wb() in
nilfs_attach_log_writer(), resolving the concern about its
layer-violating use.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index a92609816bc9..36e0bb38e1aa 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1678,6 +1678,7 @@ static void nilfs_prepare_write_logs(struct list_head *logs, u32 seed)
 	list_for_each_entry(segbuf, logs, sb_list) {
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
+			mark_buffer_dirty(bh);
 			if (bh->b_folio == bd_folio)
 				continue;
 			if (bd_folio) {
@@ -1694,6 +1695,7 @@ static void nilfs_prepare_write_logs(struct list_head *logs, u32 seed)
 	/* Prepare to write super root block */
 	bh = NILFS_LAST_SEGBUF(logs)->sb_super_root;
 	if (bh) {
+		mark_buffer_dirty(bh);
 		if (bh->b_folio != bd_folio) {
 			folio_lock(bd_folio);
 			folio_wait_writeback(bd_folio);
@@ -2843,8 +2845,6 @@ int nilfs_attach_log_writer(struct super_block *sb, struct nilfs_root *root)
 	if (!nilfs->ns_writer)
 		return -ENOMEM;
 
-	inode_attach_wb(nilfs->ns_bdev->bd_mapping->host, NULL);
-
 	err = nilfs_segctor_start_thread(nilfs->ns_writer);
 	if (unlikely(err))
 		nilfs_detach_log_writer(sb);
-- 
2.34.1


