Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA77B1984
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjI1LEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjI1LES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D54CE3;
        Thu, 28 Sep 2023 04:04:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4F5C433C9;
        Thu, 28 Sep 2023 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899056;
        bh=vy4iAqS+2cdTey8A1Hl+Z+9oNsRq3NaJubtqW8MD3oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QtotdQ5VeXWt9qtlPLzJfVS978zsBoD95Vsr3Vwe3/bMBUfsDw7LIoVItXc4yuUui
         0qVKpaE8LAbipCamK4hwvmjgx+8OTbSajy6cy+Cb/UWvpUFqHhxDcjGopD9HYL9sEZ
         hP6gCGRPRf1rQWybWszN/Jaa5+//XTPoPeDe0c7hSOLw08DlfPAJZC+AOyoI3eCFlQ
         sqLESoWAUvzT8zYinaBp7EptGyIyiRmXptcmpIHirb4q1/8BDwNyy93KnnUV9LEAtG
         MiZBgYvA8J2zUuauvH+sD4dAU+Gap1cvQNcvbZYoM2uRbh292ukBO+PRtJ9GaOBEjP
         mvTBnCVYZthRA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/87] arch/powerpc/platforms/cell/spufs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:12 -0400
Message-ID: <20230928110413.33032-2-jlayton@kernel.org>
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
 arch/powerpc/platforms/cell/spufs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 38c5be34c895..10c1320adfd0 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -86,7 +86,7 @@ spufs_new_inode(struct super_block *sb, umode_t mode)
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 out:
 	return inode;
 }
-- 
2.41.0

