Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63C748D67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjGETK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjGETIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08571BC5;
        Wed,  5 Jul 2023 12:05:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99209616C4;
        Wed,  5 Jul 2023 19:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B17C433C7;
        Wed,  5 Jul 2023 19:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583936;
        bh=hA94f6wyhm1dscTfqscmBzMcM3Ka33XMmF4YRR7LFAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs5vb9BC62hWj2fkEaoviFSqLfo2N8woX+4CHRNL6DGgiWkzkXKb/HlarndUpvCaK
         7aQYIkHFVUZjqXOeVmRrEJmNhiMo3KJRw25Xh7nsmNIMcVPrprEBBIAb1w35+Jf6Bx
         kkNUTezh4p78c/yPAaRaLT4W929h5r2fCcbTfNEsypPhg2aFqSCBI3N6Z1kx0NMoaA
         xSIYm0+cja1oYkzX8uiHuZd7vBCuOs3Y1zcf/ymo8gTicuCGegflAMz0PjIAb90J2w
         ojVHqPAl1fw8MPx3zhlLe21rP3ZV3vKwtlQRF3k562RheM6p4etqDVGbL5scbioS44
         n4lOmlZWLZOOg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 84/92] linux: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:49 -0400
Message-ID: <20230705190309.579783-82-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/fs_stack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
index 54210a42c30d..010d39d0dc1c 100644
--- a/include/linux/fs_stack.h
+++ b/include/linux/fs_stack.h
@@ -24,7 +24,7 @@ static inline void fsstack_copy_attr_times(struct inode *dest,
 {
 	dest->i_atime = src->i_atime;
 	dest->i_mtime = src->i_mtime;
-	dest->i_ctime = src->i_ctime;
+	inode_set_ctime_to_ts(dest, inode_get_ctime(src));
 }
 
 #endif /* _LINUX_FS_STACK_H */
-- 
2.41.0

