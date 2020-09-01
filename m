Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A058259785
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgIAQPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbgIAQPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:15:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B1C061245
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 09:15:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so1068002pfi.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1h0WFxrmlZti/5PdriJmCxO8e4BuJ9nFjihIY3qycs=;
        b=DMJZzRBurdYUN4x8gReiESvjIjB6WMHksdeGaRDN41WunAsqZ5Yvt1bO5dntkRFy3t
         8wwhIkp4rgfa2J7aKnYStujtMWjfHwnF6BkSHyc7XPqxl15S8Wx58seJIlrKeXoJmuGj
         MQaukCMelikiVQ/1Wm711W7exb+6DNt43lv72RbxdW6K74pL+q9Y56zYnklCSiMeeL35
         pRebHGva3Zi2MmJ3dxDLMqa5QnCLLLYiGadJKrLiaLGeasmp+w0PpyFwxsv0zQw8Or3z
         1eho9mmEcHG7AK6OcGSov1ce9KH+R9Js6Mtep8s4aW9yT+PGaaaWQiXvT8tY8YznovIj
         7SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1h0WFxrmlZti/5PdriJmCxO8e4BuJ9nFjihIY3qycs=;
        b=du+3v1FwR9Xeis39wptOBf0iDaUcOdEIbTlpLaRNPoyReEDEpxqmn88mmf5XwnJIqc
         qBGxjrldauC7ZJU6Co66RizI6XwfEl2QSjXkkVCf+9BDi/S0pQheiVnqLDnYmi0hFX87
         U+x/HZ82uiybcTypzfIZXlJpizAywOvrO3VPo5drlqEvDbi5i+uT5DY0iamRcWIEKrf7
         O5rdCM1BaeqsVrSuoDTnJGDu9wsysyybc2T/YQfe7oEuEQw6LQoSy1wo7CgICkueqrKX
         n07h2S8mYLQtYQKm8zeUUibgmn2/yX9oZ3JdnYm0JRZOCtGJb0w9BNKvWxwIJ5XhQD+c
         cUQg==
X-Gm-Message-State: AOAM5312NhCwKKW/peVPCR/kCen5YtY1mBhqJhl2GJ9AwTrtquaYPgPp
        RO9RsOswyW7cVSs0Dao/pBygew==
X-Google-Smtp-Source: ABdhPJzWV89RR/QWyu3dI160WKOjSKjBNJugNB1VuwvaljQHlhcb659AvPrOk3k8yapRkjnyxkRAeg==
X-Received: by 2002:a63:1b42:: with SMTP id b2mr1968103pgm.397.1598976938667;
        Tue, 01 Sep 2020 09:15:38 -0700 (PDT)
Received: from nagraj.lan ([175.100.146.50])
        by smtp.gmail.com with ESMTPSA id d77sm2553169pfd.121.2020.09.01.09.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 09:15:37 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Colin Cross <ccross@google.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michel Lespinasse <walken@google.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        chenqiwu <chenqiwu@xiaomi.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Adrian Reber <areber@redhat.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v7 2/3] mm: memory: Add access_remote_vm_locked variant
Date:   Tue,  1 Sep 2020 21:44:58 +0530
Message-Id: <20200901161459.11772-3-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901161459.11772-1-sumit.semwal@linaro.org>
References: <20200901161459.11772-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows accessing a remote vm while the mmap_lock is already
held by the caller.

While adding support for anonymous vma naming, show_map_vma()
needs to access the remote vm to get the name of the anonymous vma.
Since show_map_vma() already holds the mmap_lock, so this _locked
variant was required.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 49 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ca6e6a81576b..e9212c0bb5ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1708,6 +1708,8 @@ extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 extern int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long addr, void *buf, int len, unsigned int gup_flags);
+extern int access_remote_vm_locked(struct mm_struct *mm, unsigned long addr,
+				   void *buf, int len, unsigned int gup_flags);
 
 long get_user_pages_remote(struct mm_struct *mm,
 			    unsigned long start, unsigned long nr_pages,
diff --git a/mm/memory.c b/mm/memory.c
index 602f4283122f..207be99390e9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4726,17 +4726,17 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
 /*
  * Access another process' address space as given in mm.  If non-NULL, use the
  * given task for page fault accounting.
+ * This variant assumes that the mmap_lock is already held by the caller, so
+ * doesn't take the mmap_lock.
  */
-int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long addr, void *buf, int len, unsigned int gup_flags)
+int __access_remote_vm_locked(struct task_struct *tsk, struct mm_struct *mm,
+			      unsigned long addr, void *buf, int len,
+			      unsigned int gup_flags)
 {
 	struct vm_area_struct *vma;
 	void *old_buf = buf;
 	int write = gup_flags & FOLL_WRITE;
 
-	if (mmap_read_lock_killable(mm))
-		return 0;
-
 	/* ignore errors, just check how much was successfully transferred */
 	while (len) {
 		int bytes, ret, offset;
@@ -4785,9 +4785,46 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 		buf += bytes;
 		addr += bytes;
 	}
+	return buf - old_buf;
+}
+
+/*
+ * Access another process' address space as given in mm.  If non-NULL, use the
+ * given task for page fault accounting.
+ */
+int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
+		       unsigned long addr, void *buf, int len, unsigned int gup_flags)
+{
+	int ret;
+
+	if (mmap_read_lock_killable(mm))
+		return 0;
+
+	ret = __access_remote_vm_locked(tsk, mm, addr, buf, len, gup_flags);
 	mmap_read_unlock(mm);
 
-	return buf - old_buf;
+	return ret;
+}
+
+/**
+ * access_remote_vm_locked - access another process' address space, without
+ * taking the mmap_lock. This allows nested calls from callers that already have
+ * taken the lock.
+ *
+ * @mm:		the mm_struct of the target address space
+ * @addr:	start address to access
+ * @buf:	source or destination buffer
+ * @len:	number of bytes to transfer
+ * @gup_flags:	flags modifying lookup behaviour
+ *
+ * The caller must hold a reference on @mm, as well as hold the mmap_lock
+ *
+ * Return: number of bytes copied from source to destination.
+ */
+int access_remote_vm_locked(struct mm_struct *mm, unsigned long addr, void *buf,
+			    int len, unsigned int gup_flags)
+{
+	return __access_remote_vm_locked(NULL, mm, addr, buf, len, gup_flags);
 }
 
 /**
-- 
2.28.0

