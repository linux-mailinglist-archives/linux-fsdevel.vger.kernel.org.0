Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24AE3883EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352881AbhESAwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbhESAu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:50:57 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F09C0613CE;
        Tue, 18 May 2021 17:49:38 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOU-00G4Fi-6F; Wed, 19 May 2021 00:49:02 +0000
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
Subject: [PATCH 08/14] d_path: make prepend_name() boolean
Date:   Wed, 19 May 2021 00:48:55 +0000
Message-Id: <20210519004901.3829541-8-viro@zeniv.linux.org.uk>
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

It returns only 0 or -ENAMETOOLONG and both callers only check if
the result is negative.  Might as well return true on success and
false on failure...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 327cc3744554..83db83446afd 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -34,15 +34,15 @@ static void prepend(char **buffer, int *buflen, const char *str, int namelen)
  *
  * Load acquire is needed to make sure that we see that terminating NUL.
  */
-static int prepend_name(char **buffer, int *buflen, const struct qstr *name)
+static bool prepend_name(char **buffer, int *buflen, const struct qstr *name)
 {
 	const char *dname = smp_load_acquire(&name->name); /* ^^^ */
 	u32 dlen = READ_ONCE(name->len);
 	char *p;
 
 	*buflen -= dlen + 1;
-	if (*buflen < 0)
-		return -ENAMETOOLONG;
+	if (unlikely(*buflen < 0))
+		return false;
 	p = *buffer -= dlen + 1;
 	*p++ = '/';
 	while (dlen--) {
@@ -51,7 +51,7 @@ static int prepend_name(char **buffer, int *buflen, const struct qstr *name)
 			break;
 		*p++ = c;
 	}
-	return 0;
+	return true;
 }
 
 /**
@@ -127,7 +127,7 @@ static int prepend_path(const struct path *path,
 		}
 		parent = dentry->d_parent;
 		prefetch(parent);
-		if (unlikely(prepend_name(&bptr, &blen, &dentry->d_name) < 0))
+		if (!prepend_name(&bptr, &blen, &dentry->d_name))
 			break;
 
 		dentry = parent;
@@ -305,7 +305,7 @@ static char *__dentry_path(const struct dentry *d, char *p, int buflen)
 		const struct dentry *parent = dentry->d_parent;
 
 		prefetch(parent);
-		if (unlikely(prepend_name(&end, &len, &dentry->d_name) < 0))
+		if (!prepend_name(&end, &len, &dentry->d_name))
 			break;
 
 		dentry = parent;
-- 
2.11.0

