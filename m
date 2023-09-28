Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DD07B1999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjI1LFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjI1LEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2C2CFC;
        Thu, 28 Sep 2023 04:04:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E37FC433C7;
        Thu, 28 Sep 2023 11:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899065;
        bh=cXvhQkkGpOgsc0ELKlchqmSPWWV4/XY2qNHuw52SmqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hdz1GGMD7Vkz1trWmZe+MAIrycsD6w+ykdbjJl/6qtBpgAOWCWWYLP0E5KCgjLLyN
         6F6GyR/ODAdFEaO5JLfy/5T2ugxoaQXBU8QZKMkrOnws+vYgO+mdSTvRW+1GweRS7G
         4f6BG2PzRVr0NamMXpGuUQWR9mh0UkecaEZyb2NP8YGjopQGKnPba0T612ARuYvF5R
         quDWh15wjMATCYdswtWOt7ChygA1/6S30LJaY2MSAnZSshTisF/jvz9hTrwpH0gKiC
         +v6pB8bOuOEwDn73gQ1XFqCJYho2w4WD1hAQhjrIicBHXYuyjIEMoR+1zy85k1XYyt
         /IpwnIC7DQl5w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org
Subject: [PATCH 11/87] drivers/tty: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:20 -0400
Message-ID: <20230928110413.33032-10-jlayton@kernel.org>
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

