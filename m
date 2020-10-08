Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41DF286FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgJHHyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgJHHyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA830C061755;
        Thu,  8 Oct 2020 00:54:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y14so3558695pgf.12;
        Thu, 08 Oct 2020 00:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=W3BSJ4nnntDUiPO8aKzddZBmFpEEB9T5x8/2e53DTXE=;
        b=AY/dYRPHOTucdyPPWq259WQSZOmMVkNpWWwJGHnhaPHpwF/Py+9Nbe4l5C9/KTgpGl
         hP4TnyIn5knVZk9qR8DzaPkQ2aeeUgDQT9FNMiayT5MqAK57EMEmp3xHe/cKlpou1pJM
         tWu0gGWXEtEt5c/Jc3BOQT2XpwhDJ9k4vniUof7lyA6rwCS7AuDtvdUFrw3P/Ls3eIZ1
         YT/Oa53C1nLBdI6odiNBwCdHwnkpBkuwp4AAn7n2kPAMMbT98jHrMnxW+LupsZLUd+pj
         Dp88FI+XUGVZN5v4nZmnN3zkzosMvIY7DBNK1GsPLChSu4om+N4EtbvabqYb/L8/qj4J
         3ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=W3BSJ4nnntDUiPO8aKzddZBmFpEEB9T5x8/2e53DTXE=;
        b=EUNcNpj2N5OlCVdJldS0MK6OuC6+fw+qi+ZmxWuTapunTdHqScurQT4/1mZ2+e0v0y
         N7bHmAZkcb56b9pg6XFntsVN+PUUcDUfcnXG/BJeaIwZBiQkbkyyFn8Maq6iqKfQoTqV
         zKzR2H9K0KV168eBU4dS7RuBQy7F2zKs+ofRA/8zLuZIyA4yb2XtQw1Qe/7dQklkNMTv
         Kvsqb5WD9h5RnIIBldH8VKoEe2Ewmb9Hqr986YIA3BP9T2NqcsP7dvqddZbf9d5Xk3jS
         rSuZLLbEBROazOg9u+3P4ohg0TUT1KzuBwhaSQDUFVtZSPSHvD4y/SyqnQWMnPclN9EL
         k3pA==
X-Gm-Message-State: AOAM530zcWTA0uvT+NMwbYDA/ZEuSk34BvsdHR+22OAUb4JOMhhJAX5T
        zp3BIDQzmDtscye2FGgskhQ=
X-Google-Smtp-Source: ABdhPJw/j+zr/SZvlpT3YnFskHw6EzTSV6uAMFuWg1/IrNzRRywlAHSD+6l6Nt/6uyPCQy2/Fjf4vA==
X-Received: by 2002:a17:90b:4b90:: with SMTP id lr16mr7103542pjb.0.1602143640260;
        Thu, 08 Oct 2020 00:54:00 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:53:59 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [PATCH 06/35] dmemfs: support truncating inode down
Date:   Thu,  8 Oct 2020 15:53:56 +0800
Message-Id: <0e0c4b6a86d5af7cf3fa71b18b68f0c7da819f34.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

To support cut inode down, it will
introduce the race between page fault handler and
truncating handler as the entry to be deleted is being
mapped into process's VMA

in order to make page fault faster (as it's the hot
path), we use RCU to sync these two handlers. When
inode's size is updated, the handler makes sure the
new size is visible to page fault handler who will
not use truncated entry anymore and will not create
new entry in that region

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index 21d2f951b4ea..d617494fc633 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -101,8 +101,73 @@ static const struct inode_operations dmemfs_dir_inode_operations = {
 	.rename		= simple_rename,
 };
 
+static void inode_drop_dpages(struct inode *inode, loff_t start, loff_t end);
+
+static int dmemfs_truncate(struct inode *inode, loff_t newsize)
+{
+	struct super_block *sb = inode->i_sb;
+	loff_t current_size;
+
+	if (newsize & ((1 << sb->s_blocksize_bits) - 1))
+		return -EINVAL;
+
+	current_size = i_size_read(inode);
+	i_size_write(inode, newsize);
+
+	if (newsize >= current_size)
+		return 0;
+
+	/* it cuts the inode down */
+
+	/*
+	 * we should make sure inode->i_size has been updated before
+	 * unmapping and dropping radix entries, so that other sides
+	 * can not create new i_mapping entry beyond inode->i_size
+	 * and the radix entry in the truncated region is not being
+	 * used
+	 *
+	 * see the comments in dmemfs_fault()
+	 */
+	synchronize_rcu();
+
+	/*
+	 * should unmap all mapping first as dmem pages are freed in
+	 * inode_drop_dpages()
+	 *
+	 * after that, dmem page in the truncated region is not used
+	 * by any process
+	 */
+	unmap_mapping_range(inode->i_mapping, newsize, 0, 1);
+
+	inode_drop_dpages(inode, newsize, LLONG_MAX);
+	return 0;
+}
+
+/*
+ * same logic as simple_setattr but we need to handle ftruncate
+ * carefully as we inserted self-defined entry into radix tree
+ */
+static int dmemfs_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode = dentry->d_inode;
+	int error;
+
+	error = setattr_prepare(dentry, iattr);
+	if (error)
+		return error;
+
+	if (iattr->ia_valid & ATTR_SIZE) {
+		error = dmemfs_truncate(inode, iattr->ia_size);
+		if (error)
+			return error;
+	}
+	setattr_copy(inode, iattr);
+	mark_inode_dirty(inode);
+	return 0;
+}
+
 static const struct inode_operations dmemfs_file_inode_operations = {
-	.setattr = simple_setattr,
+	.setattr = dmemfs_setattr,
 	.getattr = simple_getattr,
 };
 
-- 
2.28.0

