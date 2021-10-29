Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2405440255
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 20:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhJ2Sri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhJ2Sri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:47:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21092C061570;
        Fri, 29 Oct 2021 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CinqUVkMzd6CB9z1z2X8npZ2uAGAUzQCiqL6GyuyIm0=; b=a72lUGBYbV0SGTwe2YBTsJbi+e
        FQQucBlD2VvlZG8WToyNmZLd7BPi0q+zFEQmGjZF0KcNzUwqLtVY8NCT/33gA/I8HmN9GfTZKrWrv
        jJwxD33ofoJQLLr7G9jhfF6g9QQW17Vi/72ySUvvOWZ7bpm3jz8jKbdL4N6XLVCQ/CHP0sawLaiSt
        iKPm+rsQaLJm1YIc9/BaCtbYBEc4N2eHOxqP3Q9bausP84a4f69c+lIleXtk+RnVgvpbdoLxldeb9
        A5Lfa5R5JuRRM5qljbCNxcFrRh9no+AM+LvSpVVppgzmjhliWdZyv7Gg7Ux8gmqPdXdRcJEjhWDEk
        OvW4Y17g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgWsA-00Bq0Z-Kp; Fri, 29 Oct 2021 18:45:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org
Cc:     bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/6] kernel/module: add documentation for try_module_get()
Date:   Fri, 29 Oct 2021 11:45:00 -0700
Message-Id: <20211029184500.2821444-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211029184500.2821444-1-mcgrof@kernel.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is quite a bit of tribal knowledge around proper use of
try_module_get() and that it must be used only in a context which
can ensure the module won't be gone during the operation. Document
this little bit of tribal knowledge.

I'm extending this tribal knowledge with new developments which it
seems some folks do not yet believe to be true: we can be sure a
module will exist during the lifetime of a sysfs file operation.
For proof, refer to test_sysfs test #32:

./tools/testing/selftests/sysfs/sysfs.sh -t 0032

Without this being true, the write would fail or worse,
a crash would happen, in this test. It does not.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/module.h | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index c9f1200b2312..35c98e4196cb 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -609,10 +609,43 @@ void symbol_put_addr(void *addr);
    to handle the error case (which only happens with rmmod --wait). */
 extern void __module_get(struct module *module);
 
-/* This is the Right Way to get a module: if it fails, it's being removed,
- * so pretend it's not there. */
+/**
+ * try_module_get() - Take module refcount unless module is being removed
+ * @module: the module we should check for
+ *
+ * This can be used to try to bump the reference count of a module, so to
+ * prevent module removal. The reference count of a module is not allowed
+ * to be incremented if the module is already being removed.
+ *
+ * Care must be taken to ensure the module cannot be removed during the call to
+ * try_module_get() because otherwise use of this routine could crash the kernel
+ * when racing to remove a module. Proper care can be taken by having another
+ * entity other than the module itself increment the module reference count,
+ * or through some other means which guarantees the module could not be removed
+ * during an operation. An example of this later case is using try_module_get()
+ * in a sysfs file which the module created. The sysfs store / read file
+ * operations are gauranteed to exist through the use of kernfs's active
+ * reference (see kernfs_active()). If a sysfs file operation is being run,
+ * the module which created it must still exist as the module is in charge of
+ * removing the same sysfs file being used. A sysfs / kernfs file removal
+ * cannot happen unless the same file does not have an active reference.
+ *
+ * One of the real values to try_module_get() is the module_is_live() check
+ * which ensures this the caller of try_module_get() can yield to userspace
+ * module removal requests and fail whatever it was about to process.
+ *
+ * Returns true if the reference count was successfully incremented.
+ */
 extern bool try_module_get(struct module *module);
 
+/**
+ * module_put() - release a reference count to a module
+ * @module: the module we should release a reference count for
+ *
+ * If you successfully bump a reference count to a module with try_module_get(),
+ * when you are finished you must call module_put() to release that reference
+ * count.
+ */
 extern void module_put(struct module *module);
 
 #else /*!CONFIG_MODULE_UNLOAD*/
-- 
2.30.2

