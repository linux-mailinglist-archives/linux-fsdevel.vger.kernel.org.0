Return-Path: <linux-fsdevel+bounces-32715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87799AE0A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A421F24584
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D51B6CED;
	Thu, 24 Oct 2024 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUj+Avcb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2A1CACD0;
	Thu, 24 Oct 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761994; cv=none; b=ElUrD4IuiTr0B6FXP6wselxpSA4EVuqBz0eX5yn5FGDaaiACdHwGCXcXg7/mMDFHpoIEpQott1pXrbTErz4LFL7sV8tbgQC4xcCbJuQqWhxp64xX80hOkwDteCsbsb+IrwUwOWftJI11YTx7hwYXLmAaeCCWP95xAaXRG3SB45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761994; c=relaxed/simple;
	bh=83oWICUaM1pez/cllfdiTPn+JZHb5MaKCRkNi0TEwEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeyfbB4zFOr+ME+LrlyyVSt2t2faIEW613QJ63STZelab/RW/5LqhvVHz26ZeswpOLTFnf+UPRQsqzwM1wjs2Zssa0vNOoUmq9LcF2LfM085BTEZ/tSk6+8hNf6FzJ7AOb5vPejSAI/ZnLsju+v+hDX1qOZQ6N8gAsykSGhYnYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUj+Avcb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20caea61132so4784405ad.2;
        Thu, 24 Oct 2024 02:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761992; x=1730366792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE3hzGmrsBlUG0nTaJ74q6XkM5Ijqikn5DY/sHHFnWE=;
        b=KUj+AvcbRBtKlMDHMTTU10K6rUBxw/Ruk5JSQ+RYUrj1cwaumcUcHPY6ef+AM+9Ehp
         gQi6ijejS/X8W+N+SPtKdcC6YUgiv/pchk+xcvY5uSsc5JypznURkBCiSaTmlAF9uJ7w
         gkS+pzOnI6TE1nAKSZ7wsk+HwAXlb/XSdl06Iqa9yGgjIjpGlYrVByibEqQc4zK38NKg
         dtvZcu+Du8RM2pnILUGW4sm3RS2UDIz7I5pWjHhs36YgulW4Gssd2vfc7oEEygO0Cz+T
         DC/LLetRen9/cqvAiA/Kk/VXyL+biib9TCja+o9PcCXchDlCRLl2AqQNJmS0n09C3a8K
         vcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761992; x=1730366792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE3hzGmrsBlUG0nTaJ74q6XkM5Ijqikn5DY/sHHFnWE=;
        b=YNMmyrxZy9tmEoKzilIvKq47zfUfyERyt4q4r9uJ0v/VxSKAsZZzLDOeFIMkBKkCqn
         Hesu74fPB7frfTysfxajb1tYOqF8aG9lC4vS6Lpph6DZ5dn7ic61LsviFplg1MjEScfM
         S/SQjUBPXalYsPjPErx6j2yyVDJ/fIDQLiXCrJV0H0wVjL64AEd44snsvNhFcuqRISpx
         TJCvkBcfh3Cp5zdGo1PuU6nAiVEd+sku6vtOjcyt/I/Jl95UnSLkRC1s0djtycpxpI7k
         wmLVp6YiQYRNDSMDbt1XtOdtxLPoNDsmZ2tWWQ9hrkkQzAXmEJ0+JS9vMPvXGsF+qti0
         C9tA==
X-Forwarded-Encrypted: i=1; AJvYcCUOa8t8snmHoc46GLmZoEGMlvR7D/KnWK9pvpZ4VZG1VWVaNLa46Q6r50nu6u7LZm7TKV5EvKEFBAfoTgd2@vger.kernel.org, AJvYcCUPZrIZU8ZBbYJ4jpg5duVZxYP9dwuXTbXRdDZo0FPXjOi0B4HMq5wU3IPEL3XUsTEjdkR893ypp2uZLeo=@vger.kernel.org, AJvYcCVWgjJanCUuny7+Ngo7x9bQ3p86W8LgBzSErL43+eJRb3XK/ntEPrm1Qom6fThHz7QuNXOOD/q6Ldurp7Xk@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkqmqfw77CYXSiO6myI6uRN4xXb8GKgOgLO2eKO4C3TehV3O7
	e6ADDlvNd+/jl1CHFM+Sc405WMfKQksvKUv53HkIrvrmMj8/jyMX
X-Google-Smtp-Source: AGHT+IHUtg0SMbnTv0FXcuMGx8pIxWDFjcw3z5vfuJKLY/LncWPph7w+1vBPd735uJW9h3UyjuGdEw==
X-Received: by 2002:a05:6a20:d98:b0:1d9:1af6:94ba with SMTP id adf61e73a8af0-1d978b0b693mr6788947637.14.1729761991838;
        Thu, 24 Oct 2024 02:26:31 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:31 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/12] nilfs2: Convert nilfs_page_count_clean_buffers() to take a folio
Date: Thu, 24 Oct 2024 18:25:44 +0900
Message-ID: <20241024092602.13395-11-konishi.ryusuke@gmail.com>
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

Both callers have a folio, so pass it in and use it directly.

[ konishi.ryusuke: fixed a checkpatch warning about function declaration ]
Link: https://lkml.kernel.org/r/20241002150036.1339475-3-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c   | 2 +-
 fs/nilfs2/inode.c | 2 +-
 fs/nilfs2/page.c  | 4 ++--
 fs/nilfs2/page.h  | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index a8602729586a..14e8d82f8629 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -95,7 +95,7 @@ static void nilfs_commit_chunk(struct folio *folio,
 	unsigned int nr_dirty;
 	int err;
 
-	nr_dirty = nilfs_page_count_clean_buffers(&folio->page, from, to);
+	nr_dirty = nilfs_page_count_clean_buffers(folio, from, to);
 	copied = block_write_end(NULL, mapping, pos, len, len, folio, NULL);
 	if (pos + copied > dir->i_size)
 		i_size_write(dir, pos + copied);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index c24f06268010..cf9ba481ae37 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -242,7 +242,7 @@ static int nilfs_write_end(struct file *file, struct address_space *mapping,
 	unsigned int nr_dirty;
 	int err;
 
-	nr_dirty = nilfs_page_count_clean_buffers(&folio->page, start,
+	nr_dirty = nilfs_page_count_clean_buffers(folio, start,
 						  start + copied);
 	copied = generic_write_end(file, mapping, pos, len, copied, folio,
 				   fsdata);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 10def4b55995..e48079ebe939 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -422,14 +422,14 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 	__nilfs_clear_folio_dirty(folio);
 }
 
-unsigned int nilfs_page_count_clean_buffers(struct page *page,
+unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
 					    unsigned int from, unsigned int to)
 {
 	unsigned int block_start, block_end;
 	struct buffer_head *bh, *head;
 	unsigned int nc = 0;
 
-	for (bh = head = page_buffers(page), block_start = 0;
+	for (bh = head = folio_buffers(folio), block_start = 0;
 	     bh != head || !block_start;
 	     block_start = block_end, bh = bh->b_this_page) {
 		block_end = block_start + bh->b_size;
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index 64521a03a19e..136cd1c143c9 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -43,8 +43,8 @@ int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
 void nilfs_clear_folio_dirty(struct folio *folio);
 void nilfs_clear_dirty_pages(struct address_space *mapping);
-unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
-					    unsigned int);
+unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
+		unsigned int from, unsigned int to);
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 					    sector_t start_blk,
 					    sector_t *blkoff);
-- 
2.43.0


