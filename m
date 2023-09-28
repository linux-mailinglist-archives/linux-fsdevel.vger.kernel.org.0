Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06187B19C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjI1LFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjI1LEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD50CCE;
        Thu, 28 Sep 2023 04:04:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28129C433CC;
        Thu, 28 Sep 2023 11:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899085;
        bh=0dmRPya3lrFlUXe2DLjSdq1n3kPcC+fqGa64ivtV6xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k673oIYNz2jENTBcISeNoaRbLpgxnUW+0VJmClnsLgtaL9y5ql1V+OFhuYIv9YIbc
         s4QvBZbu+M7BMigZ2hOQx+r85c3RImDaACEXv1Gv25cLyA8LMPrKarBAfdiwRImank
         T3RDmuHCZ4wNxsYMbQPj3wWnHuF+RxMbJ8XPWylCJYTQXEFOnBkLY4TpBXHreLSB/1
         s2L56TJopgBZQPZsMrCh7wVJ6wP4nmtaz3jLfIapvSFomUVZAW0yX3gdk8zhMfkEUi
         teu8K5HDMgEKMGynK1MtL26EtmeQwtCp82DmjcvBo81wHjuj6OgfK0Kjai961qRnJm
         1bCNCvp860aDA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 29/87] fs/efivarfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:38 -0400
Message-ID: <20230928110413.33032-28-jlayton@kernel.org>
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
 fs/efivarfs/file.c  | 2 +-
 fs/efivarfs/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 59b52718a3a2..7e9961639802 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -51,7 +51,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		inode_unlock(inode);
 	}
 
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index db9231f0e77b..76dd3c7295d9 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -25,7 +25,7 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inode->i_flags = is_removable ? 0 : S_IMMUTABLE;
 		switch (mode & S_IFMT) {
 		case S_IFREG:
-- 
2.41.0

