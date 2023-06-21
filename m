Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD67387FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjFUOx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjFUOxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712811FFD;
        Wed, 21 Jun 2023 07:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225B8615A1;
        Wed, 21 Jun 2023 14:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31FEC433C0;
        Wed, 21 Jun 2023 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358975;
        bh=E/Jd9jiPwA48oKoLtHMJRqaHIzPdYPGdOmDdE++Vw8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q118R/CDXJw4LjNWDJjOrkJnSqXZ3ePdF6AixmhQ+bB1hUGtfnT5XYT7popYsEg7b
         mDoPxY/jKYIPDA58H7qZP0p6oj6KoslICfyfoHpKhk0NXhMWpEAAKuLFJqy6FZbrl2
         wyvD7nRU1cvZY/5CfHRjD9wrskAXtWtIJA8HWbCKcA5WU/2FbGQcQhudtvCe3YLyJ8
         6dM3kRVscRPjPvMPuwtFynX+4DOmjULhZEfBM4alSLCZxa7oHn20xZNkzYOy/TFmaT
         5dIVRHltMPv5YsmDXPkfqzTQGPz0qDdmP8MyiVHeCajCGUy5/IBDhPio83k+9A3jwe
         Zar9kgCjROxHQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 69/79] vboxsf: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:22 -0400
Message-ID: <20230621144735.55953-68-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/vboxsf/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index dd0ae1188e87..a76dc1ec10f8 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -128,8 +128,8 @@ int vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
 
 	inode->i_atime = ns_to_timespec64(
 				 info->access_time.ns_relative_to_unix_epoch);
-	inode->i_ctime = ns_to_timespec64(
-				 info->change_time.ns_relative_to_unix_epoch);
+	inode_ctime_set(inode,
+			ns_to_timespec64(info->change_time.ns_relative_to_unix_epoch));
 	inode->i_mtime = ns_to_timespec64(
 			   info->modification_time.ns_relative_to_unix_epoch);
 	return 0;
-- 
2.41.0

