Return-Path: <linux-fsdevel+bounces-13895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3668752F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D741F258EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190F63121;
	Thu,  7 Mar 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="UbEphsG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5012AACC
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824665; cv=none; b=QaP7mnwH0fgp1D5dTFV6WuOZYo/1BFtldXrtGPc6OEWf64Rcad3Qi++skPLXPJ7pkZzHSZ/w5W46vIl09oIX9ZtOcD1ZL5W+nWySDhyyRiBasBRa5k98lTeL2JXtoOvzue5pnU9q5sC6//+PJvkRjzHlxo2JppP+igSZI/V76IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824665; c=relaxed/simple;
	bh=amg8kEuZrRw30UmImWOX1x3kPGkH5x7OuU29xKNXS/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTX6pyQ+UsEGbhl7s/HGnuaTtnCRJeXXeWx+b8AFLBQPJCnbIUrjF8S6nnLx855YlesGyrSxScOq9YjmBUdmNxLVz1/omKfP9u++zso96JHe/MMAAxqxTUyQLlTZdBP+JEwFxtZwbIaccYQ/niPcDA0EnomME9x7y2r2VGZUlKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=UbEphsG0; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id B295A803B4;
	Thu,  7 Mar 2024 10:10:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1709824204; bh=amg8kEuZrRw30UmImWOX1x3kPGkH5x7OuU29xKNXS/I=;
	h=From:To:Cc:Subject:Date:From;
	b=UbEphsG09saX7M0Wf0AHGI3CsRCDMH6yqHegXDAchgvbN7ggWvqDqiFtGRmxvSSOK
	 /dovOOQDs8CFoxKXh4VqzAxIEfdJtT63/NGq7Mk7V+AvB97qbCfpQIK1g2UTSCHALo
	 vnuV8+Z7cHhmIHADddNO7rFdr0ub6HTD9GlmpC89But/dTqsuc0adHa20tOKpa4lFz
	 MA2k7fd6i47lgvbAOo+t+TFlxA13t3TbKYRJgRkgLmp2s8En9I6axlOiurxUuDYhjW
	 QqEIYFTJuK9yqT+YoTm1R3FvJgBDbMWIsFByn6kmSWdZx2FZHdAb82wBH6+vygM761
	 6AS/TqZe4hxyA==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	josef@toxicpanda.com,
	amir73il@gmail.com
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH] fuse: update size attr before doing IO
Date: Thu,  7 Mar 2024 10:08:13 -0500
Message-ID: <9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e3f0.1709821568.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All calls into generic vfs functions need to make sure that the inode
attributes used by those functions are up to date, by calling
fuse_update_attributes() as appropriate.

generic_write_checks() accesses inode size in order to get the
appropriate file offset for files opened with O_APPEND. Currently, in
some cases, fuse_update_attributes() is not called before
generic_write_checks(), potentially resulting in corruption/overwrite of
previously appended data if i_size is out of date in the cached inode.

Therefore,  make sure fuse_update_attributes() is always
called before generic_write_checks(), and add a note about why it's not
necessary for some llseek calls.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/fuse/file.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1b0b9f2a4fbf..d69b2dd0168c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1408,13 +1408,16 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err, count;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (fc->writeback_cache) {
-		/* Update size (EOF optimization) and mode (SUID clearing) */
-		err = fuse_update_attributes(mapping->host, file,
-					     STATX_SIZE | STATX_MODE);
-		if (err)
-			return err;
+	/*
+	 * Update size (EOF optimization, and O_APPEND correctness) and
+	 * mode (SUID clearing)
+	 */
+	err = fuse_update_attributes(mapping->host, file,
+				     STATX_SIZE | STATX_MODE);
+	if (err)
+		return err;
 
+	if (fc->writeback_cache) {
 		if (fc->handle_killpriv_v2 &&
 		    setattr_should_drop_suidgid(&nop_mnt_idmap,
 						file_inode(file))) {
@@ -1666,10 +1669,19 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(iocb->ki_filp);
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
 	bool exclusive;
+	/*
+	 * For O_APPEND files, we need to make sure the size is right before
+	 * generic_write_checks() grabs it.
+	 */
+	res = fuse_update_attributes(file->f_mapping->host, file, STATX_SIZE);
+	if (res)
+		return res;
+
 
 	fuse_dio_lock(iocb, from, &exclusive);
 	res = generic_write_checks(iocb, from);
@@ -2815,7 +2827,11 @@ static loff_t fuse_file_llseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 	case SEEK_SET:
 	case SEEK_CUR:
-		 /* No i_mutex protection necessary for SEEK_CUR and SEEK_SET */
+		 /*
+		  * No i_mutex protection necessary for SEEK_CUR and SEEK_SET.
+		  * Even if we seek to a point outside the currently known size,
+		  * read and write will update the attributes before doing IO
+		  */
 		retval = generic_file_llseek(file, offset, whence);
 		break;
 	case SEEK_END:

base-commit: cdf6ac2a03d253f05d3e798f60f23dea1b176b92
-- 
2.44.0


