Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0451D72C175
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 12:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbjFLK6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 06:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbjFLK5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820B127C4;
        Mon, 12 Jun 2023 03:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D3C562418;
        Mon, 12 Jun 2023 10:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF9EC4339B;
        Mon, 12 Jun 2023 10:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686566747;
        bh=KX7S7KoBIOHdIFvOtciMzqUF0ZVLgZ3kkDz1+nuzm5g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oz4WHLbO2jQN18Ove6Yj01Q8O4ys1wPwCmlNiLDNkmgWHI4GseN0zZLHEM92GYoGu
         boxFJi841L5bbyrUSD3RGup9DgX4l4qriaT0pGf+w6tErLMj+72DpzQ0vSvdMBFlbu
         KXSDAZv890DWx+cavMPVeGecLZIAIS0tENSJ08AMARyzUalS9uU1veHX9UzzI6FQoK
         GQ5IcM6JEkKLV02OZ7r4bZ+rjgcKQTK9aoJXpooAwIGA1rf40OBNSpEW02hvFu/dDK
         7SNhtVCZvEX/ybEeXtinwolY6QwBsyPmrCP8B9kIeImVk/kMoxXe8UPrCWqnyVaGqr
         GlER8Exgmr4Sg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suren Baghdasaryan <surenb@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 6/8] exfat: ensure that ctime is updated whenever the mtime is
Date:   Mon, 12 Jun 2023 06:45:22 -0400
Message-Id: <20230612104524.17058-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612104524.17058-1-jlayton@kernel.org>
References: <20230612104524.17058-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
2.40.1

