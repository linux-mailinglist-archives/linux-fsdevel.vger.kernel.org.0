Return-Path: <linux-fsdevel+bounces-15984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8F8896687
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EC5286D15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B4D7317E;
	Wed,  3 Apr 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="g4korhKJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E4571748;
	Wed,  3 Apr 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129600; cv=none; b=cLF75bVW+XS8s8fwsifcWqrqDziqbVVhhWsOtnMVVkohEiKNEV+4fkSHq8rn+yYIS8tVBeHtBLHA+IC/oShtQs5ZCNTjoJ3Vri7qdjA2J/r+3wgxz1XVViZ6ffIX76gFylGe0Tf7twuWWPbr5xw1M5bi6rPxqaWbDrv6iE/+sWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129600; c=relaxed/simple;
	bh=RN4ChmgSR3ZQz489TYOpQl2oinZST+jD9bAbWRVw3kw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIHqjkUaHipni2eoPil+3a8r3b2Bxgi9p3KoZRqVcTIr/TXBTZ1fDlg1LYKyExqPgaDtVTr70N2dmVpJVDaWaPbkmYdDB4Syshfe0hYAVlcf5LTIrSrUlrV4AZkDsSszvPGQyVSLlOrV0eoTZZP8KHT0+tiL5GSA0sQIiX9iu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=g4korhKJ; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 5353F807DB;
	Wed,  3 Apr 2024 03:33:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129598; bh=RN4ChmgSR3ZQz489TYOpQl2oinZST+jD9bAbWRVw3kw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g4korhKJcSnDsrv9N7vH1U2FU2y1IQ+1cCMgS5/5PrxSN4HMDcoGduvy3dBmz1Nc2
	 yesnN+yjkh4f2vIszcOepeVVHQ3K67FvmEIxGpiTFYHKpuMe2R6HagoPaJ/l1N7h5B
	 kSFM1+CNyOU88P5figMN31ZJaqkeiNoaljXN4YmqKD9V2WaqCHnY88jix5aqPn43Kf
	 yGgF7UvGPp8P8KQGEm5qGPB01jtmts3h8MXOdQNZoA8tbZ857MqJXRClm9wfhrTLk2
	 A4L0DcuexATY8/UevIM4mTqaPkV3v1Ac2XqU6Gr25kMylrueJwoopHZo/lPNObd6bQ
	 02UNpUd0OrtTw==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 06/13] nilfs2: fiemap: return correct extent physical length
Date: Wed,  3 Apr 2024 03:22:47 -0400
Message-ID: <bd06389b4c9c33ab1411f2941875f02867b18642.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/nilfs2/inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 4d3c347c982b..e3108f2cead7 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1160,7 +1160,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 	__u64 logical = 0, phys = 0, size = 0;
-	__u32 flags = 0;
+	__u32 flags = FIEMAP_EXTENT_HAS_PHYS_LEN;
 	loff_t isize;
 	sector_t blkoff, end_blkoff;
 	sector_t delalloc_blkoff;
@@ -1197,7 +1197,9 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			if (blkoff > end_blkoff)
 				break;
 
-			flags = FIEMAP_EXTENT_MERGED | FIEMAP_EXTENT_DELALLOC;
+			flags = FIEMAP_EXTENT_MERGED |
+				FIEMAP_EXTENT_DELALLOC |
+				FIEMAP_EXTENT_HAS_PHYS_LEN;
 			logical = blkoff << blkbits;
 			phys = 0;
 			size = delalloc_blklen << blkbits;
@@ -1261,14 +1263,16 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 						break;
 
 					/* Start another extent */
-					flags = FIEMAP_EXTENT_MERGED;
+					flags = FIEMAP_EXTENT_MERGED |
+						FIEMAP_EXTENT_HAS_PHYS_LEN;
 					logical = blkoff << blkbits;
 					phys = blkphy << blkbits;
 					size = n << blkbits;
 				}
 			} else {
 				/* Start a new extent */
-				flags = FIEMAP_EXTENT_MERGED;
+				flags = FIEMAP_EXTENT_MERGED |
+					FIEMAP_EXTENT_HAS_PHYS_LEN;
 				logical = blkoff << blkbits;
 				phys = blkphy << blkbits;
 				size = n << blkbits;
-- 
2.43.0


