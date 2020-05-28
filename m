Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4935E1E70C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 01:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437809AbgE1XuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437779AbgE1Xtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 19:49:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7078CC014D07;
        Thu, 28 May 2020 16:49:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSHD-00HDpH-Qb; Thu, 28 May 2020 23:49:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/6] uaccess: Add user_read_access_begin/end and user_write_access_begin/end
Date:   Fri, 29 May 2020 00:49:29 +0100
Message-Id: <20200528234931.4104686-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

Some architectures like powerpc64 have the capability to separate
read access and write access protection.
For get_user() and copy_from_user(), powerpc64 only open read access.
For put_user() and copy_to_user(), powerpc64 only open write access.
But when using unsafe_get_user() or unsafe_put_user(),
user_access_begin open both read and write.

Other architectures like powerpc book3s 32 bits only allow write
access protection. And on this architecture protection is an heavy
operation as it requires locking/unlocking per segment of 256Mbytes.
On those architecture it is therefore desirable to do the unlocking
only for write access. (Note that book3s/32 ranges from very old
powermac from the 90's with powerpc 601 processor, till modern
ADSL boxes with PowerQuicc II processors for instance so it
is still worth considering.)

In order to avoid any risk based of hacking some variable parameters
passed to user_access_begin/end that would allow hacking and
leaving user access open or opening too much, it is preferable to
use dedicated static functions that can't be overridden.

Add a user_read_access_begin and user_read_access_end to only open
read access.

Add a user_write_access_begin and user_write_access_end to only open
write access.

By default, when undefined, those new access helpers default on the
existing user_access_begin and user_access_end.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr
---
 include/linux/uaccess.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f016010aad..9861c89f93be 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -378,6 +378,14 @@ extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
 static inline unsigned long user_access_save(void) { return 0UL; }
 static inline void user_access_restore(unsigned long flags) { }
 #endif
+#ifndef user_write_access_begin
+#define user_write_access_begin user_access_begin
+#define user_write_access_end user_access_end
+#endif
+#ifndef user_read_access_begin
+#define user_read_access_begin user_access_begin
+#define user_read_access_end user_access_end
+#endif
 
 #ifdef CONFIG_HARDENED_USERCOPY
 void usercopy_warn(const char *name, const char *detail, bool to_user,
-- 
2.11.0

