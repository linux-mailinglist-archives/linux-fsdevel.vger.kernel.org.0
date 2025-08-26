Return-Path: <linux-fsdevel+bounces-59239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 771E6B36E1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2F27C665B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FABE2D23A6;
	Tue, 26 Aug 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="O7oFfK1P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A4279357
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222860; cv=none; b=k7/c1P8NC/EDHAQRCDNGd9rBgNmObQZZZ096gdyJMmhBnDvkBTRBMoJje3UTHpv6V+Q0NQUCOOLQpX50Qh/Nle91NwzGNurhxF7x4tYTD27ZzwuzyANf7ctRQmt5GH2es6ePQNxcaDPbAj13M3Ae6SItNDTqCrZPrwPMoNoHbTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222860; c=relaxed/simple;
	bh=3eV0qbbQBj1MUi/XR5O70JAOPoK+SfAUiI8+4Y3kFfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMLVHf7SZ9Q1qbowYxTt6w0JprdTkadLg7QWykjtUE8GZXJYCd+5PhwuwQeGMy6pCe52+x0V+rCdUT3ByvKtehQkSzyEJaeGxRO/ZCMC1nZJC9a/sTAI7yzSzpEfpbKpTDGElrcxVrwFgGZsDoGQlYg4kKZrW8XrtyGdwiz2koY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=O7oFfK1P; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e96dd4bd847so774895276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222857; x=1756827657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TIN+NpxPBD59M3BXgkQWvxyL3wlhhluVN4EhWLiaxc=;
        b=O7oFfK1P6D64tt8FdyMds2+0BEvclyyxjHQl4ffde1OjX1ElQifzITOPFnUhSohZ/4
         p6tWk+BKKx49/j9xHAikRt97S2C7b0d7ONxTkqlMFCVK7vn/bKoo77E2F4nB1pEqDVV6
         5627Tpgy4HICnriAiuEX7HD/JJgn4L+qwSnynlAWDbudM2SqfK3mjvYGoVX182uhzAge
         Af4nMFXBoXI4z4KVrntJ9a27+xLsDsWPMWyGf2e4+MHRAZwzoe20JiZW5l5m/OVx1ZH9
         KsGLq7svw3KhXvyRiXLpeqdtZR86BXzT0g8RKV5junCeBMrkjgz0/KK4nQYY0tu0rgpp
         4/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222857; x=1756827657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TIN+NpxPBD59M3BXgkQWvxyL3wlhhluVN4EhWLiaxc=;
        b=VVtYUABr0tPeXYS9GFAjGT0g5a/4WN3sx/bWoxcj6xhshd1PqkH7yBILyLLZDeutLe
         fywC+Gw62r7YmzJvSGZiQSGV+xpw3Nhv/tgyTKdKbN81QfPUBIvXu+z1nbHorthV94Bq
         wFzmujk/0tLQ20ymjJNvD2lxRleFVSIMlk4MiJMqUS7T8DYOJ9anbqgj+CxBYbzHJXPN
         5nLdIRONCFM738ZLHvqcctzZX4U2de51DKB7Iay417ZthxmdEz/+ISx+5wFQS8+DKaIS
         h5NnW9AWerD/l7yEZKWiU9SHwsPuksjvwwrpiITnGVzFVeye3MWhUuLaR+RLQLrx2+Vj
         GqpQ==
X-Gm-Message-State: AOJu0Ywl8Xv5kE8S76kfuKZb0sMO65tso9+8czhZQ5r5Oj+rOSryWccy
	6hb3MUoRgOy5O+Vbxe+fjB4IeWeHKYxwGb8vRnL2rgb5nCJeRi2hqSOCUcyzHK3s9FBG3VMN+LW
	gCQi7
X-Gm-Gg: ASbGncvnpt4GkQp1xyT2Q7zIGNu86/1jk1yTXF+EKevT+GR+i0W13Eo7zI3+ttG4jaD
	wMadLlAssfrmUuprt9SzdaMRzjDg1JX7p1J12qGGptqW+HDb5hG2ri3yhUGlOzwWD/VM92CRTKj
	8WgKn8z1fxpak8VNCvtLlBlnL3s13XvIyQh2n1iEYaUAuiOlg/62S4tBBm+iP/6V64AHyOdcvQC
	MrTzA+qgNM4GPmldmmjcQw1Dgyo+LNheIVPpLp2gtAGWYTC24x6oSHi75Zwb+m6gP0qWLrOjVkB
	9ZioXJLWG1TQXiHSMm7299ow6NraQ8YET9CJ/xEFwP39EOD0GD61JHpUgHAnBwKdrp3Dly6FaF0
	clQl1bLqc+R0N1u5QS3cu0HurP9gffadOJT9HxwhgE37l4pNCWTH5VUm0xec=
X-Google-Smtp-Source: AGHT+IGjVsfarYu+snEUeNFin3tD/xnE4eG8D6mg1L3D/GhHe+mc76Bk21c4LHeD44Ug/c5MM06NyA==
X-Received: by 2002:a05:6902:33c5:b0:e93:43f9:5545 with SMTP id 3f1490d57ef6-e951c3c5a15mr17865473276.37.1756222857186;
        Tue, 26 Aug 2025 08:40:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96dbdb8453sm849823276.20.2025.08.26.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 06/54] fs: hold an i_obj_count reference for the i_wb_list
Date: Tue, 26 Aug 2025 11:39:06 -0400
Message-ID: <0794a0dbb7885bc905320868297a5c3666fffc5c.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're holding the inode on one of the writeback lists we need to have
a reference on that inode. Grab a reference when we add i_wb_list to
something, drop it when it's removed.

This is potentially dangerous, because we remove the inode from the
i_wb_list potentially under IRQ via folio_end_writeback(). This will be
mitigated by making sure all writeback is completed on the final iput,
before the final iobj_put, preventing a potential free under IRQ.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index acb229c194ac..cb5e22169808 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1332,6 +1332,7 @@ void sb_mark_inode_writeback(struct inode *inode)
 	if (list_empty(&inode->i_wb_list)) {
 		spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
 		if (list_empty(&inode->i_wb_list)) {
+			iobj_get(inode);
 			list_add_tail(&inode->i_wb_list, &sb->s_inodes_wb);
 			trace_sb_mark_inode_writeback(inode);
 		}
@@ -1345,16 +1346,27 @@ void sb_mark_inode_writeback(struct inode *inode)
 void sb_clear_inode_writeback(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
+	struct inode *drop = NULL;
 	unsigned long flags;
 
 	if (!list_empty(&inode->i_wb_list)) {
 		spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
 		if (!list_empty(&inode->i_wb_list)) {
+			drop = inode;
 			list_del_init(&inode->i_wb_list);
 			trace_sb_clear_inode_writeback(inode);
 		}
 		spin_unlock_irqrestore(&sb->s_inode_wblist_lock, flags);
 	}
+
+	/*
+	 * This can be called in IRQ context when we're clearing writeback on
+	 * the folio. This should not be the last iobj_put() on the inode, we
+	 * run all of the writeback before we free the inode in order to avoid
+	 * this possibility.
+	 */
+	VFS_WARN_ON_ONCE(drop && iobj_count_read(drop) < 2);
+	iobj_put(drop);
 }
 
 /*
@@ -2683,6 +2695,8 @@ static void wait_sb_inodes(struct super_block *sb)
 		 * to preserve consistency between i_wb_list and the mapping
 		 * writeback tag. Writeback completion is responsible to remove
 		 * the inode from either list once the writeback tag is cleared.
+		 * At that point the i_obj_count reference will be dropped for
+		 * the i_wb_list reference.
 		 */
 		list_move_tail(&inode->i_wb_list, &sb->s_inodes_wb);
 
-- 
2.49.0


