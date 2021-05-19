Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBAB388412
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhESAwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352876AbhESAvW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:51:22 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31763C06175F;
        Tue, 18 May 2021 17:50:03 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOT-00G4FW-HH; Wed, 19 May 2021 00:49:01 +0000
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
Subject: [PATCH 02/14] d_path: saner calling conventions for __dentry_path()
Date:   Wed, 19 May 2021 00:48:49 +0000
Message-Id: <20210519004901.3829541-2-viro@zeniv.linux.org.uk>
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

1) lift NUL-termination into the callers
2) pass pointer to the end of buffer instead of that to beginning.

(1) allows to simplify dentry_path() - we don't need to play silly
games with restoring the leading / of "//deleted" after __dentry_path()
would've overwritten it with NUL.

We also do not need to check if (either) prepend() in there fails -
if the buffer is not large enough, we'll end with negative buflen
after prepend() and __dentry_path() will return the right value
(ERR_PTR(-ENAMETOOLONG)) just fine.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 01df5dfa1f88..1a1cf05e7780 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -326,22 +326,21 @@ char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
 /*
  * Write full pathname from the root of the filesystem into the buffer.
  */
-static char *__dentry_path(const struct dentry *d, char *buf, int buflen)
+static char *__dentry_path(const struct dentry *d, char *p, int buflen)
 {
 	const struct dentry *dentry;
 	char *end, *retval;
 	int len, seq = 0;
 	int error = 0;
 
-	if (buflen < 2)
+	if (buflen < 1)
 		goto Elong;
 
 	rcu_read_lock();
 restart:
 	dentry = d;
-	end = buf + buflen;
+	end = p;
 	len = buflen;
-	prepend(&end, &len, "", 1);
 	/* Get '/' right */
 	retval = end-1;
 	*retval = '/';
@@ -373,27 +372,21 @@ static char *__dentry_path(const struct dentry *d, char *buf, int buflen)
 
 char *dentry_path_raw(const struct dentry *dentry, char *buf, int buflen)
 {
-	return __dentry_path(dentry, buf, buflen);
+	char *p = buf + buflen;
+	prepend(&p, &buflen, "", 1);
+	return __dentry_path(dentry, p, buflen);
 }
 EXPORT_SYMBOL(dentry_path_raw);
 
 char *dentry_path(const struct dentry *dentry, char *buf, int buflen)
 {
-	char *p = NULL;
-	char *retval;
-
-	if (d_unlinked(dentry)) {
-		p = buf + buflen;
-		if (prepend(&p, &buflen, "//deleted", 10) != 0)
-			goto Elong;
-		buflen++;
-	}
-	retval = __dentry_path(dentry, buf, buflen);
-	if (!IS_ERR(retval) && p)
-		*p = '/';	/* restore '/' overriden with '\0' */
-	return retval;
-Elong:
-	return ERR_PTR(-ENAMETOOLONG);
+	char *p = buf + buflen;
+
+	if (unlikely(d_unlinked(dentry)))
+		prepend(&p, &buflen, "//deleted", 10);
+	else
+		prepend(&p, &buflen, "", 1);
+	return __dentry_path(dentry, p, buflen);
 }
 
 static void get_fs_root_and_pwd_rcu(struct fs_struct *fs, struct path *root,
-- 
2.11.0

