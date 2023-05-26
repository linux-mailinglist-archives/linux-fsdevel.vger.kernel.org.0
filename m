Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23F5711C50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjEZBQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjEZBQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53306D8;
        Thu, 25 May 2023 18:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3F5064C27;
        Fri, 26 May 2023 01:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4123FC4339E;
        Fri, 26 May 2023 01:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063762;
        bh=zauCMft3J4n4mJidYMXGzg4HVZY2Q0eOfgDdwUYd3Yo=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=Z4xjI88pWzZSRe3PwddquAOTuc7wshax1ACtafWDNtH6e0aYfPwCdPTn0SyIWsxiH
         HmsWkq9bCqpzMjA2Z0uKYCi3EnyLwboaKP4IjeYBszBpPDPLw9jcoPlNVaCAb3VyHg
         wAfUM4N8GfnW3abDyqihj67+cN9TfiVvC165HnIkeIwPvNhaa13+c8Lr5xiI97c+1V
         BkOa7hXEx/DsytzWARKgH3PbjUyLQuBTaGwfavTL35Hrsm37UUVDxrIA0IQSc+JB+E
         64OJ75zjIah6vm5GHr693uVo4h+NBJLbGIq7Y8kns7oMxDtWkj3WdiHa0JBxi8fM8V
         aYUOhT7SbuFdg==
Date:   Thu, 25 May 2023 18:16:01 -0700
Subject: [PATCH 06/25] xfs: create a new helper to return a file's allocation
 unit
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065065.3734442.11052926763295429957.stgit@frogsfrogsfrogs>
In-Reply-To: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
References: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Create a new helper function to calculate the fundamental allocation
unit (i.e. the smallest unit of space we can allocate) of a file.
Things are going to get hairy with range-exchange on the realtime
device, so prepare for this now.

While we're at it, export xfs_is_falloc_aligned since the next patch
will need it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  |   28 ++++++++++------------------
 fs/xfs/xfs_file.h  |    3 +++
 fs/xfs/xfs_inode.c |   13 +++++++++++++
 fs/xfs/xfs_inode.h |    1 +
 4 files changed, 27 insertions(+), 18 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1844c22b2ccd..31eca20c854a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -39,33 +39,25 @@ static const struct vm_operations_struct xfs_file_vm_ops;
  * Decide if the given file range is aligned to the size of the fundamental
  * allocation unit for the file.
  */
-static bool
+bool
 xfs_is_falloc_aligned(
 	struct xfs_inode	*ip,
 	loff_t			pos,
 	long long int		len)
 {
-	struct xfs_mount	*mp = ip->i_mount;
-	uint64_t		mask;
+	unsigned int		alloc_unit = xfs_inode_alloc_unitsize(ip);
 
-	if (XFS_IS_REALTIME_INODE(ip)) {
-		if (!is_power_of_2(mp->m_sb.sb_rextsize)) {
-			u64	rextbytes;
-			u32	mod;
+	if (XFS_IS_REALTIME_INODE(ip) && !is_power_of_2(alloc_unit)) {
+		u32	mod;
 
-			rextbytes = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
-			div_u64_rem(pos, rextbytes, &mod);
-			if (mod)
-				return false;
-			div_u64_rem(len, rextbytes, &mod);
-			return mod == 0;
-		}
-		mask = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize) - 1;
-	} else {
-		mask = mp->m_sb.sb_blocksize - 1;
+		div_u64_rem(pos, alloc_unit, &mod);
+		if (mod)
+			return false;
+		div_u64_rem(len, alloc_unit, &mod);
+		return mod == 0;
 	}
 
-	return !((pos | len) & mask);
+	return !((pos | len) & (alloc_unit - 1));
 }
 
 /*
diff --git a/fs/xfs/xfs_file.h b/fs/xfs/xfs_file.h
index 7d39e3eca56d..2ad91f755caf 100644
--- a/fs/xfs/xfs_file.h
+++ b/fs/xfs/xfs_file.h
@@ -9,4 +9,7 @@
 extern const struct file_operations xfs_file_operations;
 extern const struct file_operations xfs_dir_file_operations;
 
+bool xfs_is_falloc_aligned(struct xfs_inode *ip, loff_t pos,
+		long long int len);
+
 #endif /* __XFS_FILE_H__ */
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index f63d0d20098c..6389df4fb30e 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3761,3 +3761,16 @@ xfs_break_layouts(
 
 	return error;
 }
+
+/* Returns the size of fundamental allocation unit for a file, in bytes. */
+unsigned int
+xfs_inode_alloc_unitsize(
+	struct xfs_inode	*ip)
+{
+	unsigned int		blocks = 1;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		blocks = ip->i_mount->m_sb.sb_rextsize;
+
+	return XFS_FSB_TO_B(ip->i_mount, blocks);
+}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index fd12509560e4..1c037455fe47 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -577,6 +577,7 @@ void xfs_iunlock2_io_mmap(struct xfs_inode *ip1, struct xfs_inode *ip2);
 
 void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
+unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
 
 struct xfs_dir_update_params {
 	const struct xfs_inode	*dp;

