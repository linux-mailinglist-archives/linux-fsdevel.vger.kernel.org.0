Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034FC748D78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjGETLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjGETK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173A13C33;
        Wed,  5 Jul 2023 12:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEAAF616F4;
        Wed,  5 Jul 2023 19:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BF4C433C9;
        Wed,  5 Jul 2023 19:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583909;
        bh=DuTLhiLcWxa1Ea4hA0KeA7+NSKJEpmgvrsdDl0+Eiao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6WF5VO2UF1eGXE4/XrP7NsTG5Xmz9ani0JItW5QC9PI1f6Gq+tWs88umqGvxtU1S
         mxAJz8ikSfaBY6nWlbPNwzFZba5npf6zlYdreW46SoOyDAqgfs1dfQeBQQu69QqwmK
         aToj8zIUTvW12z2rIQYeUVl3qcspYYgD859sIUKPbM2gLq2fk4ACehMIMRlMk0JgLx
         iWaTWDpabaBO+kCT42GzjKYhdq2SCezWszRVQJHXP9FAiEDEADJNuAFPeOprsDoo4b
         0BwZvVtXHmIcqfYF3T8xwwb4DHv/jNgNd8epq/wDMxmaYDViAg+rR3cYziWRT3+0c0
         oxeA0uY8lRDrg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Anders Larsen <al@alarsen.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 69/92] qnx4: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:34 -0400
Message-ID: <20230705190309.579783-67-jlayton@kernel.org>
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

Acked-by: Anders Larsen <al@alarsen.net>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/qnx4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 391ea402920d..a7171f5532a1 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -305,8 +305,7 @@ struct inode *qnx4_iget(struct super_block *sb, unsigned long ino)
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_sec   = le32_to_cpu(raw_inode->di_atime);
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_sec   = le32_to_cpu(raw_inode->di_ctime);
-	inode->i_ctime.tv_nsec = 0;
+	inode_set_ctime(inode, le32_to_cpu(raw_inode->di_ctime), 0);
 	inode->i_blocks  = le32_to_cpu(raw_inode->di_first_xtnt.xtnt_size);
 
 	memcpy(qnx4_inode, raw_inode, QNX4_DIR_ENTRY_SIZE);
-- 
2.41.0

