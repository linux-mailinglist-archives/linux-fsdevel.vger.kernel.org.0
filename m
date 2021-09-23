Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7925415FA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbhIWNZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:25:51 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17272 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241357AbhIWNZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1632402523; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=qH3ngKsxfDBir5NbpElwAqfEGQ6iHB041TE9vOS2w3gnqi1XONO2MMlLMRdbKRgbRfWsfFNtxgxtGDqp1YrzCkkx/VWeEV07mKNhKk70pFWgq+2gXh/Lrzkm5sshuksLpUeEDxuZGJMk6BcTA8DMN6od7bPBmOKnq2+6KZXIhxA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1632402523; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=SJerK8hn3kKJX7a0C29xFImquFtm+fSY+XjyQ7ULrjs=; 
        b=VcF6xUTRV2Z0fmfyEphbwYgIYz52AXlEBzlBP2RZnHlA80o+1qaQGwFnBRFfhzhWhNTJlgqzFxmyxOQdzghh2n6q/r4ey5kfzb5ojsuCQcY1DOi7klQrQ9RS5ythmJOSV0FoyZ0T7A4hgRzWHsbOSDUwFXFZtlaXyzkv1gaVwjs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1632402523;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=SJerK8hn3kKJX7a0C29xFImquFtm+fSY+XjyQ7ULrjs=;
        b=MwQ5U9dtYqlgPS1baurzUMI0iLzWurkQBJwILxnogau7MtDCArgzgsLxI7yYtGZ8
        +3z1v/Hgd3Y/Amfd7+2O70S07JhSlnNvafHGF8sIx1+5XCE+x51+1xPs0BhDPhCxFyL
        v3FFzjVsYlDCHSXvNKqKc6uElBrpB8MG+PVj29QU=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1632402521611230.03974667116563; Thu, 23 Sep 2021 21:08:41 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210923130814.140814-9-cgxu519@mykernel.net>
Subject: [RFC PATCH v5 08/10] fs: export wait_sb_inodes()
Date:   Thu, 23 Sep 2021 21:08:12 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210923130814.140814-1-cgxu519@mykernel.net>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to wait syncing upper inodes we need to
call wait_sb_inodes() in overlayfs' ->sync_fs.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
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


