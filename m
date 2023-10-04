Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CFE7B8BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbjJDSyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244551AbjJDSyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45871AC;
        Wed,  4 Oct 2023 11:53:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA4DC433C9;
        Wed,  4 Oct 2023 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445636;
        bh=xycpCLpfZO5cWJqgRoaNPhUR3uWaHBiSqgCz6ZToHjc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OiAQYCLAzdDweMJ9wL+eTqCmdPkm6tseNh9Zfa6cWPbZem+bl0BLKgVyv6f/1ujMZ
         r4LTTHGRz6f2FD0GvaqKWaTt7/6DYP30eXLmBQZRziwld5Zhz8DuSWs3uCSipqttLy
         tsmkoJUQ8SvOS4/3pZghQMyoQRpmmnV94jN/vHRimdPY23LCMy+wKXrTYFbtL5FY6M
         ApJDt7gUTdBABgE9kyPdloigdsqhTcyRl//eplho8rF8dOew+GFRfugRH5wuxZFuNs
         dEr+NtSgTKC5eVIn4ntOkUo3MwLUM8ohQCSbGZHW/Av0ZMGpfqiQt7K4IXk22GoYrB
         VKyrdvKNfvuMg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/89] misc: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:54 -0400
Message-ID: <20231004185347.80880-7-jlayton@kernel.org>
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

