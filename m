Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0C4158F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 09:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhIWHVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 03:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhIWHVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:21:43 -0400
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Sep 2021 00:20:12 PDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31156C061574;
        Thu, 23 Sep 2021 00:20:12 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 7F7CA100266;
        Thu, 23 Sep 2021 17:13:40 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uORAQQHh4x1W; Thu, 23 Sep 2021 17:13:40 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 6D4D9100278; Thu, 23 Sep 2021 17:13:40 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        smtp01.aussiebb.com.au
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=10.0 tests=RDNS_NONE,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
Received: from mickey.themaw.net (unknown [100.72.131.210])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id C556C100266;
        Thu, 23 Sep 2021 17:13:39 +1000 (AEST)
Subject: [PATCH] autofs: fix wait name hash calculation in autofs_wait()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 23 Sep 2021 15:13:39 +0800
Message-ID: <163238121836.315941.18066358755443618960.stgit@mickey.themaw.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a mistake in commit 2be7828c9fefc ("get rid of autofs_getpath()")
that affects kernels from v5.13.0, basically missed because of me not
fully testing the change for Al.

The problem is that the hash calculation for the wait name qstr hasn't
been updated to account for the change to use dentry_path_raw(). This
prevents the correct matching an existing wait resulting in multiple
notifications being sent to the daemon for the same mount which must
not occur.

The problem wasn't discovered earlier because it only occurs when
multiple processes trigger a request for the same mount concurrently
so it only shows up in more aggressive testing.

Fixes: 2be7828c9fefc ("get rid of autofs_getpath()")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/waitq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 16b5fca0626e..54c1f8b8b075 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -358,7 +358,7 @@ int autofs_wait(struct autofs_sb_info *sbi,
 		qstr.len = strlen(p);
 		offset = p - name;
 	}
-	qstr.hash = full_name_hash(dentry, name, qstr.len);
+	qstr.hash = full_name_hash(dentry, qstr.name, qstr.len);
 
 	if (mutex_lock_interruptible(&sbi->wq_mutex)) {
 		kfree(name);


