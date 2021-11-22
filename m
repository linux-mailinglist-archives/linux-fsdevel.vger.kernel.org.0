Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8245884C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 04:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbhKVDT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 22:19:58 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17245 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238800AbhKVDTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:19:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637550058; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=OcCT/FXQWt1Sf02RjtxTYGWUyZ5qzig68yiCIaB2sCJX0vn7/uC4+rVahdkB0rLe99Xc/9MwDfSCCPBmwDqIEGTP1pnirV2m8fEDETNlRt9XV7AEKsA5JKFhAczkkMrLnJy/QZkgVLGSgxoFpIVdfUinDiT0p6ITUVJih/qJ9fA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637550058; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XWwkiyQ/BdG5wh3JYtnpShMhf+wXumE4K+jIj9m+FGk=; 
        b=ZbLHooThIHsNsVXBskT2daRkA7a/X1LJsK+XQDjVdTaNduBRsb2/c2qNwEypwj6qMk28YK5qhzGyz73tRjY5cGRcxuLIEpTsk5d08e+/AdGqun1Fg+dctaXz4o2uGqllaKNCn5b/AcYQmzkbfKfnSYJT1RqSWc4wb1fq66aeKrQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637550058;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=XWwkiyQ/BdG5wh3JYtnpShMhf+wXumE4K+jIj9m+FGk=;
        b=TWwVMN5mC8Gj16gbsmg0QsbXh5KaDGxMhVCwaFPMoZ9zMNVEiHrugRENJdg1fiob
        RrU+6LPUthrhLjRaVurwK67BXnRlps24nK8VTg+G8aIZlfgfjAQ087fdpP2tLSd2yRT
        R0+RBQzheaUWwv8kHT/3gdiVLsQf7N36XRrbfYhE=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1637550057358568.9885767482691; Mon, 22 Nov 2021 11:00:57 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Message-ID: <20211122030038.1938875-6-cgxu519@mykernel.net>
Subject: [RFC PATCH V6 5/7] fs: export wait_sb_inodes()
Date:   Mon, 22 Nov 2021 11:00:36 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211122030038.1938875-1-cgxu519@mykernel.net>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chengguang Xu <charliecgxu@tencent.com>

In order to wait syncing upper inodes we need to
call wait_sb_inodes() in overlayfs' ->sync_fs.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
---
 fs/fs-writeback.c         | 3 ++-
 include/linux/writeback.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 81ec192ce067..0438c911241e 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2505,7 +2505,7 @@ EXPORT_SYMBOL(__mark_inode_dirty);
  * completed by the time we have gained the lock and waited for all IO tha=
t is
  * in progress regardless of the order callers are granted the lock.
  */
-static void wait_sb_inodes(struct super_block *sb)
+void wait_sb_inodes(struct super_block *sb)
 {
 =09LIST_HEAD(sync_list);
=20
@@ -2589,6 +2589,7 @@ static void wait_sb_inodes(struct super_block *sb)
 =09rcu_read_unlock();
 =09mutex_unlock(&sb->s_sync_lock);
 }
+EXPORT_SYMBOL(wait_sb_inodes);
=20
 static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long=
 nr,
 =09=09=09=09     enum wb_reason reason, bool skip_if_busy)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index d1f65adf6a26..d7aacd0434cf 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -198,6 +198,7 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info=
 *bdi,
 =09=09=09=09enum wb_reason reason);
 void inode_wait_for_writeback(struct inode *inode);
 void inode_io_list_del(struct inode *inode);
+void wait_sb_inodes(struct super_block *sb);
=20
 /* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)
--=20
2.27.0


