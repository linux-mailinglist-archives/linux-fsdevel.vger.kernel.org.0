Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4005EAACF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiIZPYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiIZPX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:23:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490EEFFB;
        Mon, 26 Sep 2022 07:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 095BFB80AB9;
        Mon, 26 Sep 2022 14:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E9FC43470;
        Mon, 26 Sep 2022 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201371;
        bh=pkSivTZ2V96w1TxFptF7OmeyWg7znCPGnB3jUa95Jow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+8QIUXjRLRkCG7Q5114LteN8thYfO3KGDUbEk8OHmCZRU0NRN9zOZGOUMaZsmFc8
         Qhz/08mG2GItjAqCJUQt+1fBmU7rLYhSwkEH3Z48T0RCOvHZsCUoaZCQGoDn8KxK7e
         3e65p+H10hOxEaF3Gzd8ONoXTvFT2U+RYnlIRQqye7Bld7K/Ry97wbOMk1xUja4eWv
         ST9ILMMl1TxTOiAKHEWwE0z1HsNLEtDq7UG6zKFXWxRaw2RYIxsLC2JJ1jMsxacDP0
         TPgUst7GuEArZUIetIpb/7OFZQSYIPV1PFixxFJQhpSIsQAQhZAGt6aCfoqtpM9EIR
         solhxC139N6Og==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 19/30] ksmbd: use vfs_remove_acl()
Date:   Mon, 26 Sep 2022 16:08:16 +0200
Message-Id: <20220926140827.142806-20-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=brauner@kernel.org; h=from:subject; bh=pkSivTZ2V96w1TxFptF7OmeyWg7znCPGnB3jUa95Jow=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbnIUeCibx/1LyUNxxTkz0Q8bNutf81rbf1S7ifm1qr7v iqotHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJKmT4Z93xS+3cbovtHWt6kkoPeU dF7Hw5Xcdhl5Zxxb3CvHmZOowMLxwvxLLZ8q9d/GvtbssTBduuij2593P+Nrmz7Jo7LqlGcwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

Now that we've switched all filesystems that can serve as the lower
filesystem for ksmbd we can switch ksmbd over to rely on
the posix acl api. Note that this is orthogonal to switching the vfs
itself over.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged

 fs/ksmbd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 430962dd2efa..482bd0911127 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1311,7 +1311,7 @@ int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
 			     sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1) ||
 		    !strncmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
 			     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1)) {
-			err = ksmbd_vfs_remove_xattr(user_ns, dentry, name);
+			err = vfs_remove_acl(user_ns, dentry, name);
 			if (err)
 				ksmbd_debug(SMB,
 					    "remove acl xattr failed : %s\n", name);
-- 
2.34.1

