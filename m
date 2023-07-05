Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2584748D16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjGETGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjGETFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:05:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C722713;
        Wed,  5 Jul 2023 12:04:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1777C61711;
        Wed,  5 Jul 2023 19:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E133BC433C8;
        Wed,  5 Jul 2023 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583841;
        bh=mmZWdyBieVaWGBZZnfvkzAkbN9EmGhp06VeUMrMf0Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vb0jQvFGFj3mucwnCa//HhQveytRyCoGk3wgFGhrsi4b7AXsQ3PT52+88afbjCuM6
         n06kmVboyxcXGooCBW51ttyaB0HQ8xSNS7Syvp0dbkrEKaDw4OnOH8jnV3dvBvekqd
         Sjx9TzxqLSTiMz+9jnkt/zb9Tkd/pLBCb8UFaSH0XtA0RQ74P/qjEl5nyvOK1THhzz
         bqkSKlKyJvtwlKmNhoX7EtDcGnhrTb+a+QH8O/NeCb8HL9wRc1ytZlGqhsJWfStHx7
         NtA+oE6LvQTSwklGqvOv/7cFuQJMqpU0F7aVJA50j03S4Kdofut7iyhcJkvN8Seux3
         4YwUct8r9IJxw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/92] cramfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:58 -0400
Message-ID: <20230705190309.579783-31-jlayton@kernel.org>
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

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cramfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 27c6597aa1be..e755b2223936 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -133,7 +133,8 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 	}
 
 	/* Struct copy intentional */
-	inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
+	inode->i_mtime = inode->i_atime = inode_set_ctime_to_ts(inode,
+								zerotime);
 	/* inode->i_nlink is left 1 - arguably wrong for directories,
 	   but it's the best we can do without reading the directory
 	   contents.  1 yields the right result in GNU find, even
-- 
2.41.0

