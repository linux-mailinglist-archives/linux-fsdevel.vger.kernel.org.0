Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2086B388400
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhESAw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbhESAu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:50:58 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C05CC06175F;
        Tue, 18 May 2021 17:49:39 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOU-00G4Fg-3B; Wed, 19 May 2021 00:49:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 07/14] d_path: lift -ENAMETOOLONG handling into callers of prepend_path()
Date:   Wed, 19 May 2021 00:48:54 +0000
Message-Id: <20210519004901.3829541-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only negative value ever returned by prepend_path() is -ENAMETOOLONG
and callers can recognize that situation (overflow) by looking at the
sign of buflen.  Lift that into the callers; we already have the
same logics (buf if buflen is non-negative, ERR_PTR(-ENAMETOOLONG) otherwise)
in several places and that'll become a new primitive several commits down
the road.

Make prepend_path() return 0 instead of -ENAMETOOLONG.  That makes for
saner calling conventions (0/1/2/3/-ENAMETOOLONG is obnoxious) and
callers actually get simpler, especially once the aforementioned
primitive gets added.

In prepend_path() itself we switch prepending the / (in case of
empty path) to use of prepend() - no need to open-code that, compiler
will do the right thing.  It's exactly the same logics as in
__dentry_path().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 72b8087aaf9c..327cc3744554 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -127,8 +127,7 @@ static int prepend_path(const struct path *path,
 		}
 		parent = dentry->d_parent;
 		prefetch(parent);
-		error = prepend_name(&bptr, &blen, &dentry->d_name);
-		if (error)
+		if (unlikely(prepend_name(&bptr, &blen, &dentry->d_name) < 0))
 			break;
 
 		dentry = parent;
@@ -149,12 +148,9 @@ static int prepend_path(const struct path *path,
 	}
 	done_seqretry(&mount_lock, m_seq);
 
-	if (error >= 0 && bptr == *buffer) {
-		if (--blen < 0)
-			error = -ENAMETOOLONG;
-		else
-			*--bptr = '/';
-	}
+	if (blen == *buflen)
+		prepend(&bptr, &blen, "/", 1);
+
 	*buffer = bptr;
 	*buflen = blen;
 	return error;
@@ -181,16 +177,11 @@ char *__d_path(const struct path *path,
 	       char *buf, int buflen)
 {
 	char *res = buf + buflen;
-	int error;
 
 	prepend(&res, &buflen, "", 1);
-	error = prepend_path(path, root, &res, &buflen);
-
-	if (error < 0)
-		return ERR_PTR(error);
-	if (error > 0)
+	if (prepend_path(path, root, &res, &buflen) > 0)
 		return NULL;
-	return res;
+	return buflen >= 0 ? res : ERR_PTR(-ENAMETOOLONG);
 }
 
 char *d_absolute_path(const struct path *path,
@@ -198,16 +189,11 @@ char *d_absolute_path(const struct path *path,
 {
 	struct path root = {};
 	char *res = buf + buflen;
-	int error;
 
 	prepend(&res, &buflen, "", 1);
-	error = prepend_path(path, &root, &res, &buflen);
-
-	if (error > 1)
-		error = -EINVAL;
-	if (error < 0)
-		return ERR_PTR(error);
-	return res;
+	if (prepend_path(path, &root, &res, &buflen) > 1)
+		return ERR_PTR(-EINVAL);
+	return buflen >= 0 ? res : ERR_PTR(-ENAMETOOLONG);
 }
 
 static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
@@ -240,7 +226,6 @@ char *d_path(const struct path *path, char *buf, int buflen)
 {
 	char *res = buf + buflen;
 	struct path root;
-	int error;
 
 	/*
 	 * We have various synthetic filesystems that never get mounted.  On
@@ -263,12 +248,10 @@ char *d_path(const struct path *path, char *buf, int buflen)
 		prepend(&res, &buflen, " (deleted)", 11);
 	else
 		prepend(&res, &buflen, "", 1);
-	error = prepend_path(path, &root, &res, &buflen);
+	prepend_path(path, &root, &res, &buflen);
 	rcu_read_unlock();
 
-	if (error < 0)
-		res = ERR_PTR(error);
-	return res;
+	return buflen >= 0 ? res : ERR_PTR(-ENAMETOOLONG);
 }
 EXPORT_SYMBOL(d_path);
 
-- 
2.11.0

