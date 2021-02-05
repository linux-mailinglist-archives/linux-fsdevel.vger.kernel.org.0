Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC5310439
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 05:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhBEExl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 23:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhBEExK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 23:53:10 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2A2C06178B;
        Thu,  4 Feb 2021 20:52:30 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nm1so2971632pjb.3;
        Thu, 04 Feb 2021 20:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHifR/C9zDoSLyJTcENc9F1KqtFYijsidThFw2+rU3c=;
        b=Ht9MVlacEqRLzs3zfhbLdJsCNayPpskpZFT9qnCgcpVykJV4ZfPMjwN0J5MUF+cHTr
         lZa1THiwb1OBkRwtWw/h+l/vP2VAN5nurUF2sNkgcB6P/vQG7mPc86eYm5MIb6tARDww
         E4fcgW/cDt5D7U47YlseQGaReiVzG5qRSJqhIabs1g+W63FAp+JROxgVtXr+faILopIG
         DLJQa1kCEujg8tIH9gVGvghEPjshHX+pvUIvtWewPBu496novTFztdTgZ2ppmgsByh8y
         hIK6gWD0sKLAimhhT22Gq8+pQBrOnsCIih7wmrvfxc0ItvxYkr0uKoSePbYRa71v7t0W
         7gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHifR/C9zDoSLyJTcENc9F1KqtFYijsidThFw2+rU3c=;
        b=e1dOkki8CShD3IKLgZhscGpbcN8r2H6eAySAmnp1qgmmNS3jLBHGls7RVrN5JfLrbw
         CoR2JssOkbXWunMq7LU3VfTnop1SAcOETTuZQvWjCQpxNOI+U8VPJjKKKMsVjevRTgsQ
         t4rHcUyT5VhuPVy/kuWavrwEorzbDCWDK01+k4Vc+u6CJRsSC9zYsHaKxh/ERGQ2wv9E
         XXFls8uc8EavoS7PGZ8Glmk/yUMqp++mFqag5L5yLgGeSOEJ7KiSh4wShWFaoo7mQ88q
         0Eiw+XRQ/U1ATA8scQficjadRktSKPRhE49E0FcXwb4osdMY/L3B31VDBEOLrldNw5Hv
         BXDQ==
X-Gm-Message-State: AOAM531M26bcLabm2sH5yprMcSoZqLVyyN18yGO5n7MbeblNr7yqKUys
        s6ic7WhF66VmWicmiAdXfrjJsmAUVxVCLA==
X-Google-Smtp-Source: ABdhPJyqCp55xPbP7u+Z9qxgZpdnejBBHGgHbsXl/N99L6lxhLyMzuV6iIF5pD14bVFcvXqJML3o2Q==
X-Received: by 2002:a17:90a:1b66:: with SMTP id q93mr2368991pjq.133.1612500749837;
        Thu, 04 Feb 2021 20:52:29 -0800 (PST)
Received: from amypc-samantha.home ([47.145.126.51])
        by smtp.gmail.com with ESMTPSA id s1sm6972440pjg.17.2021.02.04.20.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 20:52:29 -0800 (PST)
From:   Amy Parker <enbyamy@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Amy Parker <enbyamy@gmail.com>
Subject: [PATCH 3/3] fs/efs: Fix line breakage for C keywords
Date:   Thu,  4 Feb 2021 20:52:17 -0800
Message-Id: <20210205045217.552927-4-enbyamy@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205045217.552927-1-enbyamy@gmail.com>
References: <20210205045217.552927-1-enbyamy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some statements - such as if statements - are not broken into their lines correctly. For example, some are expressed on a single line. Single line if statements are expressely prohibited by the style guide. This patch corrects these violations.

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
 fs/efs/inode.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 2cc55d514421..0099e6ad529a 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -193,7 +193,8 @@ efs_extent_check(efs_extent *ptr, efs_block_t block, struct efs_sb_info *sb) {
 
 	if ((block >= offset) && (block < offset+length)) {
 		return(sb->fs_start + start + block - offset);
-	} else {
+	}
+	else {
 		return 0;
 	}
 }
@@ -264,7 +265,8 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 			/* should never happen */
 			pr_err("couldn't find direct extent for indirect extent %d (block %u)\n",
 			       cur, block);
-			if (bh) brelse(bh);
+			if (bh)
+				brelse(bh);
 			return 0;
 		}
 		
@@ -276,7 +278,8 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 			(EFS_BLOCKSIZE / sizeof(efs_extent));
 
 		if (first || lastblock != iblock) {
-			if (bh) brelse(bh);
+			if (bh)
+				brelse(bh);
 
 			bh = sb_bread(inode->i_sb, iblock);
 			if (!bh) {
@@ -297,17 +300,20 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 		if (ext.cooked.ex_magic != 0) {
 			pr_err("extent %d has bad magic number in block %d\n",
 			       cur, iblock);
-			if (bh) brelse(bh);
+			if (bh)
+				brelse(bh);
 			return 0;
 		}
 
 		if ((result = efs_extent_check(&ext, block, sb))) {
-			if (bh) brelse(bh);
+			if (bh)
+				brelse(bh);
 			in->lastextent = cur;
 			return result;
 		}
 	}
-	if (bh) brelse(bh);
+	if (bh)
+		brelse(bh);
 	pr_err("%s() failed to map block %u (indir)\n", __func__, block);
 	return 0;
 }  
-- 
2.29.2

