Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7EDA402
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 04:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbfJQCte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 22:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387605AbfJQCte (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:49:34 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59FA32082C;
        Thu, 17 Oct 2019 02:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571280573;
        bh=ASNsnE7Fxnf0kkPYLb+v3nUYiyQUYzkO+yfxzPW/f+M=;
        h=From:To:Cc:Subject:Date:From;
        b=nZ8e+obPLC+CAhuqQ0gVTjqeXlyZu5+iuknMLxXtNHX/AEH0feLWktC4mJif4npni
         ika4mXuEi6o0n8rtAHiq50Z+fMoPC0ZL0A9eAiwiCOejnTJ0G7AWlzrIM7J7bCMlEb
         dPhA8FLFdyuhpccwttBWI0pcve7hn6PYWm+EbaME=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2] fs/namespace.c: fix use-after-free of mount in mnt_warn_timestamp_expiry()
Date:   Wed, 16 Oct 2019 19:48:14 -0700
Message-Id: <20191017024814.61980-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

After do_add_mount() returns success, the caller doesn't hold a
reference to the 'struct mount' anymore.  So it's invalid to access it
in mnt_warn_timestamp_expiry().

Fix it by calling mnt_warn_timestamp_expiry() before do_add_mount()
rather than after, and adjusting the warning message accordingly.

Reported-by: syzbot+da4f525235510683d855@syzkaller.appspotmail.com
Fixes: f8b92ba67c5d ("mount: Add mount warning for impending timestamp expiry")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/namespace.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fe0e9e1410fe..2adfe7b166a3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2478,8 +2478,10 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 
 		time64_to_tm(sb->s_time_max, 0, &tm);
 
-		pr_warn("Mounted %s file system at %s supports timestamps until %04ld (0x%llx)\n",
-			sb->s_type->name, mntpath,
+		pr_warn("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
+			sb->s_type->name,
+			is_mounted(mnt) ? "remounted" : "mounted",
+			mntpath,
 			tm.tm_year+1900, (unsigned long long)sb->s_time_max);
 
 		free_page((unsigned long)buf);
@@ -2764,14 +2766,11 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
-	error = do_add_mount(real_mount(mnt), mountpoint, mnt_flags);
-	if (error < 0) {
-		mntput(mnt);
-		return error;
-	}
-
 	mnt_warn_timestamp_expiry(mountpoint, mnt);
 
+	error = do_add_mount(real_mount(mnt), mountpoint, mnt_flags);
+	if (error < 0)
+		mntput(mnt);
 	return error;
 }
 
-- 
2.23.0

