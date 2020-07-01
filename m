Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA4211463
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgGAUXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgGAUXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2307EC08C5DB;
        Wed,  1 Jul 2020 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EBziasLTB9yyj8vVMRpUDtYmmAnu214zH16u+u17qnY=; b=pEpbLaESxCoTt41nhe9kG2n0n1
        MHTBgxpfs8AqHitxWlN7EWGWzBNP1Hf+bXZlNJ3vprmQQJVydwZsYEV1vOWJ3eZKDIIXK+wheIfMI
        XeObepc9N63+5ZH9p3+SYzGnexyAk+VDomiRPBxJ7Q9iusPF7I6JdsXfnw8kmU7UX5KMQxe8PpFXD
        RTCf5hopo9QpoNacxe+6OGRKL7RHd3rL8v3U67bf6MwTmu8pMcKFoVnVFBhizfhGEQCSBfTEmU9kg
        Z6wEoIxgsEz+tdw66tUcYYQDjoj0MYQclnwQaNfhXt2NWLiRPH7EUhFfTJC2BZY2G2aDFmdQ9ZF1A
        BUbBkZYQ==;
Received: from [2001:4bb8:18c:3b3b:379a:a079:66b5:89c3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjGA-0002QO-0b; Wed, 01 Jul 2020 20:23:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/23] integrity/ima: switch to using __kernel_read
Date:   Wed,  1 Jul 2020 22:09:38 +0200
Message-Id: <20200701200951.3603160-11-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701200951.3603160-1-hch@lst.de>
References: <20200701200951.3603160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__kernel_read has a bunch of additional sanity checks, and this moves
the set_fs out of non-core code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 security/integrity/iint.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index e12c4900510f60..1d20003243c3fb 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -188,19 +188,7 @@ DEFINE_LSM(integrity) = {
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count)
 {
-	mm_segment_t old_fs;
-	char __user *buf = (char __user *)addr;
-	ssize_t ret;
-
-	if (!(file->f_mode & FMODE_READ))
-		return -EBADF;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = __vfs_read(file, buf, count, &offset);
-	set_fs(old_fs);
-
-	return ret;
+	return __kernel_read(file, addr, count, &offset);
 }
 
 /*
-- 
2.26.2

