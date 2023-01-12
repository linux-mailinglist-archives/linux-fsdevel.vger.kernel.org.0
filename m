Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A29A66699B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 04:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjALD2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 22:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjALD2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 22:28:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6EBC77E;
        Wed, 11 Jan 2023 19:28:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 722BC60EDF;
        Thu, 12 Jan 2023 03:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B4BC433EF;
        Thu, 12 Jan 2023 03:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673494084;
        bh=lTrL5/cdFLCbDI8M14ACxzOpG64h6TOm1e5TM5oaG8I=;
        h=From:To:Cc:Subject:Date:From;
        b=SuLKKKXQTK1aBWxAOxtHYlxjQ3v6LBXH3CDjpmjeB+VOX0JVHkNxuMGYpwDFF68UB
         2dZ4oTgEeL3A0FPoa33qMC6LFW8uv8N8pmm82n0sUA+9NOeEaslmwT/7PHpc7rJowW
         MkwEcDsRZ4OUvJL6ATwVl09dAA7losV9u90t3y1qrFKwdY9zaq+Qo1oIi5j/JCZT+q
         aORRJ84pKWyFiwVIJOtGM+2kGsurbDxtSBuc2CcEubzWno5XLzpqZpg2nm8WsvAybo
         hzXYr+S92t3Bmc/TMr9rj/zcPAtI6N141dZvIAWnPtRJRpZ/BMcxbjA5zhZzbs3n52
         rhtPxwGWwwLng==
From:   Chao Yu <chao@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] proc: remove mark_inode_dirty() in proc_notify_change()
Date:   Thu, 12 Jan 2023 11:27:20 +0800
Message-Id: <20230112032720.1855235-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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

proc_notify_change() has updated i_uid, i_gid and i_mode into proc
dirent, we don't need to call mark_inode_dirty() for later writeback,
remove it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/proc/generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 5f52f20d5ed1..f547e9593a77 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -127,7 +127,6 @@ static int proc_notify_change(struct user_namespace *mnt_userns,
 		return error;
 
 	setattr_copy(&init_user_ns, inode, iattr);
-	mark_inode_dirty(inode);
 
 	proc_set_user(de, inode->i_uid, inode->i_gid);
 	de->mode = inode->i_mode;
-- 
2.25.1

