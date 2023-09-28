Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D267B198E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjI1LEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjI1LEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5EFCD6;
        Thu, 28 Sep 2023 04:04:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73054C433CA;
        Thu, 28 Sep 2023 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899062;
        bh=a+3ckfaB+PnX6AyXrn1j+tvzd0IksJ7KOkM6+jjc2gI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ACE6Sd1uOoavzEstAZ6ei/eXOLQaRjtHOww4ZsQEyD3MPwkxBZ9P2k6o/6RexIDWF
         n08t7TNpuHkE5cFSFKten4LZp9cRemyrytOSWofYEwiT2/uRaOTs5R7UtnEHd+gxbV
         Ul2UBzYh7AxnDz1e+BWGQXk+l4NvCcBl5WBBqsAc2kCwxRF5fIOa66aNUdLKQ6SnRN
         9hms3x5G1lCPNmKffC/No4vVPAN/7UXT/8Px3Gu+Msoxq/2vnieavXQruZ/YiS6d40
         Ck1MArK4nWmMosqP2SzhI9QzrVZDpu5wh/atRAsnTgJqwSSK/cHmF3CbQvsVVSsBL+
         Yk36i03pBwGaw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/87] drivers/misc: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:18 -0400
Message-ID: <20230928110413.33032-8-jlayton@kernel.org>
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
 drivers/misc/ibmvmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index 2101eb12bcba..7739b783c2db 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -1124,7 +1124,7 @@ static ssize_t ibmvmc_write(struct file *file, const char *buffer,
 		goto out;
 
 	inode = file_inode(file);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 
 	dev_dbg(adapter->dev, "write: file = 0x%lx, count = 0x%lx\n",
-- 
2.41.0

