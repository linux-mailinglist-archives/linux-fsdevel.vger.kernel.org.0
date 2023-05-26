Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81816711C47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjEZBPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjEZBPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F38C194;
        Thu, 25 May 2023 18:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B383E64AFA;
        Fri, 26 May 2023 01:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A046C433EF;
        Fri, 26 May 2023 01:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063731;
        bh=Q7XpztbDZTCPqwcV5ZMUllJPcLOTiZDONz8F6l4AzDs=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=Ahj9gqkpRzF3T80ROvECarxAP0+R7u52r4y21P5+qDqJ4Yfc+yc64nnGCNk3wR2Pt
         fC9HYBHc5lcTsE7IdOly8PVqYnRdoZLuMvPk9mvkE7bzBD+S+C4zApcgtOvOco4H0l
         WZxMmseV5ajqzMMeFTK3aM+MgO3B5hbCYMw03ttGouvpEc0zeLK1PKpyDCRhW8Ov7o
         Sxl3eq+UTM2u4B5K1M57twzkk82NpTwG24n5jX8H6Ta3k8WtTN4BEjHxNqS2gSMj+D
         qcCNH4pj1Vh+XHKcPHrVqslQ5p7NMXUA5P7wvBg0jAJOSV7shstL/tLRYS2VKIDdL8
         bjO3PV+6Dx2oA==
Date:   Thu, 25 May 2023 18:15:30 -0700
Subject: [PATCH 04/25] xfs: move xfs_iops.c declarations out of xfs_inode.h
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065036.3734442.11286868946019821694.stgit@frogsfrogsfrogs>
In-Reply-To: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
References: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Similarly, move declarations of public symbols of xfs_iops.c from
xfs_inode.h to xfs_iops.h.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_inode.h |    5 -----
 fs/xfs/xfs_iops.h  |    4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index de77bc053681..fd12509560e4 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -540,11 +540,6 @@ int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
-/* from xfs_iops.c */
-extern void xfs_setup_inode(struct xfs_inode *ip);
-extern void xfs_setup_iops(struct xfs_inode *ip);
-extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
-
 /*
  * When setting up a newly allocated inode, we need to call
  * xfs_finish_inode_setup() once the inode is fully instantiated at
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 7f84a0843b24..8a38c3e2ed0e 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,4 +19,8 @@ int xfs_vn_setattr_size(struct mnt_idmap *idmap,
 int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 		const struct qstr *qstr);
 
+extern void xfs_setup_inode(struct xfs_inode *ip);
+extern void xfs_setup_iops(struct xfs_inode *ip);
+extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+
 #endif /* __XFS_IOPS_H__ */

