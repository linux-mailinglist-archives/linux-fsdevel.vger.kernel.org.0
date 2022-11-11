Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B03F6263EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 22:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiKKVzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 16:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKKVzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:55:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846494877F;
        Fri, 11 Nov 2022 13:55:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE75620D5;
        Fri, 11 Nov 2022 21:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CF6C433D6;
        Fri, 11 Nov 2022 21:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203742;
        bh=Ex1Tus6ZTu7zMmrEK18Z5Di1hLUKGsUx2db/ut+O8ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRXVH4BprFTg9NTv4QvMskUAiF4ZO+5neFne/OhkXcGO0uti3u86o7em8ybzCddnb
         8Kj3xZIE+dhuaVJ6Iet309weXodjY9uETxOSG6KrOZHhQkLPvAbAOHqn+Jn8GB9YQ4
         Caj139sq1Bd9dhO3Gac1ztiZBclme7cC+w6HIaJT7tZdsEzV6iFYZsptPDAn2XhM7t
         CGxO0uae0IQwbBLVjIuNwJfNi1Qy7radcTS8rTHpH8vfrfQrKrdQyY+kZ9Rn6BmycX
         EEOdwvm4k4hyweuu1haWDfb5XnsquQ61qcS6bIFssXHdEnKVoxC6vGFNOL53Qv97yy
         TmjsQVFnpdIGQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] lockd: fix file selection in nlmsvc_cancel_blocked
Date:   Fri, 11 Nov 2022 16:55:37 -0500
Message-Id: <20221111215538.356543-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111215538.356543-1-jlayton@kernel.org>
References: <20221111215538.356543-1-jlayton@kernel.org>
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

We currently do a lock_to_openmode call based on the arguments from the
NLM_UNLOCK call, but that will always set the fl_type of the lock to
F_UNLCK, and the O_RDONLY descriptor is always chosen.

Fix it to use the file_lock from the block instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svclock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 9eae99e08e69..4e30f3c50970 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -699,9 +699,10 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 	block = nlmsvc_lookup_block(file, lock);
 	mutex_unlock(&file->f_mutex);
 	if (block != NULL) {
-		mode = lock_to_openmode(&lock->fl);
-		vfs_cancel_lock(block->b_file->f_file[mode],
-				&block->b_call->a_args.lock.fl);
+		struct file_lock *fl = &block->b_call->a_args.lock.fl;
+
+		mode = lock_to_openmode(fl);
+		vfs_cancel_lock(block->b_file->f_file[mode], fl);
 		status = nlmsvc_unlink_block(block);
 		nlmsvc_release_block(block);
 	}
-- 
2.38.1

