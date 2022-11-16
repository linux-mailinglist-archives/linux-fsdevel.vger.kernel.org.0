Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C062C230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiKPPRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiKPPRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:17:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312C4D5FD;
        Wed, 16 Nov 2022 07:17:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E49661E83;
        Wed, 16 Nov 2022 15:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25FCC433D6;
        Wed, 16 Nov 2022 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668611853;
        bh=8KrKIuKkrzJCTsiPbPUqyZLF65iFtFpKOQstJ9arhYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCEhv/8Y/mWsgPSYs53gpC08w3XrYZJ20nGZe8Hp79eCkD5X80wAgzEnC3NfA8qr7
         lYtnAqzD6AX+UK6QrRATqQPUzI2ROz0hFYo6Pom+R9EzErazlOQ4BcWe7r/dZ8U62/
         iI57ksOVfMduWNBIdjzbPomvjEJgtrcQGhXA/DKUvWhGCqI9jk+dM+yJ7O+UoIyRwp
         NZO1uuvJaQigBjkaSMfwwoYTajtn4PtowBGK8QS1kZu/me3D5MsIStVKGcxjtE66Bk
         ncTlJ+HAt2gRNlqmkjWW+DimxA+11t24ePQ5KuulGPpi+6C9w4zPCS0rIzHXHcXzsy
         qMwhVsEvHm0wQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, hch@lst.de,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>
Subject: [PATCH 4/7] ksmbd: use locks_inode_context helper
Date:   Wed, 16 Nov 2022 10:17:23 -0500
Message-Id: <20221116151726.129217-5-jlayton@kernel.org>
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

ksmbd currently doesn't access i_flctx safely. This requires a
smp_load_acquire, as the pointer is set via cmpxchg (a release
operation).

Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <sfrench@samba.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ksmbd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 8de970d6146f..f9e85d6a160e 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -321,7 +321,7 @@ static int check_lock_range(struct file *filp, loff_t start, loff_t end,
 			    unsigned char type)
 {
 	struct file_lock *flock;
-	struct file_lock_context *ctx = file_inode(filp)->i_flctx;
+	struct file_lock_context *ctx = locks_inode_context(file_inode(filp));
 	int error = 0;
 
 	if (!ctx || list_empty_careful(&ctx->flc_posix))
-- 
2.38.1

