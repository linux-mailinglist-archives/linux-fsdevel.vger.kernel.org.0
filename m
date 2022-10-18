Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA8602AAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJRL5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJRL5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:57:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E10BBF21;
        Tue, 18 Oct 2022 04:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24C47B81D8C;
        Tue, 18 Oct 2022 11:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED2BC43470;
        Tue, 18 Oct 2022 11:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094246;
        bh=KOxsftWRjFNhddxosHic0HvFDjcmK8lm2GExwH7ASS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrEU5qAQoRlLDNgrV1A11kH2x117HiAJAlXc3J8ucH0mX8OSOWKwedzPzUCqbgx9y
         20MF7zBAWq/ayb1l1qlYN8Pwiu5vpcqrJUpjO4CMZaM9GoXWtYDtvkAa4BWdqX72pf
         0g/JpJXXQIbl6q8dDaM20flkcsehfxqkQ0BxBdMsJq1XJCDUSLDcMTZk0f+bPbjQy/
         ou/wfS2QUhwZkPU266UJP9GSS9hVKuqORLHT0qjKuVoh7R6Kl7j9dksAXIBY+Ssftv
         zVYZvLNR7DYkK2gobbJaIMUfq62nYIBd8yB75qUdwpkTJ//VmEXz2IBVnSf+D9mQcX
         1MQ7Y1LIDJxLQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 04/30] fs: add new get acl method
Date:   Tue, 18 Oct 2022 13:56:34 +0200
Message-Id: <20221018115700.166010-5-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4061; i=brauner@kernel.org; h=from:subject; bh=KOxsftWRjFNhddxosHic0HvFDjcmK8lm2GExwH7ASS0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TVENtehcZsq0ZuZkH+vjGyU+6FjyGK9RF6x5EntT4ux7 MUHrjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInUfGJk2CphUJ4Xyqtgt+7EA4uGgP qD6ptmGQqGO2zYlKc98Sp3CyPD4a1iJivea367ExKjf/a5d5uSokhYB/M/Hs3TCr9Wv/RlAQA=
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

Since some filesystem rely on the dentry being available to them when
setting posix acls (e.g., 9p and cifs) they cannot rely on the old get
acl inode operation to retrieve posix acl and need to implement their
own custom handlers because of that.

In a previous patch we renamed the old get acl inode operation to
->get_inode_acl(). We decided to rename it and implement a new one since
->get_inode_acl() is called generic_permission() and inode_permission()
both of which can be called during an filesystem's ->permission()
handler. So simply passing a dentry argument to ->get_acl() would have
amounted to also having to pass a dentry argument to ->permission(). We
avoided that change.

This adds a new ->get_acl() inode operations which takes a dentry
argument which filesystems such as 9p, cifs, and overlayfs can implement
to get posix acls.

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

 Documentation/filesystems/locking.rst | 2 ++
 Documentation/filesystems/vfs.rst     | 1 +
 include/linux/fs.h                    | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 0eebbbb299da..408cffe4e9a5 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -84,6 +84,7 @@ prototypes::
 	int (*fileattr_set)(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
+	struct posix_acl * (*get_acl)(struct user_namespace *, struct dentry *, int);
 
 locking rules:
 	all may block
@@ -105,6 +106,7 @@ get_link:	no
 setattr:	exclusive
 permission:	no (may not block if called in rcu-walk mode)
 get_inode_acl:	no
+get_acl:	no
 getattr:	no
 listxattr:	no
 fiemap:		no
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index cebede60db98..2c15e7053113 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -443,6 +443,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
 				   unsigned open_flag, umode_t create_mode);
 		int (*tmpfile) (struct user_namespace *, struct inode *, struct file *, umode_t);
+		struct posix_acl * (*get_acl)(struct user_namespace *, struct dentry *, int);
 	        int (*set_acl)(struct user_namespace *, struct dentry *, struct posix_acl *, int);
 		int (*fileattr_set)(struct user_namespace *mnt_userns,
 				    struct dentry *dentry, struct fileattr *fa);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2395e1388e2e..255f6eff89d7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2172,6 +2172,8 @@ struct inode_operations {
 			   umode_t create_mode);
 	int (*tmpfile) (struct user_namespace *, struct inode *,
 			struct file *, umode_t);
+	struct posix_acl *(*get_acl)(struct user_namespace *, struct dentry *,
+				     int);
 	int (*set_acl)(struct user_namespace *, struct dentry *,
 		       struct posix_acl *, int);
 	int (*fileattr_set)(struct user_namespace *mnt_userns,
-- 
2.34.1

