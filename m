Return-Path: <linux-fsdevel+bounces-32353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE229A4190
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 16:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A5B1C249AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1E200BB1;
	Fri, 18 Oct 2024 14:48:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF210E4;
	Fri, 18 Oct 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262905; cv=none; b=Oga1vcQPj7mA8UqXwfhAijWrALx2xxRhF3n2I5YpyB5aV4A93TKcrW+HxtuQ8/0DLh8RcS9BtoQdApX3vHGVE7ZUbGYUhxSSZXwoK7yeZZfFSuEHUaTade6j2e04ewaO9F4MW0be64dn3rTZfJiqTRzi8B8IkjqBwJfFXhG2z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262905; c=relaxed/simple;
	bh=UXd+esrUeJSXPyif7uLs6JTFMTdmCWFT4O/0ozmKKXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mDekq9qaLsctCc+rBZHGIcdNTrG83ZuMnTBRIVGju4hgw/tKYEn0MSsDPH/VN+EH183fDFzeGvSBExELLkG+vuFMQ1Y3QQN1cBjWIjvMtPfNVk59kpdzVXFoN7LpkYEvM+P/IFk0KwvSyeeBwQ86t3rnbdMSb/7eBIL8VSMyjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XVRjP5Z26z9v7JP;
	Fri, 18 Oct 2024 22:22:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3731B1404DA;
	Fri, 18 Oct 2024 22:48:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCnNS0hdRJnhEoZAw--.54084S2;
	Fri, 18 Oct 2024 15:48:15 +0100 (CET)
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
	syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH] mm: Split locks in remap_file_pages()
Date: Fri, 18 Oct 2024 16:47:10 +0200
Message-Id: <20241018144710.3800385-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCnNS0hdRJnhEoZAw--.54084S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW3XrW7tw45uFyfXw4Utwb_yoWrZFWrpF
	naqas0gF4kXF97Zrs2q3WUWFWYyry8KFyUu3yagr1rA3sFqF1SgrWfGFW5ZF4DArykZF95
	ZF4UAr95KF4UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABGcRxH8K1wAAsW

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
two regions: the first takes a read lock of mmap_lock and retrieves the VMA
and the file associated, and calculate the 'prot' and 'flags' variable; the
second takes a write lock on mmap_lock, checks that the VMA flags and the
VMA file descriptor are the same as the ones obtained in the first critical
region (otherwise the system call fails), and calls do_mmap().

In between, after releasing the read lock and taking the write lock, call
security_mmap_file(), and solve the lock inversion issue.

Cc: stable@vger.kernel.org
Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap_file_pages()")
Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.46d20.0036.GAE@google.com/
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com> (Calculate prot and flags earlier)
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/mmap.c | 62 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9c0fb43064b5..762944427e03 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1640,6 +1640,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	unsigned long populate = 0;
 	unsigned long ret = -EINVAL;
 	struct file *file;
+	vm_flags_t vm_flags;
 
 	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.\n",
 		     current->comm, current->pid);
@@ -1656,12 +1657,53 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
 		return ret;
 
-	if (mmap_write_lock_killable(mm))
+	if (mmap_read_lock_killable(mm))
+		return -EINTR;
+
+	vma = vma_lookup(mm, start);
+
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
+	ret = security_mmap_file(file, prot, flags);
+	if (ret) {
+		fput(file);
+		return ret;
+	}
+
+	ret = -EINVAL;
+
+	if (mmap_write_lock_killable(mm)) {
+		fput(file);
 		return -EINTR;
+	}
 
 	vma = vma_lookup(mm, start);
 
-	if (!vma || !(vma->vm_flags & VM_SHARED))
+	if (!vma)
+		goto out;
+
+	if (vma->vm_flags != vm_flags)
+		goto out;
+
+	if (vma->vm_file != file)
 		goto out;
 
 	if (start + size > vma->vm_end) {
@@ -1689,25 +1731,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
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


