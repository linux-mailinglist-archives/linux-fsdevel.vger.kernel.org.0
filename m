Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220EB745F09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGCOta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 10:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGCOt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:49:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FB3B2
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 07:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DAE560F79
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 14:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0DDC433CA;
        Mon,  3 Jul 2023 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688395767;
        bh=qwJ63WkEv7qe8w4CG0mCazZa8mBjf8JvX0tNePGH3OM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FjAg/CzgHI04F1EWi2QYlvMGRnmgh5o1zLVC3v8p9LbWx0flDxImqDQtRxZgio1Ej
         Bu7NzozKjccIBNrr/oARDLB8b47cWmc4nkLXJp0zgk9w2csxfhUPSpwo6zyFfAF7ux
         fhsUcgyxoDfjBaUPjzCvWFmNDbQ2uMr5QPcExj7dDr1Y5O4SRJVwHSxx6Qd+/qw+RX
         T3K4aErZkq887uVwe6spF5RGxX7a/LI05VVvXxraNattFLdCxaLmOy1Psf39ev2gVp
         cUPe23MS1X29vwqCkmN+7RVbXaT24bIaXHKvfwaZJJN0kZcHFM2eo81eMYjAeSo/KR
         5s9oPOJqDERDQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 03 Jul 2023 16:49:11 +0200
Subject: [PATCH 1/2] fs: no need to check source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230703-vfs-rename-source-v1-1-37eebb29b65b@kernel.org>
References: <20230703-vfs-rename-source-v1-0-37eebb29b65b@kernel.org>
In-Reply-To: <20230703-vfs-rename-source-v1-0-37eebb29b65b@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qwJ63WkEv7qe8w4CG0mCazZa8mBjf8JvX0tNePGH3OM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQsuv/Z+6XGPOn5jn02m6f6fM/uv3IoPqdpj4lXJqd1qO6z
 bfy2HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxL2JkaFmgKbg6yq6hWaH+Uleoi5
 GDdfKS32sePq/ZL5uueD3Bh5FhxenTARVH7Or9pMzL94SLFuyYw3NGetGC8ENHlyfoPDjIAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The @source inode must be valid. It is even checked via IS_SWAPFILE()
above making it pretty clear. So no need to check it when we unlock.

What doesn't need to exist is the @target inode. The lock_two_inodes()
helper currently swaps the @inode1 and @inode2 arguments if @inode1 is
NULL to have consistent lock class usage. However, we know that at least
for vfs_rename() that @inode1 is @source and thus is never NULL as per
above. We also know that @source is a different inode than @target as
that is checked right at the beginning of vfs_rename(). So we know that
@source is valid and locked and that @target is locked. So drop the
check whether @source is non-NULL.

Fixes: 28eceeda130f ("fs: Lock moved directories")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202307030026.9sE2pk2x-lkp@intel.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 91171da719c5..e56ff39a79bc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4874,8 +4874,7 @@ int vfs_rename(struct renamedata *rd)
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	if (source)
-		inode_unlock(source);
+	inode_unlock(source);
 	if (target)
 		inode_unlock(target);
 	dput(new_dentry);

-- 
2.34.1

