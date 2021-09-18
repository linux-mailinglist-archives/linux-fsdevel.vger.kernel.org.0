Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8CF4103D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 07:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbhIRFGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 01:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhIRFGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:06:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBBCC061574;
        Fri, 17 Sep 2021 22:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=b92mAeHk3N99JPkWqvyo9aOeWc+3cnxJoDw3jDX8Mm4=; b=eeTtMC4wY8BdtQg0gqt80SxVcA
        39IX+w7rFelMrvoaCFJiUd4nRKVK/sHW5Pt/0Fs+3nxOC95/mHALQY8xvC5uUwIwcYfxEuGTRYres
        BlYNIV4cy+WFIMeWlhvipLU5HDynUEWiS+Y2fOjqwi6IC210qa1yrSxSSRWkhjRn9kk9+ZeKGI7pM
        zm6fC6FiL/KMGFgNYLCc/HgJPkvyVg0WyRY2AV+y2NREIsZVOyoNkEpT/XyWUMHiDAcWxArrABs4y
        DJ93zDKWK9wvwbgdcJRjEloQBvTBaooSDmOwF4mgUxh//Pz0J8bmQg5ZRwvbpqUOioenmuCS4+SHv
        FdNs8PCw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRSWf-00FP4W-5L; Sat, 18 Sep 2021 05:04:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org
Cc:     rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@ACULAB.COM,
        bvanassche@acm.org, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        mcgrof@kernel.org, reinette.chatre@intel.com, fenghua.yu@intel.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, bhelgaas@google.com, kw@linux.com,
        dan.j.williams@intel.com, senozhatsky@chromium.org, hch@lst.de,
        joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: [PATCH v7 06/12] kernel/module: add documentation for try_module_get()
Date:   Fri, 17 Sep 2021 22:04:24 -0700
Message-Id: <20210918050430.3671227-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918050430.3671227-1-mcgrof@kernel.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
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
 include/linux/module.h | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index c9f1200b2312..22eacd5e1e85 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -609,10 +609,40 @@ void symbol_put_addr(void *addr);
    to handle the error case (which only happens with rmmod --wait). */
 extern void __module_get(struct module *module);
 
-/* This is the Right Way to get a module: if it fails, it's being removed,
- * so pretend it's not there. */
+/**
+ * try_module_get() - yields to module removal and bumps refcnt otherwise
+ * @module: the module we should check for
+ *
+ * This can be used to try to bump the reference count of a module, so to
+ * prevent module removal. The reference count of a module is not allowed
+ * to be incremented if the module is already being removed.
+ *
+ * Care must be taken to ensure the module cannot be removed during the call to
+ * try_module_get(). This can be done by having another entity other than the
+ * module itself increment the module reference count, or through some other
+ * means which guarantees the module could not be removed during an operation.
+ * An example of this later case is using try_module_get() in a sysfs file
+ * which the module created. The sysfs store / read file operations are
+ * gauranteed to exist through the use of kernfs's active reference (see
+ * kernfs_active()). If a sysfs file operation is being run, the module which
+ * created it must still exist as the module is in charge of removing the same
+ * sysfs file being read. Also, a sysfs / kernfs file removal cannot happen
+ * unless the same file is not active.
+ *
+ * One of the real values to try_module_get() is the module_is_live() check
+ * which ensures this the caller of try_module_get() can yield to userspace
+ * module removal requests and fail whatever it was about to process.
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

