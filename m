Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16388748D62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjGETKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbjGETIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5F3A9B;
        Wed,  5 Jul 2023 12:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A9D0616F9;
        Wed,  5 Jul 2023 19:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E074CC433C8;
        Wed,  5 Jul 2023 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583930;
        bh=44HUiQLthdvp35Vl8UfXmn2JgpqIpKZ+sVAddJOP8s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHsbj5r0fS8qV6pGFoQVuP49IY+vzc/K6Ko2Cq3y0QofnlVTuw04RkEE2vr+qFvjd
         ACBVjH2DoPeWzol0YC5NzgnOx1VP52vTkPUg38GC/MAGNzCGxK0waiZo2i9DwuSBqP
         hHQUBQ9RwUuDR/p/2hJJOVin1/e0aH+hkhwR+mVNzo7S66rQ7oL5rydLgGYEUnSiXe
         Yde+cOShAbiA7SaG4sHFYltota81jbZhg4LtvNMc6Epz+2LBpLQYwyEfLg58uPEQwS
         38cBcaGkKIOMAC79JsNsoFpqZhoTgRskpoxe0MzThGCtTqIZEaBcsQoWuVTKGLYR7Q
         XUf62bVTWWvEA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 81/92] vboxsf: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:46 -0400
Message-ID: <20230705190309.579783-79-jlayton@kernel.org>
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
 fs/vboxsf/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index dd0ae1188e87..576b91d571c5 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -128,8 +128,8 @@ int vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
 
 	inode->i_atime = ns_to_timespec64(
 				 info->access_time.ns_relative_to_unix_epoch);
-	inode->i_ctime = ns_to_timespec64(
-				 info->change_time.ns_relative_to_unix_epoch);
+	inode_set_ctime_to_ts(inode,
+			      ns_to_timespec64(info->change_time.ns_relative_to_unix_epoch));
 	inode->i_mtime = ns_to_timespec64(
 			   info->modification_time.ns_relative_to_unix_epoch);
 	return 0;
-- 
2.41.0

