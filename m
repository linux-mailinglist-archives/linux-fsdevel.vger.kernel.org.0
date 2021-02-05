Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0E931046B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 06:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhBEFPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 00:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhBEFPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:15:20 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE5C06178B;
        Thu,  4 Feb 2021 21:14:39 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c132so3732666pga.3;
        Thu, 04 Feb 2021 21:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Vega6QbYsSC2nlH6ET1v8PT9QhDice7/UaejuUUhWQ=;
        b=qQlm+FJGPOKFZqqmMPEsA6Kk1OyMdHw4asPzzAUKOtHl1j/SJt0eBw0mXEqOMZW7f2
         xWJn4OHT6WjO+QTqDIb+fLD2Bxh7SAFB4SdTTgA9myz9kto1Yvx60JlRPNh5aOCSaSDw
         bcJ6pw0dg2RfZfX4ZHIjxdibbiWvCuQKW506XAHa/YIqU+peBjedlI9gCmTsyK8fSkn9
         QwVhtgH7ESrm0aDHRGK6VrkW7UeH3kyTTfmn8BW71KGRT6YAWWgPsRpziT2byTO/O0KC
         8B3wsQF/zdZsKsgERT4VXAzMUkKFkGOf0DvqVRf0Z13oUBydXdQc/liFpt0jBErLYMe7
         G4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Vega6QbYsSC2nlH6ET1v8PT9QhDice7/UaejuUUhWQ=;
        b=ixjKanwx/bdJyaYQcJV9uQbjnY0Bxi3YCjcjuhGRIRPqGP/mCBUHTha6+CEk8wnlB7
         syIbYREtB2P3M+Fz7hMnucWcVEvNE5tIqzJjimZlUwiBEefLCjmcf/XYMYVB3Y51E2Sr
         IOohWBjPXSaown9zfalWMa5TC7qHQQ7xalh+hu2DwRQKkCBSicFpr8gYFMvMdp0+2aFt
         0aTwUXgXsUyiFVOGyWglbIeBn6G1VM3kY3xglvkzurbuUESxHR4mxL4L02R4YGKkZ9wm
         61uHFbJPQ5IV7WJKSValpBLhhngXrnd2pEl/3qT3/ML6xuoGuVCA0Z4wfeYRt9OpWJzq
         Z7Sw==
X-Gm-Message-State: AOAM530aU2GXdDrp5aEmH4R+opOWR2GoKRF/aJ4TFdHB9rBt/TEy/aaQ
        ZDzPWVHjynDH2VR6dviuFtk0e/zDX9pEHg==
X-Google-Smtp-Source: ABdhPJwv/tsOK9jRedUFELlh01PTCZ8MoVbfl3kvQOa3EXYZGZrYP4G9Kalw8rRM/AD9Vx9BYVGBtw==
X-Received: by 2002:a63:1201:: with SMTP id h1mr2655884pgl.296.1612502079442;
        Thu, 04 Feb 2021 21:14:39 -0800 (PST)
Received: from amypc-samantha.home ([47.145.126.51])
        by smtp.gmail.com with ESMTPSA id v126sm5905000pfv.163.2021.02.04.21.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 21:14:38 -0800 (PST)
From:   Amy Parker <enbyamy@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Amy Parker <enbyamy@gmail.com>
Subject: [PATCH v2 3/3] fs/efs: Fix line breakage for C keywords
Date:   Thu,  4 Feb 2021 21:14:29 -0800
Message-Id: <20210205051429.553657-4-enbyamy@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205051429.553657-1-enbyamy@gmail.com>
References: <20210205051429.553657-1-enbyamy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some statements - such as if statements - are not broken into their 
lines correctly. For example, some are expressed on a single line. 
Single line if statements are expressely prohibited by the style guide. 
This patch corrects these violations.

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

