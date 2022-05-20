Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6E352E30E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbiETDUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238077AbiETDUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:20:09 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091576162A
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 20:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oq69YaFflploRej3MW5HneuCo2VfXovYA4cutfAhPsY=; b=FKBg3V9dP/bZGlmaNp8V9gzI6x
        0x4UFiTAOzFHM6YvkWIjpg+HBwBEQ805HxjOrkHWvTs0hir7ZhS7AIpSsbgwNvgfTVPSmWxS8Yidy
        LmAgDBDU0/K2SjeVwhj4xZtDUrc9VLvKnfUEGL9UoP6IPUShuKqrSp4imGW+NqNg3UPtvprNKlPrZ
        VJMfWy3N62jwn6sdTUbheU591BDYnhx57I5oNcx5X+960JiWxTj8oLR/tm2UIDkDhWcAeuFhfV/nS
        POGA912H1gG4/Yh96Z18zeCojLV2fQeAHxl7EK6/u5otZYDonG00IomC32IOEfwWNXvU6NLiN+5uG
        GDkY6aPA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrtBP-00GU9n-0O
        for linux-fsdevel@vger.kernel.org; Fri, 20 May 2022 03:20:07 +0000
Date:   Fri, 20 May 2022 03:20:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] uninline may_mount() and don't opencode it in
 fspick(2)/fsopen(2)
Message-ID: <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
 <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's done once per (mount-related) syscall and there's no point
whatsoever making it inline.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fsopen.c    | 4 ++--
 fs/internal.h  | 1 +
 fs/namespace.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 27a890aa493a..fc9d2d9fd234 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -119,7 +119,7 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	const char *fs_name;
 	int ret;
 
-	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	if (!may_mount())
 		return -EPERM;
 
 	if (flags & ~FSOPEN_CLOEXEC)
@@ -162,7 +162,7 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	unsigned int lookup_flags;
 	int ret;
 
-	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	if (!may_mount())
 		return -EPERM;
 
 	if ((flags & ~(FSPICK_CLOEXEC |
diff --git a/fs/internal.h b/fs/internal.h
index 8590c973c2f4..315ec2f419f7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -84,6 +84,7 @@ extern int __mnt_want_write_file(struct file *);
 extern void __mnt_drop_write_file(struct file *);
 
 extern void dissolve_on_fput(struct vfsmount *);
+extern bool may_mount(void);
 
 int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
diff --git a/fs/namespace.c b/fs/namespace.c
index 40b994a29e90..6f91ce77e16b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1717,7 +1717,7 @@ void __detach_mounts(struct dentry *dentry)
 /*
  * Is the caller allowed to modify his namespace?
  */
-static inline bool may_mount(void)
+bool may_mount(void)
 {
 	return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);
 }
-- 
2.30.2

