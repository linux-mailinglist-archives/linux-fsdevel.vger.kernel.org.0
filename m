Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E1C72C18D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 12:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbjFLK7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 06:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbjFLK5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F83D59D0;
        Mon, 12 Jun 2023 03:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB38862457;
        Mon, 12 Jun 2023 10:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B31AC433EF;
        Mon, 12 Jun 2023 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566753;
        bh=nwfWQVFmTNWu2uOBjbkILUhJfQQkyxTQ7VrX+DjFMts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0dYfK+DLYYKGYbDJdQeNzwT0z9KNHMs1LbaF0DSQ0qv7l9vkd6WIEpnCbOOll/JvX
         fiOdeHU5KBlHZ1d/CsM9EhH0g+74Z8xvUM54QjZLn6HQvu70hHatB6FOkMYmCkx4lA
         Zjr1nkrgaYF8+njhjv7A6X/7WhgyQynltdSpm/XA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 005/160] afs: Fix setting of mtime when creating a file/dir/symlink
Date:   Mon, 12 Jun 2023 12:25:37 +0200
Message-ID: <20230612101715.379774066@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit a27648c742104a833a01c54becc24429898d85bf ]

kafs incorrectly passes a zero mtime (ie. 1st Jan 1970) to the server when
creating a file, dir or symlink because the mtime recorded in the
afs_operation struct gets passed to the server by the marshalling routines,
but the afs_mkdir(), afs_create() and afs_symlink() functions don't set it.

This gets masked if a file or directory is subsequently modified.

Fix this by filling in op->mtime before calling the create op.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a97499fd747b6..93e8b06ef76a6 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1358,6 +1358,7 @@ static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	op->dentry	= dentry;
 	op->create.mode	= S_IFDIR | mode;
 	op->create.reason = afs_edit_dir_for_mkdir;
+	op->mtime	= current_time(dir);
 	op->ops		= &afs_mkdir_operation;
 	return afs_do_sync_operation(op);
 }
@@ -1661,6 +1662,7 @@ static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
 	op->dentry	= dentry;
 	op->create.mode	= S_IFREG | mode;
 	op->create.reason = afs_edit_dir_for_create;
+	op->mtime	= current_time(dir);
 	op->ops		= &afs_create_operation;
 	return afs_do_sync_operation(op);
 
@@ -1796,6 +1798,7 @@ static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	op->ops			= &afs_symlink_operation;
 	op->create.reason	= afs_edit_dir_for_symlink;
 	op->create.symlink	= content;
+	op->mtime		= current_time(dir);
 	return afs_do_sync_operation(op);
 
 error:
-- 
2.39.2



