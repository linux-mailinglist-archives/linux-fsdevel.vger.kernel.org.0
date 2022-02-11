Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3D64B1E74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 07:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbiBKGN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 01:13:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345022AbiBKGNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:13:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBD45F41;
        Thu, 10 Feb 2022 22:13:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4B2561888;
        Fri, 11 Feb 2022 06:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B7CC340F1;
        Fri, 11 Feb 2022 06:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644560009;
        bh=Ow7M7vV1AuHp/+RVwqkUIet6a1LA8gAucAt2mq8+dcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGnqMaSJGnHjoh0tERg9EpNILB/3ExPEM3iLlMu3SSTegfM3Hm1nCjvCZD7KuXt0G
         +HJzU9YVZswDiCPsycbMB135i2tuEIjmnUA2Uod31uR+9pJS5LpdJLS/2eHWMhR8yf
         PWbHYz+EE2qHWEFVpGmh8y9tWfQv9pC28bTXNE0sUxMK9wckw2JkKrSp9/74Dk9DPb
         upM9ljgCO8LUoAE3QQZQ2jC4zXZCany1C5tNCagMqJS0Vbl2R1f1cDJUIuu1AuCOW2
         NrKgp1GqnECUvhBKeH3phzzhbvbXAKmhMjeGNdXDmwjHfqRw4vGSKo3QwW+OHrDZYm
         MsLIgQ7lRgOWQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/7] f2fs: support STATX_IOALIGN
Date:   Thu, 10 Feb 2022 22:11:58 -0800
Message-Id: <20220211061158.227688-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211061158.227688-1-ebiggers@kernel.org>
References: <20220211061158.227688-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support for STATX_IOALIGN to f2fs, so that I/O alignment information
is exposed to userspace in a consistent and easy-to-use way.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9cc985258f17e..334d363a7b8c5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -835,6 +835,21 @@ static bool f2fs_force_buffered_io(struct inode *inode)
 	return false;
 }
 
+/* Return the maximum value of io_opt across all the filesystem's devices. */
+static unsigned int f2fs_max_io_opt(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int io_opt = 0;
+	int i;
+
+	if (!f2fs_is_multi_device(sbi))
+		return bdev_io_opt(sbi->sb->s_bdev);
+
+	for (i = 0; i < sbi->s_ndevs; i++)
+		io_opt = max(io_opt, bdev_io_opt(FDEV(i).bdev));
+	return io_opt;
+}
+
 int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
@@ -851,6 +866,22 @@ int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		stat->btime.tv_nsec = fi->i_crtime.tv_nsec;
 	}
 
+	/*
+	 * Return the I/O alignment information if requested.  We only return
+	 * this information when requested, since on encrypted files it might
+	 * take a fair bit of work to get if the file wasn't opened recently.
+	 */
+	if ((request_mask & STATX_IOALIGN) && S_ISREG(inode->i_mode)) {
+		unsigned int bsize = i_blocksize(inode);
+
+		stat->result_mask |= STATX_IOALIGN;
+		if (!f2fs_force_buffered_io(inode)) {
+			stat->mem_align_dio = bsize;
+			stat->offset_align_dio = bsize;
+		}
+		stat->offset_align_optimal = max(f2fs_max_io_opt(inode), bsize);
+	}
+
 	flags = fi->i_flags;
 	if (flags & F2FS_COMPR_FL)
 		stat->attributes |= STATX_ATTR_COMPRESSED;
-- 
2.35.1

