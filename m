Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964313883F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352889AbhESAwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352863AbhESAu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:50:57 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC4C061761;
        Tue, 18 May 2021 17:49:38 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOT-00G4Fa-Mu; Wed, 19 May 2021 00:49:01 +0000
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
Subject: [PATCH 04/14] d_path: get rid of path_with_deleted()
Date:   Wed, 19 May 2021 00:48:51 +0000
Message-Id: <20210519004901.3829541-4-viro@zeniv.linux.org.uk>
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

expand in the sole caller; transform the initial prepends similar to
what we'd done in dentry_path() (prepend_path() will fail the right
way if we call it with negative buflen, same as __dentry_path() does).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index b3324ae7cfe2..7f3fac544bbb 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -211,23 +211,6 @@ char *d_absolute_path(const struct path *path,
 	return res;
 }
 
-/*
- * same as __d_path but appends "(deleted)" for unlinked files.
- */
-static int path_with_deleted(const struct path *path,
-			     const struct path *root,
-			     char **buf, int *buflen)
-{
-	prepend(buf, buflen, "", 1);
-	if (d_unlinked(path->dentry)) {
-		int error = prepend(buf, buflen, " (deleted)", 10);
-		if (error)
-			return error;
-	}
-
-	return prepend_path(path, root, buf, buflen);
-}
-
 static int prepend_unreachable(char **buffer, int *buflen)
 {
 	return prepend(buffer, buflen, "(unreachable)", 13);
@@ -282,7 +265,11 @@ char *d_path(const struct path *path, char *buf, int buflen)
 
 	rcu_read_lock();
 	get_fs_root_rcu(current->fs, &root);
-	error = path_with_deleted(path, &root, &res, &buflen);
+	if (unlikely(d_unlinked(path->dentry)))
+		prepend(&res, &buflen, " (deleted)", 11);
+	else
+		prepend(&res, &buflen, "", 1);
+	error = prepend_path(path, &root, &res, &buflen);
 	rcu_read_unlock();
 
 	if (error < 0)
-- 
2.11.0

