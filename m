Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0677B1A33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjI1LKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjI1LJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:09:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73967212B;
        Thu, 28 Sep 2023 04:05:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC26C43391;
        Thu, 28 Sep 2023 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899131;
        bh=zVtZIifGPxJTqvfBSth/QiVBDUFp/kv30UuF+2f2ZAU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lmlkk7drKwVLRoZsRFrMeORT8Twqn+uCMlk8R7fhZ1YEJ62CT+3a2dlYbPTJTi+Bi
         bl0fJyL647QZBCPOGDvDefy6pNK5+av+mHgk7n5YXoWqt2iDkiZygvT2TliGfKmM7q
         TjqFFaniLkn2W/fKZZvbR0JtdVmkPl+lEHyZMU+ApaR2leQCQAIZzx0BWE31VVNmyp
         DzHxlczPRUoz1NPa9JoiJ8nbIDTVZT1ljmH/DAFVqX37WOgWpJqW9IIWtaWE1oFGCW
         csYEL1QNtrvBMVyf8fKVe917y6DSFiuK1DyS//P6rJbqybpPGPW4jq6L6VQ5UiqPAg
         jaUiJmcGHyVtw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 66/87] fs/romfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:15 -0400
Message-ID: <20230928110413.33032-65-jlayton@kernel.org>
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
 fs/romfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 5c35f6c76037..c09d81b548e4 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -322,7 +322,8 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 
 	set_nlink(i, 1);		/* Hard to decide.. */
 	i->i_size = be32_to_cpu(ri.size);
-	i->i_mtime = i->i_atime = inode_set_ctime(i, 0, 0);
+	inode_set_mtime_to_ts(i,
+			      inode_set_atime_to_ts(i, inode_set_ctime(i, 0, 0)));
 
 	/* set up mode and ops */
 	mode = romfs_modemap[nextfh & ROMFH_TYPE];
-- 
2.41.0

