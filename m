Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9017B8BF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbjJDSyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244670AbjJDSyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A261BC6;
        Wed,  4 Oct 2023 11:53:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29917C433CD;
        Wed,  4 Oct 2023 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445639;
        bh=hJ13L6+0t085ntXpxQD42WXHyl1kwHHYbjDB4aBhDeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWNMv/15ARZhZhz2JIW4IT6BxNZIhAACW1IpWm0oA5a0Ku7/GgtXJemfhpVudk59l
         5TX1yy/V28obFUalsAn2irlBZqK4IX+8M05sQiNWwaPmDE+RV7rjbYMGz3XTXZEW6g
         2rXQ/vgtA8cpZ4DgnSomxppCGHmNkZTfBnm/zpfy/0fghx4/xx4hPtJ3msfs437il7
         0N1S6+RtCDL5wMmnG4xbxq9Iyh4li4JUCRW2J8lbo4g1AKcXpSb3i7IuxlNGXFrhKo
         GargV9EdMqWGJ1gNyFpiopMdi/ljmC3utqxNumBMbn1wk7Tftp4WaISQiWgenC2xG1
         c4yMnckWz8Fjw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 12/89] function: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:57 -0400
Message-ID: <20231004185347.80880-10-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
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

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index af400d083777..efe3e3b85769 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1383,8 +1383,8 @@ ffs_sb_make_inode(struct super_block *sb, void *data,
 		inode->i_mode    = perms->mode;
 		inode->i_uid     = perms->uid;
 		inode->i_gid     = perms->gid;
-		inode->i_atime   = ts;
-		inode->i_mtime   = ts;
+		inode_set_atime_to_ts(inode, ts);
+		inode_set_mtime_to_ts(inode, ts);
 		inode->i_private = data;
 		if (fops)
 			inode->i_fop = fops;
-- 
2.41.0

