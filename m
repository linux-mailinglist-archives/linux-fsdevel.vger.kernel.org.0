Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20987B1AA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjI1LVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjI1LVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:21:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D8E30DF;
        Thu, 28 Sep 2023 04:05:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D268FC43395;
        Thu, 28 Sep 2023 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899150;
        bh=0P4fQQ7SkEsC3hdW3vPp6OWO9DCcnlz/5E+g/XegbtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EA8PS94M7lAThjFIrSWRW/phMmXb7E4FNcL+kYmUWn6cw7DLcdSW5/2gppPEEnfvA
         +JOVBlG+8UuxuMvUMkJ9MK//m7GaXZP3/jC+uhHT/RcGN+ZcNDI+llhl33R3odfpn9
         aTgjA6Q6g57eLFUVH9bkc7dprQP0CRmxZpW1dBhlyLbVfLTsjSSrmY3VEPtGsWPxv4
         WVxrjXhTRPigxRgC94P9mX/7RG52Z4zoJTLGsSrBPKZcvRb+uDAaI9itQf6LpqFd3D
         JjwpgpdE40vHp/XmjgG4t8InfS95vqShUoICMDUdjsVB5D5euNREctIgoEnT/ZDdxh
         h7QrD3HmWkEIA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 81/87] net/sunrpc: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:30 -0400
Message-ID: <20230928110413.33032-80-jlayton@kernel.org>
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
 net/sunrpc/rpc_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index f420d8457345..dcc2b4f49e77 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -472,7 +472,7 @@ rpc_get_inode(struct super_block *sb, umode_t mode)
 		return NULL;
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_fop = &simple_dir_operations;
-- 
2.41.0

