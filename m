Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187A6711C64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjEZBRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjEZBRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D00D8;
        Thu, 25 May 2023 18:17:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 453E564C28;
        Fri, 26 May 2023 01:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EF5C433EF;
        Fri, 26 May 2023 01:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063856;
        bh=E36jUGCApd/U0WfGcZmj11kf51+yw1h25/Myy9ahPVo=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=AL84Rb3b1voeyiMo/ajbjz/xs0Cfi5gCzM7vyx21oeg5nuUrq/arC9NR5FKa26kVj
         vCE6bNdH/2wChNWxPQyjr+nxbBZ5FjAZdwsGxzOgJfcoh4atzELz11mOx9q9auj2Xs
         i+DxfI7N5i3bUJuiwl54NyBZt0XfSNt3xFUBp6Ss9jA8L3Z0Bhih8Cnmv7f8aPjn2h
         E2qi7Md95HgftWj345gXLHgjQz5x4utVO/GkHYVYaAJavSlmBrMOsrtx4DKmrATgCY
         Mwei1CaYJy/Pz3BGUtO2j5ZmUPugMqgIQdTunwkQ05U2gjNgbez+gt12ISgYKCnatv
         oFRBjaEi4TtlA==
Date:   Thu, 25 May 2023 18:17:36 -0700
Subject: [PATCH 12/25] xfs: enable xlog users to toggle atomic extent swapping
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065154.3734442.781167557519571183.stgit@frogsfrogsfrogs>
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

