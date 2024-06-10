Return-Path: <linux-fsdevel+bounces-21345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D39D902636
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 18:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF1F1F23023
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97B214535C;
	Mon, 10 Jun 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma0r11vv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41C6143736;
	Mon, 10 Jun 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035239; cv=none; b=bH8haLIKXebEKkdIb7iH621bmKkCdQ9YxJVa/M/pVkUeDEiVJCuQSJaUou3tnlqc4TusWPIV5rItk6sOL8hl++H44T2UX5bAKklUNJXPtQSGKgasUYs0QqakpRDO7Gcfm13jnkSFoIaLplvyUgUgbnrReLtCrToKcSbXaDYaLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035239; c=relaxed/simple;
	bh=Cqpixi5sxiPnJFGUUJpNAZk5PRn/VBKHKfOdrkdhZWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MvJfmbxOMPRgzUNYtZp0+1Q0PRHXFHAp/QIiKUYAu8eLYtNWA7kFZCCbJO01X/pefr2PzTf2xWK88l98pVEHKf/A95SakhtjgU6gk4cX6JQ+/4gsoLXMuUjamdCUjKchaDPCptlaAqxQ005izuYe2HXSlwHZNuNg3vnBqiGkQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma0r11vv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7041e39a5beso1958240b3a.3;
        Mon, 10 Jun 2024 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718035237; x=1718640037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTMYy1REZ05nqGyjoEgjo2hQqlx5VXGzyBXDQH2xccg=;
        b=Ma0r11vvM4IWu54oL8fAkXoGQuSN85uTcmXeSUg0VRmLH+uEhEaWAvk6gymbl2drMo
         GyqoZ+wCNigi0v2y4v/pNjkPlJjyoYF88YVb1Ezu6iV5yrcmptGyghoAs7KJ36/ijB+F
         7GnZQJi4wponwAcvM/ytTWoF8IwXfWl5GRjkX9ma1aEi9esoXUMdTLKlr+NwgppxnhT2
         KBwVbvte8aOIb2hWKn1GVTOGA/OEhJgx7rANLi7XZf93VrgISECeCcdvStkIQXiidfn4
         Dmowi6kAOGelBXrpUkD3KpAJuRx3YjVmNnLesueQwPHmTzLuYFEE3L5e4o4i3y2eS8oK
         bIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718035237; x=1718640037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTMYy1REZ05nqGyjoEgjo2hQqlx5VXGzyBXDQH2xccg=;
        b=mI8OaxucV1NrxP0VHO7Rmlv8kSRNkhD/G7ENHDE48HItj8SGWOuJMRluwBpPdcj1WA
         KFepSu+NLMHe7t1oXnI2Kve1slRBhH4KNPQBTtzm9LwZ/QSd8J51M9R2zN0YfPGs+9rh
         QzRiu7e1/D8xeAHbMS1jGzwdvooJTWRWEapk3O17OJFj5DSNEasmtwK5zDYCQa1IMjS0
         HGsf3Jf4JXgo7OMz9RhHxpmQtXs+/yfLsheyxCReOcwWXG8jc/yEW583/2uLvlY81vGQ
         17kJMlvKgTo4jpE/pXwaX2uD6wA/UcV0sL/x7tbNTVnHTGz2rgMv/cjcXwAMHYR261zT
         zfcA==
X-Forwarded-Encrypted: i=1; AJvYcCVHN+joKEtNG/hnz+8SpdRq0eSJRhrL1cat6hiOZJqJ7FWj6zv6u7h0uQDFKRGu6y3PwGGhqAZboO6nh8pO2gA9kr1QaO6R7NWz0k897f3pKUSHksZpM/vr9INp+6FSL9Yu1X17xgExHsav6w==
X-Gm-Message-State: AOJu0YzvRBZFlYTctFWxSbcPBFlLyhVkU0ySBMDhXB38snzz9jPA6kVs
	Zn3dVuZsU6SAsHYjwXKMeOUhf4y0thphFkas8q3Pr2e0Y8fnO5VvCWRGEw==
X-Google-Smtp-Source: AGHT+IEuvcNQPfGUOcIJtmuKfCRpaE/EKHFJ5NIkKVX1Rzy/Q5tNETGGddUYJYQHg8Zj6yylEO6J1g==
X-Received: by 2002:a05:6300:8088:b0:1b1:f19b:4df3 with SMTP id adf61e73a8af0-1b2f9caba1fmr9263685637.39.1718035236893;
        Mon, 10 Jun 2024 09:00:36 -0700 (PDT)
Received: from carrot.. (i223-217-185-141.s42.a014.ap.plala.or.jp. [223.217.185.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e4532507casm4872411a12.62.2024.06.10.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:00:36 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH -mm 1/2] nilfs2: prepare backing device folios for writing after adding checksums
Date: Tue, 11 Jun 2024 01:00:28 +0900
Message-Id: <20240610160029.7673-2-konishi.ryusuke@gmail.com>
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

In preparation for inode_attach_wb(), which is currently called when
attaching the log writer, to be done via mark_buffer_dirty(), change
the order of preparation for log writing.

Specifically, the function call that adds checksums to segment summary
and super root blocks, which correspond to the log header and trailer,
is made before starting writeback of folios containing those blocks.

The current steps are as follows:

1. Put the folios of segment summary blocks in writeback state.
2. Put the folios of data blocks, metadata file blocks, and btree node
   blocks (collectively called payload blocks) into writeback state.
3. Put the super root block folio in writeback state.
4. Add checksums.

Change these as follows:

1. Put the folios of payload blocks in writeback state.
2. Add checksums.
3. Put the folios of segment summary blocks in writeback state.
4. Put the super root block folio in writeback state.

In this order, the contents of segment summaries and super root block
that directly use buffer/folio of the backing device can be determined
including the addition of checksums, before preparing to write.

Step (1), which puts the payload block folios in writeback state, is
performed first because if there are memory-mapped data blocks, a valid
checksum can only be calculated after step (1).

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 85 +++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 6ea81f1d5094..a92609816bc9 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1639,41 +1639,30 @@ static void nilfs_begin_folio_io(struct folio *folio)
 	folio_unlock(folio);
 }
 
-static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
+/**
+ * nilfs_prepare_write_logs - prepare to write logs
+ * @logs: logs to prepare for writing
+ * @seed: checksum seed value
+ *
+ * nilfs_prepare_write_logs() adds checksums and prepares the block
+ * buffers/folios for writing logs.  In order to stabilize folios of
+ * memory-mapped file blocks by putting them in writeback state before
+ * calculating the checksums, first prepare to write payload blocks other
+ * than segment summary and super root blocks in which the checksums will
+ * be embedded.
+ */
+static void nilfs_prepare_write_logs(struct list_head *logs, u32 seed)
 {
 	struct nilfs_segment_buffer *segbuf;
 	struct folio *bd_folio = NULL, *fs_folio = NULL;
+	struct buffer_head *bh;
 
-	list_for_each_entry(segbuf, &sci->sc_segbufs, sb_list) {
-		struct buffer_head *bh;
-
-		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
-				    b_assoc_buffers) {
-			if (bh->b_folio != bd_folio) {
-				if (bd_folio) {
-					folio_lock(bd_folio);
-					folio_wait_writeback(bd_folio);
-					folio_clear_dirty_for_io(bd_folio);
-					folio_start_writeback(bd_folio);
-					folio_unlock(bd_folio);
-				}
-				bd_folio = bh->b_folio;
-			}
-		}
-
+	/* Prepare to write payload blocks */
+	list_for_each_entry(segbuf, logs, sb_list) {
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			if (bh == segbuf->sb_super_root) {
-				if (bh->b_folio != bd_folio) {
-					folio_lock(bd_folio);
-					folio_wait_writeback(bd_folio);
-					folio_clear_dirty_for_io(bd_folio);
-					folio_start_writeback(bd_folio);
-					folio_unlock(bd_folio);
-					bd_folio = bh->b_folio;
-				}
+			if (bh == segbuf->sb_super_root)
 				break;
-			}
 			set_buffer_async_write(bh);
 			if (bh->b_folio != fs_folio) {
 				nilfs_begin_folio_io(fs_folio);
@@ -1681,6 +1670,40 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			}
 		}
 	}
+	nilfs_begin_folio_io(fs_folio);
+
+	nilfs_add_checksums_on_logs(logs, seed);
+
+	/* Prepare to write segment summary blocks */
+	list_for_each_entry(segbuf, logs, sb_list) {
+		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
+				    b_assoc_buffers) {
+			if (bh->b_folio == bd_folio)
+				continue;
+			if (bd_folio) {
+				folio_lock(bd_folio);
+				folio_wait_writeback(bd_folio);
+				folio_clear_dirty_for_io(bd_folio);
+				folio_start_writeback(bd_folio);
+				folio_unlock(bd_folio);
+			}
+			bd_folio = bh->b_folio;
+		}
+	}
+
+	/* Prepare to write super root block */
+	bh = NILFS_LAST_SEGBUF(logs)->sb_super_root;
+	if (bh) {
+		if (bh->b_folio != bd_folio) {
+			folio_lock(bd_folio);
+			folio_wait_writeback(bd_folio);
+			folio_clear_dirty_for_io(bd_folio);
+			folio_start_writeback(bd_folio);
+			folio_unlock(bd_folio);
+			bd_folio = bh->b_folio;
+		}
+	}
+
 	if (bd_folio) {
 		folio_lock(bd_folio);
 		folio_wait_writeback(bd_folio);
@@ -1688,7 +1711,6 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 		folio_start_writeback(bd_folio);
 		folio_unlock(bd_folio);
 	}
-	nilfs_begin_folio_io(fs_folio);
 }
 
 static int nilfs_segctor_write(struct nilfs_sc_info *sci,
@@ -2070,10 +2092,7 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 		nilfs_segctor_update_segusage(sci, nilfs->ns_sufile);
 
 		/* Write partial segments */
-		nilfs_segctor_prepare_write(sci);
-
-		nilfs_add_checksums_on_logs(&sci->sc_segbufs,
-					    nilfs->ns_crc_seed);
+		nilfs_prepare_write_logs(&sci->sc_segbufs, nilfs->ns_crc_seed);
 
 		err = nilfs_segctor_write(sci, nilfs);
 		if (unlikely(err))
-- 
2.34.1


