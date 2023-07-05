Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F53B748D0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjGETGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGETFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D221226BC;
        Wed,  5 Jul 2023 12:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54733616F4;
        Wed,  5 Jul 2023 19:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CDDC433C8;
        Wed,  5 Jul 2023 19:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583838;
        bh=/ofqfygaQhpzuHURS13Tugz1rrEcdSJN70uEQLUNyc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMduXHxC5Ivtd2IdCY0O9tJt0hGMXyrwpA/yVvc3tBwz4FrCpQqps8SIc8rT43idR
         3CZxOOiiPUZZTQ55Lre6+YDrMbYGaTdP/w1SPPwGeVdhgSJcOJ8vSgYkzEtgN+EI++
         CBn+HM7Gga7HddiZmreoNPBfE8U/ureuwwaV/J9b1dkXvxRFTQulVcO6Uk36Iax5Bt
         DqYp3MGQ7PpEpiepHo8csmWql331rhDqHNFXLJgWOzbWAx40TFU1nz3gl9xDJbjxRV
         iiR/fZbIQpedK/hVCp6JWMk/GNsoz7nkluIKP1M/HQM3CDhApu6v7ebc3I2SND8eqI
         cjdLJCLjBdInQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        codalist@coda.cs.cmu.edu
Subject: [PATCH v2 31/92] coda: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:56 -0400
Message-ID: <20230705190309.579783-29-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
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

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/coda/coda_linux.c | 3 ++-
 fs/coda/dir.c        | 2 +-
 fs/coda/file.c       | 2 +-
 fs/coda/inode.c      | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index 903ca8fa4b9b..ae023853a98f 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -127,7 +127,8 @@ void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
 	if (attr->va_mtime.tv_sec != -1)
 		inode->i_mtime = coda_to_timespec64(attr->va_mtime);
         if (attr->va_ctime.tv_sec != -1)
-		inode->i_ctime = coda_to_timespec64(attr->va_ctime);
+		inode_set_ctime_to_ts(inode,
+				      coda_to_timespec64(attr->va_ctime));
 }
 
 
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 8450b1bd354b..1d4f40048efc 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -111,7 +111,7 @@ static inline void coda_dir_update_mtime(struct inode *dir)
 	/* optimistically we can also act as if our nose bleeds. The
 	 * granularity of the mtime is coarse anyways so we might actually be
 	 * right most of the time. Note: we only do this for directories. */
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 #endif
 }
 
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 12b26bd13564..42346618b4ed 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -84,7 +84,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
-	coda_inode->i_mtime = coda_inode->i_ctime = current_time(coda_inode);
+	coda_inode->i_mtime = inode_set_ctime_current(coda_inode);
 	inode_unlock(coda_inode);
 	file_end_write(host_file);
 
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index d661e6cf17ac..3e64679c1620 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -269,7 +269,7 @@ int coda_setattr(struct mnt_idmap *idmap, struct dentry *de,
 
 	memset(&vattr, 0, sizeof(vattr)); 
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	coda_iattr_to_vattr(iattr, &vattr);
 	vattr.va_type = C_VNON; /* cannot set type */
 
-- 
2.41.0

