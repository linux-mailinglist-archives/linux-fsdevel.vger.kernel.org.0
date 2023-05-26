Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF24711C98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjEZB2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjEZB2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB511125;
        Thu, 25 May 2023 18:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4086D60C2B;
        Fri, 26 May 2023 01:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B9DC433EF;
        Fri, 26 May 2023 01:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685064512;
        bh=yBEVPklg/o7H3DOnN+gXOPTcjM79wse51B6G8fFBW1A=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=u3asWdDXiNsT40FaLIPlin+KYf/a5FGzWeMb4u+1uXwdxdGTkhH2D9zy1NKhe0Od9
         Qk8JU/GSNdUpubQqeJ6+mSjWU6GUhYk0YDxix+tn+5cxuvm0buPDnFfJb2sg70t6np
         SEWUI+piqdxeEiYGE466Qsvr1abV1Sm3QhWVFarWnL/rSYU63WMA6zPhweWfYmtNFx
         fm1VKB2WGe7KpnaELHMFb2/FKw4Jdim4Tg5VXu2Lcn5PiiGH7Jfs6tbNiBJI41USbt
         h+NLONMQCG4vihv0D3is4tXOUtXNwF9rPq3w0J3gfb9UhCN02IC5P5XxUh2zN4w/0f
         RYqHmBq3XFWrg==
Date:   Thu, 25 May 2023 18:28:32 -0700
Subject: [PATCH 25/25] xfs: enable atomic swapext feature
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065342.3734442.13833496775459775436.stgit@frogsfrogsfrogs>
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

Add the atomic swapext feature to the set of features that we will
permit.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index bb8bff488017..0c457905cce5 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -393,7 +393,8 @@ xfs_sb_has_incompat_feature(
 #define XFS_SB_FEAT_INCOMPAT_LOG_XATTRS   (1 << 0)	/* Delayed Attributes */
 #define XFS_SB_FEAT_INCOMPAT_LOG_SWAPEXT  (1U << 31)	/* file extent swap */
 #define XFS_SB_FEAT_INCOMPAT_LOG_ALL \
-	(XFS_SB_FEAT_INCOMPAT_LOG_XATTRS)
+		(XFS_SB_FEAT_INCOMPAT_LOG_XATTRS | \
+		 XFS_SB_FEAT_INCOMPAT_LOG_SWAPEXT)
 #define XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN	~XFS_SB_FEAT_INCOMPAT_LOG_ALL
 static inline bool
 xfs_sb_has_incompat_log_feature(

