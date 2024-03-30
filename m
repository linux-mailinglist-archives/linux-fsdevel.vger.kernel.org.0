Return-Path: <linux-fsdevel+bounces-15713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A86892835
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317601F22309
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC37810E9;
	Sat, 30 Mar 2024 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+K6/RtW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46919197;
	Sat, 30 Mar 2024 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758933; cv=none; b=flAB58JPoH3txcXl/q/oAcP1RLiUcwlOEaaLw+8k6H/33lf2tJlYpTZTW9r3FP9+azk8mOf5LBgt+LFbWZc9MpZ2gUVHrXlZYjKUPqAufLmttvLfVvj1Rr1BbcbfHjIBuWFcZreoK65ywg8FsRK6r2D9m+UZ49tmP7lqIC967QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758933; c=relaxed/simple;
	bh=qBzKRn/XNF1X06PWW+d5grtgZ0sPQd5X+SRQ8zwwjKs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZWeIhTPe/l6/Ui62vMxkbOV2e74nR0Eo4xkEnmKjrItqdZUqLX/uoyhze4i7OhrLrZolXYMqaLwzI7MR6LWg6/IxSTJEmyepb4je80yffUc/TPWPUUsZgBuUXB1YGuoyX9K08e57S72FaXh33pZhnHb4Z9OYMBfjx/JlVqKnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+K6/RtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20365C433F1;
	Sat, 30 Mar 2024 00:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758933;
	bh=qBzKRn/XNF1X06PWW+d5grtgZ0sPQd5X+SRQ8zwwjKs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=M+K6/RtW1rmNXaWOFslmQE1IFBJEEZgekKJ3yOU+JpbiwlvcobmUfj9grEaqEW6KY
	 9Yfzc94dK/7Da9ACmXXql5fWI1XYhGRzoGef6LUe2lGd3+sYKj+9ah875lDAIcOXpG
	 gmJpJmVfRPS8qzpbhD31KF+dGuZdkYB5kfZtoneVH/t8S6+oJOKw2a5aVLc2SVJZMQ
	 IEYL7fRDx3XTYgh5d4DWhS5vkKkf1cFfsfeypRgxVC83LeEN3KVQjB3gd4AmDQAuwN
	 litnf1CTyBnBqkKH37BC+XmmpDpfswyllawmgWdCmzEDHvKr/oueohtUhaQg8i0ajf
	 Yo9nMU8A6AiPQ==
Date: Fri, 29 Mar 2024 17:35:32 -0700
Subject: [PATCH 11/13] fsverity: report validation errors back to the
 filesystem
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868048.1987804.2771715174385554090.stgit@frogsfrogsfrogs>
In-Reply-To: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Provide a new function call so that validation errors can be reported
back to the filesystem.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/verify.c       |   14 +++++++++++++-
 include/linux/fsverity.h |   11 +++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)


diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 99b1529bbb50b..4acfd02b0e42d 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -258,6 +258,15 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 	return false;
 }
 
+static void fsverity_fail_validation(struct inode *inode, loff_t pos,
+				     size_t len)
+{
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
+
+	if (vops->fail_validation)
+		vops->fail_validation(inode, pos, len);
+}
+
 static bool
 verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
 		   unsigned long max_ra_bytes)
@@ -280,8 +289,11 @@ verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
 		valid = verify_data_block(inode, vi, data, pos + offset,
 					  max_ra_bytes);
 		kunmap_local(data);
-		if (!valid)
+		if (!valid) {
+			fsverity_fail_validation(inode, pos + offset,
+						 block_size);
 			return false;
+		}
 		offset += block_size;
 		len -= block_size;
 	} while (len);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 761a0b76eefec..dcf9d9cffcb9f 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -236,6 +236,17 @@ struct fsverity_operations {
 	 * be implemented.
 	 */
 	void (*drop_merkle_tree_block)(struct fsverity_blockbuf *block);
+
+	/**
+	 * Notify the filesystem that file data validation failed
+	 *
+	 * @inode: the inode being validated
+	 * @pos: the file position of the invalid data
+	 * @len: the length of the invalid data
+	 *
+	 * This is called when fs-verity cannot validate the file contents.
+	 */
+	void (*fail_validation)(struct inode *inode, loff_t pos, size_t len);
 };
 
 #ifdef CONFIG_FS_VERITY


