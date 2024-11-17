Return-Path: <linux-fsdevel+bounces-35043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9FA9D0653
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 22:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ADD282278
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 21:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8611DDC19;
	Sun, 17 Nov 2024 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrUEwBWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CD1DDA2D
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2024 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879145; cv=none; b=g9H2vlgzGsxl3mXBntGap0LlLS09NWlhpMSZeiEhyBzt6BdgS2aCZIObh+NzOztbNebtVczsri1RxhDZW3qghMlS2G1yeBayAlQxPqfhUYgAEYRvgcnT92AOf0jPVjzC26PSCRRahUz9LXIIWFIAWktOiU160CoKvyjoPl03YnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879145; c=relaxed/simple;
	bh=Imws/SMxyuWl9wa5OM4mA83z05SUQjW00CX49uy8e2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErWBAqvUCtRE7f0De64+Y8rWfU5WruOsJ2LeSrfpe637MqAS9Up9jwUYzEf93+SsstYizeYbEsTXfzokSizkNnDuRisO2H+f4VdVK+yA9lVR1+poEDonHP4OLdjtnWAsOWG1ivSMF1xx8IntZRv11EnxQxNaX26rffVUjetp1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrUEwBWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02CEC4CED7;
	Sun, 17 Nov 2024 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731879144;
	bh=Imws/SMxyuWl9wa5OM4mA83z05SUQjW00CX49uy8e2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrUEwBWi8qr+8LgPYCTL0ObS1dvFTb6tStBaAmqhwR7WOv75uob1xy+nsGzACW624
	 983hu1q4sR4cX2Lk83LRRVBgzOtVX/6owVkk0TrNqlzfdYLXdwCM1XCR0Np7GPjuSU
	 Og8beXb5TVOqbhoeokxP7WPfYbCgY+DnXAiqTVGuT6U/dlT6k9cvhSK9ggu9RMZ+xR
	 8D3o4NLYk2W6dkM3nuWMPPRYJd+pRrgJjMhRsoEJ+oYPBgYwkU9qX/mN0B3VNI4BNK
	 ghueOUjbNtj2HMnqRey5UkJoKe8lBeI+KHwdbhSMMID/1zeihiN8kyRHaZkNYuYjYA
	 s6bhxF0uRx91w==
From: cel@kernel.org
To: <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>,
	Hugh Dickens <hughd@google.com>
Cc: yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/2] libfs: Improve behavior when directory offset values wrap
Date: Sun, 17 Nov 2024 16:32:06 -0500
Message-ID: <20241117213206.1636438-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117213206.1636438-1-cel@kernel.org>
References: <20241117213206.1636438-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The fix in commit 64a7ce76fb90 ("libfs: fix infinite directory reads
for offset dir") introduced a fence in offset_iterate_dir() to stop
the loop from returning child entries created after the directory
was opened. This comparison relies on the strong ordering of
DIR_OFFSET_MIN <= largest child offset <= next_offset to terminate
the directory iteration.

However, because simple_offset_add() uses mtree_alloc_cyclic() to
select each next new directory offset, ctx->next_offset is not
always the highest unused offset. Once mtree_alloc_cyclic() allows
a new offset value to wrap, ctx->next_offset will be set to a value
less than the actual largest child offset.

The result is that readdir(3) no longer shows any entries in the
directory because their offsets are above ctx->next_offset, which is
now a small value. This situation is persistent, and the directory
cannot be removed unless all current children are already known and
can be explicitly removed by name first.

In the current Maple tree implementation, there is no practical way
that 63-bit offset values can ever wrap, so this issue is cleverly
avoided. But the ordering dependency is not documented via comments
or code, making the mechanism somewhat brittle. And it makes the
continued use of mtree_alloc_cyclic() somewhat confusing.

Further, if commit 64a7ce76fb90 ("libfs: fix infinite directory
reads for offset dir") were to be backported to a kernel that still
uses xarray to manage simple directory offsets, the directory offset
value range is limited to 32-bits, which is small enough to allow a
wrap after a few weeks of constant creation of entries in one
directory.

Therefore, replace the use of ctx->next_offset for fencing new
children from appearing in readdir results.

A jiffies timestamp marks the end of each opendir epoch. Entries
created after this timestamp will not be visible to the file
descriptor. I chose jiffies so that the dentry->d_time field can be
re-used for storing the entry creation time.

The new mechanism has its own corner cases. For instance, I think
if jiffies wraps twice while a directory is open, some children
might become invisible. On 32-bit systems, the jiffies value wraps
every 49 days. Double-wrapping is not a risk on systems with 64-bit
jiffies. Unlike with the next_offset-based mechanism, re-opening the
directory will make invisible children re-appear.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Closes: https://lore.kernel.org/stable/20241111005242.34654-1-cel@kernel.org/T/#m1c448e5bd4aae3632a09468affcfe1d1594c6a59
Fixes: 64a7ce76fb90 ("libfs: fix infinite directory reads for offset dir")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index bf67954b525b..862a603fd454 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -294,6 +294,7 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 		return ret;
 
 	offset_set(dentry, offset);
+	WRITE_ONCE(dentry->d_time, jiffies);
 	return 0;
 }
 
@@ -454,9 +455,7 @@ void simple_offset_destroy(struct offset_ctx *octx)
 
 static int offset_dir_open(struct inode *inode, struct file *file)
 {
-	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
-
-	file->private_data = (void *)ctx->next_offset;
+	file->private_data = (void *)jiffies;
 	return 0;
 }
 
@@ -473,9 +472,6 @@ static int offset_dir_open(struct inode *inode, struct file *file)
  */
 static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 {
-	struct inode *inode = file->f_inode;
-	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
-
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
@@ -490,7 +486,8 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 
 	/* In this case, ->private_data is protected by f_pos_lock */
 	if (!offset)
-		file->private_data = (void *)ctx->next_offset;
+		/* Make newer child entries visible */
+		file->private_data = (void *)jiffies;
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
@@ -521,7 +518,8 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
+static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx,
+			       unsigned long fence)
 {
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
@@ -531,14 +529,15 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
 		if (!dentry)
 			return;
 
-		if (dentry2offset(dentry) >= last_index) {
-			dput(dentry);
-			return;
-		}
-
-		if (!offset_dir_emit(ctx, dentry)) {
-			dput(dentry);
-			return;
+		/*
+		 * Output only child entries created during or before
+		 * the current opendir epoch.
+		 */
+		if (time_before_eq(dentry->d_time, fence)) {
+			if (!offset_dir_emit(ctx, dentry)) {
+				dput(dentry);
+				return;
+			}
 		}
 
 		ctx->pos = dentry2offset(dentry) + 1;
@@ -569,15 +568,14 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
  */
 static int offset_readdir(struct file *file, struct dir_context *ctx)
 {
+	unsigned long fence = (unsigned long)file->private_data;
 	struct dentry *dir = file->f_path.dentry;
-	long last_index = (long)file->private_data;
 
 	lockdep_assert_held(&d_inode(dir)->i_rwsem);
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-
-	offset_iterate_dir(d_inode(dir), ctx, last_index);
+	offset_iterate_dir(d_inode(dir), ctx, fence);
 	return 0;
 }
 
-- 
2.47.0


