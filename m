Return-Path: <linux-fsdevel+bounces-14026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D28876BCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 21:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AA11F21C84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847F5D47A;
	Fri,  8 Mar 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIIiIm6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265FC51C33;
	Fri,  8 Mar 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929555; cv=none; b=G7VRtmKlInVK6bliE48K/4YWBPThhN3B1ptC3zLWBeU7GNIvtL9HR+A7CQmc8Uwp2KqxBXG528OjEO6k55LWqMEeb3bJoeyp+Qeal2SxUmz54YnKc2E3pssMn4Xd+17RZISzJZjs7p/YjcjbWjIvJw2bhtODEXWSsR9BfMk7lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929555; c=relaxed/simple;
	bh=rJdPwcztBz8X4vt5HGAw0qqMXtzhifyWt9yLAdzhfTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+OuuACXxj6Sl9PwqlX0Z3I9hf6Nf+cQ7UF9UICmW49Ox4N7Wk+vWf6iAcacxyJ884QhWFr+S+aZLRbIwhQFE9pxJsucZV/8S1sw8DOtorVodQJ9cqS8GkPHf215q1PbLQsAds4PW0djMWPiUB9xltJJHtXrTeFxIisfFku56m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIIiIm6p; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so2102814a12.1;
        Fri, 08 Mar 2024 12:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709929553; x=1710534353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXaGS2OWhnhbczoRRrQrWo6yetFGH8X8azzOfrjbE6g=;
        b=HIIiIm6pEhD2EzqpccRMPkzBVIOq/NRQ76OKeQM3Tqz3oH4nbWd8aupHlYC5Qz/Yww
         4pu+tCLO7+wIM4JbpBFGTg18R98ch3blbJIsNIwv/aZ12EAEzQJ/n6EGNjvt7vFL8iop
         +dh1oElFvfkaohWBfmSA0zeIvHJsGJ5Qr/bwrH/l2QL+kVrcBW3K3ETXr/gJnnXS4Ue8
         8LpP7VWQvs9EbrHr4MFgjoaaAgEISHGEf5AGDmsx+4YBX8lVnon66O2DikGc33GqHbSa
         P2L8+kSzrpRC/O/3iOWDJ4QGYzKA6twSKmPhFdd0uyZ+2Pq3sdC5L3Oy8rD7vJDxYv34
         MkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709929553; x=1710534353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXaGS2OWhnhbczoRRrQrWo6yetFGH8X8azzOfrjbE6g=;
        b=FxsDVVfasyO8SWPEw2V2y8t/u7QtQJXccjPa/+vxClCi6aq5QXf59Ymve723ZLIEfQ
         afvr/2rF/qgPaLJynDNSHdy3LdPXI5YE0wfZ2h+T2I1H0/6hDRMbT89OMLC27WloYV0u
         k23OH6ovqbWU/cgSK1DcJJ6j0U4jsninLnMBTz3XH3rg4gC3tek9exN3G5uD/9n2AjV7
         eo5r0/epeid8H1anEtvIowQZPtbPhqoAnGRKKt2IdvYdG6ykOZWCF18kBJlQSie3SAiJ
         UGKamOmJkE1vVUL4ld7Z0oXii3ozMMjxZckf8RQg2LpY7sHjqcJc772owkYeHOeArn3U
         s3+A==
X-Forwarded-Encrypted: i=1; AJvYcCX0YZveGJ3RM8GI0qBcnzIkiY22PCb0av/lpmwZpy3oqbhAuVgZPOf8fQiCc9vi8g91vcAZ7umb4Kfw6I17wbwupSvn7uhqKsdh8VjlMNUCQMm85f1IwmOs4JJW5S5QKLJnHcnfGvJlsXDADafuzI8zCcSua03RRKLcenYo1FDT7ITtXamxYm8=
X-Gm-Message-State: AOJu0YyR4ts+jLJgNyjT9gYVtZDs8NpbjLWA+uc9CpHiOBTyk0ki9P2t
	vXeyh236gJrGMI4zD7XSdIJQGh96IMwEMFNCuiYnirBGFpdWc93a
X-Google-Smtp-Source: AGHT+IF4C0L0MiiUU+0bie1dyOAt1ABfQ6/ycb8CLKRaB7hHeTGez0urqm3/an0rbiHzL1EqsyqpHw==
X-Received: by 2002:a17:90a:ad0c:b0:29b:b15d:5353 with SMTP id r12-20020a17090aad0c00b0029bb15d5353mr278722pjq.31.1709929553345;
        Fri, 08 Mar 2024 12:25:53 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id ob4-20020a17090b390400b0029ba7731d38sm147186pjb.7.2024.03.08.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:25:52 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-kernel@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC] ext4: Add support for ext4_map_blocks_atomic()
Date: Sat,  9 Mar 2024 01:55:42 +0530
Message-ID: <3a417188e5abe3048afac3d31ebbf11588b6d68d.1709927824.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <e4bd58d4-723f-4c94-bf46-826bceeb6a8d@oracle.com>
References: <e4bd58d4-723f-4c94-bf46-826bceeb6a8d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently ext4 exposes [fsawu_min, fsawu_max] size as
[blocksize, clustersize] (given the hw block device constraints are
larger than FS atomic write units).

That means a user should be allowed to -
1. pwrite 0 4k /mnt/test/f1
2. pwrite 0 16k /mnt/test/f1

w/o this patch the second atomic write will fail. Since current
ext4_map_blocks() will just return the already allocated extent length
to the iomap (which is less than the user requested write length).

So add ext4_map_blocks_atomic() function which can allocate full
requested length for doing an atomic write before returning to iomap.
With this we have - 

1. touch /mnt1/test/f2
2. chattr +W /mnt1/test/f2
3. xfs_io -dc "pwrite -b 4k -A -V 1 0 4k" /mnt1/test/f2
	wrote 4096/4096 bytes at offset 0
	4 KiB, 1 ops; 0.0320 sec (124.630 KiB/sec and 31.1575 ops/sec)
4. filefrag -v /mnt1/test/f2
	Filesystem type is: ef53
	File size of /mnt1/test/f2 is 4096 (1 block of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..       0:       9728..      9728:      1:             last,eof
	/mnt1/test/f2: 1 extent found
5. xfs_io -dc "pwrite -b 16k -A -V 1 0 16k" /mnt1/test/f2
	wrote 16384/16384 bytes at offset 0
	16 KiB, 1 ops; 0.0337 sec (474.637 KiB/sec and 29.6648 ops/sec)
6. filefrag -v /mnt1/test/f2
	Filesystem type is: ef53
	File size of /mnt1/test/f2 is 16384 (4 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..       3:       9728..      9731:      4:             last,eof
	/mnt1/test/f2: 1 extent found

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---

Please note, that this is very minimal tested. But it serves as a PoC of what
can be done within ext4 to allow the usecase which John pointed out.

This also shows that every filesystem can have a different ways of doing aligned
allocations to support atomic writes. So lifting extent size hints to iomap
perhaps might become very XFS centric? Althouh as long as other filesystems are 
not forced to follow that, I don't think it should be a problem.


 fs/ext4/ext4.h  |  2 ++
 fs/ext4/inode.c | 40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 529ca32b9813..1e9adc5d6569 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3702,6 +3702,8 @@ extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
 					     ext4_io_end_t *io_end);
 extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map, int flags);
+extern int ext4_map_blocks_atomic(handle_t *handle, struct inode *inode,
+				  struct ext4_map_blocks *map, int flags);
 extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
 						   int num,
 						   struct ext4_ext_path *path);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ea009ca9085d..db273c7faf36 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -453,6 +453,29 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 }
 #endif /* ES_AGGRESSIVE_TEST */
 
+int ext4_map_blocks_atomic(handle_t *handle, struct inode *inode,
+			   struct ext4_map_blocks *map, int flags)
+{
+	unsigned int mapped_len = 0, m_len = map->m_len;
+	ext4_lblk_t m_lblk = map->m_lblk;
+	int ret;
+
+	WARN_ON(!(flags & EXT4_GET_BLOCKS_CREATE));
+
+	do {
+		ret = ext4_map_blocks(handle, inode, map, flags);
+		if (ret < 0)
+			return ret;
+		mapped_len += map->m_len;
+		map->m_lblk += map->m_len;
+		map->m_len = m_len - mapped_len;
+	} while (mapped_len < m_len);
+
+	map->m_lblk = m_lblk;
+	map->m_len = mapped_len;
+	return mapped_len;
+}
+
 /*
  * The ext4_map_blocks() function tries to look up the requested blocks,
  * and returns if the blocks are already mapped.
@@ -3315,7 +3338,10 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
 
-	ret = ext4_map_blocks(handle, inode, map, m_flags);
+	if (flags & IOMAP_ATOMIC)
+		ret = ext4_map_blocks_atomic(handle, inode, map, m_flags);
+	else
+		ret = ext4_map_blocks(handle, inode, map, m_flags);
 
 	/*
 	 * We cannot fill holes in indirect tree based inodes as that could
@@ -3339,6 +3365,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	int ret;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
+	unsigned int orig_len;
 
 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
@@ -3352,6 +3379,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_lblk = offset >> blkbits;
 	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	orig_len = map.m_len;
 
 	if (flags & IOMAP_WRITE) {
 		/*
@@ -3362,9 +3390,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		 */
 		if (offset + length <= i_size_read(inode)) {
 			ret = ext4_map_blocks(NULL, inode, &map, 0);
-			if (ret > 0 && (map.m_flags & EXT4_MAP_MAPPED))
-				goto out;
+			if (map.m_flags & EXT4_MAP_MAPPED) {
+				if ((flags & IOMAP_ATOMIC && ret >= orig_len) ||
+				   (!(flags & IOMAP_ATOMIC) && ret > 0))
+					goto out;
+
+			}
 		}
+		WARN_ON(map.m_lblk != offset >> blkbits);
+		map.m_len = orig_len;
 		ret = ext4_iomap_alloc(inode, &map, flags);
 	} else {
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
-- 
2.39.2


