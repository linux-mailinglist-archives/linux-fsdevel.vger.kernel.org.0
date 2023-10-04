Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E63C7B8C81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbjJDS6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245094AbjJDS43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:56:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF31988;
        Wed,  4 Oct 2023 11:54:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09775C4166B;
        Wed,  4 Oct 2023 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445698;
        bh=YMmryZmmNEItRm2e+RTUeAshmJNZg8hKfFS2ryfvqkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hWYms5tBg7anp0uW84zt4o+EXEhIMFJDachX7wmqUsqsl24Yxew0DEMfDQSf22Sue
         9YSh7c632k6ZCA3mQqeCsf6O8gNH2s/rskd6dpZRUB8kCGUW223XotwbsA4YKtUzj4
         dJhwGAZi58NRfYKQWpqFUBccPn3Shz8urlrISuovGklJA62gHCWkcT6knYlVPJhNUy
         1EcET826gGXKwkG0pTwZqse/ssgLNpzBakDb6em5V8mpF7nlDu8/WVZO0IKT2SZjYh
         b5kL47oWXd1dDNWv/jeQSOp9j7v6jMjRB9kSQTwc0WSUdq6/KwLcYxcUYEJf/oglBw
         kVEWbnnZVaj2A==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH v2 60/89] overlayfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:45 -0400
Message-ID: <20231004185347.80880-58-jlayton@kernel.org>
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
 fs/overlayfs/file.c  | 9 ++++++---
 fs/overlayfs/inode.c | 3 ++-
 fs/overlayfs/util.c  | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index acdd79dd4bfa..131621daeb13 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -250,6 +250,7 @@ static void ovl_file_accessed(struct file *file)
 {
 	struct inode *inode, *upperinode;
 	struct timespec64 ctime, uctime;
+	struct timespec64 mtime, umtime;
 
 	if (file->f_flags & O_NOATIME)
 		return;
@@ -262,9 +263,11 @@ static void ovl_file_accessed(struct file *file)
 
 	ctime = inode_get_ctime(inode);
 	uctime = inode_get_ctime(upperinode);
-	if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
-	     !timespec64_equal(&ctime, &uctime))) {
-		inode->i_mtime = upperinode->i_mtime;
+	mtime = inode_get_mtime(inode);
+	umtime = inode_get_mtime(upperinode);
+	if ((!timespec64_equal(&mtime, &umtime)) ||
+	     !timespec64_equal(&ctime, &uctime)) {
+		inode_set_mtime_to_ts(inode, inode_get_mtime(upperinode));
 		inode_set_ctime_to_ts(inode, uctime);
 	}
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 8adc27e5e451..345b8f161ca4 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -579,7 +579,8 @@ int ovl_update_time(struct inode *inode, int flags)
 
 		if (upperpath.dentry) {
 			touch_atime(&upperpath);
-			inode->i_atime = d_inode(upperpath.dentry)->i_atime;
+			inode_set_atime_to_ts(inode,
+					      inode_get_atime(d_inode(upperpath.dentry)));
 		}
 	}
 	return 0;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index a44eec80dc82..73ac47b49218 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1509,8 +1509,8 @@ void ovl_copyattr(struct inode *inode)
 	inode->i_uid = vfsuid_into_kuid(vfsuid);
 	inode->i_gid = vfsgid_into_kgid(vfsgid);
 	inode->i_mode = realinode->i_mode;
-	inode->i_atime = realinode->i_atime;
-	inode->i_mtime = realinode->i_mtime;
+	inode_set_atime_to_ts(inode, inode_get_atime(realinode));
+	inode_set_mtime_to_ts(inode, inode_get_mtime(realinode));
 	inode_set_ctime_to_ts(inode, inode_get_ctime(realinode));
 	i_size_write(inode, i_size_read(realinode));
 	spin_unlock(&inode->i_lock);
-- 
2.41.0

