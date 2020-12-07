Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73E92D0F82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgLGLfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgLGLfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:14 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D76C0613D2;
        Mon,  7 Dec 2020 03:34:33 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so9601217pfu.13;
        Mon, 07 Dec 2020 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TR3cC+AByvGn3JshaPXKc+3rxof2L0xMPbaiJBaNE0A=;
        b=PwcAOe4heCxF7XTuomjeUtwKezkdJmM0HmTX1yw4AeADa+3Z5jYH2gnncSNx6tF/dK
         nqc3OY3XklNb6fsWrMNV9SLhYauoxenHh7jF/LUEVNXitOpU59OZoN9JC+QCR46jU/Ns
         sBCj+XDvRx916ayOQcnxhHqZ/yh9ih/c9sVknDZkZs/LBEO/v5jpO2wZ1oEm3FfjX0hE
         TbWTBt9N8W/HGCkWK2IvBBhkklXYtf5Ke1t4gjU8zkkB1O5YL8vGHwUoJwXrPE3CU4Q8
         1EfVWBeVZsU6g44z81Jf/b0p33RSG/Hwm+qr6c5NqBuzkeVYX26s7OBZzLc31WX/Gbiy
         jVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TR3cC+AByvGn3JshaPXKc+3rxof2L0xMPbaiJBaNE0A=;
        b=UPfisDrJQYj2PhVclw+UNTNBs7Zg/k0g8ZWOLVPrdXoAgkKDWs2e1mzjOwxtyPINcI
         S5DWvvCkUAhUKcJOXn4kDDNhGt8o3xruXpmNqcGMlItO9Zejm6GXgyNfxveqIsAuglRD
         mKMNuxbg9asxxkGsIV/fuvZoUoQVAfDZqhcZfr1hiSHTImdBtMe37j83j7zapNvkZ4Gw
         c0LP0MG2cshqszEV+/5kTQf6YrGv8KEyiBnEVQ53wzXXei1Qi8JUf/qdyi/oCrvGvMHA
         MFcRhPiqFswuiF78nCT70zu33SkHKtl0X3axh6FZjX7YlAAXAQbXak2KRsj9ian6V1ku
         VzsA==
X-Gm-Message-State: AOAM531cGx60hY4bYmmm3usdZClEazgnEz7UiBUGh6iKWTeQ+RzRkF+F
        QYSmZBLB+DA7ycuX+7Q1ajk=
X-Google-Smtp-Source: ABdhPJwrnzftH6wwtqZGjpZb2mr88aLorhMPJcvx0VqVsyAFRqovNa0wPGz47Osa45K8P+P4zlb4ww==
X-Received: by 2002:a63:e20:: with SMTP id d32mr18339042pgl.94.1607340873505;
        Mon, 07 Dec 2020 03:34:33 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:32 -0800 (PST)
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
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 16/37] dmemfs: introduce ->split() to dmemfs_vm_ops
Date:   Mon,  7 Dec 2020 19:31:09 +0800
Message-Id: <6b3c166a8d5827a1f6f2a33d85feae1c1633a45d.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 443f2e1..ab6a492 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -450,6 +450,13 @@ static bool check_vma_access(struct vm_area_struct *vma, int write)
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
@@ -484,6 +491,7 @@ static unsigned long dmemfs_pagesize(struct vm_area_struct *vma)
 }
 
 static const struct vm_operations_struct dmemfs_vm_ops = {
+	.split = dmemfs_split,
 	.fault = dmemfs_fault,
 	.pagesize = dmemfs_pagesize,
 	.access = dmemfs_access_dmem,
-- 
1.8.3.1

