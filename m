Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D920BF7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 09:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgF0H1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgF0H1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:27:49 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17DAC03E979;
        Sat, 27 Jun 2020 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6JtQFSFZNuHNYVW/hbRiOl0cmjzNgKOe7nvuIEAqZOM=; b=XI6CndVIJXMc32UDFraE+/6BDg
        kgds46nEXHDzwZqAki7Xb/CkKeJmq+gVJ2JvzJ+lQCBP0sos5RAoQ3vxfhbkC+HV9yZJWF5cYmSlt
        yJzPIZc1/FtkoJpBFgLIg6cR0UZEiIYy/d3lp4NDmonFbNY45srXYi70rr1817pjw+ECoDyEWFE4i
        RWKBBRkhhsWXJwaX4Gee6Ibaxv79W68lBh2leHgVD/F2uOHmizhBuO1H84Aq4FfnyBZUyjmrpaLul
        AfaqHFl5sBzlXCSXZ33BEukRpaDWm9lpNdx9d5FLRiYJSgKkNbGtmyNGWh24+udriGn3MVst9oeaO
        S4UZ/j6g==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5FG-0006XG-3J; Sat, 27 Jun 2020 07:27:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] exec: split prepare_arg_pages
Date:   Sat, 27 Jun 2020 09:27:03 +0200
Message-Id: <20200627072704.2447163-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627072704.2447163-1-hch@lst.de>
References: <20200627072704.2447163-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move counting the arguments and enviroment variables out of
prepare_arg_pages and rename the rest of the function to check_arg_limit.
This prepares for a version of do_execvat that takes kernel pointers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a5d91f8b1341d5..34781db6bf6889 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -435,20 +435,10 @@ static int count_strings(const char __user *const __user *argv)
 	return i;
 }
 
-static int prepare_arg_pages(struct linux_binprm *bprm,
-		const char __user *const __user *argv,
-		const char __user *const __user *envp)
+static int check_arg_limit(struct linux_binprm *bprm)
 {
 	unsigned long limit, ptr_size;
 
-	bprm->argc = count_strings(argv);
-	if (bprm->argc < 0)
-		return bprm->argc;
-
-	bprm->envc = count_strings(envp);
-	if (bprm->envc < 0)
-		return bprm->envc;
-
 	/*
 	 * Limit to 1/4 of the max stack size or 3/4 of _STK_LIM
 	 * (whichever is smaller) for the argv+env strings.
@@ -1886,7 +1876,19 @@ int do_execveat(int fd, struct filename *filename,
 	if (retval)
 		goto out_unmark;
 
-	retval = prepare_arg_pages(bprm, argv, envp);
+	bprm->argc = count_strings(argv);
+	if (bprm->argc < 0) {
+		retval = bprm->argc;
+		goto out;
+	}
+
+	bprm->envc = count_strings(envp);
+	if (bprm->envc < 0) {
+		retval = bprm->envc;
+		goto out;
+	}
+
+	retval = check_arg_limit(bprm);
 	if (retval < 0)
 		goto out;
 
-- 
2.26.2

