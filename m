Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553527B8BBD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244770AbjJDSzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244763AbjJDSyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE691BD6;
        Wed,  4 Oct 2023 11:54:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6C6C433C7;
        Wed,  4 Oct 2023 18:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445655;
        bh=0hQGPDet/2ubMEAKVsIRGkoE0lOJhsfJjtVDXmuhn4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IB2pxtQayP6q4otNg40wSM94rdIZr6pYnoy1FqU/ilsb9JTGCOTvQ5wkzk40XR4Fn
         4aXwT8YNufv1TMSFSAgDzPpE1SLXSGn2/0Ua1KTGxK6StLhLN24uSCLexT+mn1BG9D
         QjpMrnXOiBnpiC4iU8zRe7L6IyaoKFJNg8nRZebEhjNSx30yv62fvTQ3CrnMxgEQ0v
         kk0S5D8MTKAMccWzpqnpdBdOJv42qbaL2e1cKUjvI8rUY0YVUUSTFmaiOiEuYiNNmD
         Si1S4u/duMJvTT87s3NT15BW14lHCfKMv7Zj9u+tSoXpZNtQKMgR6MowvPcaR1H+Zh
         eERgtcSUArcXg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     codalist@coda.cs.cmu.edu
Subject: [PATCH v2 25/89] coda: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:10 -0400
Message-ID: <20231004185347.80880-23-jlayton@kernel.org>
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

