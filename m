Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994FF59B051
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiHTUR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiHTUR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:17:56 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFEF30570;
        Sat, 20 Aug 2022 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fD7vrQU4Z6TyVDACQCtFUO12NTMqAT8ivpKpMlldQjI=; b=kwUQDgmYF4rTLtMrROQoK9uYGE
        yty3SaaJSZt4cpR1dhlW3gibTu2D1srYQgRSvjyXfa2m/NbzoXK4qylAcziUpWYj8G762QNNm5Y8H
        OiOT3QGIl48Q+210OL6MRV5E0gijJT1b8Q8FWKzkySiIYEm2k7D3j67yP8EkIiVBr6l89lGuEBqug
        3sphdZo6MDcgwyg5VRqPU3AR+Z8OqQbv2nxUuZ8rBd+60FWJRQLm2MSqnhU1k8FFg0xDNvOgf0GNu
        paNQlHUdLTkyYI+WgcE/iycYC9Ve9CQ0/L7tyNXgU4k8aC5UYp2c7Mx5UJ+FE8M7SNNmz+emZJ8Mj
        sEUFrSCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPUun-006TAV-Id;
        Sat, 20 Aug 2022 20:17:53 +0000
Date:   Sat, 20 Aug 2022 21:17:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/8] nfs_finish_open(): don't open-code file_inode()
Message-ID: <YwFBcX4t/oh0sxW7@ZenIV>
References: <YwFANLruaQpqmPKv@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwFANLruaQpqmPKv@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index dbab3caa15ed..bcb2500c49b8 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2022,7 +2022,7 @@ static int nfs_finish_open(struct nfs_open_context *ctx,
 	err = finish_open(file, dentry, do_open);
 	if (err)
 		goto out;
-	if (S_ISREG(file->f_path.dentry->d_inode->i_mode))
+	if (S_ISREG(file_inode(file)->i_mode))
 		nfs_file_set_open_context(file, ctx);
 	else
 		err = -EOPENSTALE;
-- 
2.30.2

