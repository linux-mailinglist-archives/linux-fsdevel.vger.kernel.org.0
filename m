Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5538840D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhESAwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352874AbhESAvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:51:04 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD93C06175F;
        Tue, 18 May 2021 17:49:45 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOT-00G4Fe-Ug; Wed, 19 May 2021 00:49:02 +0000
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
Subject: [PATCH 06/14] d_path: don't bother with return value of prepend()
Date:   Wed, 19 May 2021 00:48:53 +0000
Message-Id: <20210519004901.3829541-6-viro@zeniv.linux.org.uk>
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

Only simple_dname() checks it, and there we can simply do those
calls and check for overflow (by looking of negative buflen)
in the end.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 311d43287572..72b8087aaf9c 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -8,14 +8,13 @@
 #include <linux/prefetch.h>
 #include "mount.h"
 
-static int prepend(char **buffer, int *buflen, const char *str, int namelen)
+static void prepend(char **buffer, int *buflen, const char *str, int namelen)
 {
 	*buflen -= namelen;
-	if (*buflen < 0)
-		return -ENAMETOOLONG;
-	*buffer -= namelen;
-	memcpy(*buffer, str, namelen);
-	return 0;
+	if (likely(*buflen >= 0)) {
+		*buffer -= namelen;
+		memcpy(*buffer, str, namelen);
+	}
 }
 
 /**
@@ -298,11 +297,10 @@ char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
 {
 	char *end = buffer + buflen;
 	/* these dentries are never renamed, so d_lock is not needed */
-	if (prepend(&end, &buflen, " (deleted)", 11) ||
-	    prepend(&end, &buflen, dentry->d_name.name, dentry->d_name.len) ||
-	    prepend(&end, &buflen, "/", 1))  
-		end = ERR_PTR(-ENAMETOOLONG);
-	return end;
+	prepend(&end, &buflen, " (deleted)", 11);
+	prepend(&end, &buflen, dentry->d_name.name, dentry->d_name.len);
+	prepend(&end, &buflen, "/", 1);
+	return buflen >= 0 ? end : ERR_PTR(-ENAMETOOLONG);
 }
 
 /*
-- 
2.11.0

