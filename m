Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5F72C07C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 12:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjFLKw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbjFLKwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:52:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693F0270B;
        Mon, 12 Jun 2023 03:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0637062402;
        Mon, 12 Jun 2023 10:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17873C433D2;
        Mon, 12 Jun 2023 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566223;
        bh=qvZA7DdE6Wpv6Z8AcTjW6nR/pOLEnQm9PEJnaG0qfLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9BlCr9mxY2RAvWUj5v2T93OY5eA0FsnKb0YD5QVpBKLvuRQarxXyrOzDesy478F8
         dwHk+FIgjhcxaR+o3yS0sPpycuhrz/2FGS/FTKqd7Uh3Wre1tMgm0+jHcZGtqjkBgv
         q4JA/42CIDxWxJfLXvYW1q1uBXoxKUHkeU1Z4n6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 13/91] afs: Fix setting of mtime when creating a file/dir/symlink
Date:   Mon, 12 Jun 2023 12:26:02 +0200
Message-ID: <20230612101702.645844977@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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
index 948a808a964d1..cec18f9f8bd7a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1394,6 +1394,7 @@ static int afs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	op->dentry	= dentry;
 	op->create.mode	= S_IFDIR | mode;
 	op->create.reason = afs_edit_dir_for_mkdir;
+	op->mtime	= current_time(dir);
 	op->ops		= &afs_mkdir_operation;
 	return afs_do_sync_operation(op);
 }
@@ -1697,6 +1698,7 @@ static int afs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	op->dentry	= dentry;
 	op->create.mode	= S_IFREG | mode;
 	op->create.reason = afs_edit_dir_for_create;
+	op->mtime	= current_time(dir);
 	op->ops		= &afs_create_operation;
 	return afs_do_sync_operation(op);
 
@@ -1832,6 +1834,7 @@ static int afs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	op->ops			= &afs_symlink_operation;
 	op->create.reason	= afs_edit_dir_for_symlink;
 	op->create.symlink	= content;
+	op->mtime		= current_time(dir);
 	return afs_do_sync_operation(op);
 
 error:
-- 
2.39.2



