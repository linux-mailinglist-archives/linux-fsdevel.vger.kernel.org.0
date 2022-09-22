Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975A55E66C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiIVPS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiIVPSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:18:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFFAEFA59;
        Thu, 22 Sep 2022 08:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5298AB83838;
        Thu, 22 Sep 2022 15:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994E1C433D6;
        Thu, 22 Sep 2022 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663859907;
        bh=9+GB0A3CKjPhAv6wovhAsOsoFb9FuOIeGhkgAfSgkdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guK0sW22NxHQv+okTMporo7nR0XyM9KoJ4Xj0bVAWryEO47bUZjRx8Brd8q6/lvpH
         fzTwIXLBl0K62aKX5enJlEZD/96y7qwnXdHpmmkOTCWtH5u//0zNetZ0/JyqD39ddB
         vNHVB7qan8+4KI7w+aiZVY1yku/ApD8lP28ypsjp5LZU/HjwYcf06lyAEBShsU9vOI
         ZbQmxNanLpP9p+913YIKwd5/7gdtaTWOQvz75XgDTBv7dK6l3OOm7llP1Vktm7XE3g
         jN4shtqBwolqWFHy92LKmlC7nHVi8gtmo01VGJ8Ae0vPRPTLuNSdLY4p9prNiF8R2+
         Nw+OLiypSV2dQ==
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
        linux-cifs@vger.kernel.org
Subject: [PATCH 18/29] ksmbd: use vfs_remove_acl()
Date:   Thu, 22 Sep 2022 17:17:16 +0200
Message-Id: <20220922151728.1557914-19-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
References: <20220922151728.1557914-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=brauner@kernel.org; h=from:subject; bh=9+GB0A3CKjPhAv6wovhAsOsoFb9FuOIeGhkgAfSgkdM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTr1FSfzbndszm0onvjnnU3BbJr7hm/FKmtuMC+9sp3ZtbD 0XmuHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZwMnIsKdf4IqS1eny7ityq4P3rm o8+G9OqtUzs+2vLtxOeMRaV8PIcD5S7Egd57bCl2VfCmx82Au5v/slnFazF+3+5WixZFM8HwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

