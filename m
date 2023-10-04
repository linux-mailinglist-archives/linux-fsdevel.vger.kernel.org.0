Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C001A7B8BB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbjJDSyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244555AbjJDSyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17931B9;
        Wed,  4 Oct 2023 11:53:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1834BC433C8;
        Wed,  4 Oct 2023 18:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445638;
        bh=hZN4D2LR8rX2IepRw2s44AxIsoHnPwI3Eb9y8mHRkJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JK4zl64wCK8ykXQg8vk5HEV4//9DGnJiz4Zp1YPsTgutEakWwDZZjpgtjlglhi+0i
         aGd8qlG4Zlck0WAKGtWNAb75q6Rx4QHd2gQie0CJhKt75QakBFc4o134l4iHIAIdtX
         m2MIvlxVBWL05psdjdNXW4oCKSHk/e6YPyqLsI1aJYlpf7RsXVPOonE+r07QEn6kyK
         mTgI12qEMGsIjp9yXe11amt060B8Uho9nntQcpkoym7wE1Z/+9IxdhRCXVLQ4dba8r
         hP0zbvBAeolWi2tpnL8AKRhRRdYjyeSeuz1moemQ0fRhFZZxXlaXtZ11xuZe3fAWJ/
         F8dCeU0U/iHyg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org
Subject: [PATCH v2 11/89] tty: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:56 -0400
Message-ID: <20231004185347.80880-9-jlayton@kernel.org>
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
 drivers/tty/tty_io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8a94e5a43c6d..d13d2f2e76c7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -818,7 +818,7 @@ static void tty_update_time(struct tty_struct *tty, bool mtime)
 	spin_lock(&tty->files_lock);
 	list_for_each_entry(priv, &tty->tty_files, list) {
 		struct inode *inode = file_inode(priv->file);
-		struct timespec64 *time = mtime ? &inode->i_mtime : &inode->i_atime;
+		struct timespec64 time = mtime ? inode_get_mtime(inode) : inode_get_atime(inode);
 
 		/*
 		 * We only care if the two values differ in anything other than the
@@ -826,8 +826,12 @@ static void tty_update_time(struct tty_struct *tty, bool mtime)
 		 * the time of the tty device, otherwise it could be construded as a
 		 * security leak to let userspace know the exact timing of the tty.
 		 */
-		if ((sec ^ time->tv_sec) & ~7)
-			time->tv_sec = sec;
+		if ((sec ^ time.tv_sec) & ~7) {
+			if (mtime)
+				inode_set_mtime(inode, sec, 0);
+			else
+				inode_set_atime(inode, sec, 0);
+		}
 	}
 	spin_unlock(&tty->files_lock);
 }
-- 
2.41.0

