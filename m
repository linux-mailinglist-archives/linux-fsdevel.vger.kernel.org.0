Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F56B1F97A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 15:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgFONA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730365AbgFONAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:00:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232CBC05BD43;
        Mon, 15 Jun 2020 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZZGHsoXTnXgAmRUOcfo4lrl/+NT7PZj7FPHx1htWx6U=; b=o2RhlHWQ1U73lI4UBKreMeuh1d
        V96c20aFyOomEbcWIphJ3pyFjo5ItIgAm/KJIp5Sh1J+gPI5HXmI2YG1i19dy0QhOUqa5pA81t8KD
        8/u9BQVaEmeq5snWMfRRjHfqH9pEVoWlA2NmGYotUCCMF4BVxoOflkeOJwlSnXr92QyTzmss9vYvp
        2FljztR/Rre+glKjpQSOqFsSl+so6GyRD1Gz9+tBqcY5EzihIIRZ/cHIDuBAmZeBeHYYSHNAPg77K
        9wpc/KR89+aovx2wkhPYW15B4NlsBqIVk/0t+F3bcJ4qSvUnBH8prQVTmMXJr70LHsZmWncdVjCvE
        mVSsqGbw==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkojF-0007w7-BU; Mon, 15 Jun 2020 13:00:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] exec: split prepare_arg_pages
Date:   Mon, 15 Jun 2020 15:00:30 +0200
Message-Id: <20200615130032.931285-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615130032.931285-1-hch@lst.de>
References: <20200615130032.931285-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
index 6e4d9d1ffa35fa..696b1e8180d7d8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -439,20 +439,10 @@ static int count_strings(const char __user *const __user *argv)
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
@@ -1890,7 +1880,19 @@ int do_execveat(int fd, struct filename *filename,
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

