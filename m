Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45D834AA25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCZOj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhCZOjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:39:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC91C0613AA;
        Fri, 26 Mar 2021 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7gG07jJWdVdkveJTg0m/JRPJ+82hLCG/BeQINxDX6bU=; b=D0aRvZfUwo4S5aaCsJt561vjqM
        xaOTDqqsYCfGC25oUmioZexS8odCWf3uARtuUQGiuIKThTV5mYEfMPFHN/0Spsff+MrDYZv8TXLQP
        PJeY4TOdB437fk7H/dCXxvaEvdZDLk99kZt3pDcJikdEeR9gVlBl91iVG5Dr+RHOuRiG0rhSBAPpG
        ugsSvI20mRLSN7CXP1owGVW/FBNDmzXrR+Nnzxm7LU/k17Js3TAtzxuyr7aMymvve5r5N/hUX/2Th
        sfIPFFMKKFFVp85fcpS40i7HKn9o8s39mE8CRL/cYOw2j7B4emzTxY29I5IegFuL6rBdz15cpJqKU
        T4zrs2PA==;
Received: from [213.208.157.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPnbz-005U6v-WC; Fri, 26 Mar 2021 14:38:58 +0000
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
Subject: [PATCH 2/4] exec: remove compat_do_execve
Date:   Fri, 26 Mar 2021 15:38:29 +0100
Message-Id: <20210326143831.1550030-3-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210326143831.1550030-1-hch@lst.de>
References: <20210326143831.1550030-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just call compat_do_execve instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b63fb020909075..06e07278b456fa 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1990,21 +1990,6 @@ static int do_execveat(int fd, struct filename *filename,
 }
 
 #ifdef CONFIG_COMPAT
-static int compat_do_execve(struct filename *filename,
-	const compat_uptr_t __user *__argv,
-	const compat_uptr_t __user *__envp)
-{
-	struct user_arg_ptr argv = {
-		.is_compat = true,
-		.ptr.compat = __argv,
-	};
-	struct user_arg_ptr envp = {
-		.is_compat = true,
-		.ptr.compat = __envp,
-	};
-	return do_execveat_common(AT_FDCWD, filename, argv, envp, 0);
-}
-
 static int compat_do_execveat(int fd, struct filename *filename,
 			      const compat_uptr_t __user *__argv,
 			      const compat_uptr_t __user *__envp,
@@ -2072,7 +2057,7 @@ COMPAT_SYSCALL_DEFINE3(execve, const char __user *, filename,
 	const compat_uptr_t __user *, argv,
 	const compat_uptr_t __user *, envp)
 {
-	return compat_do_execve(getname(filename), argv, envp);
+	return compat_do_execveat(AT_FDCWD, getname(filename), argv, envp, 0);
 }
 
 COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
-- 
2.30.1

