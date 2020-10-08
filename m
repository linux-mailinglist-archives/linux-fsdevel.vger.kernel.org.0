Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38F3287004
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgJHHye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgJHHyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21092C0613D6;
        Thu,  8 Oct 2020 00:54:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so3572217pgb.10;
        Thu, 08 Oct 2020 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+UEtOZ7eFEPFXRY1fIK0hRtr84aEIUrt41wmuOK+xgg=;
        b=VzGnhu9w1XiqyxHi9u3p9HeKoHnmocTiTSFclG3q3f+eOp/0u1KUfPdyNNLCptI99d
         BSmJkv5jSH/V5D6I6hYRuyqzL3vAV7xsYPeGngHm8mA5L3/9HJbfXQ4Xu3wwMD51hVh7
         F2sPUz9+tY10aIyW6I/MhFspsw+f2+H8LCzQhkqekjSILXEe+2AVuHf2Fbt4x0RAVeSN
         ybAYBeyLl01pH6U8NdVhnMlK9gNkc1BXBp/b0jRHRzxZAP4gSix8BiPqpKjdAaMgK2Fv
         63VY8FpqtCqCnwLBIBtm2gAoqvXn0eEo4B1gcfbPKm+2XP3zBGEIn1pVjmdxQbYDboic
         V+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+UEtOZ7eFEPFXRY1fIK0hRtr84aEIUrt41wmuOK+xgg=;
        b=dBaFKDi6IoiFMVz2ttS5CD0qwY4+LHFi7Za6iTh6V2DMzwMN1EDgN/5pCPkWkWeGf4
         SWpguc+Pd3OUwIbZ3J+2NfxHJrs8pvfC5hWYL2aKt48/ZfPQ3+OyP+lQHiXaddPKtpR8
         f4aElclsh+/8YCZlFjCc+rk0FiFrTMo5YSXYsH8z+w2YnoPeWZR9tLSQsLV0kdX/Dcyr
         zQAGa6bDSZNhUcr1CddRtvnBudwtlRK272/hxoxdT5sAgHd5/4zMMNpkgE+VYUyxjFhf
         GFEisf5A6FeXgYWtTVlt07XkyOR9nbrOO1z6QGfItNOBwc3Y10V9ar1IvUfeoOqMtdol
         RlnA==
X-Gm-Message-State: AOAM531bYDqkMfOyo33I8FqgBEGa35tBF3DkowqimxwXCd78d39+3uul
        sRe3CBk+Z+kJkQRQJClf5/M=
X-Google-Smtp-Source: ABdhPJzRNvFW9fEHPvYm2m5gg7LeIGTXsZtW9seA+qnH3C9IgNw3vgr0VPXAR6sFRlgs22r7ExeX6A==
X-Received: by 2002:aa7:8e54:0:b029:142:2501:34d2 with SMTP id d20-20020aa78e540000b0290142250134d2mr6276079pfr.43.1602143669573;
        Thu, 08 Oct 2020 00:54:29 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:54:29 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [PATCH 10/35] dmemfs: introduce max_alloc_try_dpages parameter
Date:   Thu,  8 Oct 2020 15:54:00 +0800
Message-Id: <d616c23875137d79376f9b7f03afad48c8ac418c.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

It specifies the dmem page number allocated at one time, then
multiple radix entries can be created. That will relief the
allocation pressure and make page fault more fast.

However that could cause no dmem page mmapped to userspace
even if there are some free dmem pages.

Set it to 1 to completely disable this behavior.

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index 4dacbf7e6844..6932d73edab6 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -34,6 +34,8 @@ MODULE_LICENSE("GPL v2");
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
+static uint __read_mostly max_alloc_try_dpages = 1;
+
 struct dmemfs_mount_opts {
 	unsigned long dpage_size;
 };
@@ -46,6 +48,44 @@ enum dmemfs_param {
 	Opt_dpagesize,
 };
 
+static int
+max_alloc_try_dpages_set(const char *val, const struct kernel_param *kp)
+{
+	uint sval;
+	int ret;
+
+	ret = kstrtouint(val, 0, &sval);
+	if (ret)
+		return ret;
+
+	/* should be 1 at least */
+	if (!sval)
+		return -EINVAL;
+
+	max_alloc_try_dpages = sval;
+	return 0;
+}
+
+static struct kernel_param_ops alloc_max_try_dpages_ops = {
+	.set = max_alloc_try_dpages_set,
+	.get = param_get_uint,
+};
+
+/*
+ * it specifies the dmem page number allocated at one time, then
+ * multiple radix entries can be created. That will relief the
+ * allocation pressure and make page fault more fast.
+ *
+ * however that could cause no dmem page mmapped to userspace
+ * even if there are some free dmem pages
+ *
+ * set it to 1 to completely disable this behavior
+ */
+fs_param_cb(max_alloc_try_dpages, &alloc_max_try_dpages_ops,
+	    &max_alloc_try_dpages, 0644);
+__MODULE_PARM_TYPE(max_alloc_try_dpages, "uint");
+MODULE_PARM_DESC(max_alloc_try_dpages, "Set the dmem page number allocated at one time, should be 1 at least");
+
 const struct fs_parameter_spec dmemfs_fs_parameters[] = {
 	fsparam_string("pagesize", Opt_dpagesize),
 	{}
@@ -317,6 +357,7 @@ radix_get_create_entry(struct vm_area_struct *vma, unsigned long fault_addr,
 	}
 	rcu_read_unlock();
 
+	try_dpages = min(try_dpages, max_alloc_try_dpages);
 	/* entry does not exist, create it */
 	addr = dmem_alloc_pages_vma(vma, fault_addr, try_dpages, &dpages);
 	if (!addr) {
-- 
2.28.0

