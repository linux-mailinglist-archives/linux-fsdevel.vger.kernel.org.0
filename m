Return-Path: <linux-fsdevel+bounces-14594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D75C87DE83
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E41B21233
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB472033E;
	Sun, 17 Mar 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+gnZfy7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FB1DFCB;
	Sun, 17 Mar 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692870; cv=none; b=JffoTxjubDua9tXYVTRH3YYT8bXcXdok4fT024iPpaXuNHmov0c1BTZTrZVbKJ3Npc56TyG9uoU+Q9ctSfwNeWGQAmx2cJ9MeGuHcWWOBcEnW4p6hYJ5z8dLnttxcILwiJk2vI/midZsdMMqsG51/sTcNGcSLmbDlVVsOT8GisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692870; c=relaxed/simple;
	bh=BKMI6UCt/jv/2gfwrIZH16FTO2HTxLbioRJjZsYziBU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dr36W1z2Sq75R70g2l9c+Uepu96EalpOBocdkqPS2aXF0DQY5F+h3NMyqw6X1CTf9J7mKfdkMdfeg61iAu9OdV4+eAbggY2FLoWHGgaTUZfPJDyfmOEmvngfk7ipMa/e7w6fI+ttGD3L0/xuhxAOG8YroqE34GXbV409tCWSvZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+gnZfy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D85C433F1;
	Sun, 17 Mar 2024 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692870;
	bh=BKMI6UCt/jv/2gfwrIZH16FTO2HTxLbioRJjZsYziBU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g+gnZfy7Bmsi7lEUku9rd2iqJqyP+dCAFd/JI0Vu6/1nOuO9YJChkNQhCOBicmnx2
	 i+opRODLDdwHb/OGaweRkQuFnU/0L9L0Z6715SeDPmjwn6PYvr3bdUfyGtI4gXE1L1
	 dv7MDFH/AlaL21JQuN2w5cjGbl3o03MjPS3qyorKKFnMepp8fhp2dj40VKdGnFi8po
	 9W4xgBocDh4Eyto1RCvk6lNzQgEE9j6DRvtd5J7GBOGFNmq3E9+PBaHSrIjhM+GjtT
	 PiLud0DDGwDpbfGWChouhAKj7IrD3KhO8dF3JLlCR59LVvX5WxYsO5m/RVVup3ibkv
	 7urJ8YohQFXwQ==
Date: Sun, 17 Mar 2024 09:27:49 -0700
Subject: [PATCH 17/40] fsverity: report validation errors back to the
 filesystem
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246186.2684506.3303872607648084354.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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
index 494225f60608..0782e94bc818 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -255,6 +255,15 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
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
@@ -277,8 +286,11 @@ verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
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
index da23f1e30151..57df509295f4 100644
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


