Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E787E7B19B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjI1LFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjI1LEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29C91B1;
        Thu, 28 Sep 2023 04:04:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C54C433CA;
        Thu, 28 Sep 2023 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899080;
        bh=S4sRsE1wLpo3VwGf3CgTXlsPu1I64UUP5fmvH2GmK4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uX76QE0dms8j4qrF6jLKkDVrujBi+DNWy1Q4R4UH483aFhKDGtzgBRbFRqwrz7zDr
         MELI1/86CHOxbNGYhoQ7O+1ecd0i2equ2uXLZWxH++B11EOcjpVQyQx2UOv93XUeTS
         wIJSvSf5sp70VsbVWoRGL1+Mvnrb75kbpF/8ja9WlMEJ4DMZdjGTqJS1bhSSENsCgh
         vBMa73jZg2qUxKIJMfCLVNPoT/J4550mwj4RagMw2eL/Z6MVP0OzqCyCwfvcx0BlUT
         fVxb9bJklVSM6IyhttfpeVwLrgF2UJ6f5tiZqynSVmBlI3/soMzIfKb6O7uoqfewb3
         vp0EpHzJQiVLw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     codalist@coda.cs.cmu.edu
Subject: [PATCH 24/87] fs/coda: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:33 -0400
Message-ID: <20230928110413.33032-23-jlayton@kernel.org>
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
 fs/coda/coda_linux.c | 6 ++++--
 fs/coda/dir.c        | 2 +-
 fs/coda/file.c       | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index ae023853a98f..1d2dac95f86a 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -123,9 +123,11 @@ void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
 	if (attr->va_size != -1)
 		inode->i_blocks = (attr->va_size + 511) >> 9;
 	if (attr->va_atime.tv_sec != -1) 
-		inode->i_atime = coda_to_timespec64(attr->va_atime);
+		inode_set_atime_to_ts(inode,
+				      coda_to_timespec64(attr->va_atime));
 	if (attr->va_mtime.tv_sec != -1)
-		inode->i_mtime = coda_to_timespec64(attr->va_mtime);
+		inode_set_mtime_to_ts(inode,
+				      coda_to_timespec64(attr->va_mtime));
         if (attr->va_ctime.tv_sec != -1)
 		inode_set_ctime_to_ts(inode,
 				      coda_to_timespec64(attr->va_ctime));
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index cb512b10473b..4e552ba7bd43 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -111,7 +111,7 @@ static inline void coda_dir_update_mtime(struct inode *dir)
 	/* optimistically we can also act as if our nose bleeds. The
 	 * granularity of the mtime is coarse anyways so we might actually be
 	 * right most of the time. Note: we only do this for directories. */
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 #endif
 }
 
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 42346618b4ed..16acc58311ea 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -84,7 +84,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
-	coda_inode->i_mtime = inode_set_ctime_current(coda_inode);
+	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));
 	inode_unlock(coda_inode);
 	file_end_write(host_file);
 
-- 
2.41.0

