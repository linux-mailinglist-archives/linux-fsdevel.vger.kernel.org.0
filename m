Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952BC7B1A29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjI1LJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjI1LI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:08:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE39010D1;
        Thu, 28 Sep 2023 04:05:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B18DC433C9;
        Thu, 28 Sep 2023 11:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899127;
        bh=MT2Y7jp9+cvD5+2+GZOJovkkdQ1vUxTXJ+WNXDpkssE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L6g7E9W5Wtf3sqq8MD4rNpai/DU4TGsfv+ZA0Gnic6dFv6AsgeU0n4XkxkjeH4yBx
         iXQbtQZSTDM7LxQsx3YZU+cxnfUBsGvNM6fSlGuv6iQwgYXTfuhIsQLG0wB9xoPd0F
         XaaS1vW5Ux35ohpisjM6NfsG4JgccyU/+l0N6zkcpyNCq4GxAwGw/+4VYpDuAysp1m
         hNiKCosd8okbWpAbYqYvlSOlInyKwX20WmgGwo6kGQ+X6CfskjSSEFnWob+kAxa7/B
         raouoilCgoUcyACGOf8gxxiqJA7oaCTnoYfPyN5cFIiovjQofdSLcfe2m90iBCloqx
         hpqkpFIy8ogwQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 62/87] fs/qnx4: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:11 -0400
Message-ID: <20230928110413.33032-61-jlayton@kernel.org>
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
 fs/qnx4/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index a7171f5532a1..6eb9bb369b57 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -301,10 +301,8 @@ struct inode *qnx4_iget(struct super_block *sb, unsigned long ino)
 	i_gid_write(inode, (gid_t)le16_to_cpu(raw_inode->di_gid));
 	set_nlink(inode, le16_to_cpu(raw_inode->di_nlink));
 	inode->i_size    = le32_to_cpu(raw_inode->di_size);
-	inode->i_mtime.tv_sec   = le32_to_cpu(raw_inode->di_mtime);
-	inode->i_mtime.tv_nsec = 0;
-	inode->i_atime.tv_sec   = le32_to_cpu(raw_inode->di_atime);
-	inode->i_atime.tv_nsec = 0;
+	inode_set_mtime(inode, le32_to_cpu(raw_inode->di_mtime), 0);
+	inode_set_atime(inode, le32_to_cpu(raw_inode->di_atime), 0);
 	inode_set_ctime(inode, le32_to_cpu(raw_inode->di_ctime), 0);
 	inode->i_blocks  = le32_to_cpu(raw_inode->di_first_xtnt.xtnt_size);
 
-- 
2.41.0

