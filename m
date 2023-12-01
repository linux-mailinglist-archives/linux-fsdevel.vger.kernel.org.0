Return-Path: <linux-fsdevel+bounces-4642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184348016A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494661C2032E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC81619D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ag69eQnt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3025D63
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:23 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d3d5b10197so17596307b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468743; x=1702073543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmF4uxZfMCODtKSUU/38ctU//N0K7aMAz+DrB4iNNOA=;
        b=ag69eQntN44PZaWezmodh8ZzZ2g1dGLZ4NcLMKNuNK6svISJ9ERWV5nx9iw0H5s5JB
         xUwiR686a8S4/1g2TiLzH3Uw1/+3dZN50mE+WlWtaTnMO60WmtHGv5oJlPua/VqGK3Fi
         YVjPBUwIH9oUBQFVec/sUDBOuywefnWI8coR9ngjG+/6TkWNqjQINqAWKG2MA4CkBxdt
         Lb56KoVuY+sQGtgrmFB3msgBkiUbrKno8DVrYPrZ6qFPby6vfCftx93AOqqUTUSuKBwR
         xlpUpO+qZq5PM9Y6doHOsoBPpNbd+C4LT+GmUSSBgmLSqWgJI4CAT4gLDAN0rZYokU1y
         2d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468743; x=1702073543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmF4uxZfMCODtKSUU/38ctU//N0K7aMAz+DrB4iNNOA=;
        b=qmoGdiTQek5Ysra+o96k0hxjOUzACHpk//KHuMvWMZhJ3ZP77NRrSQ9sjbDSy5dCrq
         mfsig3ysm5edxYljMI0kc0drH6kRiVrPJJkUsnB506CD6iD17vwBNY8Wsu6HBpzxeUUY
         rDo34b+IrAZvtCYKe3ujYpyd1JU17Yc03mZ/iI7W0nzIjbX5vMty+QC/t4Btjr/urXv1
         W81qsRPNrPegdLkVBO2p3wHdynWzXCbUgi3jpE5D1egjtZliQU5AL+stl+Drh2AbWxxF
         7lC/Qty5IEJ1xUv3+G7S54wKHw4QkPlf4rDCk94NWG4pgHxai6ZKt50jJp1xNGG5XA32
         d2zw==
X-Gm-Message-State: AOJu0YxxWBQvqnlV/Mzt/u01pTh2sDJQBZEzvNWwUdSIESX+j0FplwWY
	rNzhNabF9sxrpxveat7SCXyJVA==
X-Google-Smtp-Source: AGHT+IG0LrsT+litWNSx7aIMV3+r4xWV76gGMR4vpcUIaBbJ7yXgEsZoTkztw9ru8vFiIEH7eEgwfQ==
X-Received: by 2002:a05:690c:368f:b0:5cf:9a35:d406 with SMTP id fu15-20020a05690c368f00b005cf9a35d406mr301552ywb.34.1701468743146;
        Fri, 01 Dec 2023 14:12:23 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d1-20020a0ddb01000000b005d427fea43bsm677174ywe.48.2023.12.01.14.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:22 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 22/46] btrfs: add fscrypt_info and encryption_type to ordered_extent
Date: Fri,  1 Dec 2023 17:11:19 -0500
Message-ID: <f8b184888bc8a881d547fc6c7e2558220c2a794e.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to need these to update the file extent items once the
writes are complete.  Add them and add the pieces necessary to assign
them and free everything.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ordered-data.c | 2 ++
 fs/btrfs/ordered-data.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 574e8a55e24a..27350dd50828 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -181,6 +181,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
+	entry->encryption_type = BTRFS_ENCRYPTION_NONE;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
 	entry->flags = flags;
@@ -564,6 +565,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 			list_del(&sum->list);
 			kvfree(sum);
 		}
+		fscrypt_put_extent_info(entry->fscrypt_info);
 		kmem_cache_free(btrfs_ordered_extent_cache, entry);
 	}
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 127ef8bf0ffd..85ba9a381880 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -108,6 +108,9 @@ struct btrfs_ordered_extent {
 	/* compression algorithm */
 	int compress_type;
 
+	/* encryption mode */
+	int encryption_type;
+
 	/* Qgroup reserved space */
 	int qgroup_rsv;
 
@@ -117,6 +120,9 @@ struct btrfs_ordered_extent {
 	/* the inode we belong to */
 	struct inode *inode;
 
+	/* the fscrypt_info for this extent, if necessary */
+	struct fscrypt_extent_info *fscrypt_info;
+
 	/* list of checksums for insertion when the extent io is done */
 	struct list_head list;
 
-- 
2.41.0


