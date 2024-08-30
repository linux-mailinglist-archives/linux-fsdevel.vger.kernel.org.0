Return-Path: <linux-fsdevel+bounces-28029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BED96628D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D852879AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32E1B2525;
	Fri, 30 Aug 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovh6/W+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5C1B1D73
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023155; cv=none; b=eNxA4letRU+FbxkMBKwIGJJU3DPScOcsaJ1ANwBBISo1zwXMhJczotTrB+yWkNbPPrHv8vqAWMwfFx00ldKwvU6hE2ygkTWSPdnqnXhIkaj4iNJlIFOcSvNFGDiHxbcioGoL6UwkFdPzIpEcbCE92xI5KaTTYwyQl5zD3W6/cbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023155; c=relaxed/simple;
	bh=gsSA09+HfFYPf4pBq8Y5a4O4tybJu+VWXORMDBTPkXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZEenu3tk/BQWIu2Fer8ESuqKw30z8wgGxjY3gw3NIGgn5byNpqRrcPY65t22ZYTcE8XTfgi5XKKH5JaG+JrMFSRhCluR4ftYxjSh+Ih0Gytv5GFKiUmfdHYuIDJTtjT892DJC/fjReXumeYsdAeb1Vgbzh2sSWfrHlgr4wFiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovh6/W+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D61C4CECA;
	Fri, 30 Aug 2024 13:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023155;
	bh=gsSA09+HfFYPf4pBq8Y5a4O4tybJu+VWXORMDBTPkXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ovh6/W+qfXZF2Ki23cVCBZkhxPkhruizsWyA0oBCRlnYyiT4T7fwp5Nq71lJUeCxZ
	 xKhqKnd/i3mDHmKmybIykW3By/TshNspv0mDZO6Ifu4Ag3L+ZWshoEY9ykafOUoDOc
	 aN9DIu8WYM163C24IxZsVa6MWrRALyNwDDtMTrm3XQ/LE7Ux7DAMVohxZKXrtg7iMp
	 ann+BdntojVNa4NqaZHTj4C/ExnTmt1KVn1ACXAFcU4flVZiYfIO6vnhLATq3ic9vf
	 2TvPpt9cqwCtDiJiX4YK090JckeQO7FRCAbXjeuHKYS46Q706FruwU6T5Qf8ZTWgGL
	 VdExTQ0qtE13A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:48 +0200
Subject: [PATCH RFC 07/20] fs: use must_set_pos()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-7-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gsSA09+HfFYPf4pBq8Y5a4O4tybJu+VWXORMDBTPkXw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDxH6FXZ7MNXUuInaHxZ+9iS6+zx80lB/wr4WwJ/a
 dcqeW141VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR692MDPu3bdi2IeZ7wM/D
 6nuenW//WXyvuTi20ZxZ+5jaB565HKyMDLtuhT/yzSzeN7Hg2917G03KDI5GlU4qjdeLkLgeGrb
 lDBMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make generic_file_llseek_size() use must_set_pos(). We'll use
must_set_pos() in another helper in a minutes. Remove __maybe_unused
from must_set_pos() now that it's used.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/read_write.c | 51 ++++++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index acee26989d95..ad93b72cc378 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -97,7 +97,7 @@ EXPORT_SYMBOL(vfs_setpos);
  * Return: 0 if f_pos doesn't need to be updated, 1 if f_pos has to be
  * updated, and negative error code on failure.
  */
-static __maybe_unused int must_set_pos(struct file *file, loff_t *offset, int whence, loff_t eof)
+static int must_set_pos(struct file *file, loff_t *offset, int whence, loff_t eof)
 {
 	switch (whence) {
 	case SEEK_END:
@@ -157,45 +157,22 @@ loff_t
 generic_file_llseek_size(struct file *file, loff_t offset, int whence,
 		loff_t maxsize, loff_t eof)
 {
-	switch (whence) {
-	case SEEK_END:
-		offset += eof;
-		break;
-	case SEEK_CUR:
-		/*
-		 * Here we special-case the lseek(fd, 0, SEEK_CUR)
-		 * position-querying operation.  Avoid rewriting the "same"
-		 * f_pos value back to the file because a concurrent read(),
-		 * write() or lseek() might have altered it
-		 */
-		if (offset == 0)
-			return file->f_pos;
-		/*
-		 * f_lock protects against read/modify/write race with other
-		 * SEEK_CURs. Note that parallel writes and reads behave
-		 * like SEEK_SET.
-		 */
-		spin_lock(&file->f_lock);
-		offset = vfs_setpos(file, file->f_pos + offset, maxsize);
-		spin_unlock(&file->f_lock);
+	int ret;
+
+	ret = must_set_pos(file, &offset, whence, eof);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
 		return offset;
-	case SEEK_DATA:
-		/*
-		 * In the generic case the entire file is data, so as long as
-		 * offset isn't at the end of the file then the offset is data.
-		 */
-		if ((unsigned long long)offset >= eof)
-			return -ENXIO;
-		break;
-	case SEEK_HOLE:
+
+	if (whence == SEEK_CUR) {
 		/*
-		 * There is a virtual hole at the end of the file, so as long as
-		 * offset isn't i_size or larger, return i_size.
+		 * f_lock protects against read/modify/write race with
+		 * other SEEK_CURs. Note that parallel writes and reads
+		 * behave like SEEK_SET.
 		 */
-		if ((unsigned long long)offset >= eof)
-			return -ENXIO;
-		offset = eof;
-		break;
+		guard(spinlock)(&file->f_lock);
+		return vfs_setpos(file, file->f_pos + offset, maxsize);
 	}
 
 	return vfs_setpos(file, offset, maxsize);

-- 
2.45.2


