Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F617B1988
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjI1LEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjI1LEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4772FCF0;
        Thu, 28 Sep 2023 04:04:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EAEC433C8;
        Thu, 28 Sep 2023 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899060;
        bh=p3gaIy18L6Ez/8RFoleMZQ9oJz9uAXoW5EHVT1EV0+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qi1QD7te6ipGJErObR0mgV/ZUuN6Cezsxu4FFi0wzpOdAfpIsp0V8wZOO3vofB1Mp
         X7umPRbV/U8IF4TMDv0T/8AX/QF2lEmTBdnYMDDSPyWYu7QU2RAj/ND+6Qmt/mW18T
         lZpB2p2ZUf7SJcjuPGQRzrgnz3j5O9SJfSSJsDnk3cqpcinLDThSLgxJV+HMjdlbvD
         EQ89HSB22rugBcz3xhb9XJOUG/hx9j9pxKbCcE0Ve80ZTZCjCad8EY42AD4IXQxDCs
         fCj4BWMRB/6tOO7/UhvtMziJdLTTX9UVLKBtFb6RHW13MYBw4NqvGqNs3bXuUSXLKE
         Y0ESkwlGhr1aQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 07/87] drivers/infiniband/hw/qib: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:16 -0400
Message-ID: <20230928110413.33032-6-jlayton@kernel.org>
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
 drivers/infiniband/hw/qib/qib_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index ed7d4b02f45a..455e966eeff3 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -64,8 +64,8 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 	inode->i_uid = GLOBAL_ROOT_UID;
 	inode->i_gid = GLOBAL_ROOT_GID;
 	inode->i_blocks = 0;
-	inode->i_atime = inode_set_ctime_current(inode);
-	inode->i_mtime = inode->i_atime;
+	simple_inode_init_ts(inode);
+	
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
 		inode->i_op = &simple_dir_inode_operations;
-- 
2.41.0

