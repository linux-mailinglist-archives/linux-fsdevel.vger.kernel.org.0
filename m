Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D35534AA41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 15:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhCZOkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 10:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhCZOjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:39:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBBC0613AA;
        Fri, 26 Mar 2021 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/jKV/Gy/+fs6Gymuc4/KOBeEW5L+yZioO5xj7LGmOvk=; b=btDOhdv9dVGM1bGt10zskeqyPc
        IJAjY5J3M0V2Ssi7NNgeil59DhlO7E6oivZQivAq28Yc/KdK5u93ZUzDZoVMRBaqlxf7Hzy6oPSFM
        Gc7pPPsejd0I1/ziak6y+NLOOzg/pHXRIHbvit+wD4AvJYsnF0HfOWu5pwz5GIOWq8HdAkje6X7N3
        TUJFPYXDjR9Q79HD9E3nT09I7Kla49p7nnSeVcJQ8d4upVPhE6fnygZAebM1joGOA27iFFm/o0+/B
        mCSb1li1OrgAlMOR/k7wZ8wo7QJW5gJo0hZgzjjtivcofkbuzF9JLCQDLtOI6vcJLBXrOv9eI7Fih
        ZqqU60vg==;
Received: from [213.208.157.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPncI-005U87-0D; Fri, 26 Mar 2021 14:39:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] exec: move the call to getname_flags into do_execveat
Date:   Fri, 26 Mar 2021 15:38:31 +0100
Message-Id: <20210326143831.1550030-5-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210326143831.1550030-1-hch@lst.de>
References: <20210326143831.1550030-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the duplicated copying of the pathname into the common helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b34c1eb9e7ad8e..5c0dd8f85fe7b5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1843,13 +1843,16 @@ static int bprm_execve(struct linux_binprm *bprm,
 	return retval;
 }
 
-static int do_execveat(int fd, struct filename *filename,
+static int do_execveat(int fd, const char __user *pathname,
 		const char __user *const __user *argv,
 		const char __user *const __user *envp, int flags)
 {
+	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	struct filename *filename;
 	struct linux_binprm *bprm;
 	int retval;
 
+	filename = getname_flags(pathname, lookup_flags, NULL);
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
 
@@ -1993,7 +1996,7 @@ SYSCALL_DEFINE3(execve,
 		const char __user *const __user *, argv,
 		const char __user *const __user *, envp)
 {
-	return do_execveat(AT_FDCWD, getname(filename), argv, envp, 0);
+	return do_execveat(AT_FDCWD, filename, argv, envp, 0);
 }
 
 SYSCALL_DEFINE5(execveat,
@@ -2002,9 +2005,5 @@ SYSCALL_DEFINE5(execveat,
 		const char __user *const __user *, envp,
 		int, flags)
 {
-	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
-
-	return do_execveat(fd,
-			   getname_flags(filename, lookup_flags, NULL),
-			   argv, envp, flags);
+	return do_execveat(fd, filename, argv, envp, flags);
 }
-- 
2.30.1

