Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D428C6D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 03:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgJMBea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 21:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgJMBeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:34:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AA8C0613D0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s9so9736582wro.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQFsEpWuF4crrAFVUaO/CXC4VHrsA3+ZAZo85Yi/pU0=;
        b=jh6Shp34HrXFqwhbRrxN+YgzPDA8OoKF04HoFiyNjYZbVjAQaB03yWzpCRAqet1tBl
         qznQQVvt39gfc+rca19EffWNQulmC0gW4kOZ8oTyFIs115lHAaCkdHebfOmk4vwVJUR1
         d2bQ9UoW57Nh9V9EzhGNzvekxXH9NTWdA1QVVsRmgMdO4ONwKofcPq8xEzaBF3S4R5jg
         jdusZLNIDiReYRlgKGWx6Z/UqIV8WzrGb6kyLnbpUec/Bapgh5SfttlYv6fPecZcoanq
         byDqDGINOzYslI8U3EIjdSphlS2zzm6PJPCEHPm660qZ4fQUqAT8u67Dx5YXCG+X9fLu
         uI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQFsEpWuF4crrAFVUaO/CXC4VHrsA3+ZAZo85Yi/pU0=;
        b=X0pUAnaRTLcfU5Hh3eWBdDVEVFLytO1u2WIpcmSZ2J+cp9hUXCDR2a8/z68KVO/Eph
         ZvQUEc31PA8JsT7WCtoYnm9pPSkEpgpENS9VdzOLJVG5Q+4mq/1HzL3Od6UpLK20eWMP
         Bomy9kjyW//UIzecdy6Vz+Wyim19fULMKVureiKbys9NWoYtw2HUuOg86/s5MUZ4pk57
         5c4m0H2Dlucx0PV63jbtH734EeYbHxLBi1VcTYjP0xTi3fn3GdOkkHqN9n3Ta/2AqStC
         w5P2DPmEami8ZZxaZTU0l3Ch5HQnOw0ASHPi4qM/838Ht9arL2lMcNQAqe0La8itVTky
         F4zw==
X-Gm-Message-State: AOAM531UcI25ZW8XRxYgTFrrzypYgvcToyHLenoJmOws+BkK3vN2jVo5
        XjfaWVj1BuJVeBUlTlVZ/+IKbg==
X-Google-Smtp-Source: ABdhPJw5vKLkrkjcJCNIMOOzrKmqWdjiE3iZi/mIzmQ8aAHgnoINflz5eE8APWdVPpZyrKnFlUqGEw==
X-Received: by 2002:adf:e881:: with SMTP id d1mr21447682wrm.395.1602552863641;
        Mon, 12 Oct 2020 18:34:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id d23sm24825325wmb.6.2020.10.12.18.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 18:34:23 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/6] mremap: Don't allow MREMAP_DONTUNMAP on special_mappings and aio
Date:   Tue, 13 Oct 2020 02:34:13 +0100
Message-Id: <20201013013416.390574-4-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013013416.390574-1-dima@arista.com>
References: <20201013013416.390574-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As kernel expect to see only one of such mappings, any further
operations on the VMA-copy may be unexpected by the kernel.
Maybe it's being on the safe side, but there doesn't seem to be any
expected use-case for this, so restrict it now.

Fixes: commit e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
 fs/aio.c                                  | 5 ++++-
 include/linux/mm.h                        | 2 +-
 mm/mmap.c                                 | 6 +++++-
 mm/mremap.c                               | 2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 0daf2f1cf7a8..e916646adc69 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1458,7 +1458,7 @@ static int pseudo_lock_dev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int pseudo_lock_dev_mremap(struct vm_area_struct *area)
+static int pseudo_lock_dev_mremap(struct vm_area_struct *area, unsigned long flags)
 {
 	/* Not supported */
 	return -EINVAL;
diff --git a/fs/aio.c b/fs/aio.c
index d5ec30385566..3be3c0f77548 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -324,13 +324,16 @@ static void aio_free_ring(struct kioctx *ctx)
 	}
 }
 
-static int aio_ring_mremap(struct vm_area_struct *vma)
+static int aio_ring_mremap(struct vm_area_struct *vma, unsigned long flags)
 {
 	struct file *file = vma->vm_file;
 	struct mm_struct *mm = vma->vm_mm;
 	struct kioctx_table *table;
 	int i, res = -EINVAL;
 
+	if (flags & MREMAP_DONTUNMAP)
+		return -EINVAL;
+
 	spin_lock(&mm->ioctx_lock);
 	rcu_read_lock();
 	table = rcu_dereference(mm->ioctx_table);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 16b799a0522c..fd51a4a1f722 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -550,7 +550,7 @@ struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
 	int (*split)(struct vm_area_struct * area, unsigned long addr);
-	int (*mremap)(struct vm_area_struct * area);
+	int (*mremap)(struct vm_area_struct *area, unsigned long flags);
 	vm_fault_t (*fault)(struct vm_fault *vmf);
 	vm_fault_t (*huge_fault)(struct vm_fault *vmf,
 			enum page_entry_size pe_size);
diff --git a/mm/mmap.c b/mm/mmap.c
index bdd19f5b994e..50f853b0ec39 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3372,10 +3372,14 @@ static const char *special_mapping_name(struct vm_area_struct *vma)
 	return ((struct vm_special_mapping *)vma->vm_private_data)->name;
 }
 
-static int special_mapping_mremap(struct vm_area_struct *new_vma)
+static int special_mapping_mremap(struct vm_area_struct *new_vma,
+				  unsigned long flags)
 {
 	struct vm_special_mapping *sm = new_vma->vm_private_data;
 
+	if (flags & MREMAP_DONTUNMAP)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(current->mm != new_vma->vm_mm))
 		return -EFAULT;
 
diff --git a/mm/mremap.c b/mm/mremap.c
index c248f9a52125..898e9818ba6d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -384,7 +384,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (moved_len < old_len) {
 		err = -ENOMEM;
 	} else if (vma->vm_ops && vma->vm_ops->mremap) {
-		err = vma->vm_ops->mremap(new_vma);
+		err = vma->vm_ops->mremap(new_vma, flags);
 	}
 
 	if (unlikely(err)) {
-- 
2.28.0

