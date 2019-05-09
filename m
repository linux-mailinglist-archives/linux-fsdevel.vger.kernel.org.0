Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4493C188EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEIL2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 07:28:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32928 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfEIL2J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 07:28:09 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6FC508F0FA1104671975;
        Thu,  9 May 2019 12:28:07 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 9 May 2019 12:27:57 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zohar@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>, <dmitry.kasatkin@huawei.com>,
        <takondra@cisco.com>, <kamensky@cisco.com>, <hpa@zytor.com>,
        <arnd@arndb.de>, <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 1/3] fs: add ksys_lsetxattr() wrapper
Date:   Thu, 9 May 2019 13:24:18 +0200
Message-ID: <20190509112420.15671-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509112420.15671-1-roberto.sassu@huawei.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similarly to commit 03450e271a16 ("fs: add ksys_fchmod() and do_fchmodat()
helpers and ksys_chmod() wrapper; remove in-kernel calls to syscall"), this
patch introduces the ksys_lsetxattr() helper to avoid in-kernel calls to
the sys_lsetxattr() syscall.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/xattr.c               | 9 ++++++++-
 include/linux/syscalls.h | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 0d6a6a4af861..422b3d481edb 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -484,11 +484,18 @@ SYSCALL_DEFINE5(setxattr, const char __user *, pathname,
 	return path_setxattr(pathname, name, value, size, flags, LOOKUP_FOLLOW);
 }
 
+int ksys_lsetxattr(const char __user *pathname,
+		   const char __user *name, const void __user *value,
+		   size_t size, int flags)
+{
+	return path_setxattr(pathname, name, value, size, flags, 0);
+}
+
 SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 		const char __user *, name, const void __user *, value,
 		size_t, size, int, flags)
 {
-	return path_setxattr(pathname, name, value, size, flags, 0);
+	return ksys_lsetxattr(pathname, name, value, size, flags);
 }
 
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e446806a561f..b639f13cd1f8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1260,6 +1260,9 @@ int ksys_ipc(unsigned int call, int first, unsigned long second,
 	unsigned long third, void __user * ptr, long fifth);
 int compat_ksys_ipc(u32 call, int first, int second,
 	u32 third, u32 ptr, u32 fifth);
+int ksys_lsetxattr(const char __user *pathname,
+		   const char __user *name, const void __user *value,
+		   size_t size, int flags);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
-- 
2.17.1

