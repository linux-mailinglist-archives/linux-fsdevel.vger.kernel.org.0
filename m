Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6921B7B8BB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbjJDSzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244791AbjJDSyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A59A1BF5;
        Wed,  4 Oct 2023 11:54:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF999C433C7;
        Wed,  4 Oct 2023 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445661;
        bh=z2funOQvTD+nsh/eRCv4vA0TR68VHS1VOH+S/Cqeqoo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Yu7Jho/i94Dh+tD5G4TSUQIuySzOdLsquKYmzvv5YyW7+E8OHen8ClaA9MQbcvlBO
         a31Z32wcRiISih/yBaZwI2ivIrlnJw8WhjY/1mtskyHHwZKO/D2kDg0VIKQUip5pNd
         7IIXf6mHQ2JUpFO4inlk1ocOJ++28zE6iA655JBWe0cAVuteD5oV9PETvU1cB/Jlny
         tJ0gF0YsvIM4/vBSjiT17H1ZgBVf1momTCDiXeZjfDzXabqgtG8QKYWH7Zvyq2pnOT
         Ncamd/sJwLZn+QArTKOLijTPMYE8RI0TO3EFBvJRxZpzOdG0dMIjnQ7KiZn7/P7xpo
         C/Dwpkhj4KTrA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/89] efs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:16 -0400
Message-ID: <20231004185347.80880-29-jlayton@kernel.org>
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
 fs/efs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 3789d22ba501..7844ab24b813 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -103,10 +103,9 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	i_uid_write(inode, (uid_t)be16_to_cpu(efs_inode->di_uid));
 	i_gid_write(inode, (gid_t)be16_to_cpu(efs_inode->di_gid));
 	inode->i_size  = be32_to_cpu(efs_inode->di_size);
-	inode->i_atime.tv_sec = be32_to_cpu(efs_inode->di_atime);
-	inode->i_mtime.tv_sec = be32_to_cpu(efs_inode->di_mtime);
+	inode_set_atime(inode, be32_to_cpu(efs_inode->di_atime), 0);
+	inode_set_mtime(inode, be32_to_cpu(efs_inode->di_mtime), 0);
 	inode_set_ctime(inode, be32_to_cpu(efs_inode->di_ctime), 0);
-	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = 0;
 
 	/* this is the number of blocks in the file */
 	if (inode->i_size == 0) {
-- 
2.41.0

