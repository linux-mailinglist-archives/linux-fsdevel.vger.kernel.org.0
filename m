Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC93711C54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjEZBQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjEZBQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:16:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDC3195;
        Thu, 25 May 2023 18:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3A3864C27;
        Fri, 26 May 2023 01:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B103C433A7;
        Fri, 26 May 2023 01:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063778;
        bh=oksK0c9Y5uBbK6nvVj2fF/WR6GEZyDdNc2H/MJBASuk=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=R7VM1ut5tzglvgEF6VCv/4L11h+LgTf8HGSXQngKeIz2KLocYfBTNDsT5OPkcevvw
         L1LeTYMP7lgY2uWDngEJ/5dp0H1sHGdc+56W/Ao5yK+vq9rABt9qZYk0ZkU64iFSV3
         vJ6AQUfSsoC1NUt6Q+GNq+p3A2IRWbBq1QIWfJ1X7ohX2+J2RXhjBfVfDF5+wn1IXE
         RWLKdMwyaH4Zu2oJOGWpoV4P0oeR1dlNXTStH9ZGHvDfxKDEtMQ83kbSULbb+xjKVw
         6rWkhfL+P3zqEPhgujNdHpZ0Y4mw1sVUhBWf8YmxaiL6cajkRBCc0xr7f7hPXgZ7kN
         pHhHUYFXX3rNQ==
Date:   Thu, 25 May 2023 18:16:17 -0700
Subject: [PATCH 07/25] xfs: refactor non-power-of-two alignment checks
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065080.3734442.8577992154372637102.stgit@frogsfrogsfrogs>
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

Create a helper function that can compute if a 64-bit number is an
integer multiple of a 32-bit number, where the 32-bit number is not
required to be an even power of two.  This is needed for some new code
for the realtime device, where we can set 37k allocation units and then
have to remap them.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  |   12 +++---------
 fs/xfs/xfs_linux.h |    5 +++++
 2 files changed, 8 insertions(+), 9 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 31eca20c854a..3f23dc4e07ae 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -47,15 +47,9 @@ xfs_is_falloc_aligned(
 {
 	unsigned int		alloc_unit = xfs_inode_alloc_unitsize(ip);
 
-	if (XFS_IS_REALTIME_INODE(ip) && !is_power_of_2(alloc_unit)) {
-		u32	mod;
-
-		div_u64_rem(pos, alloc_unit, &mod);
-		if (mod)
-			return false;
-		div_u64_rem(len, alloc_unit, &mod);
-		return mod == 0;
-	}
+	if (XFS_IS_REALTIME_INODE(ip) && !is_power_of_2(alloc_unit))
+		return isaligned_64(pos, alloc_unit) &&
+		       isaligned_64(len, alloc_unit);
 
 	return !((pos | len) & (alloc_unit - 1));
 }
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 09f727f712fe..b8c61b48cb51 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -199,6 +199,11 @@ static inline uint64_t howmany_64(uint64_t x, uint32_t y)
 	return x;
 }
 
+static inline bool isaligned_64(uint64_t x, uint32_t y)
+{
+	return do_div(x, y) == 0;
+}
+
 int xfs_rw_bdev(struct block_device *bdev, sector_t sector, unsigned int count,
 		char *data, enum req_op op);
 

