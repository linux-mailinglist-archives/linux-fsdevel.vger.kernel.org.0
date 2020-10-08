Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD76F28700F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgJHHy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbgJHHy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DA5C0613D2;
        Thu,  8 Oct 2020 00:54:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so3323057pfd.5;
        Thu, 08 Oct 2020 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eGljQKzTgkdWVWcoLwMoNc4yYvwq/5X5+EymWM5SqAU=;
        b=I8xdPHW0M1mm8vSW+D4T0TcVydFjhpjDcTRGHXyutoitSuXG9jQZ3womXx8XzPNXe5
         i7JWsMAtVjzrAe+V0760CUL994DssjAoNXzyERtrr0N8hRjOfVo1TKMOiPDBTCMTA+io
         K8us9lACQuoG6Db8x6Mbciu0CuWTQwrBzp1mr5E6zT78Gaj5eevYKqQKJ586UbkB4LVs
         PZVtNK10HGwiIbblDumpxjC/kdTEK0j/H13eZaU+OqRK82W5/PAHJLqJbBE+cUY+sKR2
         WeRvO3IE6yTrBaQgWF3TaVZYjeXze1NKHkc3ClWRk064TvC0Awum5aVEMzw05ZwD67/T
         AyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eGljQKzTgkdWVWcoLwMoNc4yYvwq/5X5+EymWM5SqAU=;
        b=MLHdr0qxL5M/chd+kwHqwMs9ARECpWtP8zRyhVReCfHPM4k4oFgLnprHDLkxiO9TkY
         9GwNvSrl0gQnxB1HZI0stUI8bDdCVL2C1ZWS8A+2RbbMOb4fj/t7zzvf0EUwWPDNvS67
         fkxg7YgQ3L997dcACmL35t28unQaKRyMd0Z9AzTWLylDgbtD9XEFELNVGY6tk+1hLpv+
         hnTRKcGzDDW8T1VwgiLM/1nzkGnmoZHc026C7N9zdc7hf7p3KqXRPja6/JdFphy+ABGv
         tCZMYVMcknfqJVaW5Zuecnr9e2a5FuzUsqY+3LZ+WA9Zzy7ceYwyv66Ii2q78/w+TzZh
         1Q5Q==
X-Gm-Message-State: AOAM532VIB5yP7A5TBfy1GJyh8lEKywvoUqTL5DFZepWvx03QxH4qk56
        vuXgdE+A5TAe57nvy8r/lA4=
X-Google-Smtp-Source: ABdhPJyxrTr9y9iwa3fxdCr1CirZbeew7YbZv3lIdL7uc7GALHtp/3iFe7NB/PJv2EulUjVkgjDO9w==
X-Received: by 2002:a17:90a:fd97:: with SMTP id cx23mr6644455pjb.3.1602143665104;
        Thu, 08 Oct 2020 00:54:25 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:54:24 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [PATCH 09/35] dmemfs: support remote access
Date:   Thu,  8 Oct 2020 15:53:59 +0800
Message-Id: <0b749ec1fab63b2d8ee2354f576579fe23917c26.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
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
index 8b0516d98ee7..4dacbf7e6844 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -367,6 +367,51 @@ static void radix_put_entry(void)
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
@@ -403,6 +448,7 @@ static unsigned long dmemfs_pagesize(struct vm_area_struct *vma)
 static const struct vm_operations_struct dmemfs_vm_ops = {
 	.fault = dmemfs_fault,
 	.pagesize = dmemfs_pagesize,
+	.access = dmemfs_access_dmem,
 };
 
 int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.28.0

