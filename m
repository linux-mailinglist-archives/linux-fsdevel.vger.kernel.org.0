Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90FD748CD9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjGETEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjGETDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFA61BF7;
        Wed,  5 Jul 2023 12:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D4C3616FD;
        Wed,  5 Jul 2023 19:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC70CC433C8;
        Wed,  5 Jul 2023 19:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583814;
        bh=6A3lu3ahskz2UGdWWxwneKyvoSkhQFQQk7TBbCz+qvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCSd+5QKML8sW8rjLkq9XeTy5nXs45Ctu9NoTqobRQRD1OMeaV6Ow2+c2Ak6U/QK7
         ffXfwds4368Anu88DDQOkEZgKotsaAxkiGsOHhTxKbOvdAGPDBccaRExq1OW8F0lFp
         W/E8V2ouLnR0R4qW/3y+3L1Bf/BdMV+0fobr+BmwdlG/3ZCkvGy4UOaQt4ALsWYY2K
         d52XxXkWGkzp54T9qZu3N/BJ3AZvDlF6B+zXs4D0RguvBzBaBII3+G6QNBVxmbESlW
         D6RGN1qSDcrMjI+xe9gniJZFuVT0ZVoddq5GP+Qtc4p9901XpHWbmOEk6Sa0Fqyz9b
         eDwxtj1HjVUHA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH v2 18/92] infiniband: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:43 -0400
Message-ID: <20230705190309.579783-16-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
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

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/infiniband/hw/qib/qib_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index a973905afd13..ed7d4b02f45a 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -64,9 +64,8 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 	inode->i_uid = GLOBAL_ROOT_UID;
 	inode->i_gid = GLOBAL_ROOT_GID;
 	inode->i_blocks = 0;
-	inode->i_atime = current_time(inode);
+	inode->i_atime = inode_set_ctime_current(inode);
 	inode->i_mtime = inode->i_atime;
-	inode->i_ctime = inode->i_atime;
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
 		inode->i_op = &simple_dir_inode_operations;
-- 
2.41.0

