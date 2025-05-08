Return-Path: <linux-fsdevel+bounces-48519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB6CAB04F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348BB1B6747C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03F2206B5;
	Thu,  8 May 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxNTbikh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36934B1E72;
	Thu,  8 May 2025 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737474; cv=none; b=MV54grgnxvRVrtVi75mQf3Iplq5U9vsXbqWekMA6dVD1O8THhTo2Jjy6VfOUIIhzLjpKN6kZ4peSWAFBhr/YYfRVc9wk8gt8RAI1X9hLPZ0WP/9Vzs89HyJvZnlPcaU2z7RSaNO/vBChlBaKGnO/uNkCCBckleQkxpbYJa+zh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737474; c=relaxed/simple;
	bh=36aU90ah69FoQRTCIf1AH3HurENJ5MK7WWuPtIJtwww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtSS7LyhbOAd4u2GoWWK5I6xqZLm30vbUDW70MwacHWI/Q+M50gLeviHM0phyPJ87lbzb5DmzzNNlwGRZTjs7xrLWuNB0PjNv9cSF7ITMynMCPhCmhk4aGaJFxFB+CR6Fol/+3FwsGRmws/g1Gfa0b9I2xLDyUB8AFFDenTeDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxNTbikh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736a72220edso1578956b3a.3;
        Thu, 08 May 2025 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746737471; x=1747342271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHY4cFo3Ah0ejQSQVGb5q8351JcuHDwk4qDK3qK7o4s=;
        b=LxNTbikhBKgAM3DmaW3gBbvDj5pL027tWP0BFaOz9x1B+//mMkTRJTIDnJPTrq/ijS
         4/1AnisX6VZHadsZHT3AjuaiudlbhxGzSm/WJxx67W2IbC6hQaSlPwHGERnQ0X6L31vH
         1BV0hAWnrzGHshwcjASSX9DOfIzM+FsCkW1w4tw7FYnouhnh0SWh0EZpdnKRxNQpVOE5
         98Tzy0+K4v9DjEXtQD7udX+UuVIsNL3pN1Dn2G1LfMwIIlAhJgEnoDXHFT+DJKDn5Vmt
         BXKrh9AyejPxAl8+XsqXvLHPjDVHSqd2lVnfoDX9H8c1pWcuit8mt8+1qDcFF/7B39FB
         B+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746737471; x=1747342271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHY4cFo3Ah0ejQSQVGb5q8351JcuHDwk4qDK3qK7o4s=;
        b=U7SUvr6hpnrVBDChbsoqVeaOwq2I8sDDoB+8m6rfzgaqVvaFULb/fOk0WCINnuwRlC
         FvVZbGpDKSgw+V/c8szILsWtXY82weHpvKhOJjt2MONcxGISxStkFtbWBLYGxp/56Fr5
         81Q+IgLHQljmlxlkyPYhJHg6motWrBXZLxrruN7YFmp3Z/g+I7/Jg06L7664DPk/Y5wh
         pM8M74rHKGHDsscNgsGL4MLsGyZu2mdF76ImILAf5n7c6tVgknNr6v5poQEY9c3UGFiY
         2YNjqe4vfT8086/n1uTImGMtSEXeazoZUtXiWaYAs8nHxfNyzcmlwZUmkb8guGdQt9wq
         0PBw==
X-Forwarded-Encrypted: i=1; AJvYcCVfc9DBjebXYT4qWou50kBhfm0K/1NzWjPIUbZurR2LS/73fvwrZf7poUFlvXxqJVvZXCbykY0lCyEY9zm3@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBui9gKZvNzvEZEs6MbMZVqxUVc54Rt8A4dK5LPP7t+N09I2A
	0K7Wo4VhFBs6jQ0Yrsxkssuyhl1f0AInUSPJIiZVp6QYxIms4tFGOeo3fg==
X-Gm-Gg: ASbGnctog/B8QBjtJ1dqY5nQlhBfUH8yZJYaUBZ2/oxwBkF4BIMe6Gbsrt+x17eu5nL
	5V76V+DNyGyUGeeDxzImjy0xwnSK96+W5uEERhk1WBqJ2fUBYOINNUjDPqxWwAHWNxokKpTJ2S+
	3mssxaTCoFPVFgIKOdYH43SF+9iei7fp1bE6EKNGWiB07x4DF/HBTc6iJPJrWZO2eMNHTQuYZMN
	YYEeOfSJNBtWd9MCPeh59oQF0ta2IZ4rSHqTGQsMZqPpu2Vzg5Ouh5jGG/Jv/YyOkm5h6iciyg0
	iT92z8+v2PNk77dBgrSL3cbmZMm4Hu4SQWfk6OBS7QyzzJg=
X-Google-Smtp-Source: AGHT+IEy+yJsTPhGDTeRc/uxp8gIyeSZGuX6Uq3ffJTjSwL+L304dG7nxtSnw/Bnmb1XZNu2qmsuug==
X-Received: by 2002:a05:6a00:4148:b0:740:921a:3cb4 with SMTP id d2e1a72fcca58-7423bd57d80mr1172653b3a.13.1746737471458;
        Thu, 08 May 2025 13:51:11 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a97de2sm463763b3a.175.2025.05.08.13.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:51:10 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 3/7] ext4: Make ext4_meta_trans_blocks() non-static for later use
Date: Fri,  9 May 2025 02:20:33 +0530
Message-ID: <53dd687535024df91147d1c30124330d1a5c985c.1746734745.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746734745.git.ritesh.list@gmail.com>
References: <cover.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's make ext4_meta_trans_blocks() non-static for use in later
functions during ->end_io conversion for atomic writes.
We will need this function to estimate journal credits for a special
case. Instead of adding another wrapper around it, let's make this
non-static.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h  | 2 ++
 fs/ext4/inode.c | 6 +-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c0240f6f6491..e2b36a3c1b0f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3039,6 +3039,8 @@ extern void ext4_set_aops(struct inode *inode);
 extern int ext4_writepage_trans_blocks(struct inode *);
 extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
+extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
+				  int pextents);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t lend);
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b10e5cd5bb5c..2f99b087a5d8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -142,9 +142,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 						   new_size);
 }
 
-static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
-				  int pextents);
-
 /*
  * Test whether an inode is a fast symlink.
  * A fast symlink has its symlink data stored in ext4_inode_info->i_data.
@@ -5777,8 +5774,7 @@ static int ext4_index_trans_blocks(struct inode *inode, int lblocks,
  *
  * Also account for superblock, inode, quota and xattr blocks
  */
-static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
-				  int pextents)
+int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
 {
 	ext4_group_t groups, ngroups = ext4_get_groups_count(inode->i_sb);
 	int gdpblocks;
-- 
2.49.0


