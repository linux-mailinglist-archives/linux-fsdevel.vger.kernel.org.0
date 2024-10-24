Return-Path: <linux-fsdevel+bounces-32713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264279AE0A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A7E1C21DCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69BA1C8788;
	Thu, 24 Oct 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0DIYaCL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50C1C32EC;
	Thu, 24 Oct 2024 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761987; cv=none; b=lNtxDwMlb8VIY4gALUpCoLWNwVD+bwb0FBArB1nsNG54nJEO5tz46+Urp0EO0IbpcDLuYAE022rRtTXuq14gbq03qZuYPl4NQsWW070bOkS1xt8laGSDLFZj7bPP7GOxGZcx39R4LZ4zOZPN7+6BHWBSm46brE6zlwl4o9UH1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761987; c=relaxed/simple;
	bh=C3/JXOy6pyXEnet2ZU3cquvkOzRp30347+gzWGD6VE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Upaj1aZStH0c6CPGzcwmPc3/WzrPUgGD7t/vZGzEZNEh6utjuNkM3xyQgrJ1dNjqM3lfDvzASmUB5hHr5j1DKzM/S0Vcx1QbZfP7pNjarzN7Ic5RIeWqi/I4cV0KCtB5cXILkQLBhuG4BDMGMFSeJ5iijzFnhMkn/QarhBGysuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0DIYaCL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e625b00bcso515795b3a.3;
        Thu, 24 Oct 2024 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761984; x=1730366784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+VrIqKKYOtO3M0mpfjgZhM5oDURd/5X3mD5U8C7QOQ=;
        b=U0DIYaCLPFEhekvfMQzsiQZtKSRTp7om8lpbO+KBDWHbDnmqQtaENtajxd9RnyHLtH
         jr+jipUBz07AN0Scis3tTqyQoF/DAvTfVz7DVuC0pXqGlecXi1OrhN78/bvI74uuE1Dr
         Jz0ybHI1zgd/clVLhB373zx8wXQJ3oN24/GC81zChPB/DSV3Jfksjet2xQATaKCnow/e
         IijRYFLufNp7VUbcaTKn9O3mE9/UbgR/hNL8jeCz+QhVnXHno8EgOfpXMJtj+u/Pb9OH
         OzP9NxHDDqWMTVAfKzg74gRKgdcptUm3kXXC/S9bp4k793pnl7R0LNXeTRl13T5N0ig+
         E0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761984; x=1730366784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+VrIqKKYOtO3M0mpfjgZhM5oDURd/5X3mD5U8C7QOQ=;
        b=AH1oTj02raLoQhT5IjCsPfIsT2sdNneFmZZyeHB5EUYdX5VRG7vzMauM1OSVTmWZBx
         UFTHxKBfyngmrdJ3IUUJOTIDrLEgpXd2Pte3p1RS7uj+BeE4nzToCzDlJGmTqMv833sl
         HK1/LV+MY4+r4oQ4bJSg86obiJKARvB042CLLwCKWLsOP0ua21HNDHqgYjtAAYx27mE7
         vUF0gqE6S8wQTUYI4iusecCqAfSu+drEsg9V3LJGGyWM+tBZAbyfYam9jXbPe55Vnzgr
         ptIgIOK69vJG3KBd3YnSGQOPmxU29KJYhnNqGFqa1TW0Z4bOkPb9N4kwMnq3zGgTubtF
         tewA==
X-Forwarded-Encrypted: i=1; AJvYcCVanf3GRNxNAcdF6oEpShoTa5Y5xaibETIzSIQyBoyKfDmIIWwficEstm7GjDjTPFiGiHy2VPp/z6oquoY=@vger.kernel.org, AJvYcCXPwcb6nMDqMwuhxNHGyaDX8F+WoKBBQF5BRdbxq1RUSQ9m8nGeph+Xl/sEQv80l9Gvnqo//c8EmPMZ9OBd@vger.kernel.org, AJvYcCXbf9QNhoarZqdyO4jOc5+SVTP7VvF86bAxjoMOEuhPPWJD6wO+DdZnvirvAzxxJ2SMcJIbNeAlBke0gaVO@vger.kernel.org
X-Gm-Message-State: AOJu0YywRwbp3ZGwRy4oElEdTbvNDAqefaVga8Aug1kl0w+3KcSS7ovI
	cGcweovvZchx6ENNBz7QXU+7kJycaYgmC6XyllhjDRIBzRwZFhr0KXMKRQ==
X-Google-Smtp-Source: AGHT+IEAdfW6BQA61M8dhRfZrI4T8nteE8I7s4nNrFfOocP9QK13oGguSg5R20rcPru5VGaXIc2VRg==
X-Received: by 2002:a05:6a00:1390:b0:71e:6f4d:1fa4 with SMTP id d2e1a72fcca58-72030a4b659mr7850810b3a.10.1729761984387;
        Thu, 24 Oct 2024 02:26:24 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:23 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/12] nilfs2: remove nilfs_palloc_block_get_entry()
Date: Thu, 24 Oct 2024 18:25:41 +0900
Message-ID: <20241024092602.13395-8-konishi.ryusuke@gmail.com>
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

All calls to nilfs_palloc_block_get_entry() are now gone, so remove
it.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/alloc.c | 19 -------------------
 fs/nilfs2/alloc.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index 5e0a6bd3e015..ba3e1f591f36 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -390,25 +390,6 @@ size_t nilfs_palloc_entry_offset(const struct inode *inode, __u64 nr,
 		entry_index_in_block * NILFS_MDT(inode)->mi_entry_size;
 }
 
-/**
- * nilfs_palloc_block_get_entry - get kernel address of an entry
- * @inode: inode of metadata file using this allocator
- * @nr: serial number of the entry (e.g. inode number)
- * @bh: buffer head of the buffer storing the entry block
- * @kaddr: kernel address mapped for the page including the buffer
- */
-void *nilfs_palloc_block_get_entry(const struct inode *inode, __u64 nr,
-				   const struct buffer_head *bh, void *kaddr)
-{
-	unsigned long entry_offset, group_offset;
-
-	nilfs_palloc_group(inode, nr, &group_offset);
-	entry_offset = group_offset % NILFS_MDT(inode)->mi_entries_per_block;
-
-	return kaddr + bh_offset(bh) +
-		entry_offset * NILFS_MDT(inode)->mi_entry_size;
-}
-
 /**
  * nilfs_palloc_find_available_slot - find available slot in a group
  * @bitmap: bitmap of the group
diff --git a/fs/nilfs2/alloc.h b/fs/nilfs2/alloc.h
index af8f882619d4..3f115ab7e9a7 100644
--- a/fs/nilfs2/alloc.h
+++ b/fs/nilfs2/alloc.h
@@ -31,8 +31,6 @@ nilfs_palloc_entries_per_group(const struct inode *inode)
 int nilfs_palloc_init_blockgroup(struct inode *, unsigned int);
 int nilfs_palloc_get_entry_block(struct inode *, __u64, int,
 				 struct buffer_head **);
-void *nilfs_palloc_block_get_entry(const struct inode *, __u64,
-				   const struct buffer_head *, void *);
 size_t nilfs_palloc_entry_offset(const struct inode *inode, __u64 nr,
 				 const struct buffer_head *bh);
 
-- 
2.43.0


