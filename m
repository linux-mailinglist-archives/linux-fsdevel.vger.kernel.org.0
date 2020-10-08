Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8AE28701C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgJHHzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgJHHy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5948BC0613D5;
        Thu,  8 Oct 2020 00:54:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so3595154pgk.4;
        Thu, 08 Oct 2020 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uRaztcCJnlOoX6i9scY25dALTRO/x6REIkOSQ8S7jV8=;
        b=s5am6itE5ChGCgbRnNVLHpQK3th4boGgvEyz/+NCiS/yVET+IQvmz+R7EGHO/mDQxu
         D6QKxsonLgPo5UaJ5jajc5nvXTMqkP9BsLSZ+G2OQtxFjEocWZc3ja5hXZZSByAASU9f
         T9P3CvPF7HkFcUaAHkROPIzZyu4ZASaPuuaPA+cY7/LUOrvd7OlgqxQGkLZXT6PcNUPI
         6Bb9pcCgbv2ayWI+WAdFai8nslKRJSO79E7n36X70DvCPLAfLW9x9bnemZMh45jd3Qpj
         rQWRceAcpwlVyXqe9Bm42qUm44gv23i12iV1YgOtKTOlcOMvVF7/qobS4kSTeBSloJOX
         exIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=uRaztcCJnlOoX6i9scY25dALTRO/x6REIkOSQ8S7jV8=;
        b=YqjIjE8JLG/awOH4Y4eayVD9OTp2Wr/kerXlMKYaDF/SVRXF6LdTW5AjHBxpKTXsIJ
         1RXMUOY6i453X0NeEDF4cxFVo3cMIBcpu3rslL9rjdLOVFNSNdPhJqn2fYmWbiEkx6J3
         8Kv19S6DuH+YtGyEcgYsedfqOmrGSUOmq/GXrGXhXWpaI6hcgpQGji6GHc7tCYS1felJ
         eF/j5r4Gyk4UoG2FxZweBZVTGbe3uAmD0PN5JMXARxQJweLvBMy6xIXXm9yShO6az9rx
         PKHZTcgZi8c45X0KXnmo3PeGl9dgJMAhIBNGvylPPNA+7IhYzDDQVqP48bsJPS+JFiNd
         FW0w==
X-Gm-Message-State: AOAM531rFUKXoSjfl9nt3me3TopbF5RF1+Smc4YstiVjzhcX5ABuQiHH
        AsRfBwlrSua0nNQVgxKf1rU=
X-Google-Smtp-Source: ABdhPJxmneky4Nkjo5WcAH3W3ovFYU42Ol4bsicbBn4KnNNC4bw5RMfh4unJXvihHs0zVvq7rxpVdQ==
X-Received: by 2002:a62:93:0:b029:13e:d13d:a085 with SMTP id 141-20020a6200930000b029013ed13da085mr6187059pfa.28.1602143697958;
        Thu, 08 Oct 2020 00:54:57 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:54:57 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 16/35] dmemfs: introduce ->split() to dmemfs_vm_ops
Date:   Thu,  8 Oct 2020 15:54:06 +0800
Message-Id: <adb685974526804279d5c40f183985a9a5005d43.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

It is required by __split_vma() to adjust vma. munmap() which create
hole unaligned to pagesize in dmemfs-mapping should be forbidden.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index 6932d73edab6..e37498c00497 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -453,6 +453,13 @@ dmemfs_access_dmem(struct vm_area_struct *vma, unsigned long addr,
 	return len;
 }
 
+static int dmemfs_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	if (addr & (dmem_page_size(file_inode(vma->vm_file)) - 1))
+		return -EINVAL;
+	return 0;
+}
+
 static vm_fault_t dmemfs_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -487,6 +494,7 @@ static unsigned long dmemfs_pagesize(struct vm_area_struct *vma)
 }
 
 static const struct vm_operations_struct dmemfs_vm_ops = {
+	.split = dmemfs_split,
 	.fault = dmemfs_fault,
 	.pagesize = dmemfs_pagesize,
 	.access = dmemfs_access_dmem,
-- 
2.28.0

