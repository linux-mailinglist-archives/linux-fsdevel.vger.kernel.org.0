Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67E5748D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjGETLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjGETLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:11:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DD64499;
        Wed,  5 Jul 2023 12:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C4BD616FF;
        Wed,  5 Jul 2023 19:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EF0C433C9;
        Wed,  5 Jul 2023 19:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583915;
        bh=AxIRr4uzMf6HToOd79HziOv2aR8VXWEmEPY7SKLA4QY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9UEBWbcccHAypoaHtHAC9hXPW4mp7QiJ7Tv7GKLpaDE45Wvszfh0sBcdqILPht2o
         sh/Uvgm4T0iChWi0zI3i8hWE6yc1mz10RKN82ApYP3T+Ggm81HfPwnhVAbhH8QSzHw
         4dOTC7NhQRbRuli9HjAOEW/3Reh0xyO84UMkSK0nWbn9t1NTVtYvlsdzIIpFCaMsjr
         OXgsu3HnmBsze0PW0fYYyXW6FQD3sQZHq4Ibf0iHUEkibG56IkZbwQIUM5d9v/sqAI
         WtiblYa0KsSi57Vtju82IPLWBIARy84kSZbJhd3O5WwqHR/lz1g20cfhYitMVRCrqB
         koKaabQRHwc/g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 73/92] romfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:38 -0400
Message-ID: <20230705190309.579783-71-jlayton@kernel.org>
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
 fs/romfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index c59b230d55b4..961b9d342e0e 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -322,8 +322,8 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 
 	set_nlink(i, 1);		/* Hard to decide.. */
 	i->i_size = be32_to_cpu(ri.size);
-	i->i_mtime.tv_sec = i->i_atime.tv_sec = i->i_ctime.tv_sec = 0;
-	i->i_mtime.tv_nsec = i->i_atime.tv_nsec = i->i_ctime.tv_nsec = 0;
+	i->i_mtime.tv_sec = i->i_atime.tv_sec = inode_set_ctime(i, 0, 0).tv_sec;
+	i->i_mtime.tv_nsec = i->i_atime.tv_nsec = 0;
 
 	/* set up mode and ops */
 	mode = romfs_modemap[nextfh & ROMFH_TYPE];
-- 
2.41.0

