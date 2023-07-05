Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7F748CCC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjGETEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjGETDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A31989;
        Wed,  5 Jul 2023 12:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E553616EC;
        Wed,  5 Jul 2023 19:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5696FC433CA;
        Wed,  5 Jul 2023 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583807;
        bh=KWaqWqc/38Kzci3VQKWkRcd53CVOEuWovP0o19vIoz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WclbXEIC0F2OWeE3/SIvdzxd4Nct3v3+p/ewdhScqQHUiwA8kX38+2hiHQfoI8Kot
         JYAt41YVG5MshRIFOO1EnB67og4b0wfiWgj2rllg0DAdw9AFN+7Heqf+Q6Clg5O7gJ
         jT+9Z4YvmD9VM12ARs/oQWuKCZf9NicyhSkkHqMW5OakqQEJXdErLml+629OSIlBOb
         OlxNTnkYvBfaBB7BQAHf/CoSjf5xPk4deAmP4JYnykwrRAbnf0VSz208Zury3GcS5c
         oezB2tGru9AuPutoCjn0dLEGkg/3Ub54Ypx2O2zFdMc7IjSyWgz0P+zx0oZio7cKdD
         XU17wdH9xrQUQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH v2 14/92] reiserfs: convert to simple_rename_timestamp
Date:   Wed,  5 Jul 2023 15:00:39 -0400
Message-ID: <20230705190309.579783-12-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/reiserfs/namei.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 52240cc891cf..405ac59eb2dd 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1325,7 +1325,6 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 	int jbegin_count;
 	umode_t old_inode_mode;
 	unsigned long savelink = 1;
-	struct timespec64 ctime;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
@@ -1576,14 +1575,11 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 
 	mark_de_hidden(old_de.de_deh + old_de.de_entry_num);
 	journal_mark_dirty(&th, old_de.de_bh);
-	ctime = current_time(old_dir);
-	old_dir->i_ctime = old_dir->i_mtime = ctime;
-	new_dir->i_ctime = new_dir->i_mtime = ctime;
 	/*
 	 * thanks to Alex Adriaanse <alex_a@caltech.edu> for patch
 	 * which adds ctime update of renamed object
 	 */
-	old_inode->i_ctime = ctime;
+	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 
 	if (new_dentry_inode) {
 		/* adjust link number of the victim */
@@ -1592,7 +1588,6 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 		} else {
 			drop_nlink(new_dentry_inode);
 		}
-		new_dentry_inode->i_ctime = ctime;
 		savelink = new_dentry_inode->i_nlink;
 	}
 
-- 
2.41.0

