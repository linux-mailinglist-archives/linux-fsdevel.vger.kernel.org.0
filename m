Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F596263F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 22:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiKKVzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 16:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiKKVzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:55:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E08B76F98;
        Fri, 11 Nov 2022 13:55:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 229EEB82800;
        Fri, 11 Nov 2022 21:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46918C433C1;
        Fri, 11 Nov 2022 21:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203741;
        bh=GUr/pvjzS+Gbv0NQ95I+TzMbAVc9/2m30a4t6CDpvKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BlpCnLxxYMSwSA6zo1I7q3vKNwRSoEjttrbu1Z6R5TQIXQsWDzQzlnJnlpNLQRrQP
         JsnqRoc821yENRfOZnQhtEnyl7fg4fin/cTDVRgNdvjBUrVt60eEeB3sCEDcqXHbGE
         zQ0CELzSF10geEtm+XVZN1HeDFvjqfiF8r2yd47gFetAKu87ZG+8zuD+bsLfL/G+7c
         YzTnnlRWgTz21QFjFgdNelvy7f+H7gm9oYdELN9bfSN0kQk+uq18hmuiNXwLzVOYBm
         UYyy/fi79o1wmH9p62b7dHKP2m9fB/23FoyMUuGGLfRC4zWwqG+944+00wEPVp7sE6
         /Do6YuatqUe+g==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] lockd: ensure we use the correct file description when unlocking
Date:   Fri, 11 Nov 2022 16:55:36 -0500
Message-Id: <20221111215538.356543-3-jlayton@kernel.org>
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

Shared locks are set on O_RDONLY descriptors and exclusive locks are set
on O_WRONLY ones. nlmsvc_unlock however calls vfs_lock_file twice, once
for each descriptor, but it doesn't reset fl_file. Ensure that it does.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svclock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 9c1aa75441e1..9eae99e08e69 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -659,11 +659,13 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
 	nlmsvc_cancel_blocked(net, file, lock);
 
 	lock->fl.fl_type = F_UNLCK;
-	if (file->f_file[O_RDONLY])
-		error = vfs_lock_file(file->f_file[O_RDONLY], F_SETLK,
+	lock->fl.fl_file = file->f_file[O_RDONLY];
+	if (lock->fl.fl_file)
+		error = vfs_lock_file(lock->fl.fl_file, F_SETLK,
 					&lock->fl, NULL);
-	if (file->f_file[O_WRONLY])
-		error = vfs_lock_file(file->f_file[O_WRONLY], F_SETLK,
+	lock->fl.fl_file = file->f_file[O_WRONLY];
+	if (lock->fl.fl_file)
+		error |= vfs_lock_file(lock->fl.fl_file, F_SETLK,
 					&lock->fl, NULL);
 
 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
-- 
2.38.1

