Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98738840F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 02:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352893AbhESAwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 20:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhESAvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 20:51:08 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD0C06175F;
        Tue, 18 May 2021 17:49:49 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljAOU-00G4Fs-JV; Wed, 19 May 2021 00:49:02 +0000
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
Subject: [PATCH 13/14] d_path: prepend_path() is unlikely to return non-zero
Date:   Wed, 19 May 2021 00:49:00 +0000
Message-Id: <20210519004901.3829541-13-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index ba629879a4bf..8a9cd44f6689 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -187,7 +187,7 @@ char *__d_path(const struct path *path,
 	DECLARE_BUFFER(b, buf, buflen);
 
 	prepend(&b, "", 1);
-	if (prepend_path(path, root, &b) > 0)
+	if (unlikely(prepend_path(path, root, &b) > 0))
 		return NULL;
 	return extract_string(&b);
 }
@@ -199,7 +199,7 @@ char *d_absolute_path(const struct path *path,
 	DECLARE_BUFFER(b, buf, buflen);
 
 	prepend(&b, "", 1);
-	if (prepend_path(path, &root, &b) > 1)
+	if (unlikely(prepend_path(path, &root, &b) > 1))
 		return ERR_PTR(-EINVAL);
 	return extract_string(&b);
 }
@@ -396,7 +396,7 @@ SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
 		DECLARE_BUFFER(b, page, PATH_MAX);
 
 		prepend(&b, "", 1);
-		if (prepend_path(&pwd, &root, &b) > 0)
+		if (unlikely(prepend_path(&pwd, &root, &b) > 0))
 			prepend(&b, "(unreachable)", 13);
 		rcu_read_unlock();
 
-- 
2.11.0

