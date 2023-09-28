Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16127B1A2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjI1LJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjI1LJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:09:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9522108;
        Thu, 28 Sep 2023 04:05:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13902C433CB;
        Thu, 28 Sep 2023 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899128;
        bh=Qayin5SASKfJJl/xecNB8alrWi4t9sgg92O3QuynXjQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mEWU+BzSQ9FP50WtesqRRI9SFs/ICVSPtdBkd7skCB1gHgi4x53YQ3U+fxOA/962H
         lAnfKJdLRYTpiKWW8DHgiAx/4TeVZIiO8I/GqgC877LfmzOD+QYT9c5Ix7cWrTHHfo
         AmhpopEA3HonOtLBvMO4DkEjhhVrmnS/Abt/WZ/DBaxmsdFatC5PNpwbfkQQGExWCa
         1rCSWrE9K5K5grC3U1AMdHom58JjkUlIkH+MIMjnF5D6JvBa1CCOAoZmjmaIoc9U54
         Wachy2KwpoUq7Q850yP+F7UzTRZmw08xoLoJ5E3DbYtRRVu8gJKvFlDQPHiIMtZSBS
         kk15xoSf4yN/g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 63/87] fs/qnx6: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:12 -0400
Message-ID: <20230928110413.33032-62-jlayton@kernel.org>
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
 fs/qnx6/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 21f90d519f1a..a286c545717f 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -558,10 +558,8 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	i_uid_write(inode, (uid_t)fs32_to_cpu(sbi, raw_inode->di_uid));
 	i_gid_write(inode, (gid_t)fs32_to_cpu(sbi, raw_inode->di_gid));
 	inode->i_size    = fs64_to_cpu(sbi, raw_inode->di_size);
-	inode->i_mtime.tv_sec   = fs32_to_cpu(sbi, raw_inode->di_mtime);
-	inode->i_mtime.tv_nsec = 0;
-	inode->i_atime.tv_sec   = fs32_to_cpu(sbi, raw_inode->di_atime);
-	inode->i_atime.tv_nsec = 0;
+	inode_set_mtime(inode, fs32_to_cpu(sbi, raw_inode->di_mtime), 0);
+	inode_set_atime(inode, fs32_to_cpu(sbi, raw_inode->di_atime), 0);
 	inode_set_ctime(inode, fs32_to_cpu(sbi, raw_inode->di_ctime), 0);
 
 	/* calc blocks based on 512 byte blocksize */
-- 
2.41.0

