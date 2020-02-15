Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A229B15FF02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 16:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgBOPix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 10:38:53 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53118 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbgBOPiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 10:38:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9914A8EE302;
        Sat, 15 Feb 2020 07:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581781132;
        bh=Is4gjJXUw4+JIkfLcQjjmaIbmYgT3i6jizgl3BOtdJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpDU/g5ixTCFS1DHV50TmTqnJiXcQaOZzGndyvsFUUSf94q6V/zRSFbIs+NRRROHP
         oWPiZSGK/NlZ8FL+OMnNgloqgxRoWvAWjOpzRH9bZdL/HAhfIjAFfGAJK6pQGEvB7I
         EFdkzR3n4cVcDUOrFiwlLqXtEB3T121V9aCH7Yxk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JvnIb0bEkufC; Sat, 15 Feb 2020 07:38:52 -0800 (PST)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CC8358EE121;
        Sat, 15 Feb 2020 07:38:51 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 5/6] fs: expose internal interfaces open_detached_copy and do_reconfigure_mount
Date:   Sat, 15 Feb 2020 10:36:08 -0500
Message-Id: <20200215153609.23797-6-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
References: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are needed for the forthcoming bind configure type to work.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/internal.h  | 3 +++
 fs/namespace.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 507d59e9a540..80d89ddb9b28 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -95,6 +95,9 @@ extern void dissolve_on_fput(struct vfsmount *);
 int fsopen_cf_get(const struct configfd_context *cfc,
 		  struct configfd_param *p);
 
+extern int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags);
+extern struct file *open_detached_copy(struct path *path, bool recursive);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index 09b3220d9437..69fb23ae3d8f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2318,7 +2318,7 @@ static int do_loopback(struct path *path, const char *old_name,
 	return err;
 }
 
-static struct file *open_detached_copy(struct path *path, bool recursive)
+struct file *open_detached_copy(struct path *path, bool recursive)
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	struct mnt_namespace *ns = alloc_mnt_ns(user_ns, true);
@@ -2494,7 +2494,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
  * superblock it refers to.  This is triggered by specifying MS_REMOUNT|MS_BIND
  * to mount(2).
  */
-static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
+int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 {
 	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
-- 
2.16.4

