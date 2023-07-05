Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6F748D7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjGETLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjGETKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C753420F;
        Wed,  5 Jul 2023 12:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30AFD616EF;
        Wed,  5 Jul 2023 19:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1288EC433C8;
        Wed,  5 Jul 2023 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583910;
        bh=eJBrCYXPAM78Uhl6doLO7xB75I+7r+A66Ah7b9xHMkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvia3rWYl7fjY2XB0bH6AfSyk9CRVvizR7DUFO3QDfVB/OELev3kS+UySXuyCgOKm
         9gjB+dQmRDKiUeiJ0HcCW5f1oITEauThib3xM1Jz6sVwKsFMtFBhB8Rq6hol0TbwdN
         QDJs4JZ8KV63yHxPOkk/MoH/jSjMOyPBMNRL3NkFv0Mml+1m+LNmiO52vWsxvU9IWi
         k3C5wmpuXIv1ZCzD5o5wKp/LMPRg6WDoro+yRg+m7hRcuX0Tm2anPLAIjaV0fBpe/q
         Wo6375tZJWxdReteCm315iI1jc21ldIJy/1V8TqSSQkehb72s8gfEknPTxbqYQUe0s
         vdDjswIWNAjrQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 70/92] qnx6: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:35 -0400
Message-ID: <20230705190309.579783-68-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 fs/qnx6/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 85b2fa3b211c..21f90d519f1a 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -562,8 +562,7 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_sec   = fs32_to_cpu(sbi, raw_inode->di_atime);
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_sec   = fs32_to_cpu(sbi, raw_inode->di_ctime);
-	inode->i_ctime.tv_nsec = 0;
+	inode_set_ctime(inode, fs32_to_cpu(sbi, raw_inode->di_ctime), 0);
 
 	/* calc blocks based on 512 byte blocksize */
 	inode->i_blocks = (inode->i_size + 511) >> 9;
-- 
2.41.0

