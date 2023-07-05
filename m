Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDDA748CB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjGETDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjGETDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EFC1985;
        Wed,  5 Jul 2023 12:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E845616EF;
        Wed,  5 Jul 2023 19:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED71C433C8;
        Wed,  5 Jul 2023 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583795;
        bh=C29zaLc0+YewpaXSEH0HW42gKnjE7YUcBZ4P7Z6b8Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwjgVC7Cbh9HQG2vDydlZGjLCZkcX1Ds3CLZ61K/xriTZaI/1UBNBiDzxP+g/dIZB
         Z1b9xp3sy523k6IzA0saIP3vpzd2L1B4S325qj1QrjG92VPEgqhl6mxOiyELZ2DqM8
         OREJCtRhqTLktGuNCrpzYO/VV2b9RmtMCTbA6+UzGIMzOwW9Iel67mauV7xvmtiGiM
         McJ3467i8G17Xwv2uQ1SP2RdJGHk3OTuiK55GkB144F4uQV8kGRbZme9vY+WHZ6hww
         9lU1DH4+FoNn400oj2U5B9F2VN6u9FxOY28tE9cjuCXHgVDa4fPKe/PQZDbGfgcPfh
         GlYx1XFDP2Qog==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/92] exfat: ensure that ctime is updated whenever the mtime is
Date:   Wed,  5 Jul 2023 15:00:31 -0400
Message-ID: <20230705190309.579783-4-jlayton@kernel.org>
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

When removing entries from a directory, the ctime must also be updated
alongside the mtime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/exfat/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e0ff9d156f6f..d9b46fa36bff 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -817,7 +817,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	ei->dir.dir = DIR_DELETED;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = dir->i_atime = current_time(dir);
+	dir->i_mtime = dir->i_atime = dir->i_ctime = current_time(dir);
 	exfat_truncate_atime(&dir->i_atime);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
@@ -825,7 +825,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 		mark_inode_dirty(dir);
 
 	clear_nlink(inode);
-	inode->i_mtime = inode->i_atime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	exfat_truncate_atime(&inode->i_atime);
 	exfat_unhash_inode(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
@@ -979,7 +979,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	ei->dir.dir = DIR_DELETED;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = dir->i_atime = current_time(dir);
+	dir->i_mtime = dir->i_atime = dir->i_ctime = current_time(dir);
 	exfat_truncate_atime(&dir->i_atime);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
@@ -988,7 +988,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	drop_nlink(dir);
 
 	clear_nlink(inode);
-	inode->i_mtime = inode->i_atime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	exfat_truncate_atime(&inode->i_atime);
 	exfat_unhash_inode(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
-- 
2.41.0

