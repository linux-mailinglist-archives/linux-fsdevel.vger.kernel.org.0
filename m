Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3A678E6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjAXCkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjAXCjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:39:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7DF30EB9;
        Mon, 23 Jan 2023 18:39:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6EA8B80EBB;
        Tue, 24 Jan 2023 02:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C0BC4339B;
        Tue, 24 Jan 2023 02:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674527959;
        bh=fE7TnKGk+7sECniXW1Co7rrNpfck1npdV3aCIbmWvVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCqPJMhz+6FbBO604fTHk1Jefz1JgQav5j2OQSC3HHeTH0ntkts7NTG+v7/9iOw/d
         VH8t4YwRoediSlsf7CsTGHnBSl0p3K2USE5t6imqn3MIo8ibGniAgzUMqnOuhIQf0f
         EKzmS70uGtCYaHtwFjryFoDS57RDKMy0gv1g3GtK4dn8mEwQKiVWWyz2NeRy3Oyk6M
         itrKbYiUeb98SDn72IUnYOeZA+4jJSEX08dRL1fNu5W+yAiHR7GPHhudfc1RXuIZJ/
         e81hZ7FKkHYqIvypgC0aM4zrD7JMxv3ijn2XHbpIaB0GqHPIMv5zxZJ8n0IDjTEjMF
         iZ0SK9zvS4xqw==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v3 11/11] Fix revalidate
Date:   Tue, 24 Jan 2023 02:38:34 +0000
Message-Id: <20230124023834.106339-12-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230124023834.106339-1-ericvh@kernel.org>
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <20230124023834.106339-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unclear if this case ever happens, but if no inode in dentry, then
the dentry is definitely invalid.  Seemed to be the opposite in the
existing code.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_dentry.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 65fa2df5e49b..b0c3f8e8ea00 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -68,7 +68,7 @@ static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 
 	inode = d_inode(dentry);
 	if (!inode)
-		goto out_valid;
+		return 0;
 
 	v9inode = V9FS_I(inode);
 	if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
@@ -91,7 +91,6 @@ static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 		if (retval < 0)
 			return retval;
 	}
-out_valid:
 	return 1;
 }
 
-- 
2.37.2

