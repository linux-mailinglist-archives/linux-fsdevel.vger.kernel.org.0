Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADDB609FF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 13:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJXLNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 07:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJXLNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCCF52475
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 04:13:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD0A9B80EAB
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 11:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F8FC433C1;
        Mon, 24 Oct 2022 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609990;
        bh=+FDjFAzY8xzZIxfhiocs/netBbAwfpHMk929Ly9a7Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjQAFlWlB4pruhXbWXB/y07UoGUNbPrYfp3YBRE0/t3NcZZykVkbWStD6CWmAdGg4
         jwlj5TB+fE3Tc8RITO0i3WUi9B/FUnbJz1GLd4XT/p8jbxTYA9VT6vZquQkYkTKRRM
         xGB8R1Z9WLsC0tbGdphb590JX0FWJHpOcr4m1wBpn0hUV2+896iG2+e13cG/ZhEtR3
         znxVkmdUVEbJ5AzsUahVmb4BOhFS/nE1jMBGYht10OjqfJ093z9DVh7BSuio+04R3M
         C6RsfnnIvDZ9wWpAlrrct/hyEiSP1BCWJiguQwm+vLc6LaVZ1SoekPZApMFcFkENlD
         QqeM5OhhpuATQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6/8] fuse: port to vfs{g,u}id_t and associated helpers
Date:   Mon, 24 Oct 2022 13:12:47 +0200
Message-Id: <20221024111249.477648-7-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024111249.477648-1-brauner@kernel.org>
References: <20221024111249.477648-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=brauner@kernel.org; h=from:subject; bh=+FDjFAzY8xzZIxfhiocs/netBbAwfpHMk929Ly9a7Zc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSHFetu2jD7n+mtoLS3x+RTJ/7Vsrl48o6ClOv18nXlM053 OHnP7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIlyDD/6oZiZXauoqR9rOu21VE+p b4h7x/PnX/xEuSJ64Iz3xSf4Xhf2z1hIo7Blf/fpgYuCW+9/u2+KijPH/+/d376UTkK57l35gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A while ago we introduced a dedicated vfs{g,u}id_t type in commit
1e5267cd0895 ("mnt_idmapping: add vfs{g,u}id_t").  We already switched over
a good part of the VFS.  Ultimately we will remove all legacy idmapped
mount helpers that operate only on k{g,u}id_t in favor of the new type safe
helpers that operate on vfs{g,u}id_t.

Cc: Seth Forshee (Digital Ocean) <sforshee@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    Note that this patch is currently also in Miklos tree.

 fs/fuse/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 337cb29a8dd5..84c1ca4bc1dc 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -98,7 +98,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 			return ret;
 		}
 
-		if (!in_group_p(i_gid_into_mnt(&init_user_ns, inode)) &&
+		if (!vfsgid_in_group_p(i_gid_into_vfsgid(&init_user_ns, inode)) &&
 		    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
-- 
2.34.1

