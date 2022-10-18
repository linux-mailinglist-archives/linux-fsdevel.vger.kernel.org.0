Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35283602ADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJRMAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 08:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiJRL7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D4BD048;
        Tue, 18 Oct 2022 04:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF2456153E;
        Tue, 18 Oct 2022 11:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31712C4347C;
        Tue, 18 Oct 2022 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094286;
        bh=teWCdQUW/cUSsg8wVa6iVxyQjVMfugVIKET/hobFmcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ITZ1EMxyQ132UhADZTSAUr3l6zaaqx9oS0ulFmMhhsFMNHQmFbwb4v2EUMUKp2M9A
         vBtwdbJ8swqq316+DOioVqh6PHgcGCP73bxmmco4QuJAbI6pTVC10L1Nx5hL89Z11E
         D0zbM9ryPLcvnjZDwMczmxKu229+lUeVILqrA4ZLZEj0P6vqSuEb2Is99/b761tauV
         aiyC8xVbKrs7y+z94Ox3BeFq2V0BGZiS/WinnUdejItjpz2cLlZtL6DHXNqdvFbQch
         Zd0WnPRIt0bf2xHRbm0Hfft9UiBP3iNcQHhIKwknjzmk/m28qQd2kD8tyLwa8fPQPm
         3wir743oLYeuA==
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
Subject: [PATCH v5 18/30] ksmbd: use vfs_remove_acl()
Date:   Tue, 18 Oct 2022 13:56:48 +0200
Message-Id: <20221018115700.166010-19-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=brauner@kernel.org; h=from:subject; bh=teWCdQUW/cUSsg8wVa6iVxyQjVMfugVIKET/hobFmcQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TdHgO1X1/jfXnuALZpeOZHnMXpMu9kH0TeuyGR9PrnCP 7Zj2paOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAibJ8YGf5tYFoY/Ydzdx2z6qLpvI tO9Yp+ZRHwcJa1bGdI3HX5QQgjw5Y9iqrz73raf01PFmHr2cByUZkxtbpXrfjhX9snlRP5+QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
    
    /* v3 */
    unchanged
    
    /* v4 */
    unchanged
    
    /* v5 */
    unchanged

 fs/ksmbd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 93f65f01a4a6..7ccda91b0dc4 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1321,7 +1321,7 @@ int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
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

