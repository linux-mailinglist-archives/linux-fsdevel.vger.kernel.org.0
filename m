Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB0A7B1A39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjI1LKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjI1LJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:09:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8D2695;
        Thu, 28 Sep 2023 04:05:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FBBC43395;
        Thu, 28 Sep 2023 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899135;
        bh=GSs8K8rj3xzkDUaqDpXTyJe0zo505hLTnO0gJr9PIPk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mtj0L/ZJ/qzHWjTrc9MXWSJfQ9JrpD7MdhmTRu0lO/CCc5iGSY5LayaO3flGWTqY/
         2Sba3ihZLTVgQwniR6UcDadWcCUwm0Knx4zMHy7jG/1SI2x/ae/o5itr5/mWFiPxer
         dC6UKJwyo5EZrDjOWN+oLXuU8YNGCg2Tq6+/cS2t/J8YunoTtNu36i2iUBLsaOVIZV
         EZS56zJud6xC2eoJ2xmtLlnX6QJ3OJZ0bp076zFHpKAjD0d+dqrzM4EgTrQv31Evr6
         mWFGkbz7mGVQwATSHC2/HVaICTDYcLXyh5rFk9kU4BsaqfReJMN4cc2QpDYZmbUDOP
         pibSUN6122c3g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 69/87] fs/squashfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:18 -0400
Message-ID: <20230928110413.33032-68-jlayton@kernel.org>
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
 fs/squashfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index c6e626b00546..5e3c38eaca2c 100644
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
+	inode_set_atime(inode, inode_get_mtime(inode).tv_sec, 0);
+	inode_set_ctime(inode, inode_get_mtime(inode).tv_sec, 0);
 	inode->i_mode = le16_to_cpu(sqsh_ino->mode);
 	inode->i_size = 0;
 
-- 
2.41.0

