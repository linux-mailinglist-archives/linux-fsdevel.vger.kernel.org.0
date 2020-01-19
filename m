Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D33141BA3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgASDX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:23:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56890 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgASDX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:23:27 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it1Ai-00BFdV-W6; Sun, 19 Jan 2020 03:22:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 17/17] expand the only remaining call of path_lookup_conditional()
Date:   Sun, 19 Jan 2020 03:17:29 +0000
Message-Id: <20200119031738.2681033-17-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6852a0dcb25d..e840472ab9bf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -816,13 +816,6 @@ static void set_root(struct nameidata *nd)
 	}
 }
 
-static void path_put_conditional(struct path *path, struct nameidata *nd)
-{
-	dput(path->dentry);
-	if (path->mnt != nd->path.mnt)
-		mntput(path->mnt);
-}
-
 static inline void path_to_nameidata(const struct path *path,
 					struct nameidata *nd)
 {
@@ -1233,8 +1226,11 @@ static int follow_managed(struct path *path, struct nameidata *nd)
 		ret = 1;
 	if (ret > 0 && unlikely(d_flags_negative(flags)))
 		ret = -ENOENT;
-	if (unlikely(ret < 0))
-		path_put_conditional(path, nd);
+	if (unlikely(ret < 0)) {
+		dput(path->dentry);
+		if (path->mnt != nd->path.mnt)
+			mntput(path->mnt);
+	}
 	return ret;
 }
 
-- 
2.20.1

