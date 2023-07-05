Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B0748D4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjGETJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjGETIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC51FD4;
        Wed,  5 Jul 2023 12:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3220A6170C;
        Wed,  5 Jul 2023 19:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04510C433C8;
        Wed,  5 Jul 2023 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583863;
        bh=XUGLj6vRT2nD6OcTnqWk1j5eSDsjuOt1nCtiIEhrnV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLOgOXVGV+KiWlI9cx0L7N77auOJqmGI5YUpgqp4j5nt8APesTi0+DLwaxbepOnOI
         jMU3uM7XJqSkTTjXyh8rtglLHfrInkXQLJWt0WF0qROqd/wMH7HP/avbYMIMgaiw85
         fqJ/5E3lBSDUUUp8dyhsfxM38NsBsXOMKSxb+t+Hgr1cCW2Rs8QIvogGv/B7071BQ1
         CWpH/3dwS2GyJsoVnGWlvb8i+Cpt4Vzq5Pga5VZY7hvNObpAYIfxXsM7KVWGzKl4Dz
         keJiXv0SfWRV9MWv5uqCNyyCGMSP8MKxDflrErIhi+rlZ6cN4oQPseIbND8vj6xsQi
         axXz/PLKlqJhg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 45/92] freevxfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:10 -0400
Message-ID: <20230705190309.579783-43-jlayton@kernel.org>
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
 fs/freevxfs/vxfs_inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index ceb6a12649ba..ac5d43b164b5 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -110,10 +110,9 @@ static inline void dip2vip_cpy(struct vxfs_sb_info *sbi,
 	inode->i_size = vip->vii_size;
 
 	inode->i_atime.tv_sec = vip->vii_atime;
-	inode->i_ctime.tv_sec = vip->vii_ctime;
+	inode_set_ctime(inode, vip->vii_ctime, 0);
 	inode->i_mtime.tv_sec = vip->vii_mtime;
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
 	inode->i_mtime.tv_nsec = 0;
 
 	inode->i_blocks = vip->vii_blocks;
-- 
2.41.0

