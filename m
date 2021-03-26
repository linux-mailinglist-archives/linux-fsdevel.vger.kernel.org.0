Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CED34AA2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 15:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhCZOja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 10:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhCZOjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:39:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A95AC0613AA;
        Fri, 26 Mar 2021 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ik1ZxFDTbN543xAdjkIaY+LrhRyZTgPPWblbYOdt+Ho=; b=nG0Tk1zj75N7RMl5ukKyw29ZN3
        b+NOjFYQo+wu7oBBfqqtji5laQisXQUxuPMbt4PIZGaF5UD040L3w0xZQgANcLCj4xlzSLv5c2bi0
        lg9LbshcQpAREZtrDf18Q/SG8yTj+moIlWxcm5A0jZuwX9nyD35AhobYsHKdA5fX54UC0vHu8806g
        gsQQ4ddMqtHcBjByEmM6PFfM8jGudMsMvUmqfrPkPqsQZUPyECPVNPi/pHwO/6wQl9g9tp+eSJhLo
        ky70B67w9ulsBx+95/RE/FpcWOmqKKR/GxCJeqMv1ybsBv6RXTwNNLaTgHmzPqWkAYUa8nGsQP8tS
        c4NX3KcA==;
Received: from [213.208.157.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPnbr-005U6S-Bx; Fri, 26 Mar 2021 14:38:47 +0000
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
Subject: [PATCH 1/4] exec: remove do_execve
Date:   Fri, 26 Mar 2021 15:38:28 +0100
Message-Id: <20210326143831.1550030-2-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210326143831.1550030-1-hch@lst.de>
References: <20210326143831.1550030-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just call do_execveat instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31fe1..b63fb020909075 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1978,15 +1978,6 @@ int kernel_execve(const char *kernel_filename,
 	return retval;
 }
 
-static int do_execve(struct filename *filename,
-	const char __user *const __user *__argv,
-	const char __user *const __user *__envp)
-{
-	struct user_arg_ptr argv = { .ptr.native = __argv };
-	struct user_arg_ptr envp = { .ptr.native = __envp };
-	return do_execveat_common(AT_FDCWD, filename, argv, envp, 0);
-}
-
 static int do_execveat(int fd, struct filename *filename,
 		const char __user *const __user *__argv,
 		const char __user *const __user *__envp,
@@ -2060,7 +2051,7 @@ SYSCALL_DEFINE3(execve,
 		const char __user *const __user *, argv,
 		const char __user *const __user *, envp)
 {
-	return do_execve(getname(filename), argv, envp);
+	return do_execveat(AT_FDCWD, getname(filename), argv, envp, 0);
 }
 
 SYSCALL_DEFINE5(execveat,
-- 
2.30.1

