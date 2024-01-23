Return-Path: <linux-fsdevel+bounces-8537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A523838CAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3261C23A3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1AA5C914;
	Tue, 23 Jan 2024 10:58:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9E5C908;
	Tue, 23 Jan 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007502; cv=none; b=AL9PBR4tHRe+Qa8DArknXTkYwmQLRDjfZJRjXz7EHfqEv1F9/hH4yT86Y2beJ46igQGo11cwx11nZyLufsowZhb8VnD/yizdFu1tykDvWI1fZRy3DgmO/ACDdM7WdkRcbM+YEpOMOqDsURsbsn5VYMNb/t5qtG4VY6a5jri0GXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007502; c=relaxed/simple;
	bh=5zPOFE3A4m+p7S/1E46Gz/eFCoCUJsr0vNBF3Qh4MHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aiSdZCX1Z0o72Ls3MsI1hDaNyRY9x8JMI13Pee9HRrytGn5ntoToOMj06WrbGwVcG8rdKPXUv1BUK6mGJwQ++pVzgZpsFzsCvnT/xjjXf0xJ8m9tWyQ4NBC0kDQ8HLlsPoIvXZKl02DPymcoAa36I7ydYiox4gETKfn/UkuG3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.CYDCD_1706007484;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.CYDCD_1706007484)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 18:58:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] virtiofs: avoid unnecessary VM_MIXEDMAP for mmap support
Date: Tue, 23 Jan 2024 18:58:03 +0800
Message-Id: <20240123105803.1725795-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit e1fb4a0864958 ("dax: remove VM_MIXEDMAP for fsdax and
device dax"), VM_MIXEDMAP seems unnecessary for virtiofs DAX mapping
(devmap).

At least I'm not sure why VM_MIXEDMAP is used during some internal
review (I guess that was added due to the current DAX documentation),
it could avoid copying page table when forking since page faults could
fill DAX VMAs just fine.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/fuse/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb..5a3c17a80340 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -858,7 +858,7 @@ int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	file_accessed(file);
 	vma->vm_ops = &fuse_dax_vm_ops;
-	vm_flags_set(vma, VM_MIXEDMAP | VM_HUGEPAGE);
+	vm_flags_set(vma, VM_HUGEPAGE);
 	return 0;
 }
 
-- 
2.39.3


