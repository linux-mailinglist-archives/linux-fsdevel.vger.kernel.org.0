Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D91708028
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 13:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjERLsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjERLr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 07:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E98B9;
        Thu, 18 May 2023 04:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DC6A64ED2;
        Thu, 18 May 2023 11:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F80EC433AA;
        Thu, 18 May 2023 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684410474;
        bh=+ZM+liB0nOC40xQZQZ86xt6fi25JWXDh676GI1IVOtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQnkqGwCCO7vGJ/Yl4qfYfKxifiKbMPWX2nYexu/UCvc1oIUUfQVuW6udPdzJ1m4k
         rWMY0fCaeAJOQI+qqhPBhxIV7gfUu9Ylg2eSEobnGKZW88ySXBwsucmW1y8Y+nFlfR
         6tVEWNilLHOCnTpp/KdfqHoVSXvdllBWDnVe9kNrF2FvgYteYmwPND+Z+1pY9ZmQ2e
         iyCImFsXgFxeUDph74sSt9m0qYQnTUhLuWqAY/TFIwQnnTp/OT8BBkqPnjwa96LF+q
         MqMJYD6fBTddkIFRXAdvcgr6RmUENlMzwsFZYCbPjxDR9haBrGDkiCc3Hs4jGSiG4s
         1NqFQlisf4yPQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 3/9] overlayfs: allow it to handle multigrain timestamps
Date:   Thu, 18 May 2023 07:47:36 -0400
Message-Id: <20230518114742.128950-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518114742.128950-1-jlayton@kernel.org>
References: <20230518114742.128950-1-jlayton@kernel.org>
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

Ensure that we strip off the I_CTIME_QUERIED bit when copying up.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/overlayfs/file.c | 7 +++++--
 fs/overlayfs/util.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7c04f033aadd..cad715df8c4e 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -222,6 +222,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 static void ovl_file_accessed(struct file *file)
 {
 	struct inode *inode, *upperinode;
+	struct timespec64 ctime, uctime;
 
 	if (file->f_flags & O_NOATIME)
 		return;
@@ -232,10 +233,12 @@ static void ovl_file_accessed(struct file *file)
 	if (!upperinode)
 		return;
 
+	ctime = ctime_peek(inode);
+	uctime = ctime_peek(upperinode);
 	if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
-	     !timespec64_equal(&inode->i_ctime, &upperinode->i_ctime))) {
+	     !timespec64_equal(&ctime, &uctime))) {
 		inode->i_mtime = upperinode->i_mtime;
-		inode->i_ctime = upperinode->i_ctime;
+		inode->i_ctime = uctime;
 	}
 
 	touch_atime(&file->f_path);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 923d66d131c1..f4f9d7e189ef 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1117,6 +1117,6 @@ void ovl_copyattr(struct inode *inode)
 	inode->i_mode = realinode->i_mode;
 	inode->i_atime = realinode->i_atime;
 	inode->i_mtime = realinode->i_mtime;
-	inode->i_ctime = realinode->i_ctime;
+	inode->i_ctime = ctime_peek(realinode);
 	i_size_write(inode, i_size_read(realinode));
 }
-- 
2.40.1

