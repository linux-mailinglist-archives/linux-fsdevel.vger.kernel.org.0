Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB67B19EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjI1LHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjI1LFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:05:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9709210EB;
        Thu, 28 Sep 2023 04:04:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E0EC433BA;
        Thu, 28 Sep 2023 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899096;
        bh=KL3FQ3jpZEuK0Ewt0+ej83FFC76E2dh/iXYhCIu4n5w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BY7DmgdSg0T+ZpSlNxARM6JDMhM5D7IoMPX+GzyEbHOBEa/96E/62DMGJL3iRGmJ5
         M2d9Z2nNlAmP1AkA5k51OjmsF2nBbJihcIvvO4xajT8QbDoKkJGGXE0ewKi4apiUDs
         qJSF0pQNNXsOaOnoAp5fR9EMEulPv5bDGtKDmHhMfyrVkWXR+PvGYTV4JmvSa5y2dj
         tTZL79V4eW614t4GX4jh2isrokRRWaY3bVEaO182EKuZP8feqMRKLapZn/FI7xtefV
         VYKFCrfCqQdZgB8mIrv3BOJ08hSNGaXLL2eu9TPaw9XGDxNKO0scPmF03/Fz1thbPk
         2pIWXNAaJpEyg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 37/87] fs/freevxfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:46 -0400
Message-ID: <20230928110413.33032-36-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/freevxfs/vxfs_inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index ac5d43b164b5..20600e9ea202 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -109,11 +109,9 @@ static inline void dip2vip_cpy(struct vxfs_sb_info *sbi,
 	set_nlink(inode, vip->vii_nlink);
 	inode->i_size = vip->vii_size;
 
-	inode->i_atime.tv_sec = vip->vii_atime;
+	inode_set_atime(inode, vip->vii_atime, 0);
 	inode_set_ctime(inode, vip->vii_ctime, 0);
-	inode->i_mtime.tv_sec = vip->vii_mtime;
-	inode->i_atime.tv_nsec = 0;
-	inode->i_mtime.tv_nsec = 0;
+	inode_set_mtime(inode, vip->vii_mtime, 0);
 
 	inode->i_blocks = vip->vii_blocks;
 	inode->i_generation = vip->vii_gen;
-- 
2.41.0

