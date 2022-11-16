Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C584862C22A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiKPPRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiKPPRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:17:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B184FF99;
        Wed, 16 Nov 2022 07:17:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A22E61E89;
        Wed, 16 Nov 2022 15:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7DEC433D6;
        Wed, 16 Nov 2022 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668611851;
        bh=TUD2k8y3eCAtEWkgfeRtEJwkTlc0W2hsoZ3J6u4H/dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnG3wSQSHPK5lq2pp3IPQJJSnvGfebGD8gee0jYnKZ016PUOhWPdlh8qobWv5/444
         iZkTjL1eQVaOyCrTXNMNS5RMekMnEY1fEBnVmOys+SJUREB/TPv7rBLoUz4TrkvwYZ
         5XggxGH9DStlz6i6dZHUXPOUjVaFjw8NYlNTnUAMypw+gRq65M3eYv8z+vWRp0GRL8
         QfmvC6WClOaagAbkIz9J5mR4wyU0LP8uQ8M1ljq64oVxrFVKRVKchO3k3jNNa2RmlR
         4IKmnkrmVTDpUn6UWSZ5kONUiVjkA3cqXBZnO4OPAkYAHVowgCk6mimheYuGy1JjX2
         eaWQK4zpn11Bg==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, hch@lst.de, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 2/7] ceph: use locks_inode_context helper
Date:   Wed, 16 Nov 2022 10:17:21 -0500
Message-Id: <20221116151726.129217-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116151726.129217-1-jlayton@kernel.org>
References: <20221116151726.129217-1-jlayton@kernel.org>
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

ceph currently doesn't access i_flctx safely. This requires a
smp_load_acquire, as the pointer is set via cmpxchg (a release
operation).

Cc: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/locks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 3e2843e86e27..f3b461c708a8 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -364,7 +364,7 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 	*fcntl_count = 0;
 	*flock_count = 0;
 
-	ctx = inode->i_flctx;
+	ctx = locks_inode_context(inode);
 	if (ctx) {
 		spin_lock(&ctx->flc_lock);
 		list_for_each_entry(lock, &ctx->flc_posix, fl_list)
@@ -418,7 +418,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 				int num_fcntl_locks, int num_flock_locks)
 {
 	struct file_lock *lock;
-	struct file_lock_context *ctx = inode->i_flctx;
+	struct file_lock_context *ctx = locks_inode_context(inode);
 	int err = 0;
 	int seen_fcntl = 0;
 	int seen_flock = 0;
-- 
2.38.1

