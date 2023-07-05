Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C39748D3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjGETIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjGETGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A802D4F;
        Wed,  5 Jul 2023 12:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E6F86171C;
        Wed,  5 Jul 2023 19:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08474C433C7;
        Wed,  5 Jul 2023 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583848;
        bh=HTBHTFlA5RxJ0OO7bJDzoz9Pa37uljN3z9pWnlY8GV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOm99tMX5bBnXkWVa6CJqTOT4j9ZJrPL4lzx90SOuqo6YoLt9KicPGSd/T0L0CMJO
         mjmQVT8Z1YGbshbCtC+FivXzBAnclRDwEFadkOe/1qCSoYKrZwhvYXpXbdyoedtKdT
         ECjYUIRmcYh4tOUMyi5j/JFFLxLaVq956U2dJMIaA67CJSJhXndVPjsNq7qFlphTUi
         bcyaeLFyqmhGjIeTc7625wtbL5E2EgRGkARdg3+ztZ6G+MpMlQVByrbb6DOBnR2CW/
         QIEoGL26snEwviCv/gmGpDTKrpZqqwkqYP9/YWwtiw2MKIyJIvNueRV4+yWNgnSKK/
         NnEhNuT96riiQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/92] efs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:03 -0400
Message-ID: <20230705190309.579783-36-jlayton@kernel.org>
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
 fs/efs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 3ba94bb005a6..3789d22ba501 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -105,8 +105,8 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	inode->i_size  = be32_to_cpu(efs_inode->di_size);
 	inode->i_atime.tv_sec = be32_to_cpu(efs_inode->di_atime);
 	inode->i_mtime.tv_sec = be32_to_cpu(efs_inode->di_mtime);
-	inode->i_ctime.tv_sec = be32_to_cpu(efs_inode->di_ctime);
-	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = 0;
+	inode_set_ctime(inode, be32_to_cpu(efs_inode->di_ctime), 0);
+	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = 0;
 
 	/* this is the number of blocks in the file */
 	if (inode->i_size == 0) {
-- 
2.41.0

