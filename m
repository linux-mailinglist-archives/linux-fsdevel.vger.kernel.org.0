Return-Path: <linux-fsdevel+bounces-32362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03339A4374
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 18:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7A7282DCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B1202F8F;
	Fri, 18 Oct 2024 16:15:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4A56B81;
	Fri, 18 Oct 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268124; cv=none; b=M6xe5Btxn/wYGO3w8YBRaiHoZx4Iauysg26oVlRSlDjf1C/s9sIJWO1nJlT8ZQg3qrGukA1VOSosgDPcdQlvtfZ7TAXuQyGKJOaqPTMY0tknhWAcrhzILH0XlJFCzlg5g9/uNwu2Pu4HWaCnrWSzJfxqOEO1QMNUOwYBhXg0Eq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268124; c=relaxed/simple;
	bh=NYJbSUC7fmb8x7A/KtOI5Vy3tZbgLqj8fj+8r53CnXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DjXr+Yg1RE2NcolvmZ9It+ZJmCusTBPmXWLEYMhfU7+oP2MU/DKWAEZUDy7T3qQD/oqkDW3/UBdcB2aCoofZxhHGrHUGgSh8LmqnM3I0TPtnOmr3gws0xuoC3fX4Si35NrEBuLRIPdRUuPm986WTvwWL79ioqzU0S6v+6JG7Xzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XVTml1RfXz9v7JC;
	Fri, 18 Oct 2024 23:55:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 4C0DC1407B1;
	Sat, 19 Oct 2024 00:15:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC3+zJ_iRJnh0oaAw--.43081S2;
	Fri, 18 Oct 2024 17:15:11 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ebpqwerty472123@gmail.com,
	paul@paul-moore.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	stable@vger.kernel.org,
	syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2] mm: Split critical region in remap_file_pages() and invoke LSMs in between
Date: Fri, 18 Oct 2024 18:14:15 +0200
Message-Id: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwC3+zJ_iRJnh0oaAw--.43081S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry5Zr4kXF4UXF1fZFWfAFb_yoW7Gw17pF
	naqas0gFWkXF97Xrs2q3WDWFWYyryrKFyUurWagr1rC3sFqF1SgrWfGFW5ZF4DArykZFZ5
	ZF4jyr9YkF4UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07jIksgUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABGcRw-kMAAAAsF

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
remap_file_pages()") fixed a security issue, it added an LSM check when
trying to remap file pages, so that LSMs have the opportunity to evaluate
such action like for other memory operations such as mmap() and mprotect().

However, that commit called security_mmap_file() inside the mmap_lock lock,
while the other calls do it before taking the lock, after commit
8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").

This caused lock inversion issue with IMA which was taking the mmap_lock
and i_mutex lock in the opposite way when the remap_file_pages() system
call was called.

Solve the issue by splitting the critical region in remap_file_pages() in
two regions: the first takes a read lock of mmap_lock, retrieves the VMA
and the file descriptor associated, and calculates the 'prot' and 'flags'
variables; the second takes a write lock on mmap_lock, checks that the VMA
flags and the VMA file descriptor are the same as the ones obtained in the
first critical region (otherwise the system call fails), and calls
do_mmap().

In between, after releasing the read lock and before taking the write lock,
call security_mmap_file(), and solve the lock inversion issue.

Cc: stable@vger.kernel.org # v6.12-rcx
Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap_file_pages()")
Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.46d20.0036.GAE@google.com/
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Tested-by: Roberto Sassu <roberto.sassu@huawei.com>
Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/mmap.c | 69 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9c0fb43064b5..f731dd69e162 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1640,6 +1640,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	unsigned long populate = 0;
 	unsigned long ret = -EINVAL;
 	struct file *file;
+	vm_flags_t vm_flags;
 
 	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.\n",
 		     current->comm, current->pid);
@@ -1656,12 +1657,60 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
 		return ret;
 
-	if (mmap_write_lock_killable(mm))
+	if (mmap_read_lock_killable(mm))
 		return -EINTR;
 
+	/*
+	 * Look up VMA under read lock first so we can perform the security
+	 * without holding locks (which can be problematic). We reacquire a
+	 * write lock later and check nothing changed underneath us.
+	 */
 	vma = vma_lookup(mm, start);
 
-	if (!vma || !(vma->vm_flags & VM_SHARED))
+	if (!vma || !(vma->vm_flags & VM_SHARED)) {
+		mmap_read_unlock(mm);
+		return -EINVAL;
+	}
+
+	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
+	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
+	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
+
+	flags &= MAP_NONBLOCK;
+	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
+	if (vma->vm_flags & VM_LOCKED)
+		flags |= MAP_LOCKED;
+
+	/* Save vm_flags used to calculate prot and flags, and recheck later. */
+	vm_flags = vma->vm_flags;
+	file = get_file(vma->vm_file);
+
+	mmap_read_unlock(mm);
+
+	/* Call outside mmap_lock to be consistent with other callers. */
+	ret = security_mmap_file(file, prot, flags);
+	if (ret) {
+		fput(file);
+		return ret;
+	}
+
+	ret = -EINVAL;
+
+	/* OK security check passed, take write lock + let it rip. */
+	if (mmap_write_lock_killable(mm)) {
+		fput(file);
+		return -EINTR;
+	}
+
+	vma = vma_lookup(mm, start);
+
+	if (!vma)
+		goto out;
+
+	/* Make sure things didn't change under us. */
+	if (vma->vm_flags != vm_flags)
+		goto out;
+	if (vma->vm_file != file)
 		goto out;
 
 	if (start + size > vma->vm_end) {
@@ -1689,25 +1738,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 			goto out;
 	}
 
-	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
-	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
-	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
-
-	flags &= MAP_NONBLOCK;
-	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
-	if (vma->vm_flags & VM_LOCKED)
-		flags |= MAP_LOCKED;
-
-	file = get_file(vma->vm_file);
-	ret = security_mmap_file(vma->vm_file, prot, flags);
-	if (ret)
-		goto out_fput;
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, 0, pgoff, &populate, NULL);
-out_fput:
-	fput(file);
 out:
 	mmap_write_unlock(mm);
+	fput(file);
 	if (populate)
 		mm_populate(ret, populate);
 	if (!IS_ERR_VALUE(ret))
-- 
2.34.1


