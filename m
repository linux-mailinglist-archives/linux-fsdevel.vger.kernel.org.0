Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84F69B6EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 01:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBRAfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 19:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBRAfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:35:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC883F7;
        Fri, 17 Feb 2023 16:35:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98EF6620A7;
        Sat, 18 Feb 2023 00:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4C2C433A0;
        Sat, 18 Feb 2023 00:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676680438;
        bh=r7VYuVAQDU98smxxlBwk5mo68iLowdZ4mILXuE17YKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDJ1tW0nJd35lXKg/oEsGs3Ne79q5RUlNKJDhBoD/8r2U17+sfDm/9TIdBPUfTFp8
         PGDwxrROXHSZvpgHxEO+DmkbufWFUSZ1tKsY+eywqQMKQhG7nOrY8YylC0Co29AjER
         Tang6L0vTIU+SYJJo8r3oqG3c5+CWkIRlNTZfMw73FCXjXQXE0yqX8lqC4pzGL0qzo
         UUg22R5WDeTe3nTQpDehgTaMut4l+XnBpZp+H7x9EoaPrWg7WKqkTEgdW5zMQEYbl9
         zcULamDlKZwhtpnYeq+ogRkPovsOb9QrWMOLPWUvUGdr+iCZLPQ6TWtpvjrGlEfsw/
         TaEUfsQFg9uWg==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 04/11] fs/9p: Remove unnecessary superblock flags
Date:   Sat, 18 Feb 2023 00:33:16 +0000
Message-Id: <20230218003323.2322580-5-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230218003323.2322580-1-ericvh@kernel.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
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

These flags just add unnecessary extra operations.
When 9p is run without cache, it inherently implements
these options so we don't need them in the superblock
(which ends up sending extraneous fsyncs, etc.).  User
can still request these options on mount, but we don't
need to set them as default.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 266c4693e20c..65d96fa94ba2 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -84,9 +84,7 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 		sb->s_bdi->io_pages = v9ses->maxdata >> PAGE_SHIFT;
 	}
 
-	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
-	if (!v9ses->cache)
-		sb->s_flags |= SB_SYNCHRONOUS;
+	sb->s_flags |= SB_ACTIVE;
 
 #ifdef CONFIG_9P_FS_POSIX_ACL
 	if ((v9ses->flags & V9FS_ACL_MASK) == V9FS_POSIX_ACL)
-- 
2.37.2

