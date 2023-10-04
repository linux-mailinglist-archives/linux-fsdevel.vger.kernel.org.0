Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4C57B8BBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244695AbjJDSyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244702AbjJDSy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EE719AE;
        Wed,  4 Oct 2023 11:53:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A720C433C8;
        Wed,  4 Oct 2023 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445630;
        bh=jwS/maqXmK0T9pimsNUUGNYN+WZVE+M+UfX5KqHyk1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpOrlZpJSqLuel0lQLPdPOTonwy+6VYYeFt7ydcVpG1CIXwDVqnK+ehXtyCLiMCEZ
         yRkFAtkLQEsTSW03T3wkPVqxur3jAWS/jyFvFtjeDZLHBqclPwF2TZX5z/a3UJX4xE
         GLOnUHAsfRrrBXxBqJZAJyJVcmIAZ4fm5D4aNqZuhNlfma7i/PYYGBrXTpPyMq8JDk
         xSBGV87ATL/NvkViy2Gq+kan4g9EoU4SSrjUQkbfF+fe/+6Zy08T4r+Ezk8GjA7VQ2
         MHYKWZcZ3yhbV8oMAxhPvPsiv2QRAQW03aI6yG3zS/EoNb51/p8m07NX82dKE2yQea
         EeMuB2M49THEg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 03/89] spufs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:48 -0400
Message-ID: <20231004185347.80880-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185221.80802-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
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

