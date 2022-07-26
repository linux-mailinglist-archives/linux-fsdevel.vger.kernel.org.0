Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D17581AF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 22:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbiGZUXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 16:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiGZUXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E382F66B;
        Tue, 26 Jul 2022 13:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FE361610;
        Tue, 26 Jul 2022 20:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F070C433D7;
        Tue, 26 Jul 2022 20:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658867016;
        bh=NyN3/4LNn7Sy1cHiJRL1jJc+ZDbuOe/CwpY9JJLIbLo=;
        h=From:To:Cc:Subject:Date:From;
        b=D6VqkZaXBEunh4WTZvdxkG9rZkyIqN0xw5/dy5EvVVQOwujAFB1Qndiu3QGjHp/Gz
         GHi50mHrceIAqOBVKhae/tmGFBBw0DplBQ6RE8X0WP/vBl0OZvfWZb210oIcrYuFHf
         hoMdseuHIo9D143RU6AQHTm8wj2+L/Cac09zFUOffHpOQWumgERTl80nXbQH62Kf/e
         Q9J0RcwpvS/+hJzkKNMw9jyQNM7cd/rMpB503C799bzLI5/d0RLl9ut41kzqiOAY1U
         bUxMj4CVIJVV1jKm3Eo+1+FWoGl84Z4k/RNOCIFWYzyEOQqo8CjUV6HE4PlR4fMQgV
         iGlH2uvaBrxLQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Yongchen Yang <yoyang@redhat.com>
Subject: [RFC PATCH] vfs: don't check may_create_in_sticky if the file is already open/created
Date:   Tue, 26 Jul 2022 16:23:33 -0400
Message-Id: <20220726202333.165490-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NFS server is exporting a sticky directory (mode 01777) with root
squashing enabled. Client has protect_regular enabled and then tries to
open a file as root in that directory. File is created (with ownership
set to nobody:nobody) but the open syscall returns an error.

The problem is may_create_in_sticky, which rejects the open even though
the file has already been created/opened. Only call may_create_in_sticky
if the file hasn't already been opened or created.

Cc: Christian Brauner <brauner@kernel.org>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1976829
Reported-by: Yongchen Yang <yoyang@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..7480b6dc8d27 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3495,10 +3495,15 @@ static int do_open(struct nameidata *nd,
 			return -EEXIST;
 		if (d_is_dir(nd->path.dentry))
 			return -EISDIR;
-		error = may_create_in_sticky(mnt_userns, nd,
-					     d_backing_inode(nd->path.dentry));
-		if (unlikely(error))
-			return error;
+		if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
+			error = may_create_in_sticky(mnt_userns, nd,
+						d_backing_inode(nd->path.dentry));
+			if (unlikely(error)) {
+				printk("%s: f_mode=0x%x oflag=0x%x\n",
+					__func__, file->f_mode, open_flag);
+				return error;
+			}
+		}
 	}
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return -ENOTDIR;
-- 
2.37.1

