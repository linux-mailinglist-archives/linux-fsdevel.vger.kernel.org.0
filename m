Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5445B2D0F22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgLGLee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgLGLeb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:31 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D93C061A4F;
        Mon,  7 Dec 2020 03:33:45 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id e5so7190667pjt.0;
        Mon, 07 Dec 2020 03:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eX1IR50aPFiEwdJQV5xGne8H/FATcvY6dG1G5D19yRg=;
        b=eXbX382qovy7COikmy0KYqgAQma7SSrycd5mwQ9J3QDSquh0VXtGUzblKKkJuAAuVI
         PHSVAom05MaCyxQFaVh4X0uD1ku5P8agDSw+IP8A/Cg85jWOn4rl+hXVuErT69iZK05Z
         AcBFV5C+p5lDBPuGmBkyAuL5TR4/MK5NGKvZAxWYLkqPklUmSTDRcAnTp3+KTbgnYNva
         U4uPsEDUiXFj3Bp/DPp8dqvmHNJAQNKovFWzqT1K4nBuHDOyV8p/E0E60YvnLz8urUmn
         JGkze+2OWmWXsKpBGQx87ndhmBmG+X4sOrdozDV9Gp1n+V+72T9SRvDWV3Jt7aMnyj1a
         mpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eX1IR50aPFiEwdJQV5xGne8H/FATcvY6dG1G5D19yRg=;
        b=GV2AUCqqcmJCDIZN7oxC7Z5rxj9jQftaZJOKpqd/FquFYbfFsu5wwbE3bi2i70xU2d
         4oSKtBqYIwa2P5RBd07muEb8kxnwhs7aPvGFdYNpbD1b0dMIOjNl0eajVqGB+RKVfrTw
         wj6PLkx2HOFCl1ZZncreWqeeKY5+C6Ly6rTz/ESa80TTz/3SCenohFKC5/VQ1B0KJ0HS
         +gBBii/etku1nwjm/idmDNbwr/kB7I74AJTKDsGyiL8nAYC1L48a2RnvSbzmkOYJp6C4
         gaHWBVj0/W8zG3h2HCRmNuXI0KKDkcPH9+rvaLgfqDo2n5SIqkrtjhXnho78fMWOTZ3j
         xEHQ==
X-Gm-Message-State: AOAM531G9O+51VXW+8Oly0TiEeS4d1eHLZi+wmwcmtLTgCCNPGoZ93Xs
        Z+cHPPoAEwKco/RXxz6Qckw=
X-Google-Smtp-Source: ABdhPJwWiUXd//0TI6YPXtELG5n3boi+qEdZaWxYAMBrmQrPfGNew3+nfNYMRr95hadFZhb2SRQXRw==
X-Received: by 2002:a17:90a:b38d:: with SMTP id e13mr16560118pjr.214.1607340825515;
        Mon, 07 Dec 2020 03:33:45 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.33.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:33:45 -0800 (PST)
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
Subject: [RFC V2 06/37] dmemfs: support truncating inode down
Date:   Mon,  7 Dec 2020 19:30:59 +0800
Message-Id: <ad5df9d722c6e843ea88e230d2355c04da54bcc8.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/dmemfs/inode.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index 7b6e51d..9ec62dc 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -98,8 +98,73 @@ static int dmemfs_mkdir(struct inode *dir, struct dentry *dentry,
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
1.8.3.1

