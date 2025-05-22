Return-Path: <linux-fsdevel+bounces-49639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41927AC0126
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009357B86B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B081C1FC3;
	Thu, 22 May 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq3xOnPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FEA645;
	Thu, 22 May 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872714; cv=none; b=RJvAsMCZ14vGhymjJlWMZgIGTHd3NoJPhX/sQTL1CAbxQjTF5tnZfjEAOkXGJonw4u+zni+qp/S61IdCUmH4+5ozG+A3P7c7sBKkbrbYaKLXCevUN5ZQ39c61r1dk/6BmfvGgNqwB0eOTQjoEliINDX5yWuvASs8IpRslmQ4r54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872714; c=relaxed/simple;
	bh=ct2WrNTjQtcyz/XTu+7hvWre0Sy3LtX40mAawBkyyg8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQuSWvkXfaFS9CiVD+lIwejUolcKs2jICBpIvTD7Kntotu6/O8jT02boRZmtmdTjZAws20J+ED2226WtjrN/RyUV9KAaThs7JLV2ApXOKYR0nqK9mE0uISIug/fdZ6n1r4EZnMPKOiVBLDtOvhwmdy1XwcDSwCiEUzsFoeX/fFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq3xOnPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8069C4CEE4;
	Thu, 22 May 2025 00:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872713;
	bh=ct2WrNTjQtcyz/XTu+7hvWre0Sy3LtX40mAawBkyyg8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Qq3xOnPBKRBTHrlqZU1SDM5evcW0ACqtzjzCndn125V30nWOWZ1E8BOeVywhztydQ
	 iQWRpkEn5uFWqwRh1xTGl5qBSXn80kP1Wl3DQRgWt8kQxvfr3JgMFKZ3bjb2udWlCA
	 e4b1D68zuiCer1OVJ5RtfDyXfhxeyFxvGAG3xVKsD0SkmYsFZADx27DUAi8eRE8FLL
	 CagA70jP1HiHykrXsFFS3tVrnBBSPQ5uyDCAFxlLIOymZxVbYsKjg0wwqEc2fbREpS
	 9mN7dzhySB0KwNMpwBKVRSxDJEZbIF1FWSsi1B72hqBCnKvsw7h33l663cWThoWCAr
	 UBFyR8vjOLLSA==
Date: Wed, 21 May 2025 17:11:53 -0700
Subject: [PATCH 04/16] fuse2fs: implement directio file reads
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198505.1484996.12562805540320275647.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
References: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement file reads via iomap.  Currently only directio is supported.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 91c0da096bef9c..b1f3002ec8c481 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1103,6 +1103,11 @@ static void *op_init(struct fuse_conn_info *conn
 			goto mount_fail;
 	}
 
+#if defined(HAVE_FUSE_IOMAP) && defined(FUSE_CAP_IOMAP_DIRECTIO)
+	if (iomap_enabled(ff))
+		fuse_set_feature_flag(conn, FUSE_CAP_IOMAP_DIRECTIO);
+#endif
+
 	/* Clear the valid flag so that an unclean shutdown forces a fsck */
 	if (ff->writable) {
 		fs->super->s_mnt_count++;
@@ -4942,7 +4947,26 @@ static int fuse_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 				 uint64_t count, uint32_t opflags,
 				 struct fuse_iomap *read_iomap)
 {
-	return -ENOSYS;
+	errcode_t err;
+
+	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
+		return -ENOSYS;
+
+	/* fall back to slow path for inline data reads */
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return -ENOSYS;
+
+	/* flush dirty io_channel buffers to disk before iomap reads them */
+	err = io_channel_flush(ff->fs->io);
+	if (err)
+		return translate_error(ff->fs, ino, err);
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return extent_iomap_begin(ff, ino, inode, pos, count, opflags,
+					 read_iomap);
+
+	return indirect_iomap_begin(ff, ino, inode, pos, count, opflags,
+				    read_iomap);
 }
 
 static int fuse_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,


