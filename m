Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E7659ED2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiL3XwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiL3XwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:52:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBFE1E3C1;
        Fri, 30 Dec 2022 15:52:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 592F460CF0;
        Fri, 30 Dec 2022 23:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BE6C433EF;
        Fri, 30 Dec 2022 23:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444333;
        bh=E36jUGCApd/U0WfGcZmj11kf51+yw1h25/Myy9ahPVo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pXGO+oJSU+PQuz3FMghAu7cuZ9kMGOAvlXNYoyHBAGoFfOU2v7ztjtR8cdBMli48p
         yRj/lfwhj/pElR9XqbRI5bPxhx3KWFDtE0VwBNbrfGAyHiY/4GdGC8hcRXB5LlcIVr
         eqH/NpYJg2l4JqBhRhbyC67tg8oV4aC2hRVIkO84/LrhOFj8QBJbWlXD3+uNVRi/fw
         ro8puXOpm+c1igxihyEPBxLVel0kBbv63G4Wj0X+ElMTImLoiPNlms0zrAI4PhCX/U
         lF7tRDZMXo9EniyEtEXmQlumz8zVp6yUpYToUYc2MI2i6b2ISz1V6b3t/6Js30AwG8
         VV/yYA1J2WiMw==
Subject: [PATCH 08/21] xfs: enable xlog users to toggle atomic extent swapping
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:56 -0800
Message-ID: <167243843639.699466.9221823995188278604.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Plumb the necessary bits into the xlog code so that higher level callers
can enable the atomic extent swapping feature and have it clear
automatically when possible.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_log.c      |   13 +++++++++++++
 fs/xfs/xfs_log.h      |    1 +
 fs/xfs/xfs_log_priv.h |    1 +
 3 files changed, 15 insertions(+)


diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index a0ef09addc84..37e85c1bb913 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1501,11 +1501,17 @@ xlog_clear_incompat(
 	if (down_write_trylock(&log->l_incompat_xattrs))
 		incompat_mask |= XFS_SB_FEAT_INCOMPAT_LOG_XATTRS;
 
+	if (down_write_trylock(&log->l_incompat_swapext))
+		incompat_mask |= XFS_SB_FEAT_INCOMPAT_LOG_SWAPEXT;
+
 	if (!incompat_mask)
 		return;
 
 	xfs_clear_incompat_log_features(mp, incompat_mask);
 
+	if (incompat_mask & XFS_SB_FEAT_INCOMPAT_LOG_SWAPEXT)
+		up_write(&log->l_incompat_swapext);
+
 	if (incompat_mask & XFS_SB_FEAT_INCOMPAT_LOG_XATTRS)
 		up_write(&log->l_incompat_xattrs);
 }
@@ -1625,6 +1631,7 @@ xlog_alloc_log(
 	log->l_sectBBsize = 1 << log2_size;
 
 	init_rwsem(&log->l_incompat_xattrs);
+	init_rwsem(&log->l_incompat_swapext);
 
 	xlog_get_iclog_buffer_size(mp, log);
 
@@ -3922,6 +3929,9 @@ xlog_use_incompat_feat(
 	case XLOG_INCOMPAT_FEAT_XATTRS:
 		down_read(&log->l_incompat_xattrs);
 		break;
+	case XLOG_INCOMPAT_FEAT_SWAPEXT:
+		down_read(&log->l_incompat_swapext);
+		break;
 	}
 }
 
@@ -3935,5 +3945,8 @@ xlog_drop_incompat_feat(
 	case XLOG_INCOMPAT_FEAT_XATTRS:
 		up_read(&log->l_incompat_xattrs);
 		break;
+	case XLOG_INCOMPAT_FEAT_SWAPEXT:
+		up_read(&log->l_incompat_swapext);
+		break;
 	}
 }
diff --git a/fs/xfs/xfs_log.h b/fs/xfs/xfs_log.h
index d187f6445909..30bdbf8ee25c 100644
--- a/fs/xfs/xfs_log.h
+++ b/fs/xfs/xfs_log.h
@@ -161,6 +161,7 @@ bool	  xlog_force_shutdown(struct xlog *log, uint32_t shutdown_flags);
 
 enum xlog_incompat_feat {
 	XLOG_INCOMPAT_FEAT_XATTRS = XFS_SB_FEAT_INCOMPAT_LOG_XATTRS,
+	XLOG_INCOMPAT_FEAT_SWAPEXT = XFS_SB_FEAT_INCOMPAT_LOG_SWAPEXT
 };
 
 void xlog_use_incompat_feat(struct xlog *log, enum xlog_incompat_feat what);
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index a13b5b6b744d..6cbee6996de5 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -448,6 +448,7 @@ struct xlog {
 
 	/* Users of log incompat features should take a read lock. */
 	struct rw_semaphore	l_incompat_xattrs;
+	struct rw_semaphore	l_incompat_swapext;
 };
 
 /*

