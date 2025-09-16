Return-Path: <linux-fsdevel+bounces-61621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078E6B58A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD414800EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7976F1DE89A;
	Tue, 16 Sep 2025 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS3f3FIm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340DD2FB;
	Tue, 16 Sep 2025 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984308; cv=none; b=WmWwtomgxvmwVqsdBs6FOoVdz/OHyImm4WYj5E+x71QPyDMUfrlSk78XgvQ9AbPi2WKYHqMjo/Cn6ehyHOse+4hw1CXA4nOT8WE2jAYHa2Uo9wzkVYH07rKBdKrDAdTE2LltPeudSQvycSgIh1LVdkfMKaaVGXWgU4djtT6Jh1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984308; c=relaxed/simple;
	bh=Z6QA3eH86l+ScYuV6WkeOKtuoS7+liQqlzV6HtcjPqs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RElymHGe7xFD0GHpuKH2izgizUWtXH/8ECYNPt2enAYt/SH5Pu8EskuVYm5VxbPIHsl6mBnWyqr3GeSMttp5SNIPUdOpL/96ONR6wg685Fw12ZX3qArNZT3ZYRQz0ZccY1EUmMymPY4ITv6qSDvZDw4EjccWGKHKkgH/XSIRErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS3f3FIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542C5C4CEF1;
	Tue, 16 Sep 2025 00:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984308;
	bh=Z6QA3eH86l+ScYuV6WkeOKtuoS7+liQqlzV6HtcjPqs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hS3f3FImHpxD971hROqeXnfDzz+kpcq6pfmalck9LME8Y0pBA8i/T7Q7yY8cstmps
	 uEiF4Tnm6UA4oyglLpubgs2CqBpkgRhPZX0Aeh40v9vZC6Jj8+kwhMlD7Cw99uh/QK
	 AdzH4xrmQU++qqWZPl1bPSCabrU9V7g3aHhoo5QoJJlhAK4001k/SBLoWG50J0X3qh
	 Ft/miRlf1yjlygRoC17t1eEl5fKeHhCkJIsteWLgz5iZs2zbk1xM+nTzROqaBpDrHO
	 uK0EXF0Psvww4MDqUNN/5wYk2zWhNdKuuREXYGBrtk559Cy0RebPQ3X2eIvkFardV+
	 9W+2vm0iGotwQ==
Date: Mon, 15 Sep 2025 17:58:27 -0700
Subject: [PATCH 09/10] libext2fs: allow callers to disallow I/O to file data
 blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161486.390072.17393236598223883280.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161283.390072.8565583077948994821.stgit@frogsfrogsfrogs>
References: <175798161283.390072.8565583077948994821.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a flag to ext2_file_t to disallow read and write I/O to file data
blocks.  This supports fuse2fs iomap support, which will keep all the
file data I/O inside the kerne.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fs.h |    3 +++
 lib/ext2fs/fileio.c |   12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index dee9feb02624ed..7d36b1a839dc57 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -178,6 +178,9 @@ typedef struct ext2_struct_dblist *ext2_dblist;
 #define EXT2_FILE_WRITE		0x0001
 #define EXT2_FILE_CREATE	0x0002
 
+/* no file I/O to disk blocks, only to inline data */
+#define EXT2_FILE_NOBLOCKIO	0x0004
+
 #define EXT2_FILE_MASK		0x00FF
 
 #define EXT2_FILE_BUF_DIRTY	0x4000
diff --git a/lib/ext2fs/fileio.c b/lib/ext2fs/fileio.c
index 3a36e9e7fff43b..95ee45ec7371ae 100644
--- a/lib/ext2fs/fileio.c
+++ b/lib/ext2fs/fileio.c
@@ -314,6 +314,11 @@ errcode_t ext2fs_file_read(ext2_file_t file, void *buf,
 	if (file->inode.i_flags & EXT4_INLINE_DATA_FL)
 		return ext2fs_file_read_inline_data(file, buf, wanted, got);
 
+	if (file->flags & EXT2_FILE_NOBLOCKIO) {
+		retval = EXT2_ET_OP_NOT_SUPPORTED;
+		goto fail;
+	}
+
 	while ((file->pos < EXT2_I_SIZE(&file->inode)) && (wanted > 0)) {
 		retval = sync_buffer_position(file);
 		if (retval)
@@ -441,6 +446,11 @@ errcode_t ext2fs_file_write(ext2_file_t file, const void *buf,
 		retval = 0;
 	}
 
+	if (file->flags & EXT2_FILE_NOBLOCKIO) {
+		retval = EXT2_ET_OP_NOT_SUPPORTED;
+		goto fail;
+	}
+
 	while (nbytes > 0) {
 		retval = sync_buffer_position(file);
 		if (retval)
@@ -609,7 +619,7 @@ static errcode_t ext2fs_file_zero_past_offset(ext2_file_t file,
 	int ret_flags;
 	errcode_t retval;
 
-	if (off == 0)
+	if (off == 0 || (file->flags & EXT2_FILE_NOBLOCKIO))
 		return 0;
 
 	retval = sync_buffer_position(file);


