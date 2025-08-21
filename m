Return-Path: <linux-fsdevel+bounces-58641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A16B3062A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13886AE2FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233A371E88;
	Thu, 21 Aug 2025 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FdjFDnSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747EA370583
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807625; cv=none; b=daR3vB0QXz7GmF33INI2JWYb1888Enwpm1BKCPJo1NI8t529Jgv36rt5Omuw4/PbOetcqRhKXYaXAf3IJ1CyK7fMFwWIVs0Hqpe9EZAcIvfzFBNSd/ZnjX29OR5bcW8FqjQeqy4eIYem2ODWisJEn490ngeKYdZtX3Rzy/qOV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807625; c=relaxed/simple;
	bh=D93quPOEYKV3ecF80PgDZ/SBCUn+YEd3pA6H3kfuds8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxmg7q77Ce9JfroQjwGysDQyndvkIAxc9pz8UIfIFFa19tCVwLQT1IfrIhl6xdZzPHboTolB65bvYTA9WG7GRZ4zJj9mTYD+aalyzJJWmvHjkt2nBwyuY32MR516gJACDg7UBN5CUm/ZAlLrexeuczugC2TjnNYUDnph9B8schY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FdjFDnSf; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d71bcac45so12457737b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807622; x=1756412422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAA7yBTxTE6ptsf2bLIbVrVMiD/7hA8aK0cz9PGFZKo=;
        b=FdjFDnSfQSraijqQk4sRFY1Q/f7Na957iwTOMAMkV1vDWbUvnYX2c9jm+Yecn59Xq8
         e9Q4yUlnAJCLAhN5PJYMxOnLHYJSjOzF6j2uUDUE6kQ8mcd3s8H4BNXU2hZ4WitqIVuj
         qixhh10usq3B5ANJPaoMcOzpggFR8xj2FL6aSdI01WzbzpNowVYIAOBUW1AyVDoN5jQq
         nDkwe7pbw7Za7iaoc9ZYC7eFA8PhSSeBu7zM2bPx6XcIUPaN43cnMIPUDi9C7lA1tNQj
         aK0FRgEzqRhXrZDu+xMw1XYe/+LwFIHw38nuBKNmlvSOLLFhviwZKra/h3h6JGnrwkYt
         tHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807622; x=1756412422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAA7yBTxTE6ptsf2bLIbVrVMiD/7hA8aK0cz9PGFZKo=;
        b=ihcu7FR5p/tUNDrzOI3b6p3W1azL7r+R4ETBkGnXHrBAhHHUTGhFnrzZQdiA/r4kKg
         qHOQQDIPlaOhFkayKp/BLIvADy8Ab4nfz5qaRd/Wuir0aFhAJC9H3Bg3XMhYbzvohk3p
         TdlaI2F5/EYequMJrP/zAM5ge58UjxF2GnCC7PMVReh+H191nsj7ExgZmSWGVZ+4xxrG
         JuzFEst7JK98u09hVD8+HNrJacmP/Z8lYdtBgC3k4H45Y9lKLyhCUUNZI0qVYCI8vMsa
         XE3JszRxS9iEKUrB6vewSItEaulRRT0I6qUEGedcJyA6CyegUjS/DMYToBp21RViWbaQ
         rGVg==
X-Gm-Message-State: AOJu0Yzq1xBNWA/j0FGzu3Wnar/zqvBy9u8qbmpru86KkPFcLNgiPW2V
	Z3bLgjjjypTVd/SI9OAbSUAttHIwGrR36unM8mD8wkw3kis/NJ0rtpdTGV2HN3uiUsVlpVeV5FL
	jtY8Jd93rzw==
X-Gm-Gg: ASbGncuyqA3lWt512PhvGIyQXRHkIOGbcKMahreaJkkpVUCbGrrEuoZz0umLclTgB4g
	cynOlBTeh97LoNWOl1rqH+iiho66xM3iCXf9lQYPONwIAwD9WkWzlhlFuVNbcfy+bYQQwNvn7GQ
	eQAoeIm0EWmEl4bNByOqmQnTuqnSshLGE2VxUWdTcatkcRT3Q6rKPXP61hqtKmhjRNwaX/vDoOf
	xQbef8lnJiX3zVX4qE2rycvvkGpdjIxQEwusg2uCwhboyO5WLv/P2Ds/YiSS5GjItGo9zIuDst6
	cdjwczfN1PmKLqeQZNQT4qt1oFVmjagENymUQYVbTT5wxE1puMXetzhQ2YRNoslCBI5fCBYWTz4
	4N/m4wIBfT1+ybVA1gpzaaXeMi6Dgmlsg3SR2zp+l0n6t3fuNK/oZVNSawBBa/Vj/jgPhfpwRZh
	JvreM/
X-Google-Smtp-Source: AGHT+IGv4NhJf1cT6NIbqZa/4R9/wEW3Dk34Z/qOn5/BwvXw6MJR1AIUtLA2xvcvi2nVywQSjYDnPA==
X-Received: by 2002:a05:690c:4b89:b0:719:5664:87fd with SMTP id 00721157ae682-71fdc40e0aamr6490137b3.37.1755807621709;
        Thu, 21 Aug 2025 13:20:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6de96c79sm46567797b3.11.2025.08.21.13.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 04/50] fs: hold an i_obj_count reference for the i_wb_list
Date: Thu, 21 Aug 2025 16:18:15 -0400
Message-ID: <39379ac2620e98987f185dcf3a20f7b273d7ca33.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
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
index 001773e6e95c..c2437e3d320a 100644
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
@@ -1346,15 +1347,26 @@ void sb_clear_inode_writeback(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	unsigned long flags;
+	bool drop = false;
 
 	if (!list_empty(&inode->i_wb_list)) {
 		spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
 		if (!list_empty(&inode->i_wb_list)) {
+			drop = true;
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
+	if (drop)
+		iobj_put(inode);
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


