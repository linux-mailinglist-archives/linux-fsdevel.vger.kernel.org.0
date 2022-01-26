Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7D49C121
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiAZCSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiAZCSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:18:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E16CC061744;
        Tue, 25 Jan 2022 18:18:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7400F615D5;
        Wed, 26 Jan 2022 02:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED1DC340E7;
        Wed, 26 Jan 2022 02:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163500;
        bh=nnlHlZQnmG5CM2nTGpDI2cjXIXEAd+9UzR3UB9PzNPY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kXa8Y9KBFuNFsTMEwSveAQIZK15UIwACTFYC53A4r9u8hek9DQqOghyY1gbHNI1AM
         4Eu3AxEFLQzP7yS8+m0GYMTzp6/EkLd00d6/gsIv4VUTdEPF/KxFzokcSBY970Zjom
         khEQl5zLuV9uYPn6nYHU7BpcBOdphYnkAK360r+wkKkwF00efMI1tVpfYsj+L+w52f
         EwelhjC3OkI51PWurzJd5fjTUMO9m0Q5SeYBMC/F6Uc/9CYBdZ44nhn3rwm5KHOTLh
         RG+1eLqikfEp9zd+h5VGUvxeKB7FyQqZpZIY6RGOPNOkJfQy0+HrBphBA0c/q/eJN9
         w6AvMFdbVDfWw==
Subject: [PATCH 2/4] vfs: make sync_filesystem return errors from ->sync_fs
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Date:   Tue, 25 Jan 2022 18:18:20 -0800
Message-ID: <164316350055.2600168.13687764982467881652.stgit@magnolia>
In-Reply-To: <164316348940.2600168.17153575889519271710.stgit@magnolia>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Strangely, sync_filesystem ignores the return code from the ->sync_fs
call, which means that syscalls like syncfs(2) never see the error.
This doesn't seem right, so fix that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/sync.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)


diff --git a/fs/sync.c b/fs/sync.c
index 3ce8e2137f31..c7690016453e 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -29,7 +29,7 @@
  */
 int sync_filesystem(struct super_block *sb)
 {
-	int ret;
+	int ret = 0;
 
 	/*
 	 * We need to be protected against the filesystem going from
@@ -52,15 +52,21 @@ int sync_filesystem(struct super_block *sb)
 	 * at a time.
 	 */
 	writeback_inodes_sb(sb, WB_REASON_SYNC);
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, 0);
+	if (sb->s_op->sync_fs) {
+		ret = sb->s_op->sync_fs(sb, 0);
+		if (ret)
+			return ret;
+	}
 	ret = sync_blockdev_nowait(sb->s_bdev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	sync_inodes_sb(sb);
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, 1);
+	if (sb->s_op->sync_fs) {
+		ret = sb->s_op->sync_fs(sb, 1);
+		if (ret)
+			return ret;
+	}
 	return sync_blockdev(sb->s_bdev);
 }
 EXPORT_SYMBOL(sync_filesystem);

