Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16923883F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352895AbhESAwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbhESAu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:50:57 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFB6C06175F;
        Tue, 18 May 2021 17:49:37 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOT-00G4FY-K4; Wed, 19 May 2021 00:49:01 +0000
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
Subject: [PATCH 03/14] d_path: regularize handling of root dentry in __dentry_path()
Date:   Wed, 19 May 2021 00:48:50 +0000
Message-Id: <20210519004901.3829541-3-viro@zeniv.linux.org.uk>
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

All path-forming primitives boil down to sequence of prepend_name()
on dentries encountered along the way toward root.  Each time we prepend
/ + dentry name to the buffer.  Normally that does exactly what we want,
but there's a corner case when we don't call prepend_name() at all (in case
of __dentry_path() that happens if we are given root dentry).  We obviously
want to end up with "/", rather than "", so this corner case needs to be
handled.

__dentry_path() used to manually put '/' in the end of buffer before
doing anything else, to be overwritten by the first call of prepend_name()
if one happens and to be left in place if we don't call prepend_name() at
all.  That required manually checking that we had space in the buffer
(prepend_name() and prepend() take care of such checks themselves) and lead
to clumsy keeping track of return value.

A better approach is to check if the main loop has added anything
into the buffer and prepend "/" if it hasn't.  A side benefit of using prepend()
is that it does the right thing if we'd already run out of buffer, making
the overflow-handling logics simpler.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 1a1cf05e7780..b3324ae7cfe2 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -329,31 +329,22 @@ char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
 static char *__dentry_path(const struct dentry *d, char *p, int buflen)
 {
 	const struct dentry *dentry;
-	char *end, *retval;
+	char *end;
 	int len, seq = 0;
-	int error = 0;
-
-	if (buflen < 1)
-		goto Elong;
 
 	rcu_read_lock();
 restart:
 	dentry = d;
 	end = p;
 	len = buflen;
-	/* Get '/' right */
-	retval = end-1;
-	*retval = '/';
 	read_seqbegin_or_lock(&rename_lock, &seq);
 	while (!IS_ROOT(dentry)) {
 		const struct dentry *parent = dentry->d_parent;
 
 		prefetch(parent);
-		error = prepend_name(&end, &len, &dentry->d_name);
-		if (error)
+		if (unlikely(prepend_name(&end, &len, &dentry->d_name) < 0))
 			break;
 
-		retval = end;
 		dentry = parent;
 	}
 	if (!(seq & 1))
@@ -363,11 +354,9 @@ static char *__dentry_path(const struct dentry *d, char *p, int buflen)
 		goto restart;
 	}
 	done_seqretry(&rename_lock, seq);
-	if (error)
-		goto Elong;
-	return retval;
-Elong:
-	return ERR_PTR(-ENAMETOOLONG);
+	if (len == buflen)
+		prepend(&end, &len, "/", 1);
+	return len >= 0 ? end : ERR_PTR(-ENAMETOOLONG);
 }
 
 char *dentry_path_raw(const struct dentry *dentry, char *buf, int buflen)
-- 
2.11.0

