Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC38D37F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfHNMuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 08:50:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36356 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfHNMuM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:50:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id c15so17251996oic.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2019 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/+aArS/+ZpXWQrNyAPbe/FVozsbsHho1Pyh+D5yt+eM=;
        b=Q46RYsE22MhQi0qPL9mOVIvPiWIAlcb6XvRg2G1Kab100w6d33bkV6Nj7WbfBhZLFS
         DePA24isLJdfXVfQiu01V6rvCiv+SNWBYE1TAmyt7D0OP0KaZLFg3PB7+pLJD+GF+OWk
         MGcqJVVXmPl35qlkvYbT7sQLmXWlVgITTelZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/+aArS/+ZpXWQrNyAPbe/FVozsbsHho1Pyh+D5yt+eM=;
        b=qiue62eCrBdV4s/OukrQkOYywz4T9Kz0h/b4UiG+QkATN/wyBWr0lCw9lxQkTAFYKc
         2nq52Q6C8wXzqnlMsSAljOW130Ok23eMRJlvpP1vOrfkYDFWTBpvVoTrxh1Icqqgd3kT
         7ry8h4iGzSLqwjZOnkUtwDGziGmd8rpyrV89r7mx4ZRVLxzanjw8FF0+AbmRoSN8GIyJ
         8qOEOBz7XUWdyPcxLq7wD3yLMxvvmqzaTioqRI3nV4WQdFPDNL0aNerKH5riPp/CX6Fr
         VRawvHv4/iH8GrOiyZqvbZxf6dV1Y0AAoJHuRVYBgK3xJPTePuMkTLKpj5GPtkiz/5EF
         DyNQ==
X-Gm-Message-State: APjAAAXCg+QGZGmSyboUdhsW4UIzZYE6JivTqG2jXW1uy/pxyLdKwk8C
        rWcEt5t32AhStZVVCnHP8Qe3ZA==
X-Google-Smtp-Source: APXvYqwDOApCZPr3cCgqfm3OG0AgLMRjBq0SWb9OHeIgBreHeTX11da+LxeS/BlgpYOjG+0S+p3dig==
X-Received: by 2002:a02:9981:: with SMTP id a1mr3295802jal.17.1565787011740;
        Wed, 14 Aug 2019 05:50:11 -0700 (PDT)
Received: from iscandar.digidescorp.com ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id j5sm83102558iom.69.2019.08.14.05.50.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 05:50:11 -0700 (PDT)
From:   "Steven J. Magnani" <steve.magnani@digidescorp.com>
X-Google-Original-From: "Steven J. Magnani" <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH v2] udf: reduce leakage of blocks related to named streams
Date:   Wed, 14 Aug 2019 07:50:02 -0500
Message-Id: <20190814125002.10869-1-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Windows is capable of creating UDF files having named streams.
One example is the "Zone.Identifier" stream attached automatically
to files downloaded from a network. See:
  https://msdn.microsoft.com/en-us/library/dn392609.aspx

Modification of a file having one or more named streams in Linux causes
the stream directory to become detached from the file, essentially leaking
all blocks pertaining to the file's streams.

Fix by saving off information about an inode's streams when reading it,
for later use when its on-disk data is updated.

Changes from v1:
Remove modifications that would limit leakage of all inode blocks
on deletion.
This restricts the patch to preservation of stream data during inode
modification.

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

--- a/fs/udf/udf_i.h	2019-07-26 11:35:28.257563879 -0500
+++ b/fs/udf/udf_i.h	2019-08-06 14:35:55.579654263 -0500
@@ -42,12 +42,15 @@ struct udf_inode_info {
 	unsigned		i_efe : 1;	/* extendedFileEntry */
 	unsigned		i_use : 1;	/* unallocSpaceEntry */
 	unsigned		i_strat4096 : 1;
-	unsigned		reserved : 26;
+	unsigned		i_streamdir : 1;
+	unsigned		reserved : 25;
 	union {
 		struct short_ad	*i_sad;
 		struct long_ad		*i_lad;
 		__u8		*i_data;
 	} i_ext;
+	struct kernel_lb_addr	i_locStreamdir;
+	__u64			i_lenStreams;
 	struct rw_semaphore	i_data_sem;
 	struct udf_ext_cache cached_extent;
 	/* Spinlock for protecting extent cache */
--- a/fs/udf/super.c	2019-07-26 11:35:28.253563792 -0500
+++ b/fs/udf/super.c	2019-08-06 15:04:30.851086957 -0500
@@ -151,9 +151,13 @@ static struct inode *udf_alloc_inode(str
 
 	ei->i_unique = 0;
 	ei->i_lenExtents = 0;
+	ei->i_lenStreams = 0;
 	ei->i_next_alloc_block = 0;
 	ei->i_next_alloc_goal = 0;
 	ei->i_strat4096 = 0;
+	ei->i_streamdir = 0;
+	ei->i_locStreamdir.logicalBlockNum = 0xFFFFFFFF;
+	ei->i_locStreamdir.partitionReferenceNum = 0xFFFF;
 	init_rwsem(&ei->i_data_sem);
 	ei->cached_extent.lstart = -1;
 	spin_lock_init(&ei->i_extent_cache_lock);
--- a/fs/udf/inode.c	2019-07-26 11:35:28.253563792 -0500
+++ b/fs/udf/inode.c	2019-08-06 15:04:30.851086957 -0500
@@ -1485,6 +1485,10 @@ reread:
 		iinfo->i_lenEAttr = le32_to_cpu(fe->lengthExtendedAttr);
 		iinfo->i_lenAlloc = le32_to_cpu(fe->lengthAllocDescs);
 		iinfo->i_checkpoint = le32_to_cpu(fe->checkpoint);
+		iinfo->i_streamdir = 0;
+		iinfo->i_lenStreams = 0;
+		iinfo->i_locStreamdir.logicalBlockNum = 0xFFFFFFFF;
+		iinfo->i_locStreamdir.partitionReferenceNum = 0xFFFF;
 	} else {
 		inode->i_blocks = le64_to_cpu(efe->logicalBlocksRecorded) <<
 		    (inode->i_sb->s_blocksize_bits - 9);
@@ -1498,6 +1502,16 @@ reread:
 		iinfo->i_lenEAttr = le32_to_cpu(efe->lengthExtendedAttr);
 		iinfo->i_lenAlloc = le32_to_cpu(efe->lengthAllocDescs);
 		iinfo->i_checkpoint = le32_to_cpu(efe->checkpoint);
+
+		/* Named streams */
+		iinfo->i_streamdir = (efe->streamDirectoryICB.extLength != 0);
+		iinfo->i_locStreamdir =
+			lelb_to_cpu(efe->streamDirectoryICB.extLocation);
+		iinfo->i_lenStreams = le64_to_cpu(efe->objectSize);
+		if (iinfo->i_lenStreams >= inode->i_size)
+			iinfo->i_lenStreams -= inode->i_size;
+		else
+			iinfo->i_lenStreams = 0;
 	}
 	inode->i_generation = iinfo->i_unique;
 
@@ -1760,9 +1774,19 @@ static int udf_update_inode(struct inode
 		       iinfo->i_ext.i_data,
 		       inode->i_sb->s_blocksize -
 					sizeof(struct extendedFileEntry));
-		efe->objectSize = cpu_to_le64(inode->i_size);
+		efe->objectSize =
+			cpu_to_le64(inode->i_size + iinfo->i_lenStreams);
 		efe->logicalBlocksRecorded = cpu_to_le64(lb_recorded);
 
+		if (iinfo->i_streamdir) {
+			struct long_ad *icb_lad = &efe->streamDirectoryICB;
+
+			icb_lad->extLocation =
+				cpu_to_lelb(iinfo->i_locStreamdir);
+			icb_lad->extLength =
+				cpu_to_le32(inode->i_sb->s_blocksize);
+		}
+
 		udf_adjust_time(iinfo, inode->i_atime);
 		udf_adjust_time(iinfo, inode->i_mtime);
 		udf_adjust_time(iinfo, inode->i_ctime);
