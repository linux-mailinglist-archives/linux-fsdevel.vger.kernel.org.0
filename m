Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5472335F40F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351027AbhDNMj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 08:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347336AbhDNMjV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:39:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05A6961242;
        Wed, 14 Apr 2021 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618403939;
        bh=trjYxEgalZgxYJrHZB3dPQb397DtdefL3Lsm4LvCJWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5cA7MvJ8u/PxHz/mTf+LlXfEt3LqMQBsmvb29ek09df6dQDeGtD3iUnc3ADbsBJc
         ryketa8FV75N3FodGyTBY0KSmGrhMSXM2aYceXyVZ1RvA1lKAhDIUwoWFLozEZDFgq
         aPGq76CSmzC64HUf/0H64P6YYpk8NlDxA1Hu9dMGu3qH07Y9JhmJbCsU5liuaUQB/8
         mlFQ44XsnlaaI96OFOESbCp7p7O9VAYkaD7ZncBUzHJ0qxegMUl1BdHsCTiHVhSNX6
         OPDQ80yn+0jZ0H4ViTZ2MdmDl7dQ7yxLUjWzvDba55xMTT6T4wml5BPDZF1lpxVQDu
         AdZ5/6ipoOFjg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-cachefs@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 7/7] ecryptfs: extend ro check to private mount
Date:   Wed, 14 Apr 2021 14:37:51 +0200
Message-Id: <20210414123750.2110159-8-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414123750.2110159-1-brauner@kernel.org>
References: <20210414123750.2110159-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=TJq3ADscBRuq3vVMRrZQ25nFLYThkfCmWR4OfInmRrw=; m=1ciTf4lEciTeOTFMYE8Ti/zNFh88dj9ns8fWVydD8Es=; p=z+y7HlsQCE+Knq6tGOyffFIPiZjVOof3onzoRF6Hb6E=; g=0d107768135058226d796803890d0dee0a0e7ec6
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHbh4AAKCRCRxhvAZXjcotLBAQDn6l9 aXkwGRy7SXgg32N2NRCvBm3ku22g55ZuZqsqPhwD/TYrdUDq3t7xICbXuJj/8/Y+oSbZh1gRpQ2li RXJyZgI=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

So far ecryptfs only verified that the superblock wasn't read-only but
didn't check whether the mount was. This made sense when we did not use
a private mount because the read-only state could change at any point.

Now that we have a private mount and mount properties can't change
behind our back extend the read-only check to include the vfsmount.

The __mnt_is_readonly() helper will check both the mount and the
superblock.  Note that before we checked root->d_sb and now we check
mnt->mnt_sb but since we have a matching <vfsmount, dentry> pair here
this is only syntactical change, not a semantic one.

Overlayfs and cachefiles have been changed to check this as well.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/ecryptfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 3ba2c0f349a3..4e5aeec91e95 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -571,7 +571,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 	 *   1) The lower mount is ro
 	 *   2) The ecryptfs_encrypted_view mount option is specified
 	 */
-	if (sb_rdonly(path.dentry->d_sb) || mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)
+	if (__mnt_is_readonly(mnt) || mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)
 		s->s_flags |= SB_RDONLY;
 
 	s->s_maxbytes = path.dentry->d_sb->s_maxbytes;
-- 
2.27.0

