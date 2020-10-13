Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FA28C6D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 03:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgJMBea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 21:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgJMBe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:34:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C633C0613D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so21825154wrp.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPwHwZEP2PqHjnQGol/aPrlKhQ+v52jFp6WQVgPqijE=;
        b=YferU0tbNRf+gxmODbnA9Mqj4CpE0dtIAEistHAFS9i3faI1yKc65RMZjMueeuAd6K
         v90BcKD8EX8QrUHOBuc4RWU+YiTI127qs5q/pJVwzTOsSBeMcxB+oU2aVU55wR6pUlRv
         SK4XoL4NVCK1yi9eXXrxvr+Hj+52qancDHwYD07EaxXrNrtycjOMzvm0DxsjDe0Yr0Ym
         fy/5nhiDgsBYbPKPmos1hfATHBYfbuDpAX3q/tHFinsU09UpL8L6CMHFoHKZdGQST4Fx
         VqAQoWLpkvmc+4PZzRrMb/5p1F7aQWI0x1fji1HYeph0/+jjPTkmcPOZJhw2LejVQqoH
         0K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPwHwZEP2PqHjnQGol/aPrlKhQ+v52jFp6WQVgPqijE=;
        b=hkPzZDSCR5hsnUpW98Giu5OMldmKLBe2W8I2HHY8R/HNbQ5NaEsrhnmAe+LFiWhrJ/
         09s7iI4w8Mp93tBu+rEJTYOm6YMbTBl9AlYO8kahfFnX/U0B/45J5WeeCssijE2WD6dg
         9QfJw+NJAhSM8Gakl8BuFmpW7hjIW9/fjZRaktIn37F+PuV67MM7DWaQaxFZRfBUOLfx
         Qad4v041ooB769mbqNjGLBYROCYX3138o5WtSKOLK7eOGsg4Ey1tQ7pLAXOzJaVl6RU3
         zSQZWmCbUjwYPHzKX1So4tn+DxqJ7D65FjdrfVBkq8NzOr6MMnXiL9kYIMDkpN67D4pu
         drLQ==
X-Gm-Message-State: AOAM533xHnLJ4alvO57QymWzxzhHC1ytqtX+wqwY2X4Vn25yxJVnDJhi
        j1fW2EqB91Xvabw9d9UWUOsriQ==
X-Google-Smtp-Source: ABdhPJx2Iz5ia07SkXg8JuVb45XrLxBzUgObuPt4vpXjnHItp8RoscX39wxroX44gq9L0v4LP5bsSA==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr480698wrr.300.1602552865214;
        Mon, 12 Oct 2020 18:34:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id d23sm24825325wmb.6.2020.10.12.18.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 18:34:24 -0700 (PDT)
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
Subject: [PATCH 4/6] vm_ops: Rename .split() callback to .may_split()
Date:   Tue, 13 Oct 2020 02:34:14 +0100
Message-Id: <20201013013416.390574-5-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013013416.390574-1-dima@arista.com>
References: <20201013013416.390574-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename the callback to reflect that it's not called *on* or *after*
split, but rather some time before the splitting to check if it's
possible.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/dax/device.c | 4 ++--
 include/linux/mm.h   | 3 ++-
 ipc/shm.c            | 8 ++++----
 mm/hugetlb.c         | 2 +-
 mm/mmap.c            | 4 ++--
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 1e89513f3c59..223dd1d13d5c 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -276,7 +276,7 @@ static vm_fault_t dev_dax_fault(struct vm_fault *vmf)
 	return dev_dax_huge_fault(vmf, PE_SIZE_PTE);
 }
 
-static int dev_dax_split(struct vm_area_struct *vma, unsigned long addr)
+static int dev_dax_may_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct file *filp = vma->vm_file;
 	struct dev_dax *dev_dax = filp->private_data;
@@ -299,7 +299,7 @@ static unsigned long dev_dax_pagesize(struct vm_area_struct *vma)
 static const struct vm_operations_struct dax_vm_ops = {
 	.fault = dev_dax_fault,
 	.huge_fault = dev_dax_huge_fault,
-	.split = dev_dax_split,
+	.may_split = dev_dax_may_split,
 	.pagesize = dev_dax_pagesize,
 };
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fd51a4a1f722..90887661ef44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -549,7 +549,8 @@ enum page_entry_size {
 struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
-	int (*split)(struct vm_area_struct * area, unsigned long addr);
+	/* Called any time before splitting to check if it's allowed */
+	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
 	int (*mremap)(struct vm_area_struct *area, unsigned long flags);
 	vm_fault_t (*fault)(struct vm_fault *vmf);
 	vm_fault_t (*huge_fault)(struct vm_fault *vmf,
diff --git a/ipc/shm.c b/ipc/shm.c
index e25c7c6106bc..febd88daba8c 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -434,13 +434,13 @@ static vm_fault_t shm_fault(struct vm_fault *vmf)
 	return sfd->vm_ops->fault(vmf);
 }
 
-static int shm_split(struct vm_area_struct *vma, unsigned long addr)
+static int shm_may_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct file *file = vma->vm_file;
 	struct shm_file_data *sfd = shm_file_data(file);
 
-	if (sfd->vm_ops->split)
-		return sfd->vm_ops->split(vma, addr);
+	if (sfd->vm_ops->may_split)
+		return sfd->vm_ops->may_split(vma, addr);
 
 	return 0;
 }
@@ -582,7 +582,7 @@ static const struct vm_operations_struct shm_vm_ops = {
 	.open	= shm_open,	/* callback for a new vm-area open */
 	.close	= shm_close,	/* callback for when the vm-area is released */
 	.fault	= shm_fault,
-	.split	= shm_split,
+	.may_split = shm_may_split,
 	.pagesize = shm_pagesize,
 #if defined(CONFIG_NUMA)
 	.set_policy = shm_set_policy,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 67fc6383995b..c4dc0e453be1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3759,7 +3759,7 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.fault = hugetlb_vm_op_fault,
 	.open = hugetlb_vm_op_open,
 	.close = hugetlb_vm_op_close,
-	.split = hugetlb_vm_op_split,
+	.may_split = hugetlb_vm_op_split,
 	.pagesize = hugetlb_vm_op_pagesize,
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 50f853b0ec39..a62cb3ccafce 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2693,8 +2693,8 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *new;
 	int err;
 
-	if (vma->vm_ops && vma->vm_ops->split) {
-		err = vma->vm_ops->split(vma, addr);
+	if (vma->vm_ops && vma->vm_ops->may_split) {
+		err = vma->vm_ops->may_split(vma, addr);
 		if (err)
 			return err;
 	}
-- 
2.28.0

