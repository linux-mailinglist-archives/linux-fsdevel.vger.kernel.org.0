Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFA53BCAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389589AbfFJTP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:15:28 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39098 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389210AbfFJTOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:36 -0400
Received: by mail-vs1-f67.google.com with SMTP id n2so6215954vso.6;
        Mon, 10 Jun 2019 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aR//uD4NhWFMVjpTld02Vmm29l8MHQS0/NqSGli70F8=;
        b=PGcOELLZdo4Kg9v3G6sVPoxRniXMINmFDyPMiPzN6isPtueXfeYgWgOyCx0uoSur6Y
         BXjfDo4sohWRnSKAPm3pnL13BdVoyTCx9qi/EqPsq03d/dFrAs4Dw0EAGhJO2s387BYa
         wkV4b6w1U/1tnm5eMOEcF6yk3uvrsTIBW7Bt6MF6DiKLaIrGx+8/XpDIebBQ0XvBKqA2
         6UlHky1ZYmBRQDGoZ9N5kdM7QbeeK997QHERdJ2a1GzdhnDrpD/fmkI82eyHpQCrU58+
         JOuVu272wM6Iye9GuJvp5FN9pnJlXOLfJUu6wCw5V/p9PXENnGZ2zaqXM5WkdrjhfesR
         FngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aR//uD4NhWFMVjpTld02Vmm29l8MHQS0/NqSGli70F8=;
        b=qc+9CS/YgIyfnPGJWqynPr/2+8P20ILz1kbFGF7oSdFKVZ/YvN+aDXtcibXSzWqwUM
         MB+eo6C5JcQQgvUmCJcA4qN0n5aM4UIGR7wLH5AcVr5Fw3H/dEqAeOPDDKjwKvz7pwTb
         xsREjvaM5Jx2+btcH+Pd2QDxduCh+ilwOzKdz0KAQjw9giupxSJnlMD1KyHVF9H8kvuu
         Ssa0mZn5JlJJ9/rzUxIjQrzFQeZ/Tb5geElnSheC3TykChSPxcGbgzAT7hkxq4OhXiP/
         HUFJE95HKPDvvBCxz29h1T+mNikgAPgGNNZbbRQKty5gjtT3VKEbccPx9gIoyFm6L4iY
         AaUQ==
X-Gm-Message-State: APjAAAVtCqmFXJ/P7M9kFsLQSG5ZCFfrx+73frVe+MsNGMYTm/vQCUb+
        r62gx9nap9VK/N/9PSxDuujpWdVXlQ==
X-Google-Smtp-Source: APXvYqxaP8f1TN0DkPEILnhMA4UYfW7vT2pn5ycz2pBDc25trij2XZ0vvzlD2cfHHMKAgC0ktwlfvg==
X-Received: by 2002:a67:f911:: with SMTP id t17mr3355111vsq.128.1560194074584;
        Mon, 10 Jun 2019 12:14:34 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:33 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 05/12] fs: insert_inode_locked2()
Date:   Mon, 10 Jun 2019 15:14:13 -0400
Message-Id: <20190610191420.27007-6-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

New helper for bcachefs, so that when we race inserting an inode we can
atomically grab a ref to the inode already in the inode cache.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/inode.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 8881dc551f..cc44f345e0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1479,6 +1479,46 @@ int insert_inode_locked(struct inode *inode)
 }
 EXPORT_SYMBOL(insert_inode_locked);
 
+struct inode *insert_inode_locked2(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	ino_t ino = inode->i_ino;
+	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+
+	while (1) {
+		struct inode *old = NULL;
+		spin_lock(&inode_hash_lock);
+		hlist_for_each_entry(old, head, i_hash) {
+			if (old->i_ino != ino)
+				continue;
+			if (old->i_sb != sb)
+				continue;
+			spin_lock(&old->i_lock);
+			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
+				spin_unlock(&old->i_lock);
+				continue;
+			}
+			break;
+		}
+		if (likely(!old)) {
+			spin_lock(&inode->i_lock);
+			inode->i_state |= I_NEW | I_CREATING;
+			hlist_add_head(&inode->i_hash, head);
+			spin_unlock(&inode->i_lock);
+			spin_unlock(&inode_hash_lock);
+			return NULL;
+		}
+		__iget(old);
+		spin_unlock(&old->i_lock);
+		spin_unlock(&inode_hash_lock);
+		wait_on_inode(old);
+		if (unlikely(!inode_unhashed(old)))
+			return old;
+		iput(old);
+	}
+}
+EXPORT_SYMBOL(insert_inode_locked2);
+
 int insert_inode_locked4(struct inode *inode, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a88d994751..d5d12d6981 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3010,6 +3010,7 @@ extern struct inode *find_inode_nowait(struct super_block *,
 				       void *data);
 extern int insert_inode_locked4(struct inode *, unsigned long, int (*test)(struct inode *, void *), void *);
 extern int insert_inode_locked(struct inode *);
+extern struct inode *insert_inode_locked2(struct inode *);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void lockdep_annotate_inode_mutex_key(struct inode *inode);
 #else
-- 
2.20.1

