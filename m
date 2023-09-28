Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED37B19A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjI1LFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjI1LEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67410CA;
        Thu, 28 Sep 2023 04:04:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46A2C433C9;
        Thu, 28 Sep 2023 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899068;
        bh=slu/w5rI+KXxDY+5fpzzCTL3L8BN0xD+uN4a6hp53rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GI7swmbVibd1tjnpl/jAkDP9LmrrY1nhy3unkOrf0gYEvrV9e9PCt3H2+UCFavHjE
         U2ynj3iONb40+fZ5mpQ4FOwKUOcLuP02UXSoHignubFnOPEscgNc43+oxi3Avi7a/E
         yGSuUbxkLF99cgYAQdsuIahGPKcofVDZPrISq886MwofoYoXcFTDsaY0FsRWqOnwjA
         i8hFXvoUv70ngcew2yEjJ7BB/7ZcF4SHKXF4qMKUwRcNUEUMYQRQqRzorxu5he45Ru
         61F7zWbFo9C5MNYOujXCAz427YNK1L1L/liwrSvDDgx3h0grwXE0mKxcIHYZrCYWDN
         yCZyYBzSzQmMQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 14/87] drivers/usb/gadget/legacy: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:23 -0400
Message-ID: <20230928110413.33032-13-jlayton@kernel.org>
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
 drivers/usb/gadget/legacy/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index ce9e31f3d26b..cdc0926100fd 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1969,7 +1969,7 @@ gadgetfs_make_inode (struct super_block *sb,
 		inode->i_mode = mode;
 		inode->i_uid = make_kuid(&init_user_ns, default_uid);
 		inode->i_gid = make_kgid(&init_user_ns, default_gid);
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inode->i_private = data;
 		inode->i_fop = fops;
 	}
-- 
2.41.0

