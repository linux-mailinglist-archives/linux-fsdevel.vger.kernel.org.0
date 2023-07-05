Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD8748CC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjGETDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjGETDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262EA1BC8;
        Wed,  5 Jul 2023 12:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9C3C616EE;
        Wed,  5 Jul 2023 19:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5FBC433C8;
        Wed,  5 Jul 2023 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583805;
        bh=J50IkY8hwE4QTdi0JMbfyXssVuP1VqMJJNGL0hjOLIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StuSvgMioLeO2MnU4FKLpR57Lq9joplYJ/hH+vDNtOQre9Z2gxqUVPf4nO7z3zuqP
         Sejb0izI8q7txVYTFwFQ2gcblCAas/UBidU3vMW/44Ahvb68XOP7WQts7Y29V5MFcU
         7CBQfeUGYUibnKvuI3WmZaI5AVxSbqLrXI4hmaJYfHNVCXbxXiH0LFbCQKdtSNgChI
         7XMQo2YOLiS1XfVbPoBjKz1S4ll5bj0+U4m+arMmGWMkbX2WZsxKY0Pw5wmmaDuhs8
         0ilLHK5yFYLOGERBrQWqD9v9VEHhqGW5fq1XyK83ge5awm0gY5s9nfh9DbP3jIWlfi
         Oqfz8Jt7zb4lQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/92] exfat: convert to simple_rename_timestamp
Date:   Wed,  5 Jul 2023 15:00:37 -0400
Message-ID: <20230705190309.579783-10-jlayton@kernel.org>
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

A rename potentially involves updating 4 different inode timestamps.
Convert to the new simple_rename_timestamp helper function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/exfat/namei.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index d9b46fa36bff..e91022ff80ef 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1312,8 +1312,8 @@ static int exfat_rename(struct mnt_idmap *idmap,
 		goto unlock;
 
 	inode_inc_iversion(new_dir);
-	new_dir->i_ctime = new_dir->i_mtime = new_dir->i_atime =
-		EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
+	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
+	EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
 	exfat_truncate_atime(&new_dir->i_atime);
 	if (IS_DIRSYNC(new_dir))
 		exfat_sync_inode(new_dir);
@@ -1336,7 +1336,6 @@ static int exfat_rename(struct mnt_idmap *idmap,
 	}
 
 	inode_inc_iversion(old_dir);
-	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
 	if (IS_DIRSYNC(old_dir))
 		exfat_sync_inode(old_dir);
 	else
-- 
2.41.0

