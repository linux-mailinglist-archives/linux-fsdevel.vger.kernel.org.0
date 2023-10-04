Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13707B8D2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbjJDS7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244981AbjJDS5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:57:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7940E1BD3;
        Wed,  4 Oct 2023 11:55:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4E8C433CA;
        Wed,  4 Oct 2023 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445710;
        bh=BarXufvXf2ktRprPzHNppo1XnC87rUiWSkDLJs3wtgM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IqCYdL/2Q7DHU2a6kZiAksUSC9udosFiIVjxa30pfzz/qefKqWnNKFN7yC73cWQ8s
         o2qBSzPNCObrNxI6QRI9cKDzAhDbRw8liTQt1dtwYXtt/25MjvBDLo9HEbBrQIEOt3
         Z04vuAf2WgSLf69zxOE0GeFzuFqHgfjUdqDztel4bBWucbUfjxYhkVHadRC8TA5Pth
         hPifYve2XAt/F8gNd5KZ9y1Yt8M4/gymedNq2NBW5nyCmsPIWRf0vBFNW6EbLK2l/i
         VJzAFNMWw9jRiB80vOVW5SjUeYa/aIlPoq3DG3CqQp5JLXc+LnTV/VmiEZfAloz+pU
         jFUe3evo8bvGQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 70/89] squashfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:55 -0400
Message-ID: <20231004185347.80880-68-jlayton@kernel.org>
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
 fs/squashfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index c6e626b00546..aa3411354e66 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -59,9 +59,9 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 	i_uid_write(inode, i_uid);
 	i_gid_write(inode, i_gid);
 	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
-	inode->i_mtime.tv_sec = le32_to_cpu(sqsh_ino->mtime);
-	inode->i_atime.tv_sec = inode->i_mtime.tv_sec;
-	inode_set_ctime(inode, inode->i_mtime.tv_sec, 0);
+	inode_set_mtime(inode, le32_to_cpu(sqsh_ino->mtime), 0);
+	inode_set_atime(inode, inode_get_mtime_sec(inode), 0);
+	inode_set_ctime(inode, inode_get_mtime_sec(inode), 0);
 	inode->i_mode = le16_to_cpu(sqsh_ino->mode);
 	inode->i_size = 0;
 
-- 
2.41.0

