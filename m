Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46A748CB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjGETDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjGETDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6341730;
        Wed,  5 Jul 2023 12:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5149616C4;
        Wed,  5 Jul 2023 19:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623D6C433C7;
        Wed,  5 Jul 2023 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583794;
        bh=kM0aleIbcnRzUxbHQknvyJkwiNG9CJKpnUbOghkokco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phaRUhycINZtI8zYHg2fG+4V1LUiUO/5B9eREQVACAzMMyozSUi/ITEr6/5RK7bsR
         iz7VqtRyVBoSBmASgtj/FnMd27l66LZTn80QtUDRsBzil07NF6x7PGdMR8LyBlxUPZ
         opM56Z0PcwVH5XjNxm2R/QgwYZEuIUE1VBns+KCJ7wKFUz9phIWV2LI4vrEKu1OJ5n
         Eww0q6XNhtkREiEuJHMjdtbc7WAyXu8ftTasC7vEfj1Gz/0oK+tCMYh98ztMflFc6m
         lS0QrRTSmiv3w4N+JNZXRaXgcQOX/lWJlc3E0uJzhvYwyQwFaiW7eK0iXEQJNbpj9z
         35fi6aJ+Q580w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH v2 03/92] efivarfs: update ctime when mtime changes on a write
Date:   Wed,  5 Jul 2023 15:00:30 -0400
Message-ID: <20230705190309.579783-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

POSIX says:

"Upon successful completion, where nbyte is greater than 0, write()
 shall mark for update the last data modification and last file status
 change timestamps of the file..."

Add the missing ctime update.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/efivarfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index d57ee15874f9..375576111dc3 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -51,7 +51,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
-		inode->i_mtime = current_time(inode);
+		inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode_unlock(inode);
 	}
 
-- 
2.41.0

