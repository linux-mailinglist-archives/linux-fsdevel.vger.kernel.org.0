Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9978E7B1990
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjI1LEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjI1LEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D06CF5;
        Thu, 28 Sep 2023 04:04:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D01CC433CD;
        Thu, 28 Sep 2023 11:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899061;
        bh=3ALQnVOlECoxdHtAC/FoUF2rGDdvF2VfrJ2fGjtK4Eo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OEaWy9rwkdDpoRIztwChRCTZrAEBrOEnWg89WwylxaBIO9kvN199Lm4Swvjrme7uG
         WjWBpyZXY1wLgWq79or7mK0GZ08aCkTAjMiGJZz2dxOGDJzOjv8lO5fzOvA5LL/tN2
         V54d0WWSmPyB+/PT+cy16Aj4W3p5uhVPeTAr8/ph6f7UEITATOL+EKwtQliLO4DGWp
         IGYZp1fq7rX4M/GV1XiOfqTwbW/7+bUaYv5+jmWJCL7Av2e4wpzVAqXxZu+TU7DxSi
         1ZZLOkBIC8yuzMTrQBnIpnGyP749mkPkWHJThdcLqToOdpSb+zfjQmoRigk/nVh9dP
         arV6TDYYVE2EA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/87] drivers/misc/ibmasm: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:17 -0400
Message-ID: <20230928110413.33032-7-jlayton@kernel.org>
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
 drivers/misc/ibmasm/ibmasmfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index 5867af9f592c..c44de892a61e 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -139,7 +139,7 @@ static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode)
 	if (ret) {
 		ret->i_ino = get_next_ino();
 		ret->i_mode = mode;
-		ret->i_atime = ret->i_mtime = inode_set_ctime_current(ret);
+		simple_inode_init_ts(ret);
 	}
 	return ret;
 }
-- 
2.41.0

