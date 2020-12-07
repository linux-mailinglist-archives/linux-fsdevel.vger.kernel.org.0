Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644272D0F3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgLGLeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgLGLet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:49 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0262C061A54;
        Mon,  7 Dec 2020 03:33:59 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so9616581pfu.1;
        Mon, 07 Dec 2020 03:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZ7s/TPFWElvYaRd2Z4ImP4zL6ID97NqxxjlgrDo46E=;
        b=AJAm2JQDxedsaO81FFlH0EqySZx0V1JZAWUyZSgG2JMejw/2P/2YNsn13l0harXSnv
         U3Gyun4C/tDEp5GY75ukYQ8NKpN7HVEwvvgyY8BzE7ExfFNdBMDEZ/aOgvx075MECqL7
         pYdV9tIyA5ilsGCR6SY4i+lSEV5W2rx9BftPjIVtKxyjCDnbwztLge9MJFNY8KOYMREE
         wy7RQIV+YMYcC9VSimCcE1RnrIyOSmzDJjr9L/rCvjGXRPmPiQpqhp+CP4j7obar6c5B
         qxRX1Y83xXr1EcYfim8OijyqJDwojAyLtA46wHnMUKFxo4aQcxCnXcAgkjCcPB8f/9ef
         owvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ7s/TPFWElvYaRd2Z4ImP4zL6ID97NqxxjlgrDo46E=;
        b=DwwkgLz3GSwfIi30Hjq7iJr4GY0lkbU6ataj6ZkHMh6lrHIBA2R4LtsbLyGdflLlFx
         xyDaY9vb0HiHInIatvkhOyv2D5WKjIrkbLnauUEL7qGdPVRkpF3k6R2KDm2fbsg2mmRe
         wBxcqM8clvJV929R8R5UidRwsrOXKL5PxZ2gwVIoQuH7um9bwod54WJpqKvK0r8iJPNA
         wqbqSNlAZ9mDQpDDRpb8mOtdTFsvQZlwcZl8Qp/ELHfU3oIAWoA2MweBfGFbv40JDq+S
         D/cg+PIMWg67DZ7md/Q0UtQvWXga+3Ov9OIgJ3cyrjWTR74Zc82hNlCriP4HH9FAlhAW
         LK/w==
X-Gm-Message-State: AOAM5308/8YrfOy4HRgozIB/UHvk+9JkIvvd6FkZ5E830NlhZT4uXwwi
        0jyK5LlxbqI2wJw5azGG8Ec=
X-Google-Smtp-Source: ABdhPJwNOCi3KR2PAp9drrOXOVZPvcKF+MCuZ8w1Uu6pFaCaU7qErwtZSzlK+Cv5rjtTzxX3eZsSAw==
X-Received: by 2002:a17:902:aa84:b029:da:f114:6022 with SMTP id d4-20020a170902aa84b02900daf1146022mr5850388plr.46.1607340839351;
        Mon, 07 Dec 2020 03:33:59 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.33.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:33:58 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [RFC V2 09/37] dmemfs: support remote access
Date:   Mon,  7 Dec 2020 19:31:02 +0800
Message-Id: <ff4b0e1c0d62754c1373489bbf2553132c1c561c.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

It is required by ptrace_writedata and ptrace_readdata to access
dmem memory remotely. The typical user is gdb, after this patch,
gdb is able to read & write memory owned by the attached process

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index 7723b58..3192f31 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -364,6 +364,51 @@ static void radix_put_entry(void)
 	rcu_read_unlock();
 }
 
+static bool check_vma_access(struct vm_area_struct *vma, int write)
+{
+	vm_flags_t vm_flags = write ? VM_WRITE : VM_READ;
+
+	return !!(vm_flags & vma->vm_flags);
+}
+
+static int
+dmemfs_access_dmem(struct vm_area_struct *vma, unsigned long addr,
+		   void *buf, int len, int write)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	struct super_block *sb = inode->i_sb;
+	void *entry, *maddr;
+	int offset, pgoff;
+
+	if (!check_vma_access(vma, write))
+		return -EACCES;
+
+	pgoff = linear_page_index(vma, addr);
+	if (pgoff > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
+		return -EFAULT;
+
+	entry = radix_get_create_entry(vma, addr, inode, pgoff);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	offset = addr & (sb->s_blocksize - 1);
+	addr = dmem_entry_to_addr(inode, entry);
+
+	/*
+	 * it is not beyond vma's region as the vma should be aligned
+	 * to blocksize
+	 */
+	len = min(len, (int)(sb->s_blocksize - offset));
+	maddr = __va(addr);
+	if (write)
+		memcpy(maddr + offset, buf, len);
+	else
+		memcpy(buf, maddr + offset, len);
+	radix_put_entry();
+
+	return len;
+}
+
 static vm_fault_t dmemfs_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -400,6 +445,7 @@ static unsigned long dmemfs_pagesize(struct vm_area_struct *vma)
 static const struct vm_operations_struct dmemfs_vm_ops = {
 	.fault = dmemfs_fault,
 	.pagesize = dmemfs_pagesize,
+	.access = dmemfs_access_dmem,
 };
 
 int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
-- 
1.8.3.1

