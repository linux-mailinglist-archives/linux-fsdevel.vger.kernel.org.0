Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5390E10B7D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 21:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfK0UhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 15:37:23 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57270 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728167AbfK0UhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:37:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 440608EE133;
        Wed, 27 Nov 2019 12:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574887042;
        bh=bRDcnN7yw64KKmiz+v8oSaprM7jS6fqRB+bRIuxPcJg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ecltZKHUqnU/Yf3+urIiGIQsJrCkgFBcLViP4+8HL6EtWTisGjf6/wypXeVjAjq23
         fUMoClOu1a2Jvl143DAeI9yiYMovKk8+c3ZonQfeS8TOJ7rum3I/UQa2T9mypzQ7Kc
         me1IfYgIfEnjT/Am54Mr4L0dVut7R8N+aCqVWyN4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m5X-ICHApB_h; Wed, 27 Nov 2019 12:37:22 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BCA9D8EE130;
        Wed, 27 Nov 2019 12:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574887042;
        bh=bRDcnN7yw64KKmiz+v8oSaprM7jS6fqRB+bRIuxPcJg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ecltZKHUqnU/Yf3+urIiGIQsJrCkgFBcLViP4+8HL6EtWTisGjf6/wypXeVjAjq23
         fUMoClOu1a2Jvl143DAeI9yiYMovKk8+c3ZonQfeS8TOJ7rum3I/UQa2T9mypzQ7Kc
         me1IfYgIfEnjT/Am54Mr4L0dVut7R8N+aCqVWyN4=
Message-ID: <1574887041.21593.12.camel@HansenPartnership.com>
Subject: [RFC 5/6] fs: expose internal interfaces open_detached_copy and
 do_reconfigure_mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Nov 2019 12:37:21 -0800
In-Reply-To: <1574886778.21593.7.camel@HansenPartnership.com>
References: <1574295100.17153.25.camel@HansenPartnership.com>
         <17268.1574323839@warthog.procyon.org.uk>
         <1574352920.3277.18.camel@HansenPartnership.com>
         <1574886778.21593.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
index e3039de79134..f27136058d7d 100644
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
index 13be853e9225..9dcbafe62e4e 100644
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

