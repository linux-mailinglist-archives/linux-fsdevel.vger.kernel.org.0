Return-Path: <linux-fsdevel+bounces-49183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D6DAB9028
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD374A6E09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C8E22A7F8;
	Thu, 15 May 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrfQp7QR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81A2980AB;
	Thu, 15 May 2025 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338682; cv=none; b=hmux6KCgvO5qp9IHmFl+FqIMTQN8JtpVTPyT3RB0ndu4JMEgwE1oWZS+g3F2JBlvellkUUsWM4S2GbyRvrG7NRsaS/qo/HkrOIliHpDmsYs2cSeDcX2M4vtJjg7LMHJcq7upYOtRijHEE04V4KIwxk+aIk4nF8WJ23vVE0wUPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338682; c=relaxed/simple;
	bh=qy5Lsv+8bg5XtirxFaxWUek6uWiiKPkj1UI/BETJAG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqAogLTaoRL2oXIPHbsU+B39bRgYBqTzaOHmQLVf8K4xpspRqAyLcLe7SqU3xuHsn9Ic3R56S8CoAZI1DKqrF9FJtCGywPPYr957IUU/ad2Lg2n4N/LGM7qtznkCfJz4tz2l1z0/bHzgRKCoPhZese8xKobazojPVGwB3BvKmVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrfQp7QR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so1137938a12.3;
        Thu, 15 May 2025 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747338679; x=1747943479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzSbbiFQm2kwqOByIvSZFOSSFh0n0db4UJIuluy1TUs=;
        b=ZrfQp7QRfwBZo2tZAieeIlNbFy01kOWftDZ1VYpTHqm+sCPLBLc56ywv1FI4ALhOe2
         ShLJZkwZKiu2w0JCFL7Z+nGMoUee8+E86dRHVMx3HvuQzS6rZ+uXE6uwnM/DJ3bL3MuO
         5+17s4JN3bfUVgK2Picav3NZmsb0g7E6FKQ87WM6o8b3vTmwVrJ9kq4elYfZhojUrHA2
         RH+MAFXgkPHsKDgXTOjINAT7cW2I8hgSuG9gWzcSuMWcANS7CgUV/uG7Vcuetb7KGRN0
         6yJOfX3xyHI/coaNY+EZU5MifQubNcXF0zG/BpVI3IyrxlIGN3XR602p5V8InAeh/CAM
         MmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747338679; x=1747943479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzSbbiFQm2kwqOByIvSZFOSSFh0n0db4UJIuluy1TUs=;
        b=idrKQV7QohI9zCfkiBxj8ibbtNGbOZ4R14iaffrqmS/BbULT2iVo7QcK7vJngjw/Rc
         c+nHurZ5aFIFbwkt4kGlOHfdYvHQ5JtgKLhRol7tI3LWENxdw5Zq2t/2pxfawmqlA7WC
         YiZfMqZFU3Aqr1mNFief4jYcYxSLEMU1FheP09UaPXwFjWC1yP/0NJVY60uS6LO/dv4Z
         G0k2gaql3YoXJa2hijXCJ9gAJL6KbayK0fyEkjeqGgdgVAdsz+Wym9SxKYHGwsiNMTPD
         41z28nGUoUky3a+T30gkUWUG23xC49T6XX/4I1IlWa8enEtfgJPksN0g1Gv97sXibkMe
         pSAg==
X-Forwarded-Encrypted: i=1; AJvYcCWeBzsdhPQlSFTwW//vkM29B7W6ikADOtOyvOG6L7aWuLxwU6Jncwy1zr3kLuGmG1nUocWC46x+CRSpxQbB@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgpsDrqeR97zSN/9vtiQTPW2LnDQ2/+Qnn2ac7cQBcm293WEz
	tfFMM2vkqUWFBwu8slSU6pmeXo55Pd85Bu/KW8dKMgq0Z1uxnmUEAn+/L48nKA==
X-Gm-Gg: ASbGncsXt/uxPsNiJW5v/lEtx0ZDU1fdOXwaOpGtGvfJ+W+mcLKM9dgcmbSpIW854CD
	KuYsJDp3gxPWWlAxglVpFWWlEuYNqO2LDlf6yD15VQOgFavA4s5f0jPypte7C1HFp1InYVi0ugz
	eTgoDPt7IhDdkbNHE41SltTQigE3UylLQwSSXGr0Mnu+8FfU5pfZnLUovPGVgO/4crL8hMTEDib
	Em//9lX9GmPV0HEVJpfKqrzCANrInvn5sOrpru2rSHSYaSH4Kl7PnjTRHyNvjf70sUbhkJqUEdL
	kS3yy0BlVVBCwtYwX7AnBGKcIQEyfoQFkHx1/PBUTng7sb0=
X-Google-Smtp-Source: AGHT+IFUuMP60hc91CvjuHJ0p/R35gwyB9AHB33vUx8Z6cbdsfPl1TEa79o0tPJ+P9fgi2EeQPavhQ==
X-Received: by 2002:a17:903:187:b0:226:30f6:1639 with SMTP id d9443c01a7336-231d45e637dmr7875635ad.51.1747338678814;
        Thu, 15 May 2025 12:51:18 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm280463a12.72.2025.05.15.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:51:18 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 3/7] ext4: Make ext4_meta_trans_blocks() non-static for later use
Date: Fri, 16 May 2025 01:20:51 +0530
Message-ID: <23ce80d4286f792831ce99d13558182ee228fedb.1747337952.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747337952.git.ritesh.list@gmail.com>
References: <cover.1747337952.git.ritesh.list@gmail.com>
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

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
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


